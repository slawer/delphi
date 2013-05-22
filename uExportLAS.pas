unit uExportLAS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, ExtCtrls, StdCtrls,
  Buttons, CheckLst, Grids, Spin,
  uAbstrArray, uExportLASconst, uKRSfunctionV3, uMainData, uMainConst,
  uDBservice3Job, uOreolDBDirect2, uOreolProtocol6,
  uMsgDial, ComCtrls, ScktComp, uDEPgrafJob2, uDEPdescript2, uDEPdescript2const;

type
  TExportLASproc1 = class(prqTHread)
  private
    HandleBoss: THandle;
    Msg: TMessage;

//    shbDNot1, shbDNot2: single;

    outFile: File;        // Вывод в файл
    jRowCur: Integer;     // Счётчик выведенных строк

    procedure calcLasExport;
    function  putLasHeaderToFile: Boolean;
    function  putLasBodyToFile(jIndRcd: Integer): Boolean;
    function  findBegDepth(var jIndex, jDepth: Integer): Boolean;
    function  findEndDepth(var jIndex, jDepth: Integer): Boolean;
    function  LasDetermineIndex(var jDepthGoal, indBeg, indEnd: Integer): Boolean;
    procedure CopyCrntToPrev;
    procedure insertClearRecord(jGoal: Integer; var jCrnt: Integer; bNan: Boolean);
    function  putLasBody(jIndRcd: Integer): string;
    function  addStringField(const sIn, sField: string): string;
    function  writeTOfile(s1: string): boolean;
    function  putLasHeader: string;

//    procedure hrErr0;
//    procedure hrErr1;
//    procedure hrErr2;
//    procedure hrErr3;

    procedure ExportLAS;
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

  TcExportLAS = class(Tpf2)
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
    Edit1: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox5: TComboBox;
    TabSheet3: TTabSheet;
    Label7: TLabel;
    ComboBox6: TComboBox;
    Edit2: TEdit;
    Label8: TLabel;
    SaveDialog1: TSaveDialog;
    CheckBox4: TCheckBox;
    Label10: TLabel;
    ComboBox7: TComboBox;
    Edit3: TEdit;
    Label11: TLabel;
    SpinEdit2: TSpinEdit;
    Label12: TLabel;
    Label13: TLabel;
    CheckBox5: TCheckBox;
    Memo1: TMemo;
    Panel8: TPanel;
    BitBtn5: TBitBtn;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Panel1Resize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
  private
    { Private declarations }
    BlockWorking:   prqTBlockRsrc;
    job:            prqTExpLassJob;

    procDB:         TExportLASproc1; // Процесс экспорта данных

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
  ImSelf: TcExportLAS;

implementation
uses uSupport;

{$R *.dfm}

procedure TcExportLAS.FormCreate(Sender: TObject);
begin
  inherited;
  jUniType   := pc006_108_jMain;
  Caption    := pc006_108_Caption;
  BlockWorking := prqTBlockRsrc.Create;
  BlockWorking.bBlockRsrc := false;
  procDB   := nil;
  ImSelf   := self;
  job      := nil;
  listChanals := prqTinteger.Create;
  self.SaveDialog1.Filter := pc006_108_TypeFls;
  self.SaveDialog1.FilterIndex := 1;

  StringGrid1.Cells[0,0] := pc006_108_sg1_00_00;
  StringGrid1.Cells[1,0] := pc006_108_sg1_01_00;
  StringGrid1.Cells[2,0] := pc006_108_sg1_02_00;
  StringGrid1.Cells[0,1] := pc006_108_sg1_00_01;
  StringGrid1.Cells[0,2] := pc006_108_sg1_00_02;

  ComboBox1.Items.Add(pc006_108_CmbBx1_00);
  ComboBox1.Items.Add(pc006_108_CmbBx1_01);
  ComboBox1.Items.Add(pc006_108_CmbBx1_02);
  ComboBox1.ItemIndex := 0;

  ComboBox2.Items.Add(pc006_108_CmbBx2_01);
  ComboBox2.Items.Add(pc006_108_CmbBx2_02);
  ComboBox2.Items.Add(pc006_108_CmbBx2_03);
  ComboBox2.ItemIndex := 0;

  ComboBox3.Items.Add(pc006_108_CmbBx3_00);
  ComboBox3.Items.Add(pc006_108_CmbBx3_01);
  ComboBox3.Items.Add(pc006_108_CmbBx3_02);
  ComboBox3.ItemIndex := 0;

  ComboBox4.Items.Add(pc006_108_CmbBx4_00);
  ComboBox4.Items.Add(pc006_108_CmbBx4_01);
//  ComboBox4.Items.Add(pc006_108_CmbBx4_02);
  ComboBox4.ItemIndex := 0;

  ComboBox5.Items.Add(pc006_108_CmbBx5_00);
  ComboBox5.Items.Add(pc006_108_CmbBx5_01);
  ComboBox5.ItemIndex := 0;

  ComboBox6.Items.Add(pc006_108_CmbBx6_00);
  ComboBox6.Items.Add(pc006_108_CmbBx6_01);
  ComboBox6.Items.Add(pc006_108_CmbBx6_02);
  ComboBox6.Items.Add(pc006_108_CmbBx6_03);
  ComboBox6.Items.Add(pc006_108_CmbBx6_04);
  ComboBox6.ItemIndex := 0;

  ComboBox7.Items.Add(pc006_108_CmbBx7_00);
  ComboBox7.Items.Add(pc006_108_CmbBx7_01);
  ComboBox7.Items.Add(pc006_108_CmbBx7_02);
  ComboBox7.ItemIndex := 0;
end;

procedure TcExportLAS.Panel1Resize(Sender: TObject);
begin
  inherited;
  setSizeMyObject;
end;

procedure TcExportLAS.setSizeMyObject;
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

procedure TcExportLAS.FormActivate(Sender: TObject);
begin
  inherited;
  setSizeMyObject;
end;

procedure TcExportLAS.Init;
begin
// Настроить таблицу

  self.job              :=   self.jobExp.jobExportLas;
  self.Edit1.Text       := floatToStr(self.job.constNan);
  self.Memo1.Lines.Text := job.sFileName;
  self.ShowParam;
end;

procedure TcExportLAS.BitBtn1Click(Sender: TObject);
var
  dBeg, tBeg, dEnd, tEnd: TDateTime;
  jC2, j2, j1, jC1, jR, jC: Integer;
  mMeasuring: TOP_GetMeasuring;
  bStart, b1: Boolean;
  dtSi: Single;
  s1: String;
begin
  inherited;

  if self.BlockWorking.isBlockRsrc then
  begin
    ShowMessage(pc006_108_011);
    Exit;
  end;

  bStart := false;
  try

    if not CheckBox2.Checked then
    begin
      if MessageDlg(pc006_108_010, mtConfirmation, [mbYes, mbCancel], 0) <> mrYes then
      begin
        Exit;
      end;
    end;

    if Length(job.sFileName) = 0 then
    begin
      ShowMessage(pc006_108_007);
      Exit;
    end;

    if FileExists(job.sFileName) then
    begin
      if MessageDlg(pc006_108_006, mtConfirmation, [mbYes, mbCancel], 0) <> mrYes then
      begin
        Exit;
      end;
      job.isExist := true;
    end
    else
      job.isExist := false;

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
      ShowMessage(pc006_108_002);
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
        ShowMessage(format(pc006_108_frm02, [jR, jC]));
        Exit;
      end;
    end;
    dBeg := dBeg + tBeg; dEnd := dEnd + tEnd;
    if dBeg >= dEnd then
    begin
      ShowMessage(pc006_108_001);
      Exit;
    end;

  //  Подготовка запроса
    if not prqStrToFloat(Edit1.Text, job.constNan) then
    begin
      ShowMessage(pc006_108_008);
      Exit;
    end;

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
    job.vInterpol       := SpinEdit2.Value;
    if job.vInterval >= job.vInterpol then
    begin
      ShowMessage(pc006_108_009);
      Exit;
    end;

    if job.bOrigin then
    begin
      job.sFrm  := pc006_108_frm0;
    end
    else
    begin
      job.sFrm  := pc006_108_frm2;
    end;

    job.jStep           := 1;
    case job.jInterval of
      0:
      begin
        job.sFrmH  := pc006_108_frmH0;
  //      job.dStep := ( job.dStep / 1000 ); // mm
      end;
      1:
      begin
        job.sFrmH := pc006_108_frmH1;
        job.jStep := 10;  // sm
  //      job.dStep := ( job.dStep / 100 );  // sm
      end;
      2:
      begin
        job.jStep := 1000;  // m
        job.sFrmH := pc006_108_frmH2;
      end;
    end;
    job.jStepInterp := job.jStep * job.vInterpol;
    job.jStep       := job.jStep * job.vInterval;

    job.bTreamFld := self.CheckBox4.Checked;

    job.dNot    := cdbTOutVal;  job.dNot1   := job.dNot   * 0.9;  job.dNot2   := job.dNot   * 1.1;
    job.dNotIn  := cdbNotInt;   job.dNotIn1 := job.dNotIn * 0.9;  job.dNotIn2 := job.dNotIn * 1.1;

    if Pos(pc006_108_CmbBx5_00, self.ComboBox5.Text) > 0 then
    begin
      job.jCodeFile := pc006_108_CodeDOS;
    end
    else
    if Pos(pc006_108_CmbBx5_01, self.ComboBox5.Text) > 0 then
    begin
      job.jCodeFile := pc006_108_CodeWin;
    end
    else
    begin
      job.jCodeFile := pc006_108_CodeDOS;
    end;

    if Pos(pc006_108_CmbBx6_00, self.ComboBox6.Text) > 0 then
    begin
      job.jCodeChar := pc006_108_CodeChProb;
      job.sCodeChar := pc006_108_SCodeChProb;
    end
    else
    if Pos(pc006_108_CmbBx6_01, self.ComboBox6.Text) > 0 then
    begin
      job.jCodeChar := pc006_108_CodeChTab;
      job.sCodeChar := pc006_108_SCodeChTab;
    end
    else
    if Pos(pc006_108_CmbBx6_02, self.ComboBox6.Text) > 0 then
    begin
      job.jCodeChar := pc006_108_CodeChComa;
      job.sCodeChar := pc006_108_SCodeChComa;
    end
    else
    if Pos(pc006_108_CmbBx6_03, self.ComboBox6.Text) > 0 then
    begin
      job.jCodeChar := pc006_108_CodeChCoPt;
      job.sCodeChar := pc006_108_SCodeChCoPt;
    end
    else
    begin
      job.jCodeChar := pc006_108_CodeChManu;
      job.sCodeChar := Trim(self.Edit2.Text);
    end;
    if Length(job.sCodeChar) = 0 then
    begin
      ShowMessage(pc006_108_005);
      Exit;
    end;

    if Pos(pc006_108_CmbBx7_00, self.ComboBox7.Text) > 0 then
    begin
      job.jComaChar := pc006_108_ComaChPoint;
      job.sComaChar := pc006_108_SComaChPoint;
    end
    else
    if Pos(pc006_108_CmbBx7_01, self.ComboBox7.Text) > 0 then
    begin
      job.jComaChar := pc006_108_ComaChComa;
      job.sComaChar := pc006_108_SComaChComa;
    end
    else
    begin
      job.jComaChar := pc006_108_ComaChManu;
      job.sComaChar := Trim(self.Edit3.Text);
    end;
    if Length(job.sComaChar) = 0 then
    begin
      ShowMessage(pc006_108_005);
      Exit;
    end;


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
      job.valExport.addField(ftSingle, 0);                               // Значения параметров
      case job.jLegend of                                                // Подпись к столбцу
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

    job.valExport.Count := pc006_108_DBasD - 1;
    j1 := -1;
    dtSi := job.dNot;
    for jC1 := 1 to pc006_108_DBasD - 1 do
    begin
      job.valExport.setField(jC1, 1, @j1);
      for jC2 := 4 to job.valExport.listField.Count do
      begin
        job.valExport.setField(jC1, jC2, @dtSi);
      end;
    end;

// Создание процесса, запуск на выполнение
    procDB := TExportLASproc1.Create(true); // Процесс расчёта рапорта
    procDB.jTimeOut := pc006_108_Hread_01tim;
    procDB.Priority := tpNormal;                     // tpNormal; //tpHigher; // tpLower;
    procDB.jUniType := pc006_108_Hread_01typ;
    procDB.jUniKeyBoss := jUniKeySelf;
//    registryObj(taskParam, procDB.jUniKeySelf, procDB.jUniKeyBoss, procDB.jUniType, procDB);
    procDB.Caption  := pc006_108_Hread_01cpt;
    procDB.FreeOnTerminate := true;
    procDB.taskParam := taskParam;
    procDB.bNoUnReg := True;

    bStart := true;
    procDB.Resume;

    ShowProcess(taskParam, jUniKeySelf, True, pc006_108_003, nil);


  finally
    if not bStart then
    begin
      self.BlockWorking.bBlockRsrc := false;
    end;
  end;
end;

procedure TcExportLAS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BlockWorking.Free;
  listChanals.Free;

  SavePFParComp(taskParam.getNamRegDivision(self, jUniType), SpinEdit1);
  SavePFParComp(taskParam.getNamRegDivision(self, jUniType), SpinEdit2);
//  SavePFParComp(taskParam.getNamRegDivision(self, jUniType), CheckListBox1);
  SavePFParComp(taskParam.getNamRegDivision(self, jUniType), StringGrid1);
  inherited;
end;

procedure TcExportLAS.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TcExportLAS.BitBtn3Click(Sender: TObject);
var
  jC1: Integer;
begin
  for jC1 := 1 to CheckListBox1.Items.Count do
  begin
    CheckListBox1.Checked[jC1-1] := True;
  end;
end;

procedure TcExportLAS.BitBtn4Click(Sender: TObject);
var
  jC1: Integer;
begin
  for jC1 := 1 to CheckListBox1.Items.Count do
  begin
    CheckListBox1.Checked[jC1-1] := False;
  end;
end;

procedure TcExportLAS.BitBtn5Click(Sender: TObject);
var
  s1: string;
begin
  inherited;
  if SaveDialog1.Execute then
  begin
    job.sFileName := SaveDialog1.FileName;
    if SaveDialog1.FilterIndex < 3 then
    begin
      s1 := ExtractFileExt(job.sFileName);
      if Length(s1) = 0 then
      begin
        if SaveDialog1.FilterIndex = 1 then
        begin
          job.sFileName := setFileNameExt(job.sFileName, pc006_108_TypeFl1);
        end
        else
        begin
          job.sFileName := setFileNameExt(job.sFileName, pc006_108_TypeFl2);
        end;
      end;
    end;
    self.Memo1.Lines.Text := job.sFileName;
  end;
end;

procedure TcExportLAS.TabSheet2Show(Sender: TObject);
begin
  inherited;
  Label11.Caption := format(pc006_108_frmSizeInt, [ComboBox1.Text]);
end;

procedure TcExportLAS.ShowParam;
var
  jCrow: Integer;
  s1: String;
  b1: boolean;
begin
  if not Assigned(self.listParam) then Exit;
  self.listChanals.Count := 0;
  self.CheckListBox1.Clear;
  b1 := not self.CheckBox5.Checked;
  for jCrow := 1 to self.listParam.Count do
  begin
    if b1 then
    begin
      if not self.listParam[jCrow].bSaveDB then continue;
    end;
    s1 := Format(pc006_108_frm03, [self.listParam[jCrow].DEPparNum,
                                   self.listParam[jCrow].SGTparNameShrt,
                                   self.listParam[jCrow].SGTparNameType,
                                   self.listParam[jCrow].SGTparNameBig]);
    self.CheckListBox1.Items.Add(s1);
    self.listChanals.Append(@jCrow);
  end;
end;

procedure TcExportLAS.CloseProcessAvr;
begin
  destoyHread1;
  self.BlockWorking.bBlockRsrc := false;
end;

procedure TcExportLAS.CloseProcShow;
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

procedure TcExportLAS.destoyHread1;
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

procedure TcExportLAS.produceFinMsg(var Msg: TMessage);
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

procedure TcExportLAS.ShowProcMessage;
begin
  try
    ShowMessage(self.procDB.sMessage);
  except
  end;
end;

{ TExportLASproc1 }

function TExportLASproc1.addStringField(const sIn, sField: string): string;
var
  s1: String;
begin
  if ImSelf.job.bTreamFld then
  begin
    s1 := Trim(sField);
  end
  else
  begin
    s1 := sField;
  end;

  if Length(sIn) = 0 then
  begin
    result := s1;
  end
  else
  begin
    result := sIn + ImSelf.job.sCodeChar + s1;
  end;
end;

procedure TExportLASproc1.calcLasExport;
var
  t1: Double;
  jCrnt, jIndBeg, jIndEnd, jDepthBeg, jDepthEnd: Integer;
  jFieldDp, jLine, jField,
  jC1, jI1, jI2: Integer;
  rDp, rDp0: Single;
  val: Variant;
  bFree: Boolean;
  myDecimalSeparator: String;
begin
// подготовить столбец с глубиной
  if ImSelf.bGlbDepth then
  begin
    jFieldDp := 1;
    if ImSelf.job.bIncTime then Inc(jFieldDp);
    if ImSelf.job.bIncIndex then Inc(jFieldDp);

    jLine := ImSelf.job.valExport.Count;
    jField := ImSelf.job.valExport.listField.Count;

    rDp0 := ImSelf.job.dNot;
    for jC1 := pc006_108_DBasD to jLine do
    begin
      rDp0 := ImSelf.job.valExport.getValField(jC1, jField); // Depth
      if not isDiapazon(rDp0, ImSelf.job.dNot1, ImSelf.job.dNot2) then break;
    end;

    if not isDiapazon(rDp0, ImSelf.job.dNot1, ImSelf.job.dNot2) then
    begin
      for jC1 :=  pc006_108_DBasD to jLine do
      begin
        rDp := ImSelf.job.valExport.getValField(jC1, jField); // Depth

        if not isDiapazon(rDp, ImSelf.job.dNot1, ImSelf.job.dNot2) then
        begin
          rDp0 := rDp;
        end;
        val := rDp0;
        ImSelf.job.valExport.setField(jC1, 3, val); // Depth
      end;
    end;
  end;

  myDecimalSeparator := DecimalSeparator;
  jRowCur := 0;
  try
    DecimalSeparator := ImSelf.job.sComaChar[1];

    if ImSelf.job.valExport.Count <  pc006_108_DBasD then
    begin
      self.sErr := pc006_108_022;
      Exit;
    end;

    AssignFile(outFile, ImSelf.job.sFileName );	{ Open output file }
    Rewrite(outFile, 1);	{ Record size = 1 }

    try
{
Вывод заголовка
}

  // Вывод заголовков
      if not putLasHeaderToFile then Exit;

// Вывод значений
      if ImSelf.job.bOrigin then
      begin
// Вывод оригинала данных
        for jC1 :=  pc006_108_DBasD to ImSelf.job.valExport.Count do
        begin
          t1 := ImSelf.job.valExport.getValField(jC1, 2); // Time
          if (t1 < ImSelf.job.rcdExport.dtBeg) or (t1 > ImSelf.job.rcdExport.dtEnd) then continue; // это (не) лишнее :-)

          if not putLasBodyToFile(jC1) then Exit;
        end;

      end

      else
      begin
// Найти диапазон глубин
        if not findBegDepth(jIndBeg, jDepthBeg) then
        begin
          self.sErr := pc006_108_022;
          Exit;
        end;
        if not findEndDepth(jIndEnd, jDepthEnd) then
        begin
          self.sErr := pc006_108_022;
          Exit;
        end;
        if jDepthBeg >= jDepthEnd then
        begin
          self.sErr := pc006_108_022;
          Exit;
        end;

        jI1 := jIndBeg;
        jI2 := jIndEnd;
        jCrnt := jDepthBeg;
        while jCrnt <= jDepthEnd do
        begin
          bFree  := not LasDetermineIndex(jCrnt, jI1, jI2);
          if bFree then break;

          if not putLasBodyToFile(pc006_108_CrntD) then Exit;

          CopyCrntToPrev;
          jCrnt := jCrnt + ImSelf.job.jStep;
        end;

      end;

    finally
      CloseFile(outFile);
    end;

  finally
    DecimalSeparator := myDecimalSeparator[1];
    ImSelf.job.valExport.Count := 0;
  end;
end;

procedure TExportLASproc1.CopyCrntToPrev;
begin
  ImSelf.job.valExport.Copy(pc006_108_CrntD, pc006_108_PrevD);
end;

constructor TExportLASproc1.Create(susp: Boolean);
begin
  inherited Create(susp);
end;

destructor TExportLASproc1.Destroy;
begin

  inherited;
end;

procedure TExportLASproc1.doProcess;
begin
  FbCalc := True;

    self.ExportLAS; // Test1; //ExportLAS; //

  FbCalc := False;
end;

procedure TExportLASproc1.ExportLAS;
var
  s1: string;
  bRes: boolean;
  j1: integer;
begin
  try
// 1. Подготовительные операции
    self.FindBoss;
    self.ProtSendBoss(pc006_108_012);
    bRes := false;

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
//    job.valExport.Count := pc003_124_DBasD - 1; // служебные поля

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
        s1 := formatDateTime(pc006_108_frm4, Now) + ' ' + pc006_108_020;
        self.ProtSendBoss(s1);
        s1 := pc006_108_PrtStep + ImSelf.jobAll.sErr;
        self.ProtSendBoss(s1);
        Exit;
      end;

      if Length(ImSelf.jobAll.sErr) > 0 then
      begin
        s1 := pc006_108_PrtStep + ImSelf.jobAll.sErr;
        self.ProtSendBoss(s1);
      end;
      j1 := ImSelf.job.valExport.Count - pc006_108_DBasD + 1;
      s1 := formatDateTime(pc006_108_frm4, Now) + ' ' +
            format(pc006_108_021, [j1]);
      self.ProtSendBoss(s1);

      if j1 = 0 then
      begin
        self.sMessage := pc006_108_022;
        Synchronize( ImSelf.ShowProcMessage );
        Exit;
      end;

      if self.isTerminated then Exit;

// . Экспортировать в LAS
      self.sErr := '';
      self.calcLasExport;
      if self.isTerminated then Exit;

      if Length(self.sErr) > 0 then
      begin
        Synchronize( ImSelf.CloseProcShow );
        self.sMessage := self.sErr;
        s1 := pc006_108_PrtStep + self.sErr;
        self.ProtSendBoss(s1);
        Synchronize( ImSelf.ShowProcMessage );
        Exit;
      end;

      s1 := formatDateTime(pc006_108_frm4, Now) + ' ' + format(pc006_108_024, [self.jRowCur]);
      self.ProtSendBoss(s1);

    finally
      if self.Terminated  then
      begin
        s1 := formatDateTime(pc006_108_frm4, Now) + ' ' + pc006_108_017;
        self.ProtSendBoss(s1);
      end
      else
      begin
        if not bRes then
        begin
          s1 := formatDateTime(pc006_108_frm4, Now) + ' ' + pc006_108_019;
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

function TExportLASproc1.findBegDepth(var jIndex,
  jDepth: Integer): Boolean;
var
  jCnt, jL1, j1, jC1: Integer;
  d1: Double;
  r1: Single;
begin
  result := false;
  jCnt   := ImSelf.job.valExport.Count;
  for jC1 :=  pc006_108_DBasD to jCnt do
  begin
    d1 := ImSelf.job.valExport.getValField(jC1, 2); // Time
    if d1 >= ImSelf.job.rcdExport.dtBeg then
    begin
      r1  := ImSelf.job.valExport.getValField(jC1, 3); // Depth
      try
        j1  := Round(r1 * pc006_108_CmbBx1_Msht);
      except
        j1 := MaxInt;
      end;
      jL1 := j1 div ImSelf.job.jStep;
      if (j1 mod ImSelf.job.jStep) = 0 then
      begin
        jDepth := jL1 * ImSelf.job.jStep;
      end
      else
      begin
        jDepth := (jL1 * ImSelf.job.jStep) + ImSelf.job.jStep;
      end;
      jIndex := jC1;
      result := true;
      Exit;
    end;
  end;
end;

procedure TExportLASproc1.FindBoss;
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

function TExportLASproc1.findEndDepth(var jIndex,
  jDepth: Integer): Boolean;
var
  jCnt, j1, jC1: Integer;
  d1: Double;
  r1: Single;
begin
  result := false;
  jCnt   := ImSelf.job.valExport.Count;
  for jC1 := jCnt downto pc006_108_DBasD do
  begin
    d1 := ImSelf.job.valExport.getValField(jC1, 2); // Time
    if d1 <= ImSelf.job.rcdExport.dtEnd then
    begin
      r1     := ImSelf.job.valExport.getValField(jC1, 3); // Depth
      try
        j1  := Round(r1 * pc006_108_CmbBx1_Msht);
      except
        j1 := MaxInt;
      end;
      jDepth := j1 div ImSelf.job.jStep;
      jDepth := jDepth * ImSelf.job.jStep;
      jIndex := jC1;
      result := true;
      Exit;
    end;
  end;
end;

procedure TExportLASproc1.insertClearRecord(jGoal: Integer;
  var jCrnt: Integer; bNan: Boolean);
var
  r1: Single;
  jC1, jField, jCparCount: Integer;
begin
  if bNan OR (ImSelf.job.jInterp = 1) then
  begin
    r1         := ImSelf.job.constNan;
    jCparCount := ImSelf.job.rcdExport.pFld.Count;
    jField := 3;
    for jC1 := 1 to jCparCount do
    begin
      Inc(jField);
      ImSelf.job.valExport.setField(pc006_108_PrevD, jField, @r1);
    end;
  end;

// ==================================
// jGoal - Где стоим, jCrnt -где дожны были стоять
// мы должны вывести записи от jCrnt до jGoal
  Dec(jGoal, ImSelf.job.jStep);
  while jCrnt < jGoal do
  begin
    r1 := jCrnt; r1 := r1 / pc006_108_CmbBx1_Msht;                 // Искомая глубина
    ImSelf.job.valExport.setField(pc006_108_PrevD, 3, @r1);  // Depth
    if not putLasBodyToFile(pc006_108_PrevD) then Exit;
    Inc(jCrnt, ImSelf.job.jStep);
  end;
end;

function TExportLASproc1.LasDetermineIndex(var jDepthGoal, indBeg,
  indEnd: Integer): Boolean;
var
  jC2, jC1, j1, jField, jCparCount, newIndBeg: Integer;
  t1: Double;
  r1: Single;
  clD1: prqValStat;
  rcd1: rcdValStat;
  b1: Boolean;
begin
  result := False;

  newIndBeg := indBeg;

  b1 := false;
  while newIndBeg <= indEnd do
  begin
    r1 := ImSelf.job.valExport.getValField(newIndBeg, 3); // Depth
    try
      j1  := Round(r1 * pc006_108_CmbBx1_Msht);
    except
      j1 := MaxInt;
    end;
    if j1 >= jDepthGoal then
    begin
      b1 := true;
      break;
    end;
    Inc(newIndBeg);
  end;

  if not b1 then Exit;
  result := True;

  if newIndBeg > indBeg then
  begin
    if j1 > jDepthGoal then
    begin
      Dec(newIndBeg);
    end;
  end;

// Проверяем окно координат
  if (j1 - jDepthGoal) >= ImSelf.job.jStep then
  begin
    if (j1 - jDepthGoal) >= ImSelf.job.jStepInterp then
    begin
// заполняем пропуски NANом
      insertClearRecord(j1, jDepthGoal, true);
    end
    else
    begin
// восстанавливаем пропуски по установке
      insertClearRecord(j1, jDepthGoal, false); // Где стоим, где дожны были стоять
    end;
  end;


// Получаем текущие значения
  j1 := ImSelf.job.valExport.getValField(newIndBeg, 1);    // Index
  t1 := ImSelf.job.valExport.getValField(newIndBeg, 2);    // Time
  r1 := jDepthGoal; r1 := r1 / pc006_108_CmbBx1_Msht;                 // Искомая глубина

  ImSelf.job.valExport.setField(pc006_108_CrntD, 1, @j1);  // Index
  ImSelf.job.valExport.setField(pc006_108_CrntD, 2, @t1);  // Time
  ImSelf.job.valExport.setField(pc006_108_CrntD, 3, @r1);  // Depth

//Каналы:
  jCparCount := ImSelf.job.rcdExport.pFld.Count;
  jField := 3;
  rcd1.jCnt := 0;
  for jC2 := 1 to jCparCount do
  begin
    Inc(jField);

    case ImSelf.job.jMethod of
      0: // Последнее на интервале
      begin
        b1 := false;
        for jC1 := newIndBeg downto indBeg do
        begin
          r1 := ImSelf.job.valExport.getValField(jC1, jField); // Chanal
          if isDiapazon(r1, ImSelf.job.dNot1, ImSelf.job.dNot2) then continue;
          b1 := true;
          break;
        end;

        if not b1 then
        begin
          if ImSelf.job.jInterp = 0 then
          begin
            r1 := ImSelf.job.valExport.getValField(pc006_108_PrevD, jField);
          end
          else
          begin
            r1 := ImSelf.job.dNot;
          end;
        end;
        ImSelf.job.valExport.setField(pc006_108_CrntD, jField, @r1); // Есть последнее значение!!!
      end;

      1: // Среднее на интервале
      begin
        t1 := 0;
        j1 := 0;
        for jC1 := indBeg to newIndBeg do
        begin
          r1 := ImSelf.job.valExport.getValField(jC1, jField); // Chanal
          if isDiapazon(r1, ImSelf.job.dNot1, ImSelf.job.dNot2) then continue;
          t1 := t1 + r1;
          Inc(j1);
        end;
        if j1 = 0 then
        begin
          if ImSelf.job.jInterp = 0 then
          begin
            r1 := ImSelf.job.valExport.getValField(pc006_108_PrevD, jField);
          end
          else
          begin
            r1 := ImSelf.job.dNot;
          end;
          ImSelf.job.valExport.setField(pc006_108_CrntD, jField, @r1);
        end
        else
        begin
          t1 := t1 / j1;
//          ImSelf.job.valExport.setField(pc006_108_PrevD, jField, @t1);
          ImSelf.job.valExport.setField(pc006_108_CrntD, jField, @t1);
        end;
      end;

      2: // Частотный выбор
      begin
        clD1 := prqValStat.Create;
        try
          for jC1 := indBeg to newIndBeg do
          begin
            r1 := ImSelf.job.valExport.getValField(jC1, jField); // Chanal
            if isDiapazon(r1, ImSelf.job.dNot1, ImSelf.job.dNot2) then continue;
            rcd1.dVal := r1;
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
            if ImSelf.job.jInterp = 0 then
            begin
              r1 := ImSelf.job.valExport.getValField(pc006_108_PrevD, jField);
            end
            else
            begin
              r1 := ImSelf.job.dNot;
            end;
            ImSelf.job.valExport.setField(pc006_108_CrntD, jField, @r1);
          end
          else
          begin
            clD1.SortFast(2);
            t1 := clD1[clD1.Count].dVal;
//            ImSelf.job.valExport.setField(pc003_124_PrevD, jField, @t1);
            ImSelf.job.valExport.setField(pc006_108_CrntD, jField, @t1);
          end;
        finally
          clD1.Free;
        end;
      end;
    end;
  end;

  indBeg := newIndBeg + 1;
end;

procedure TExportLASproc1.ProtSendBoss(s1: string);
begin
  if HandleBoss <> 0 then
  begin
    uSupport.putString(s1, HandleBoss, pc006_108_jMain);
    Msg.LParam   := pc006_108_jMain;
    SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
  end;
end;

function TExportLASproc1.putLasBody(jIndRcd: Integer): string;
var
  j1, jCparCount, jC2, jField: Integer;
  t1: Double;
  r1: Single;
  s1: String;
begin
  result := '';

  jField := 1;

  if ImSelf.job.bIncIndex then
  begin
    j1 := ImSelf.job.valExport.getValField(jIndRcd, jField); // Index
    if j1 > 0 then
    begin
      s1 := format(pc006_108_frmI0, [j1]);
      result := addStringField(result, s1);
    end;
  end;
  Inc(jField);

  if ImSelf.job.bIncTime then
  begin
    t1 := ImSelf.job.valExport.getValField(jIndRcd, jField); // Time
//    if not isDiapazon(t1, ImSelf.job.dNot1, ImSelf.job.dNot2) then
    begin
      s1 := FormatDateTime(ImSelf.job.sFrm, t1);
      result := addStringField(result, s1);
    end;
  end;
  Inc(jField);

  if ImSelf.job.bIncDepth then
  begin
    r1 := ImSelf.job.valExport.getValField(jIndRcd, jField); // Depth
//    if not isDiapazon(r1, ImSelf.job.dNot1, ImSelf.job.dNot2) then
    begin
      s1 := Format(ImSelf.job.sFrmH, [r1]);
      result := addStringField(result, s1);
    end;
  end;
  Inc(jField);

  jCparCount := ImSelf.job.rcdExport.pFld.Count;
  if ImSelf.bGlbDepth then Dec(jCparCount);
  for jC2 := 1 to jCparCount do
  begin
    r1 := ImSelf.job.valExport.getValField(jIndRcd, jField); // Chanal
    if not isDiapazon(r1, ImSelf.job.dNot1, ImSelf.job.dNot2) then
    begin
          s1 := Format(pc006_108_frmV0, [r1]);
      result := addStringField(result, s1);
    end
    else
    begin
          s1 := Format(pc006_108_frmV0, [ImSelf.job.constNan]);
      result := addStringField(result, s1);
    end;
    Inc(jField);
  end;
end;

function TExportLASproc1.putLasBodyToFile(jIndRcd: Integer): Boolean;
var
  s1: String;
begin
  result := false;
  s1 := putLasBody(jIndRcd);
  if Length(s1) > 0 then
  begin
    if not writeTOfile(s1) then Exit;
    Inc(jRowCur)
  end;
  result := true;
end;

function TExportLASproc1.putLasHeader: string;
var
  jC1, jCparCount, jC2: Integer;
  s1: String;
begin
  result := '';
// Вывод подписей к колонкам
  result :=   result + pc006_108_LAS_VI_B + #13#10;
  result :=   result + pc006_108_LAS_VI_1 + #13#10;
  result :=   result + pc006_108_LAS_VI_2 + #13#10;

  result :=   result + pc006_108_LAS_WI_B  + #13#10;
  result :=   result + pc006_108_LAS_WI_MU + #13#10;
  result :=   result + format(pc006_108_LAS_WI_01, [FloatToStr(0)]) + #13#10;
  result :=   result + format(pc006_108_LAS_WI_02, [FloatToStr(0)]) + #13#10;
  result :=   result + pc006_108_LAS_WI_03 + #13#10;
  result :=   result + format(pc006_108_LAS_WI_04, [FloatToStr(ImSelf.job.constNan)]) + #13#10; //      = '  NULL.  %s: Null value';
  result :=   result + pc006_108_LAS_WI_05 + #13#10;
  result :=   result + pc006_108_LAS_WI_06 + #13#10;
  result :=   result + pc006_108_LAS_WI_07 + #13#10;
  result :=   result + pc006_108_LAS_WI_08 + #13#10;
  result :=   result + pc006_108_LAS_WI_09 + #13#10;
  result :=   result + pc006_108_LAS_WI_10 + #13#10;
  result :=   result + pc006_108_LAS_WI_11 + #13#10;
  result :=   result + pc006_108_LAS_WI_12 + #13#10;
  result :=   result + pc006_108_LAS_WI_13 + #13#10;
  result :=   result + pc006_108_LAS_WI_14 + #13#10;
  result :=   result + pc006_108_LAS_WI_15 + #13#10;

  result :=   result + pc006_108_LAS_CI_B  + #13#10;
  result :=   result + pc006_108_LAS_CI_MU + #13#10;

  s1     := '';
  jC1    := 0;
  if ImSelf.job.jLegend > 0 then
  begin
    if ImSelf.job.bIncIndex then
    begin
      s1 := addStringField('', format(pc006_108_frmS0, [pc006_108_103]));
      Inc(jC1);
      result :=   result + format(pc006_108_LAS_CI_XX, [jC1, s1]) + #13#10;
    end;

    if ImSelf.job.bIncTime then
    begin
      s1 := addStringField('', format(pc006_108_frmS0, [pc006_108_101]));
      Inc(jC1);
      result :=   result + format(pc006_108_LAS_CI_XX, [jC1, s1]) + #13#10;
    end;

    if ImSelf.job.bIncDepth then
    begin
      s1 := addStringField('', format(pc006_108_frmS0, [pc006_108_102]));
      Inc(jC1);
      result :=   result + format(pc006_108_LAS_CI_XX, [jC1, s1]) + #13#10;
    end;

    jCparCount := ImSelf.job.rcdExport.pFld.Count;
    for jC2 := 1 to jCparCount do
    begin
      s1 := ImSelf.job.valLegend.getAsString(jC2);
      if Length(s1) = 0 then s1 := pc006_108_EmptyHeadField;
      s1 := addStringField('', format(pc006_108_frmS0, [s1]));
      Inc(jC1);
      result :=   result + format(pc006_108_LAS_CI_XX, [jC1, s1]) + #13#10;
    end;
  end;

  result :=   result + pc006_108_LAS_AD_B;
end;

function TExportLASproc1.putLasHeaderToFile: Boolean;
var
  s1: String;
begin
  result := false;
  s1 := putLasHeader;
  if ImSelf.job.jCodeFile = pc006_108_CodeDOS then
  begin
    s1 := ImSelf.jobExp.coder.CoderWorker(s1, 2, 1);
  end;
  if Length(s1) > 0 then
  begin
    if not writeTOfile(s1) then Exit;
//    Inc(jRowCur);
  end;
  result := true;
end;

procedure TcExportLAS.CheckBox5Click(Sender: TObject);
begin
  inherited;
  self.ShowParam;
end;

function TExportLASproc1.writeTOfile(s1: string): boolean;
var
  jCntWrite, jCntStr: Integer;
begin
  result := false;
  try
{
    if self.job.jobExportLas.jCodeFile = pc006_108_CodeDOS then
    begin
      s1 := self.job.coder.CoderWorker(s1, 2, 1);
    end;
}
    s1 := s1 + #13#10;
    jCntStr := Length(s1);
    BlockWrite(outFile, s1[1], jCntStr, jCntWrite);
    if jCntStr = jCntWrite then result := true;
  except
  end;
end;

end.
