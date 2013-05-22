unit uExportXLS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, ExtCtrls, StdCtrls,
  Buttons, CheckLst, Grids, Spin, uMsgDial, ComCtrls, ScktComp,
  uExportXLSConst, uAbstrArray, uOreolDBDirect2, uOreolProtocol6, uMainData,
  uMainConst, uDBservice3Job, uAbstrExcel, uKRSfunctionV3, uDEPdescript2,
  uDEPgrafJob2, uDEPdescript2const;

type
  TExportXLSproc1 = class(prqTHread)
  private
    HandleBoss: THandle;
    Msg: TMessage;

    jLchanal: integer;
    shbDNot1, shbDNot2: single;
    bRowCalc: Boolean;    // Счётчик строк (вывод в XLS)
    jRowCnt, jRowCur: Integer;     // Счётчик выведенных строк
    jColCnt, jColCur: Integer;     // Счётчик выведенных строк
    xlsData: OLEVariant;  // Массив для экспорта данных

//    procedure hrErr0;
//    procedure hrErr1;
//    procedure hrErr2;
//    procedure hrErr3;

    procedure calcExport2;
    function  calcExportCalcRow: Integer;
    procedure calcExport1;
    function  putHeaderC1: Boolean;
    function  putBodyC1(jIndRcd: Integer): Boolean;
    function  DetermineIndex(dBeg, dEnd: Double; var indBeg, indEnd: Integer): Boolean;
    function  putTimeC1: Boolean;
    function  isRcdEmpty(ind: Integer): Boolean;

    procedure ExportXLS;
    procedure FindBoss;
    procedure ProtSendBoss(s1: string);
  protected

  public
    sErr: string;
    sMessage: string;
    procedure doProcess; override;
    constructor Create(susp: Boolean);
    destructor Destroy; override;
  published
  end;

  TcExportXLS = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckListBox1: TCheckListBox;
    Panel6: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    Panel4: TPanel;
    StringGrid1: TStringGrid;
    Panel7: TPanel;
    ComboBox2: TComboBox;
    Label2: TLabel;
    Panel5: TPanel;
    ComboBox3: TComboBox;
    Label3: TLabel;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    ComboBox1: TComboBox;
    Label4: TLabel;
    ComboBox4: TComboBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label5: TLabel;
    ComboBox5: TComboBox;
    CheckBox4: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Panel1Resize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
  private
    { Private declarations }
    BlockWorking:   prqTBlockRsrc;
    job:            prqTExpJob;

    procDB:         TExportXLSproc1; // Процесс экспорта данных

    listChanals:    prqTinteger;     // Список каналов, представленных на экране

    procedure destoyHread1;
    procedure CloseProcShow;
    procedure setSizeMyObject;
  public
    { Public declarations }
    bGlbDepth: boolean;

    jobExp: dbDBservice3Job;        // Задание на работу
    jobAll: TDEPgrafJob1;           // Задание на работу
    listParam: TDEPdepParam;        // Список параметров базы данных

    procedure Init;
    procedure ShowParam;

    procedure ShowProcMessage;

    procedure produceFinMsg(var Msg: TMessage); override;
    procedure CloseProcessAvr;
  end;

var
  ImSelf: TcExportXLS;

implementation
uses uSupport;

{$R *.dfm}

procedure TcExportXLS.FormCreate(Sender: TObject);
begin
  inherited;
  jUniType   := pc006_107_jMain;
  Caption    := pc006_107_Caption;
  BlockWorking := prqTBlockRsrc.Create;
  BlockWorking.bBlockRsrc := false;
  procDB   := nil;
  ImSelf   := self;
  job      := nil;
  listChanals := prqTinteger.Create;

  StringGrid1.Cells[0,0] := pc006_107_sg1_00_00;
  StringGrid1.Cells[1,0] := pc006_107_sg1_01_00;
  StringGrid1.Cells[2,0] := pc006_107_sg1_02_00;
  StringGrid1.Cells[0,1] := pc006_107_sg1_00_01;
  StringGrid1.Cells[0,2] := pc006_107_sg1_00_02;

  ComboBox1.Items.Add(pc006_107_CmbBx1_00);
  ComboBox1.Items.Add(pc006_107_CmbBx1_01);
  ComboBox1.Items.Add(pc006_107_CmbBx1_02);
  ComboBox1.ItemIndex := 0;

  ComboBox2.Items.Add(pc006_107_CmbBx2_01);
  ComboBox2.Items.Add(pc006_107_CmbBx2_02);
  ComboBox2.ItemIndex := 0;

  ComboBox3.Items.Add(pc006_107_CmbBx3_00);
  ComboBox3.Items.Add(pc006_107_CmbBx3_01);
  ComboBox3.Items.Add(pc006_107_CmbBx3_02);
  ComboBox3.ItemIndex := 0;

  ComboBox4.Items.Add(pc006_107_CmbBx4_00);
  ComboBox4.Items.Add(pc006_107_CmbBx4_01);
//  ComboBox4.Items.Add(pc006_107_CmbBx4_02);
  ComboBox4.ItemIndex := 0;

  ComboBox5.Items.Add(pc006_107_CmbBx5_00);
  ComboBox5.Items.Add(pc006_107_CmbBx5_01);
  ComboBox5.Items.Add(pc006_107_CmbBx5_02);
  ComboBox5.ItemIndex := 0;
end;

procedure TcExportXLS.Panel1Resize(Sender: TObject);
begin
  inherited;
  setSizeMyObject;
end;

procedure TcExportXLS.setSizeMyObject;
var
  jL, j3, j2, j1: Integer;
begin
  j1 := BitBtn1.Left;
  j2 := Panel1.ClientWidth - (j1 + BitBtn2.Width);
  if (j2 - BitBtn1.Width) > j1 then
  begin
    BitBtn2.Left := j2;
  end;

  j1 := StringGrid1.ClientWidth - (StringGrid1.ColCount + 1) * StringGrid1.GridLineWidth;
  j2 := j1 div StringGrid1.ColCount;
  j3 := j1 mod StringGrid1.ColCount;
  j1 := 0;
  while j1 < StringGrid1.ColCount do
  begin
    jL := j2; if j1 < j3 then Inc(jL, StringGrid1.GridLineWidth);
    StringGrid1.ColWidths[j1] := jL;
    Inc(j1);
  end;
end;

procedure TcExportXLS.FormActivate(Sender: TObject);
begin
  inherited;
  setSizeMyObject;
end;

procedure TcExportXLS.Init;
begin
// Настроить таблицу
  self.job := jobExp.jobExport;
  ShowParam;
end;

procedure TcExportXLS.BitBtn1Click(Sender: TObject);
var
  dBeg, tBeg, dEnd, tEnd: TDateTime;
  jC2, j2, j1, jC1, jR, jC: Integer;
  //bDepth,
  bStart, b1: Boolean;
  dtSi: Single;
  s1: String;
begin
  inherited;

  if self.BlockWorking.isBlockRsrc then
  begin
    ShowMessage(pc006_107_004);
    Exit;
  end;

  bStart := false;
  try

// Проверка выделеных каналов
    b1 := False;

    for jC1 := 1 to CheckListBox1.Items.Count do
    begin
      if CheckListBox1.Checked[jC1-1] then
      begin
        b1 := True; break;
      end;
    end;
    if not b1 then
    begin
      ShowMessage(pc006_107_002);
      Exit;
    end;

// Работа с временами запроса
    jR := 1; jC := 1;
    try
      dBeg := StrToDate(StringGrid1.Cells[1, 1]);
      Inc(jC);
      tBeg := StrToTime(StringGrid1.Cells[2, 1]);
      jR := 2; jC := 1;
      dEnd := StrToDate(StringGrid1.Cells[1, 2]);
      Inc(jC);
      tEnd := StrToTime(StringGrid1.Cells[2, 2]);
    except
      on E: Exception do
      begin
        ShowMessage(format(pc006_107_frm02, [jR, jC]));
        Exit;
      end;
    end;
    dBeg := dBeg + tBeg; dEnd := dEnd + tEnd;
    if dBeg >= dEnd then
    begin
      ShowMessage(pc006_107_001);
      Exit;
    end;

//  Подготовка запроса
    job.rcdExport.tySd  := 0; // Все данные
    job.bOrigin         := RadioButton1.Checked;
    job.rcdExport.dtBeg := dBeg;
    job.rcdExport.dtEnd := dEnd;
    job.bIncTime        := CheckBox1.Checked;
    job.bIncDepth       := CheckBox2.Checked;
    job.bIncIndex       := CheckBox3.Checked;
    job.jInterval       := ComboBox1.ItemIndex;
    job.vInterval       := SpinEdit1.Value;
    job.jMethod         := ComboBox2.ItemIndex;
    job.jLegend         := ComboBox3.ItemIndex;
    job.jInterp         := ComboBox4.ItemIndex;
    job.jAdmiss         := ComboBox5.ItemIndex;
    job.dStep           := 1;
    case job.jInterval of
      0:
      begin
        job.sFrm  := pc006_107_frm0;
        job.dStep := ((job.dStep / 24) / 3600000); // msek
      end;
      1:
      begin
        job.sFrm  := pc006_107_frm1;
        job.dStep := ((job.dStep / 24) / 3600);    // sek
      end;
      2:
      begin
        job.sFrm := pc006_107_frm2;
        job.dStep := ((job.dStep / 24) / 60);     // min
      end;
    end;
    job.dStep   := job.dStep * job.vInterval;
    job.dNot    := cdbTOutVal;  job.dNot1   := job.dNot   * 0.9;  job.dNot2   := job.dNot   * 1.1;
    job.dNotIn  := cdbNotInt;   job.dNotIn1 := job.dNotIn * 0.9;  job.dNotIn2 := job.dNotIn * 1.1;

    job.valLegend.Count := 0;
    job.rcdExport.pFld.Count := 0;
    job.valExport.clrField;
    job.valExport.addField(ftInteger, 0); // Индекс
    job.valExport.addField(ftDouble,  0); // Дата время
    job.valExport.addField(ftSingle,  0); // Глубина

    for jC1 := 1 to CheckListBox1.Count do
    begin
      if not CheckListBox1.Checked[jC1-1] then continue;
      job.rcdExport.pFld.Append(@listParam[listChanals[jC1]^].DEPparNum);  // Номера каналов
      job.valExport.addField(ftSingle, 0);                                 // Значения параметров
      case job.jLegend of                                                  // Подпись к столбцу
        1: s1 := listParam[listChanals[jC1]^].SGTparNameShrt;
        2: s1 := IntToStr(listParam[listChanals[jC1]^].DEPparNum);
        else
           s1 := '';
      end;
      if Length(s1) > 0 then
      begin
        j1 := job.valLegend.Count + 1;
        job.valLegend.Count := j1;
        job.valLegend.SetAsString(j1, s1);
      end;
    end;

    self.bGlbDepth := false;
    if job.bIncDepth then
    begin
      for jC1 := 1 to jobAll.DEPsgtParam.Count do
      begin
        // Найти канал Глубина забоя
        if jobAll.DEPsgtParam[jC1].SGTparNum = pc006_503_SGTpar2nb then
        begin
          if jobAll.DEPsgtParam[jC1].DEPparNum >= 0 then
          begin
            j2 := jobAll.DEPsgtParam[jC1].DEPparNum;
            job.rcdExport.pFld.Append(@j2);  // Номера каналов
            job.valExport.addField(ftSingle, 0);                                 // Значения параметров
            self.bGlbDepth := true;
            break;
          end;
        end;
      end;
    end;

//    job.rcdExport.pFld.Sort(1);

    job.valExport.Count := pc006_107_DBasD - 1;
    j1 := -1;
    dtSi := job.dNot;
    for jC1 := 1 to pc006_107_DBasD - 1 do
    begin
      job.valExport.setField(jC1, 1, @j1);
      for jC2 := 4 to job.valExport.listField.Count do
      begin
        job.valExport.setField(jC1, jC2, @dtSi);
      end;
    end;

// Создание процесса, запуск на выполнение
    procDB := TExportXLSproc1.Create(true); // Процесс расчёта рапорта
    procDB.jTimeOut := pc006_107_Hread_01tim;
    procDB.Priority := tpNormal;                     // tpNormal; //tpHigher; // tpLower;
    procDB.jUniType := pc006_107_Hread_01typ;
    procDB.jUniKeyBoss := jUniKeySelf;
//    registryObj(taskParam, procDB.jUniKeySelf, procDB.jUniKeyBoss, procDB.jUniType, procDB);
    procDB.Caption  := pc006_107_Hread_01cpt;
    procDB.FreeOnTerminate := true;
    procDB.taskParam := taskParam;
    procDB.bNoUnReg := True;

    bStart := true;
    procDB.Resume;

//  ShowProcess(taskParam, jUniKeySelf, True, pc003_139_026, nil, aviFindFolder); // Повесить заставку
    ShowProcess(taskParam, jUniKeySelf, True, pc006_107_003, nil);

  finally
    if not bStart then
    begin
      self.BlockWorking.bBlockRsrc := false;
    end;
  end;
end;

procedure TcExportXLS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BlockWorking.Free;
  listChanals.Free;

//  SavePFParComp(taskParam.getNamRegDivision(self, jUniType), SpinEdit1);
//  SavePFParComp(taskParam.getNamRegDivision(self, jUniType), CheckListBox1);
//  SavePFParComp(taskParam.getNamRegDivision(self, jUniType), StringGrid1);
  inherited;
end;

procedure TcExportXLS.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TcExportXLS.BitBtn3Click(Sender: TObject);
var
  jC1: Integer;
begin
  for jC1 := 1 to CheckListBox1.Items.Count do
  begin
    CheckListBox1.Checked[jC1-1] := True;
  end;
end;

procedure TcExportXLS.BitBtn4Click(Sender: TObject);
var
  jC1: Integer;
begin
  for jC1 := 1 to CheckListBox1.Items.Count do
  begin
    CheckListBox1.Checked[jC1-1] := False;
  end;
end;

procedure TcExportXLS.ShowParam;
var
  jCrow: Integer;
  s1: String;
  b1: boolean;
begin
  if not Assigned(self.listParam) then Exit;
  self.listChanals.Count := 0;
  self.CheckListBox1.Clear;
  b1 := not self.CheckBox4.Checked;
  for jCrow := 1 to self.listParam.Count do
  begin
    if b1 then
    begin
//      if not self.listParam[jCrow].bActive then continue;
      if not self.listParam[jCrow].bSaveDB then continue;
    end;
    s1 := Format(pc006_107_frm01, [self.listParam[jCrow].DEPparNum,
                                   self.listParam[jCrow].SGTparNameShrt,
                                   self.listParam[jCrow].SGTparNameType,
                                   self.listParam[jCrow].SGTparNameBig]);
    self.CheckListBox1.Items.Add(s1);
    self.listChanals.Append(@jCrow);
  end;
end;

{ TExportXLSproc1 }

procedure TExportXLSproc1.calcExport1;
var
  xls: TprqExcel;
  dTi, dTiCrnt1, dTiCrnt2: Double;
  rCh: Single;
  j1, jC1, jI1, jI2: Integer;
  bFree: Boolean;
begin
  try

    xls := TprqExcel.Create;
    self.xlsData := VarArrayCreate([1, self.jRowCnt, 1, self.jColCnt], varVariant);
    try
      if not xls.CreateWorkBook   then
      begin
        self.sErr := xls.strErr;
        Exit;
      end;
      if not xls.OpenWorkSheet(1) then
      begin
        self.sErr := xls.strErr;
        Exit;
      end;

      self.jRowCur := 1;
  // Вывод заголовков
      if not putHeaderC1 then Exit;

  // Вывод значений
      if ImSelf.job.bOrigin then
      begin
                  // Вывод оригинала данных
        for jC1 :=  pc006_107_DBasD to ImSelf.job.valExport.Count do
        begin
          dTi := ImSelf.job.valExport.getValField(jC1, 2); // Time
          if (dTi < ImSelf.job.rcdExport.dtBeg) or (dTi > ImSelf.job.rcdExport.dtEnd) then continue; // это (не) лишнее :-)

          if ImSelf.job.jAdmiss = 2 then
          begin
            if isRcdEmpty(jC1) then continue;
          end;

          if not putBodyC1(jC1) then Exit;
        end;

      end
      else
      begin

        jI1 := 0; jI2 := 0; // Заодно хранится информация о предыдущих индексах
        dTiCrnt1 := ImSelf.job.rcdExport.dtBeg;
        while dTiCrnt1 <= ImSelf.job.rcdExport.dtEnd do
        begin
          dTiCrnt2 := dTiCrnt1 + ImSelf.job.dStep;
          bFree  := not DetermineIndex(dTiCrnt1, dTiCrnt2, jI1, jI2);
          if bFree then
          begin
            case ImSelf.job.jAdmiss of
              0:
              begin // Пустая строка с отметкой времени
                ImSelf.job.valExport.setField(pc006_107_CrntD, 2, @dTiCrnt1);
                if not putTimeC1 then Exit;
              end;
              1:
              begin // Предыдущее значение
                j1 := 0;
                ImSelf.job.valExport.setField(pc006_107_CrntD, 1, @j1);
                ImSelf.job.valExport.setField(pc006_107_CrntD, 2, @dTiCrnt1);
                rCh := ImSelf.job.dNot;
                ImSelf.job.valExport.setField(pc006_107_CrntD, 3, @rCh);
                for jC1 := 4 to self.jLchanal do
                begin
                  rCh := ImSelf.job.valExport.getValField(pc006_107_PrevD, jC1);
                  ImSelf.job.valExport.setField(pc006_107_CrntD, jC1, @rCh);
                end;
                if not putBodyC1(pc006_107_CrntD) then Exit;
              end;
            end;
          end
          else
          begin
            if not putBodyC1(pc006_107_CrntD) then Exit;
          end;

          dTiCrnt1 := dTiCrnt2;
        end;

      end;

      if not xls.putVarArray(1,1, self.jColCnt,self.jRowCnt, self.xlsData, pc006_107_WindowXLSSize) then
      begin
        self.sErr := xls.strErr;
        Exit;
      end;

      xls.showExcel;
    finally
      xls.Free;
      self.xlsData := Null;
    end;

  finally
    ImSelf.job.valExport.Count := 0;
  end;
end;

procedure TExportXLSproc1.calcExport2;
var
  rDp, rDp0: Single;
  val: Variant;
  jLine, jC1, jField, jFieldDp: Integer;
begin
  self.jLchanal := ImSelf.job.valExport.listField.Count;
  self.shbDNot1 := ImSelf.job.dNot1;
  self.shbDNot2 := ImSelf.job.dNot2;
  self.bRowCalc := true;
  if self.calcExportCalcRow = 0 then Exit;
  self.jRowCnt := self.jRowCur;
  self.jColCnt := self.jColCur;
  self.bRowCalc := false;

// подготовить столбец с глубиной
  if ImSelf.bGlbDepth then
  begin
    jFieldDp := 1;
    if ImSelf.job.bIncTime then Inc(jFieldDp);
    if ImSelf.job.bIncIndex then Inc(jFieldDp);

    jLine := ImSelf.job.valExport.Count;
    jField := ImSelf.job.valExport.listField.Count;

    rDp0 := ImSelf.job.dNot;
    for jC1 :=  pc006_107_DBasD to jLine do
    begin
      rDp0 := ImSelf.job.valExport.getValField(jC1, jField); // Depth
      if not isDiapazon(rDp0, self.shbdNot1, self.shbdNot2) then break;
    end;

    if not isDiapazon(rDp0, self.shbdNot1, self.shbdNot2) then
    begin
      for jC1 :=  pc006_107_DBasD to jLine do
      begin
        rDp := ImSelf.job.valExport.getValField(jC1, jField); // Depth

        if not isDiapazon(rDp, self.shbdNot1, self.shbdNot2) then
        begin
          rDp0 := rDp;
        end;
        val := rDp0;
        ImSelf.job.valExport.setField(jC1, 3, val); // Depth
      end;
    end;
  end;

  self.calcExport1;
end;

function TExportXLSproc1.calcExportCalcRow: Integer;
var
  dTi, dTiCrnt1, dTiCrnt2: Double;
  rDpth, rCh: Single;
  j1, jC1, jI1, jI2: Integer;
  bFree: Boolean;
begin
  result := 0;
  rDpth  := ImSelf.job.dNot;
  try

    if ImSelf.job.valExport.Count <  pc006_107_DBasD then
    begin
      self.sErr := pc006_107_022;
      Exit;
    end;

    jRowCur := 1;
// Вывод заголовков
    if not putHeaderC1 then Exit;

// Вывод значений
    if ImSelf.job.bOrigin then
    begin
                // Вывод оригинала данных
      for jC1 :=  pc006_107_DBasD to ImSelf.job.valExport.Count do
      begin
        dTi := ImSelf.job.valExport.getValField(jC1, 2); // Time
        if (dTi < ImSelf.job.rcdExport.dtBeg) or (dTi > ImSelf.job.rcdExport.dtEnd) then continue; // это (не) лишнее :-)

        if ImSelf.job.jAdmiss = 2 then
        begin
          if isRcdEmpty(jC1) then continue;
        end;

        if not putBodyC1(jC1) then Exit;
      end;

    end
    else
    begin

      jI1 := 0; jI2 := 0; // Заодно хранится информация о предыдущих индексах
      dTiCrnt1 := ImSelf.job.rcdExport.dtBeg;
      while dTiCrnt1 <= ImSelf.job.rcdExport.dtEnd do
      begin
        dTiCrnt2 := dTiCrnt1 + ImSelf.job.dStep;
        bFree  := not DetermineIndex(dTiCrnt1, dTiCrnt2, jI1, jI2);
        if bFree then
        begin
          case ImSelf.job.jAdmiss of
            0:
            begin // Пустая строка с отметкой времени
              ImSelf.job.valExport.setField(pc006_107_CrntD, 2, @dTiCrnt1);
              if not putTimeC1 then Exit;
            end;
            1:
            begin // Предыдущее значение
              j1 := 0;
              ImSelf.job.valExport.setField(pc006_107_CrntD, 1, @j1);
              ImSelf.job.valExport.setField(pc006_107_CrntD, 2, @dTiCrnt1);
              ImSelf.job.valExport.setField(pc006_107_CrntD, 3, @rDpth);
              for jC1 := 4 to self.jLchanal do
              begin
                rCh := ImSelf.job.valExport.getValField(pc006_107_PrevD, jC1);
                ImSelf.job.valExport.setField(pc006_107_CrntD, jC1, @rCh);
              end;
              if not putBodyC1(pc006_107_CrntD) then Exit;
            end;
          end;
        end
        else
        begin
          if not putBodyC1(pc006_107_CrntD) then Exit;
        end;

        dTiCrnt1 := dTiCrnt2;
      end;

    end;

    Dec(jRowCur);
    result := jRowCur;

  finally
    if result = 0 then
    begin
      ImSelf.job.valExport.Count := 0;
    end;
  end;
end;

constructor TExportXLSproc1.Create(susp: Boolean);
begin
  self.xlsData := Null;
  inherited Create(susp);
end;

destructor TExportXLSproc1.Destroy;
begin

  inherited;
end;

function TExportXLSproc1.DetermineIndex(dBeg, dEnd: Double; var indBeg,
  indEnd: Integer): Boolean;
var
  jC2, jC1, j1, jField, jCparCount, newIndBeg, newIndEnd, jCnt: Integer;
  dMedia, dTi: Double;
  rCh, rDp: Single;
  clD1: prqValStat;
  rcd1: rcdValStat;
begin
  result := False;
  dTi := 0;

// Выделяем нижнюю границу интервала
  newIndBeg := indEnd; if newIndBeg = 0 then Inc(newIndBeg, pc006_107_DBasD);
  jCnt := ImSelf.job.valExport.Count;
  while newIndBeg <= jCnt do
  begin
    dTi := ImSelf.job.valExport.getValField(newIndBeg, 2); // Time
    if dTi >= dBeg then break;
    Inc(newIndBeg);
  end;

  if newIndBeg > jCnt then
  begin
    indBeg := newIndBeg;
    indEnd := newIndBeg;     // Нет данных в нужном диапазоне
    Exit;
  end
  else
  if dTi > dEnd then
  begin
    indBeg := newIndBeg;
    indEnd := newIndBeg;     // Нет данных в нужном диапазоне
    Exit;
  end;

// Выделяем верхнюю границу интервала
  newIndEnd := newIndBeg;
  while newIndEnd <= jCnt do
  begin
    dTi := ImSelf.job.valExport.getValField(newIndEnd, 2); // Time
    if dTi > dEnd then break;
    Inc(newIndEnd);
  end;
  Dec(newIndEnd);
  indBeg := newIndBeg;
  indEnd := newIndEnd;

// Получаем усреднённые значения
  j1 := ImSelf.job.valExport.getValField(newIndBeg, 1);
  ImSelf.job.valExport.setField(pc006_107_CrntD, 1, @j1);             // Index
  ImSelf.job.valExport.setField(pc006_107_CrntD, 2, @dBeg);           // Time
  rDp := ImSelf.job.valExport.getValField(newIndBeg, 3);
  ImSelf.job.valExport.setField(pc006_107_CrntD, 3, @rDp);             // Depth
//Каналы:
  jCparCount := ImSelf.job.rcdExport.pFld.Count;
  jField := 3;
  rcd1.jCnt := 0;
  for jC2 := 1 to jCparCount do
  begin
    Inc(jField);
    case ImSelf.job.jMethod of
      0: // Частотный выбор
      begin
        clD1 := prqValStat.Create;
        try
          for jC1 := newIndBeg to newIndEnd do
          begin
            rCh := ImSelf.job.valExport.getValField(jC1, jField); // Chanal
            if isDiapazon(rCh, self.shbdNot1, self.shbdNot2) then continue;
            rcd1.dVal := rCh;
            j1 := clD1.FindFast(@rcd1, 1);
            if j1 = 0 then
            begin
              clD1.Append(@rcd1);
              clD1.ReSortFast(1, clD1.Count);
            end
            else
            begin
              clD1[j1].jCnt := clD1[j1].jCnt + 1;
            end;
          end;
          j1 := clD1.Count;
          if j1 = 0 then
          begin
            if ImSelf.job.jInterp > 0 then
            begin
              rCh := ImSelf.job.valExport.getValField(pc006_107_PrevD, jField);
            end
            else
            begin
              rCh := ImSelf.job.dNot;
            end;
            ImSelf.job.valExport.setField(pc006_107_CrntD, jField, @rCh);
          end
          else
          begin
            result := True;
            clD1.SortFast(2);
            rCh := clD1[clD1.Count].dVal;
            ImSelf.job.valExport.setField(pc006_107_PrevD, jField, @rCh);
            ImSelf.job.valExport.setField(pc006_107_CrntD, jField, @rCh);
          end;
        finally
          clD1.Free;
        end;
      end;

      1: // Среднее на интервале
      begin
        dMedia := 0;
        j1 := 0;
        for jC1 := newIndBeg to newIndEnd do
        begin
          rCh := ImSelf.job.valExport.getValField(jC1, jField); // Chanal
          if isDiapazon(rCh, self.shbdNot1, self.shbdNot2) then continue;
          dMedia := dMedia + rCh;
          Inc(j1);
        end;
        if j1 = 0 then
        begin
          if ImSelf.job.jInterp > 0 then
          begin
            rCh := ImSelf.job.valExport.getValField(pc006_107_PrevD, jField);
          end
          else
          begin
            rCh := ImSelf.job.dNot;
          end;
          ImSelf.job.valExport.setField(pc006_107_CrntD, jField, @rCh);
        end
        else
        begin
          result := True;
          rCh := dMedia / j1;
          ImSelf.job.valExport.setField(pc006_107_PrevD, jField, @rCh);
          ImSelf.job.valExport.setField(pc006_107_CrntD, jField, @rCh);
        end;
      end;
    end;
  end;
end;

procedure TExportXLSproc1.doProcess;
begin
  FbCalc := True;

    self.ExportXLS; //Test1;

  FbCalc := False;
end;

procedure TExportXLSproc1.ExportXLS;
var
  s1: string;
  bRes: boolean;
  j1: integer;
begin
  try
// 1. Подготовительные операции
    self.FindBoss;
    self.ProtSendBoss(pc006_107_016);
    bRes := false;

    s1 := formatDateTime(pc006_107_frm4, Now) + ' ' + pc006_107_011;
    self.ProtSendBoss(s1);

    try
      if self.isTerminated then Exit;

// . Прочитать параметры
//  Номера каналов   ImSelf.job.rcdExport.pFld
//    job.rcdExport.dtBeg := dBeg;
//    job.rcdExport.dtEnd := dEnd;
//    job.valExport.addField(ftInteger, 0); // Индекс
//    job.valExport.addField(ftDouble,  0); // Дата время
//    job.valExport.addField(ftSingle,  0); // Глубина
//    job.valExport.addField(ftSingle, 0);  // Значения параметров
//    job.valExport.Count := pc006_107_DBasD - 1; // служебные поля

      j1 := ImSelf.jobAll.CreateDataFileByTime(
                   ImSelf.job.rcdExport.pFld,
                   ImSelf.job.valExport,
                   ImSelf.job.rcdExport.dtBeg,
                   ImSelf.job.rcdExport.dtEnd,
                   ImSelf.job.dNot);

      if (j1 = 0) or (j1 = 1) then
      begin
        bRes := true;
      end
      else
      begin
        s1 := formatDateTime(pc006_107_frm4, Now) + ' ' + pc006_107_018;
        self.ProtSendBoss(s1);
        s1 := pc006_107_PrtStep + ImSelf.jobAll.sErr;
        self.ProtSendBoss(s1);
        Exit;
      end;

      if Length(ImSelf.jobAll.sErr) > 0 then
      begin
        s1 := pc006_107_PrtStep + ImSelf.jobAll.sErr;
        self.ProtSendBoss(s1);
      end;
      j1 := ImSelf.job.valExport.Count - pc006_107_DBasD + 1;
      s1 := formatDateTime(pc006_107_frm4, Now) + ' ' +
            format(pc006_107_012, [j1]);
      self.ProtSendBoss(s1);

      if j1 = 0 then
      begin
        self.sMessage := pc006_107_022;
        Synchronize( ImSelf.ShowProcMessage );
        Exit;
      end;

      if self.isTerminated then Exit;

// . Экспортировать в XLS
      self.sErr := '';
      self.calcExport2;
      if self.isTerminated then Exit;

      if Length(self.sErr) > 0 then
      begin
        self.sMessage := self.sErr;
        s1 := pc006_107_PrtStep + self.sErr;
        self.ProtSendBoss(s1);
        Synchronize( ImSelf.ShowProcMessage );
        Exit;
      end;

      s1 := formatDateTime(pc006_107_frm4, Now) + ' ' + format(pc006_107_013, [self.jRowCur - 1]);
      self.ProtSendBoss(s1);


    finally
      if self.Terminated  then
      begin
        s1 := formatDateTime(pc006_107_frm4, Now) + ' ' + pc006_107_015;
        self.ProtSendBoss(s1);
      end
      else
      begin
        if not bRes then
        begin
          s1 := formatDateTime(pc006_107_frm4, Now) + ' ' + pc006_107_019;
          self.ProtSendBoss(s1);
        end;
      end;
    end;

// . Завершить процедуры
  finally
    ImSelf.BlockWorking.bBlockRsrc := false;
    Synchronize( ImSelf.CloseProcShow );
    ImSelf.job.valExport.Count := 0;
  end;
end;

procedure TExportXLSproc1.FindBoss;
var
  j1: Integer;
begin
  j1 := uSupport.findRegistryObjSelf(ImSelf.taskParam, ImSelf.jUniKeyBoss);
  if j1 > 0 then
  begin
    HandleBoss := (ImSelf.taskParam.treeObj[j1].cls as TForm).Handle;
    Msg.WParamLo := 1110;
    Msg.WParamHi := 0;
  end
  else
  begin
    HandleBoss := 0;
  end;
end;

function TExportXLSproc1.isRcdEmpty(ind: Integer): Boolean;
var
  jC1: integer;
  sng1: single;
begin
  result := true;
  for jC1 := 4 to self.jLchanal do
  begin
    sng1 := ImSelf.job.valExport.getValField(ind, jC1);
    if not isDiapazon(sng1, self.shbdNot1, self.shbdNot2) then
    begin
      result := false;
      Exit;
    end;
  end;
end;

procedure TExportXLSproc1.ProtSendBoss(s1: string);
begin
  if HandleBoss <> 0 then
  begin
    uSupport.putString(s1, HandleBoss, pc006_107_jMain);
    Msg.LParam   := pc006_107_jMain;
    SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
  end;
end;

function TExportXLSproc1.putBodyC1(jIndRcd: Integer): Boolean;
var
  j1, jCparCount, jCol, jC2, jField: Integer;
  rCh, rDp: Single;
  dTi: TDateTime;
  bNew: Boolean;
begin
  bNew   := false;
  jField := 1; jCol := 1;

  if ImSelf.job.bIncIndex then
  begin
    bNew := true;
    if not self.bRowCalc then
    begin
      j1 := ImSelf.job.valExport.getValField(jIndRcd, jField); // Index
      self.xlsData[self.jRowCur, jCol] := j1;
    end;
    Inc(jCol);
  end;
  Inc(jField);

  if ImSelf.job.bIncTime then
  begin
    bNew := true;
    if not self.bRowCalc then
    begin
      dTi := ImSelf.job.valExport.getValField(jIndRcd, jField); // Time
//      if not isDiapazon(dTi, self.dNot1, self.dNot2) then
      begin
        self.xlsData[self.jRowCur, jCol] := dTi;
      end;
    end;
    Inc(jCol);
  end;
  Inc(jField);

  if ImSelf.job.bIncDepth then
  begin
    bNew := true;
    if not self.bRowCalc then
    begin
      rDp := ImSelf.job.valExport.getValField(jIndRcd, jField); // Depth
//      if not isDiapazon(rDp, self.dNot1, self.dNot2) then
      begin
        self.xlsData[self.jRowCur, jCol] := rDp;
      end;
    end;
    Inc(jCol);
  end;
  Inc(jField);

  jCparCount := ImSelf.job.rcdExport.pFld.Count;
  if ImSelf.bGlbDepth then Dec(jCparCount);
  for jC2 := 1 to jCparCount do
  begin
    bNew := true;
    if not self.bRowCalc then
    begin
      rCh := ImSelf.job.valExport.getValField(jIndRcd, jField); // Chanal
      if not isDiapazon(rCh, self.shbdNot1, self.shbdNot2) then
      begin
        self.xlsData[self.jRowCur, jCol] := rCh;
      end;
    end;
    Inc(jField); Inc(jCol);
  end;

  if bNew then Inc(jRowCur);
  result := True;
end;

function TExportXLSproc1.putHeaderC1: Boolean;
var
  jCparCount, jC2: Integer;
begin
// Вывод подписей к колонкам
  if (ImSelf.job.jLegend > 0)  OR  self.bRowCalc then
  begin
    self.jColCur := 0;

    if ImSelf.job.bIncIndex then
    begin
      Inc(self.jColCur);
      if not self.bRowCalc then
        self.xlsData[self.jRowCur, self.jColCur] := pc006_107_113;
    end;

    if ImSelf.job.bIncTime then
    begin
      Inc(self.jColCur);
      if not self.bRowCalc then
        self.xlsData[self.jRowCur, self.jColCur] := pc006_107_111;
    end;

    if ImSelf.job.bIncDepth then
    begin
      Inc(self.jColCur);
      if not self.bRowCalc then
        self.xlsData[self.jRowCur, self.jColCur] := pc006_107_112;
    end;

    jCparCount := ImSelf.job.rcdExport.pFld.Count;
    for jC2 := 1 to jCparCount do
    begin
      Inc(self.jColCur);
      if not self.bRowCalc then
        self.xlsData[self.jRowCur, self.jColCur] := ImSelf.job.valLegend.getAsString(jC2);
    end;

    Inc(self.jRowCur);
  end;
  result := True;
end;

function TExportXLSproc1.putTimeC1: Boolean;
var
  jCol, jField: Integer;
  dTi: TDateTime;
  bNew: Boolean;
begin
  bNew   := false;
  jField := 2; jCol := 1;

  if ImSelf.job.bIncIndex then
  begin
    bNew := true;
    Inc(jCol);
  end;

  if ImSelf.job.bIncTime then
  begin
    bNew := true;

    if not self.bRowCalc then
    begin
      dTi := ImSelf.job.valExport.getValField(1, jField); // Time
      self.xlsData[self.jRowCur, jCol] := dTi;
    end;
  end;

  if bNew then Inc(jRowCur);
  result := True;
end;

procedure TcExportXLS.CloseProcShow;
var
  j1: Integer;
begin
  try
    j1 := findRegistryObjType(taskParam, tobjShowProc);
    if j1 > 0 then
    begin
      (taskParam.treeObj[j1].cls as Tpf2).bMustSave := False;
      (taskParam.treeObj[j1].cls as Tpf2).bNoUnReg  := False;
      (taskParam.treeObj[j1].cls as TForm).WindowState := wsNormal;
      (taskParam.treeObj[j1].cls as TForm).Show;
      (taskParam.treeObj[j1].cls as Tpf2).Close;
    end;
  except
  end;
end;

procedure TcExportXLS.CloseProcessAvr;
begin
  destoyHread1;
  self.BlockWorking.bBlockRsrc := false;
end;

procedure TcExportXLS.produceFinMsg(var Msg: TMessage);
begin
  Application.ProcessMessages;
  case Msg.WParam of
    cWPar_UF_ProcAbort:
    begin
      CloseProcessAvr;
    end;
    else
      inherited;
  end;
  Msg.Result := 0;
  Application.ProcessMessages;
end;

procedure TcExportXLS.destoyHread1;
begin
  if self.procDB <> nil then
  begin
    try
      if self.procDB.bCalc then
      begin
        KillProcess(self.procDB);
      end;
    except
    end;
    try
      self.procDB.Free;
    except
    end;
    self.procDB := nil;
    try
      self.CloseProcShow;
    except
    end;
  end;
end;

procedure TcExportXLS.CheckBox4Click(Sender: TObject);
begin
  inherited;
  self.ShowParam;
end;

procedure TcExportXLS.ShowProcMessage;
begin
  try
    ShowMessage(self.procDB.sMessage);
  except
  end;
end;

end.
