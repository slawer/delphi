unit uReportSGTv1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, upf1, uMainData, uMainConst, ActnList, Menus,
  ExtCtrls, ScktComp, ComCtrls, Grids, registry, StdCtrls, ComObj, ShellAPI, Buttons,
  IniFiles,
  uMsgDial,
  uAbstrExcel, uAbstrArray,
  DateUtils, jpeg,
  CheckLst, xmldom, XMLIntf, msxmldom, XMLDoc,
  Spin,
  uReportSGTv1const, uSGTreportJob1, uCalendar1,
  uShowDEPparam1, uShowDEPparam1const, uSGTreportJob1Const, uShowSGTparam1, uShowSGTparam1const,
  uShowREPparam1, uShowREPparam1const, uDEPdescript2, uDEPdescriptconst, uSGTlibDB1Const, uOreolProtocol6,
  DB, ADODB;

type
  TreadDBproc1 = class(prqTHread)
  private
    jCicle: Integer;
    sErr: string;
//    procedure Test1;
//    procedure Test2;
    procedure GetByTime1;
  protected

  public
    procedure diagnose;
    procedure endProc;
    procedure errProc;
    procedure doProcess; override;
    constructor Create(susp: Boolean);
    destructor Destroy; override;
  published

  end;


  TcReportSGTv1 = class(Tpf2)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ActionList1: TActionList;
    Action1: TAction;
    Action7: TAction;
    Exit1: TMenuItem;
    N10: TMenuItem;
    OpenDialog1: TOpenDialog;
    PrintDialog1: TPrintDialog;
    XMLDocument1: TXMLDocument;
    N4: TMenuItem;
    Action14: TAction;
    N8: TMenuItem;
    N17: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    Action3: TAction;
    Panel4: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    BitBtn1: TBitBtn;
    Action5: TAction;
    N3: TMenuItem;
    Action2: TAction;
    N5: TMenuItem;
    Action4: TAction;
    N6: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn2: TBitBtn;
    Edit4: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    ADOConnection1: TADOConnection;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Action1Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action14Execute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    bLast: Boolean;
    keyStr: Integer; // Номер строки сообщения из БД

    job: SGTreportJob1; // Задание на работу

// Параметры запроса на формирование суточного рапорта СГТ
//    Hour, Year, Month, Day: Integer;
    dDate, dHour: TDateTime;
    procDB: TreadDBproc1; // Процесс расчёта рапорта

    procedure SendStringToSelf(const sOut: String; bShow: Boolean; nPanel: Integer);
    procedure CloseProcShow;

    function  QueryReportCheck: Boolean;
    function  QueryReportCreate: Boolean;
    function  addNewParam(numbe_prm: Integer): Boolean;


    procedure destoyHread1;

    function _LoadParam(var sAvr: string): integer;

  public
    { Public declarations }
    bAvar:          Boolean;
    BlockWorking:   prqTBlockRsrc;

    sNameFilePar:   String;         // имя файла с параметрами
    sNameFileShab:  String;         // имя файла с шаблоном
    sNameFileStage: String;         // имя файла с этапами



    procedure ShowAllParam;

    procedure unknowDialogMessage(var Msg: TMessage; kode: Integer); override;
    procedure produceFinMsg(var Msg: TMessage); override;
  end;

var
  cReportSGTv1: TcReportSGTv1;

implementation
uses uSupport;

{$R *.dfm}

procedure TcReportSGTv1.FormCreate(Sender: TObject);
begin
  procDB := nil;
  keyStr := 0;
  bLast  := False;
  bAvar  := False;
  DecimalSeparator        := ',';
  TimeSeparator           := ':';
  DateSeparator           := '.';
  ShortDateFormat         := 'dd.mm.yyyy';
  ShortTimeFormat         := 'hh:nn:ss';

  Application.Title       := pc006_02_ProjectZGL;
  Caption                 := pc006_02_ProjectName;

// Загрузка библиотеки DEP БД:
  job                     := SGTreportJob1.Create;
  if not job.LibInit(ADOConnection1, pc006_02_DepDLLName) then
  begin
    ShowMessage(pc006_02_DepDLLavr);
    bAvar := true;
    Exit;
  end;

  taskParam               := TtaskParam.Create;
  taskParam.ProjectName   := pc006_02_ProjectName;
  taskParam.MainGUID      := pc006_02_MainGUID;
  taskParam.mainPath      := pc006_02_SoftPath;
  taskParam.regTask;

  inherited;

  bTag  := True;
  bGeom := True;

// Зарегистрировать форму Create and register object
  jUniType                := tobjMain;
  jUniKeyBoss             := 0;
  registryObj(taskParam, jUniKeySelf, jUniKeyBoss, jUniType, self);
  taskParam.mainKey       := jUniKeySelf;

  job.jUniType            := pc006_02_JobMain;
  job.jUniKeyBoss         := jUniKeySelf;
  job.Caption             := pc006_02_ServiceCaption;
  job.dirStart            := extractFilePath(paramStr(0));
  job.dirCrnt             := IncludeTrailingPathDelimiter(GetCurrentDir);
  job.cnfSgtParamName     := job.dirCrnt + pc006_02_ConfigSGTparName;
  job.tmpSgtRptParamName  := job.dirCrnt + pc006_02_ConfigTMPdatName;
  job.xlsSgtRptShblnName  := job.dirCrnt + pc006_02_ConfigSHBxlsName;
  job.xlsSgtRptReprtName  := job.dirCrnt + pc006_02_ConfigRPTxlsName;
  job.XMLDocument1        := self.XMLDocument1;

  registryObj(taskParam, job.jUniKeySelf, jUniKeySelf, job.jUniType, job);

// Восстановить параметры Restore parameters
  getParam;

  BlockWorking := prqTBlockRsrc.Create;
  BlockWorking.bBlockRsrc := false;

//  PanelResize;
end;

procedure TcReportSGTv1.Action1Execute(Sender: TObject);
begin
  Close;
end;

procedure TcReportSGTv1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if BlockWorking.isBlockRsrc then
  begin
    if MessageDlg( pc006_02_1102, mtConfirmation, [mbYes,mbNo], 0 ) <> mrYes then Exit;
    destoyHread1;
  end;
  BlockWorking.Free;

  try
    if job.DEPsgtParam.Modify or job.DEPqueParam.Modify then
    begin
      job.sgtParamSave;
    end;
  except end;

  try
    if isCanCloseChilObj(taskParam, jUniKeySelf, True) then
      UnregChildTreeObj(taskParam, jUniKeySelf, jUniKeySelf);
  except end;

  inherited;

  taskParam.Free;
end;

procedure TcReportSGTv1.Action7Execute(Sender: TObject);
begin
// Запросить список параметров
end;

procedure TcReportSGTv1.unknowDialogMessage(var Msg: TMessage;
  kode: Integer);

procedure PrintMessage;
var
  s1: String;
begin
  s1 := extStr.movePull(Msg.LParam);
  ShowMessage(s1);
end;


var
  s1: String;
begin
  if kode = WM_User_Dialog then
  begin
    case Msg.WParamLo of // Номер процесса
110:
      begin
        PrintMessage;
        Exit;
      end;

{
111:
      begin // Завершение приема данных по рапорту
        calcRaport;
        Exit;
      end;
}
{
112:
      begin // Завершение приема данных по экспорту
        calcExport2;
        Exit;
      end;
}
{
113:
      begin // Завершение приема данных по экспорту
        calcLasExport;
        Exit;
      end;
}
120..121: // Получено сообщение
      begin
        s1 := extStr.movePull(Msg.LParam);
        Memo1.Lines.Add(s1);
        if Msg.WParamHi = 1 then
        begin // Известить однако надо бы товарища об ошибке - ждет ведь данные
          ShowMessage(s1);
        end;
        Exit;
      end;

122: // Получено сообщение
      begin
        s1 := extStr.movePull(Msg.LParam);
        if Length(s1) > 0 then
          Memo1.Lines.Add(s1);
        Exit;
      end;

{
123: // Получено сообщение
      begin
        if bdM <> bdMprev then
        begin
          s1 := extStr.movePull(Msg.LParam);
          if Length(s1) > 0 then
            Memo1.Lines.Add(s1);
          bdMprev := bdM;
        end;
        Exit;
      end;
}
{
pc003_133_AcceptMsg:
      begin // Обновлена таблица этапов и параметры
      end;
}

pc006_02_AcceptMsg1:
      begin // Вывести рапорт
        if Length(job.sErr) > 0 then
        begin
          ShowMessage(job.sErr);
        end;
        Action4Execute(nil);
        Exit;
      end;
{
201:
      begin // Запрос isBdmWrk XLS
        if isBdmWrk then
        begin
          Msg.Result := 1;
          bdM := bdcWaiteXLSData;
        end
        else
          Msg.Result := 0;
        Exit;
      end;
}
{
202:
      begin // Запрос isBdmWrk Las
        if isBdmWrk then
        begin
          Msg.Result := 1;
          bdM := bdcWaiteLasData;
        end
        else
          Msg.Result := 0;
        Exit;
      end;
}
    end;
  end;

  inherited;
end;

procedure TcReportSGTv1.ShowAllParam;
begin
// Показать таблицу "Общие"

// Показать таблицу "редактор_этапов"

// Показать подписи

// Показать таблицу "обсадная_колонна"

// Показать таблицу "скважина"

// Показать таблицу "замечания_комментарии"
end;

procedure TcReportSGTv1.SendStringToSelf(const sOut: String; bShow: Boolean; nPanel: Integer);
var
  Msg: TMessage;
begin
  if keyStr = High(Integer) then keyStr := 0;
  Inc(keyStr);
  putString(sOut, Handle, keyStr);
  Msg.WParamLo := nPanel; // 122
  if bShow then Msg.WParamHi := 1 else Msg.WParamHi := 0;
  Msg.LParam   := keyStr;
  PostMessage(Handle, WM_User_Dialog, Msg.WParam, Msg.LParam);
end;

procedure TcReportSGTv1.produceFinMsg(var Msg: TMessage);
begin
  Application.ProcessMessages;
  case Msg.WParam of
    cWPar_UF_ProcAbort:
    begin
// аварийное завершение операции с БД
      destoyHread1;
      self.BlockWorking.bBlockRsrc := false;
      self.Memo1.Lines.Add(formatDateTime(pc006_02_1114, Now) + pc006_02_1117);
      ShowMessage(pc006_02_1122);
    end;
    else
      inherited;
  end;
  Msg.Result := 0;
  Application.ProcessMessages;
end;

procedure TcReportSGTv1.CloseProcShow;
var
  j1: Integer;
begin
  j1 := findRegistryObjType(taskParam, tobjShowProc);
  if j1 > 0 then
  begin
    (taskParam.treeObj[j1].cls as Tpf2).bMustSave := False;
    (taskParam.treeObj[j1].cls as Tpf2).bNoUnReg  := False;
    (taskParam.treeObj[j1].cls as TForm).WindowState := wsNormal;
    (taskParam.treeObj[j1].cls as TForm).Show;
    (taskParam.treeObj[j1].cls as Tpf2).Close;
  end;
end;

procedure TcReportSGTv1.Action14Execute(Sender: TObject);
var
  pDD: TcShowSGTparam1;
begin
// Создать диалог
  if self.BlockWorking.isBlockRsrc then
  begin
    ShowMessage(pc006_02_1103);
    Exit;
  end;

  try
    pDD := TcShowSGTparam1.Create(self);
    pDD.taskParam := taskParam;
    registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
    pDD.bTag  := True;
    pDD.bGeom := True;
    pDD.getParam;
    pDD.CreateIMG(job.DEPdepParam, job.DEPsgtParam, self.BlockWorking);
    pDD.ShowModal;

  finally
    self.BlockWorking.bBlockRsrc := false;
  end;
end;

procedure TcReportSGTv1.FormActivate(Sender: TObject);
var
  sAvr: string;
  jCode: Integer;
begin
  inherited;
  if bLast then Exit;

  bLast := true;

  try


// Загрузка списка параметров соотношений содержательных понятий рапорта СГТ
    job.sErr := '';
    jCode := job.sgtParamLoad;
    sAvr  := '';
    if jCode <> 0 then
    begin
      case jCode of
       -1: begin sAvr := pc006_02_1001; job.sErr := ''; end;
       -2: begin sAvr := pc006_02_1101; jCode := 0; job.sErr := ''; end;

pc005_504_XMLerr_001:
           begin sAvr := job.sErr; jCode := 0; end;

pc005_504_XMLerr_002:
           begin sAvr := pc005_504_cMSG_003; jCode := 0; end;

pc005_504_XMLerr_003:
           begin sAvr := pc005_504_cMSG_003; jCode := 0; end;

      else
           begin sAvr := job.sErr; if Length(sAvr) = 0 then sAvr := pc006_02_1002; end;
      end;
    end
    else
    begin
      if Length(job.sErr) <> 0 then sAvr := job.sErr;
    end;
    if Length(sAvr) <> 0 then ShowMessage(sAvr);
    if jCode <> 0 then
    begin
      Close;
      Exit;
    end;

  except
    on E: Exception do
    begin
      sAvr := E.Message;
      if Length(sAvr) = 0 then sAvr := pc006_02_1005 else sAvr := sAvr + pc006_02_1006;
      ShowMessage(sAvr);
    end;
  end;

// Связаться с DLL, получить список параметров
  _LoadParam(sAvr);
  if Length(sAvr) <> 0 then ShowMessage(sAvr);
end;

procedure TcReportSGTv1.Action3Execute(Sender: TObject);
var
  pDD: TcShowDEPparam1;
  j1: Integer;
begin
// Показать список параметров БД
  j1 := findRegistryObjType(taskParam, pc005_103_jMain);
  if j1 > 0 then
  begin
    (taskParam.treeObj[j1].cls as TForm).WindowState := wsNormal;
    (taskParam.treeObj[j1].cls as TForm).Show;
    Exit;
  end;

// Создать диалог
  pDD := TcShowDEPparam1.Create(self);
  pDD.taskParam := taskParam;
  registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
  pDD.bTag  := True;
  pDD.bGeom := True;
  pDD.getParam;
  pDD.CreateIMG(job.DEPdepParam);
  pDD.Show;
end;

procedure TcReportSGTv1.BitBtn1Click(Sender: TObject);
var
  clndr: TcCalendar1;
  dT: TDateTime;
  Year, Month, Day: Word;
begin
  inherited;
  clndr := TcCalendar1.Create(self);
  try
    clndr.MonthCalendar1.Date := Date - 1;
    clndr.ShowModal;
    if clndr.bFinish then
    begin
      dT := clndr.MonthCalendar1.Date;
      DecodeDate(dT, Year, Month, Day);
      self.Edit5.Text := IntToStr( Day );
      self.Edit6.Text := IntToStr( Month );
      self.Edit7.Text := IntToStr( Year );
    end;
  finally
    clndr.Free;
  end;
end;

procedure TcReportSGTv1.Action5Execute(Sender: TObject);
begin
  inherited;
// Создать Суточный рапорт
  if self.BlockWorking.isBlockRsrc then
  begin
    ShowMessage(pc006_02_1103);
    Exit;
  end;

  if not QueryReportCheck then
  begin
    self.BlockWorking.bBlockRsrc := false;
    Exit;
  end;

// Сформировать задание на рапорт, расчитать рапорт!
  if MessageDlg( format(pc006_02_1110, [DateTimeToStr(dDate + dHour)]),
                 mtConfirmation, [mbYes, mbNo], 0) <> mrYes
  then
  begin
    self.BlockWorking.bBlockRsrc := false;
    Exit;
  end;

// Сформировать запрос на данный
  if QueryReportCreate then
  begin
    destoyHread1;

    self.Memo1.Lines.Add(formatDateTime(pc006_02_1114, Now) + pc006_02_1115);

// Запуск процесса расчёта
    procDB := TreadDBproc1.Create(true); // Процесс расчёта рапорта
    procDB.jTimeOut := pc006_02_Hread_01;
    procDB.Priority := tpNormal; // tpNormal; //tpHigher; // tpLower;
    procDB.jUniType := pc006_02_Hread_02;
    procDB.jUniKeyBoss := jUniKeySelf;
//    registryObj(taskParam, procDB.jUniKeySelf, procDB.jUniKeyBoss, procDB.jUniType, procDB);
    procDB.Caption  := 'Process to service Oreol DB';
    procDB.FreeOnTerminate := false;
    procDB.taskParam := taskParam;
    procDB.bNoUnReg := True;
    ShowProcess(taskParam, jUniKeySelf, True, pc006_02_1104, nil); // Повесить заставку
    procDB.Resume;
  end
  else
  begin
    self.BlockWorking.bBlockRsrc := false;
  end;
end;

function TcReportSGTv1.QueryReportCheck: Boolean;
var
  Hour, Year, Month, Day: Integer;
  Start: TDateTime;
begin
  result := false;

  if not uSupport.prqStrToInt(Trim(self.Edit5.Text), Day) then
  begin
    ShowMessage(pc006_02_1105);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit6.Text), Month) then
  begin
    ShowMessage(pc006_02_1106);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit7.Text), Year) then
  begin
    ShowMessage(pc006_02_1107);
    Exit;
  end;

  if not TryEncodeDate(Year, Month, Day, dDate) then
  begin
    ShowMessage(pc006_02_1108);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit8.Text), Hour) then
  begin
    ShowMessage(pc006_02_1109);
    Exit;
  end;
  if (Hour < 0) or (Hour > 23) then
  begin
    ShowMessage(pc006_02_1109);
    Exit;
  end;
  dHour := Hour; dHour := dHour / 24;

  if not uSupport.prqStrToInt(Trim(self.Edit1.Text), Day) then
  begin
    ShowMessage(pc006_02_1105);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit2.Text), Month) then
  begin
    ShowMessage(pc006_02_1119);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit3.Text), Year) then
  begin
    ShowMessage(pc006_02_1120);
    Exit;
  end;

  if not TryEncodeDate(Year, Month, Day, Start) then
  begin
    ShowMessage(pc006_02_1121);
    Exit;
  end;

  self.job.dStart := Start;
  self.job.Skva   := Trim(Edit4.Text);
  self.job.Kust   := Trim(Edit9.Text);
  self.job.Zakaz  := Trim(Edit10.Text);
  self.job.Podr   := Trim(Edit11.Text);
  self.job.Mast   := Trim(Edit12.Text);

  result := true;
end;

function TcReportSGTv1.QueryReportCreate: Boolean;
begin
  result := false;
// Работа с временами запроса
  job.DEPqueParam.dBeg := self.dDate + self.dHour;
  job.DEPqueParam.dEnd := job.DEPqueParam.dBeg + 1;

// Подготовка приёмника под каналы
  job.DEPqueParam.valReport.clrField;
  job.DEPqueParam.listReport.Count := 0;

//  job.DEPrptParam.valReport.addField(ftInteger, 0);   // Индекс
//  job.DEPrptParam.valReport.addField(ftDouble,  0);   // Дата время
//  job.DEPrptParam.valReport.addField(ftSingle,  0);   // Глубина

  if not addNewParam(pc005_504_NumPar_DateTime) then Exit;
  if not addNewParam(pc005_504_NumPar_DepthZab) then Exit;
  if not addNewParam(pc005_504_NumPar_Etap) then Exit;
//  if not addNewParam(pc005_504_NumPar_Rezhim) then Exit;

  result := true;
end;

function TcReportSGTv1.addNewParam(numbe_prm: Integer): Boolean;
var
  jN: Integer;
  rcdDEP: rcdDEPdepParam;
  rcdSGT: rcdDEPsgtParam;
  s1: string;
begin
  result := false;
  rcdSGT.SGTparNum := numbe_prm;
  jN := self.job.DEPsgtParam.Find(@rcdSGT, 1);
  if jN <= 0 then
  begin
    s1 := format(pc006_02_1112, [self.job.getNameSGTParam(numbe_prm)]);
    ShowMessage(s1);
    Exit;
  end;

  rcdDEP.DEPparNum := self.job.DEPsgtParam[jN].DEPparNum;
  if rcdDEP.DEPparNum < 0 then
  begin
    result := true;
    Exit;
  end;

  jN := self.job.DEPdepParam.Find(@rcdDEP, 1);
  if jN > 0 then
  begin
    self.job.DEPqueParam.listReport.Append( @numbe_prm );    // Номер параметра
    case numbe_prm of // Значение параметра
pc005_504_NumPar_DateTime:
         self.job.DEPqueParam.valReport.addField(ftDouble, 0); // Время - Double
                                                          // Какие-то парамы ещё как-то
    else self.job.DEPqueParam.valReport.addField(ftSingle, 0); // Прочие - Single по умолчанию
    end;
  end
  else
  begin
    s1 := format(pc006_02_1118, [self.job.getNameSGTParam(numbe_prm)]);
    ShowMessage(s1);
    Exit;
  end;
  result := true;
end;

{ TreadDBproc1 }

constructor TreadDBproc1.Create(susp: Boolean);
begin
  inherited Create(susp);
end;

destructor TreadDBproc1.Destroy;
begin

  inherited;
end;

procedure TreadDBproc1.diagnose;
begin
  cReportSGTv1.Memo1.Lines.Add( IntToStr(jCicle) );
  Application.ProcessMessages;
end;

procedure TreadDBproc1.doProcess;
begin
  FbCalc := True;

//1. Формирование запроса к DLL
//2. Вызов процедуры создания файла
//3. Чтение и распаковка файла

  GetByTime1;
//  Test3;

  FbCalc := False;
end;

procedure TreadDBproc1.endProc;
begin
  cReportSGTv1.Memo1.Lines.Add(formatDateTime(pc006_02_1114, Now) + pc006_02_1116);
  Application.ProcessMessages;
end;

procedure TreadDBproc1.errProc;
begin
  cReportSGTv1.Memo1.Lines.Add(formatDateTime(pc006_02_1114, Now) + ' ' + sErr);
  Application.ProcessMessages;
end;
{
procedure TreadDBproc1.Test1;
begin
  jCicle := 5;
  repeat
    Dec(jCicle);
    if isTerminated then break;

    sleep(2000);
    Synchronize( diagnose );
  until jCicle = 0;

  cReportSGTv1.BlockWorking.bBlockRsrc := false;
  if not isTerminated then Synchronize( endProc );
  Synchronize( cReportSGTv1.CloseProcShow );
end;
}
procedure TcReportSGTv1.destoyHread1;
begin
  if procDB <> nil then
  begin
    try
      if procDB.FbCalc then
      begin
        KillProcess(self.procDB);
      end;
    except
    end;
    try
      procDB.Free;
    except
    end;
    procDB := nil;
    try
      CloseProcShow;
    except
    end;
  end;
end;
{
procedure TreadDBproc1.Test2;
var
  pParameterID: PInteger;
  ParameterID: array [1..255] of Integer;
  jC1, j1: Integer;
begin
//1. Формирование запроса к DLL
  ParameterID[1] := cReportSGTv1.job.FindSGTparam(cReportSGTv1.job.DEPrptParam.listReport[1]^);
  for jC1 := 2 to 255 do
  begin
    ParameterID[jC1] := -jC1;
  end;
  pParameterID := @ParameterID[127];

  try
    try
      j1 := cReportSGTv1.job.CreateDataFile(
            'DataPath',
            LPTSTR(cReportSGTv1.job.tmpSgtParamName),
            Date,
            Date + 0.5,
            LPTSTR(cReportSGTv1.job.DEPrptParam.NULLValue),
            2,
            pParameterID,
            LPTSTR(cReportSGTv1.job.DEPrptParam.Delimeter),
            3, 10, 0);
    except
      j1 := -1;
      sErr := '!!!';
    end;

    if j1 < 0 then
    begin
      Synchronize( errProc );
    end
    else
    if j1 = 0 then
    begin
      if not isTerminated then Synchronize( endProc );
      for jC1 := 0 to 11 do
      begin
        sErr := cReportSGTv1.job.GetLastError(jC1);
        Synchronize( errProc );
      end;
    end
    else
    begin
      sErr := cReportSGTv1.job.GetLastError(0);
      Synchronize( errProc );
    end;
  finally
    cReportSGTv1.BlockWorking.bBlockRsrc := false;
    Synchronize( cReportSGTv1.CloseProcShow );
  end;

//2. Вызов процедуры создания файла
//3. Чтение и распаковка файла
end;
}
procedure TreadDBproc1.GetByTime1;
var
  procResult: Integer;
  Msg: TMessage;
begin
  procResult := -1;
  cReportSGTv1.job.sErr := '';
  try

    try
// Вызов процедуры создания файла
      procResult := cReportSGTv1.job.CreateDataFileByTime(
                      cReportSGTv1.job.DEPqueParam.listReport,
                      cReportSGTv1.job.DEPqueParam.valReport,

                      cReportSGTv1.dDate + cReportSGTv1.dHour,
                      cReportSGTv1.dDate + cReportSGTv1.dHour + 1,

                      uOreolProtocol6.cdbTOutVal);

      sErr := Trim( cReportSGTv1.job.sErr );
      if Length(sErr) > 0 then Synchronize( errProc );

    except
      on E: Exception do
      begin
        procResult := -1;
        sErr   := E.Message;
      end;
    end;
    if procResult < 0 then
    begin
      Synchronize( errProc );
      Exit;
    end
    else
    if procResult <= 1 then
    begin
      sErr := pc006_02_006;
      Synchronize( errProc );
    end
    else
    begin
      Exit;
    end;
    if isTerminated then Exit;

// Подготовка рапорта - создание XLS файла
    try

      procResult := cReportSGTv1.job.createRaport;

    except
      on E: Exception do
      begin
        procResult := -1;
        sErr   := E.Message;
      end;
    end;
    if procResult < 0 then
    begin
      Synchronize( errProc );
      Exit;
    end
    else
    if procResult = 0 then
    begin
    end
    else
    begin
      sErr := cReportSGTv1.job.sErr;
      Synchronize( errProc );
      Exit;
    end;
    sErr := format(pc006_02_009, [cReportSGTv1.job.lastDoc]);
    Synchronize( errProc );

  finally
    cReportSGTv1.BlockWorking.bBlockRsrc := false;
    Synchronize( cReportSGTv1.CloseProcShow );
    if not isTerminated then
    begin
      if procResult = 0 then
      begin
        Synchronize( endProc );
        Msg.WParamLo := pc006_02_AcceptMsg1;
        Msg.WParamHi := 0;
        PostMessage(cReportSGTv1.Handle, WM_User_Dialog, Msg.WParam, Msg.LParam);
      end;
    end
    else
    begin
      cReportSGTv1.job.DEPqueParam.listReport.Count := 0;
      cReportSGTv1.job.DEPqueParam.valReport.Count := 0;
    end;
  end;
end;

procedure TcReportSGTv1.Action2Execute(Sender: TObject);
var
  pDD: TcShowREPparam1;
  s1: string;
begin
// Создать диалог
  if self.BlockWorking.isBlockRsrc then
  begin
    ShowMessage(pc006_02_1103);
    Exit;
  end;

  try
    pDD := TcShowREPparam1.Create(self);
    pDD.taskParam := taskParam;
    registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
    pDD.bTag  := True;
    pDD.bGeom := True;
    pDD.getParam;
    s1 := job.DEPqueParam.RefrPath;
    pDD.CreateIMG(job.DEPqueParam);
    pDD.ShowModal;
    if job.DEPqueParam.Modify then
    begin
      if s1 <> job.DEPqueParam.RefrPath then
      begin // Перегрузить параметры
        _LoadParam(s1);
        if Length(s1) <> 0 then ShowMessage(s1);
      end;
    end;

  finally
    self.BlockWorking.bBlockRsrc := false;
  end;
end;

procedure TcReportSGTv1.Action4Execute(Sender: TObject);
var
  xls: TprqExcel;
  s1: string;
begin
  inherited;
// Показать последний рапорт
  if self.BlockWorking.isBlockRsrc then
  begin
    ShowMessage(pc006_02_1103);
    Exit;
  end;

  try
    if not FileExists(self.job.xlsSgtRptReprtName) then
    begin
      ShowMessage(pc006_02_010);
      Exit;
    end;

    xls := TprqExcel.Create;
    try
      if Sender = nil then
      begin
        s1 := self.job.lastDoc;
      end
      else
      begin
        s1 := self.job.xlsSgtRptReprtName;
      end;

      if not xls.OpenWorkBook(s1) then
      begin
        ShowMessage(xls.strErr);
        Exit;
      end;
      if not xls.OpenWorkSheet(1) then
      begin
        ShowMessage(xls.strErr);
        Exit;
      end;

      xls.showExcel;
    finally
      xls.Free;
    end;

  finally
    self.BlockWorking.bBlockRsrc := false;
  end;
end;

procedure TcReportSGTv1.BitBtn2Click(Sender: TObject);
var
  clndr: TcCalendar1;
  dT: TDateTime;
  Year, Month, Day: Word;
begin
  inherited;
  clndr := TcCalendar1.Create(self);
  try
    clndr.ShowModal;
    if clndr.bFinish then
    begin
      dT := clndr.MonthCalendar1.Date;
      DecodeDate(dT, Year, Month, Day);
      self.Edit1.Text := IntToStr( Day );
      self.Edit2.Text := IntToStr( Month );
      self.Edit3.Text := IntToStr( Year );
    end;
  finally
    clndr.Free;
  end;
end;

function TcReportSGTv1._LoadParam(var sAvr: string): integer;
begin
  job.sErr := '';
  sAvr  := '';
  result := job.ParamLoad;
end;

end.
