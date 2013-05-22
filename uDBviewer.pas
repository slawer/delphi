unit uDBviewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, upf1, uMainData, uMainConst, ActnList, Menus,
  ExtCtrls, ScktComp, ComCtrls, Grids, registry, StdCtrls, ComObj, ShellAPI, Buttons,
  IniFiles, uMsgDial, uAbstrExcel, uAbstrArray, DateUtils, jpeg, CheckLst, xmldom, XMLIntf, msxmldom, XMLDoc,
  Spin, uDBviewerConst, uDEPgrafJob2, uCalendar1, uShowDEPparam1, uShowDEPparam1const, uDEPgrafJob2Const, uShowSGTparam1, uShowSGTparam1const,
  uShowREPparam2, uDEPdescript2, uDEPdescript2const, uDBVgrafQuery, uDEPprotShow1,
  uDEPGrafList1, uShowImage3, uShowImageConst, uSGTlibDB1const, uGraphPatterns1,
  DB, ADODB, uOreolProtocol6, uDBviewer_TuneDB, uDEPprotShow1const, uDBVreportQuery,
  uKRSfunctionV3, uExportXLS, uDBservice3Job, uQueryDopCond, uExportLAS, uTransfer1,
  uTransfer1const, uSGTlibDB1;

type
  TintMsg = class
  public
    msg: string;
  end;

  TreadDBproc1 = class(prqTHread)
  private
    jCicle: Integer;
    sErr: string;
    procedure GetByTime1;
  protected

  public
    processMode: integer;
    procedure diagnose;
    procedure endProc;
    procedure errProc;
    procedure doProcess; override;
    constructor Create(susp: Boolean);
    destructor Destroy; override;
  published

  end;


  TcDBviewer = class(Tpf2)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ActionList1: TActionList;
    Action1: TAction;
    Action7: TAction;
    Exit1: TMenuItem;
    N10: TMenuItem;
    OpenDialog1: TOpenDialog;
    XMLDocument1: TXMLDocument;
    N4: TMenuItem;
    Action14: TAction;
    N8: TMenuItem;
    N17: TMenuItem;
    Panel1: TPanel;
    Action3: TAction;
    Action5: TAction;
    N3: TMenuItem;
    Action2: TAction;
    N5: TMenuItem;
    Action4: TAction;
    N6: TMenuItem;
    Action6: TAction;
    N7: TMenuItem;
    Memo1: TMemo;
    Action8: TAction;
    N9: TMenuItem;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label5: TLabel;
    N11: TMenuItem;
    ADOConnection1: TADOConnection;
    Action9: TAction;
    N12: TMenuItem;
    N13: TMenuItem;
    Action10: TAction;
    N14: TMenuItem;
    Action11: TAction;
    N15: TMenuItem;
    Action12: TAction;
    N16: TMenuItem;
    XLS1: TMenuItem;
    Action13: TAction;
    N18: TMenuItem;
    Action15: TAction;
    LASS1: TMenuItem;
    Action16: TAction;
    N19: TMenuItem;
    Action17: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Action1Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action14Execute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
    procedure Action11Execute(Sender: TObject);
    procedure Action12Execute(Sender: TObject);
    procedure Action13Execute(Sender: TObject);
    procedure Action15Execute(Sender: TObject);
    procedure Action16Execute(Sender: TObject);
    procedure Action17Execute(Sender: TObject);
  private
    { Private declarations }
    bLast: Boolean;
    keyStr: Integer; // ����� ������ ��������� �� ��

    job: TDEPgrafJob1; // ������� �� ������
    jobXLS: dbDBservice3Job; // ������� �� ������� � XLS
    jobLAS: dbDBservice3Job; // ������� �� ������� � LAS
    depImgParam: TdepImgParam;
    cArchiv: TArrScreenShot1;

// ��������� ������� �� ������������ ��������� ������� ���
    procDB: TreadDBproc1; // ������� ������� �������

    protocol: TStringList;

    procedure SendStringToSelf(const sOut: String; Mode: Integer);
    procedure CloseProcShow;

    function  QueryReportCheck: Boolean;
    function  QueryReportCreate: Boolean;
    procedure addNewGRFParam(numbe_prm: Integer);
    procedure addNewSGTParam;

    function  QueryDaylyCheck: Boolean;
    function  QueryDaylyCreate: Boolean;
// ������� ������, ��������� �� �������
// �������� ������, ��������� �� �������
    procedure CreateDayliReport;

    procedure ShowGrafList;
    procedure updGrafParam(gList: TprqRptGrafList4);
    procedure setGrafParam(gList: TprqRptGrafList4);
    procedure setGrafParam_Page(gList: TprqRptGrafList4);
    procedure setGrafParam_List(gList: TprqRptGrafList4; pGW: TprqRptGrafWindow);
    procedure setGrafParam_Graph(gList: TprqRptGrafList4; trPattern: TTrackPattern;
                                 grf: TprqRptGraf1; j1: integer);
    procedure RepaintGrafList;

    procedure destoyHread1;
    procedure printMsg(const s: string);

    function _LoadParam(var sAvr: string): integer;
  public
    { Public declarations }
    bAvar:          Boolean;
    BlockWorking:   prqTBlockRsrc;

    sNameFilePar:   String;         // ��� ����� � �����������
    sNameFileShab:  String;         // ��� ����� � ��������
    sNameFileStage: String;         // ��� ����� � �������



    procedure ShowAllParam;
    procedure CreateRaport;

    procedure unknowDialogMessage(var Msg: TMessage; kode: Integer); override;
    procedure produceFinMsg(var Msg: TMessage); override;
  end;

var
  cDBviewer: TcDBviewer;

implementation
uses uSupport;

{$R *.dfm}

procedure TcDBviewer.FormCreate(Sender: TObject);
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

  Application.Title       := pc006_01_ProjectZGL;
  Caption                 := pc006_01_ProjectName;
  depImgParam := TdepImgParam.Create;
  cArchiv := TArrScreenShot1.Create;

  job := TDEPgrafJob1.Create;
  jobXLS := dbDBservice3Job.Create;
  jobLAS := dbDBservice3Job.Create;

  // �������� �������� ������:
  if not job.LibInit(ADOConnection1, pc006_01_DepDLLName) then
  begin
    ShowMessage(pc006_01_DepDLLavr);
    bAvar := true;
    Exit;
  end;

  taskParam               := TtaskParam.Create;
  taskParam.ProjectName   := pc006_01_ProjectName;
  taskParam.MainGUID      := pc006_01_MainGUID;
  taskParam.mainPath      := pc006_01_SoftPath;
  taskParam.regTask;

  inherited;

  bTag  := True;
  bGeom := True;

// ���������������� ����� Create and register object
  jUniType                  := tobjMain;
  jUniKeyBoss               := 0;
  registryObj(taskParam, jUniKeySelf, jUniKeyBoss, jUniType, self);
  taskParam.mainKey         := jUniKeySelf;

  job.jUniType              := pc006_01_JobMain;
  job.jUniKeyBoss           := jUniKeySelf;
  job.Caption               := pc006_01_ViewerCaption;
  job.dirStart              := extractFilePath(paramStr(0));
  job.dirCrnt               := IncludeTrailingPathDelimiter(GetCurrentDir);
  job.cnfSgtParamName       := job.dirCrnt + pc006_01_ConfigSGTparNameR;
  job.cnfSgtGraphParamName  := job.dirCrnt + pc006_01_ConfigSGTparName;
  job.tmpSgtGraphParamName  := job.dirCrnt + pc006_01_ConfigTMPdatName;
  job.xlsSgtGraphShblnName  := job.dirCrnt + pc006_01_ConfigSHBxlsName;
  job.xlsSgtGraphReprtName  := job.dirCrnt + pc006_01_ConfigRPTxlsName;
  job.bmpSgtGraphReprtName  := job.dirCrnt + pc006_01_ConfigRPTbmpName;
  job.XMLDocument1          := self.XMLDocument1;
  registryObj(taskParam, job.jUniKeySelf, jUniKeySelf, job.jUniType, job);

  job.xlsSgtRptShblnName    := job.dirCrnt + pc006_01_ConfigSHBxlsNameR;
  job.xlsSgtRptReprtName    := job.dirCrnt + pc006_01_ConfigRPTxlsNameR;

// ������������ ��������� Restore parameters
  getParam;

  BlockWorking := prqTBlockRsrc.Create;
  BlockWorking.bBlockRsrc := false;

  protocol     := TStringList.Create;

  self.Action9Execute(nil);

//  PanelResize;
end;

procedure TcDBviewer.Action1Execute(Sender: TObject);
begin
  Close;
end;

procedure TcDBviewer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if BlockWorking.isBlockRsrc then
  begin
    if MessageDlg( pc006_01_1102, mtConfirmation, [mbYes,mbNo], 0 ) <> mrYes then Exit;
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
    if job.Modify then
    begin
      job.grfParamSave;
    end;
  except end;

  try
    if isCanCloseChilObj(taskParam, jUniKeySelf, True) then
      UnregChildTreeObj(taskParam, jUniKeySelf, jUniKeySelf);
  except end;

  inherited;

  jobXLS.Free;
  jobLAS.Free;
  protocol.Free;
  taskParam.Free;
  cArchiv.Free;
end;

procedure TcDBviewer.Action7Execute(Sender: TObject);
begin
// ��������� ������ ����������
end;

procedure TcDBviewer.unknowDialogMessage(var Msg: TMessage;
  kode: Integer);

procedure PrintMessage;
var
  s1: String;
begin
  s1 := extStr.movePull(Msg.LParam);
  ShowMessage(s1);
end;

procedure _ProtMessage;
var
  s1: String;
begin
  s1 := extStr.movePull(Msg.LParam);
  self.printMsg(s1);
//  Memo1.Lines.Add(s1);
//  Application.ProcessMessages;
end;

var
  s1: String;
  c1: TintMsg;
begin
  if kode = WM_User_Dialog then
  begin
    case Msg.WParamLo of // ����� ��������
110:
      begin
        PrintMessage;
        Exit;
      end;

pc006_01_MsgCode_01:
      begin
        s1 := extStr.movePull(Msg.LParam);
        self.printMsg(s1);
        Exit;
      end;

pc006_01_MsgCode_02:
      begin
        s1 := extStr.movePull(Msg.LParam);
        ShowMessage(s1);
        Exit;
      end;

pc006_01_MsgCode_03:
      begin
        s1 := extStr.movePull(Msg.LParam);
        self.printMsg(s1);
        ShowMessage(s1);
        Exit;
      end;

pc006_01_MsgCode_04:
      begin
        s1 := extStr.movePull(Msg.LParam);
// �������� ������, ��������� �� �������
        ShowGrafList;
        Exit;
      end;

pc006_01_MsgCode_05:
      begin
        s1 := extStr.movePull(Msg.LParam);
// ������� ������, ��������� �� �������
// �������� ������, ��������� �� �������
        CreateDayliReport;
        Exit;
      end;

pc005_110_AcceptMsg:
      begin // ��������� ������� ������ � ���������
        updGrafParam(self.job.gList);
        Exit;
      end;


pc005_110_AcceptMsg1:
      begin // ������� ������
        CreateRaport;
        Exit;
      end;

1110:
      begin
        _ProtMessage;
        Exit;
      end;

pc006_110_Msg1:
      begin
        case Msg.WParamHi of
         0: begin _ProtMessage; Exit; end;
         1: begin
              c1 := TintMsg.Create();
              try
                c1.msg := extStr.movePull(Msg.LParam);
                self.Action17Execute(c1);
                Exit;
              finally
                c1.Free();
              end;
            end;
        end;
      end;
    end;
  end;

  inherited;
end;

procedure TcDBviewer.ShowAllParam;
begin
// �������� ������� "�����"

// �������� ������� "��������_������"

// �������� �������

// �������� ������� "��������_�������"

// �������� ������� "��������"

// �������� ������� "���������_�����������"
end;

procedure TcDBviewer.SendStringToSelf(const sOut: String; Mode: Integer);
var
  Msg: TMessage;
begin
  if Length(sOut) > 0 then
  begin
    if keyStr = High(Integer) then keyStr := 0;
    Inc(keyStr);
    putString(sOut, Handle, keyStr);
  end;

  Msg.WParamLo := Mode;
  Msg.WParamHi := 0;
  Msg.LParam   := keyStr;
  PostMessage(Handle, WM_User_Dialog, Msg.WParam, Msg.LParam);
end;

procedure TcDBviewer.produceFinMsg(var Msg: TMessage);
begin
  Application.ProcessMessages;
  case Msg.WParam of
    cWPar_UF_ProcAbort:
    begin
// ��������� ���������� �������� � ��
      destoyHread1;
      self.BlockWorking.bBlockRsrc := false;
      self.printMsg(formatDateTime(pc006_01_1114, Now) + pc006_01_1117);
      ShowMessage(pc006_01_1121);
    end;
    else
      inherited;
  end;
  Msg.Result := 0;
  Application.ProcessMessages;
end;

procedure TcDBviewer.CloseProcShow;
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

procedure TcDBviewer.Action14Execute(Sender: TObject);
var
  pDD: TcShowSGTparam1;
  j1: Integer;
begin
// �������� ������ ����������
  j1 := findRegistryObjType(taskParam, pc005_104_jMain);
  if j1 > 0 then
  begin
    (taskParam.treeObj[j1].cls as TForm).WindowState := wsNormal;
    (taskParam.treeObj[j1].cls as TForm).Show;
    Exit;
  end;

// ������� ������
  pDD := TcShowSGTparam1.Create(self);
  pDD.taskParam := taskParam;
  registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
  pDD.bTag  := True;
  pDD.bGeom := True;
  pDD.getParam;
  pDD.CreateIMG(job.DEPdepParam, job.DEPsgtParam, self.BlockWorking);
  pDD.Show;
end;

procedure TcDBviewer.FormActivate(Sender: TObject);
var
  sAvr: string;
  jCode: Integer;
begin
  inherited;
  if bLast then Exit;

  bLast := true;

  try

// �������� ������ ���������� ����������� �������������� ������� ������� ���
    job.sErr := '';
    jCode := job.sgtParamLoad;
    sAvr  := '';
    if jCode <> 0 then
    begin
      case jCode of
       -1: begin sAvr := pc006_01_1001; job.sErr := ''; end;
       -2: begin sAvr := pc006_01_1101; jCode := 0; job.sErr := ''; end;

pc006_503_XMLerr_001:
           begin sAvr := job.sErr; jCode := 0; end;

pc006_503_XMLerr_002:
           begin sAvr := pc006_503_cMSG_003; jCode := 0; end;

pc006_503_XMLerr_003:
           begin sAvr := pc006_503_cMSG_003; jCode := 0; end;

      else
           begin sAvr := job.sErr; if Length(sAvr) = 0 then sAvr := pc006_01_1002; end;
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

// ��������� � DLL, �������� ������ ����������
    jCode := _LoadParam(sAvr);
    if Length(sAvr) <> 0 then ShowMessage(sAvr);
    if jCode <> 0 then
    begin
//      Close;
//      Exit;
    end;

// �������� �������� �������
    job.sErr := '';
    jCode := job.grfParamLoad;
    sAvr  := '';
    if jCode <> 0 then
    begin
      case jCode of
       -1: begin sAvr := pc006_01_1001; job.sErr := ''; end;
       -2: begin sAvr := pc006_01_1101; jCode := 0; job.sErr := ''; end;

pc006_502_XMLerr_001:
           begin sAvr := job.sErr; jCode := 0; end;

pc006_502_XMLerr_002:
           begin sAvr := pc006_502_cMSG_003; jCode := 0; end;

pc006_502_XMLerr_003:
           begin sAvr := pc006_502_cMSG_003; jCode := 0; end;

      else
           begin sAvr := job.sErr; if Length(sAvr) = 0 then sAvr := pc006_01_1002; end;
      end;
    end
    else
    begin
      if Length(job.sErr) <> 0 then sAvr := job.sErr;
    end;
    if Length(sAvr) <> 0 then ShowMessage(sAvr);
    if jCode <> 0 then
    begin
//      Close;
//      Exit;
    end;

    self.Action13Execute(nil);

  except
    on E: Exception do
    begin
      sAvr := E.Message;
      if Length(sAvr) = 0 then sAvr := pc006_01_1005 else sAvr := sAvr + pc006_01_1006;
      ShowMessage(sAvr);
    end;
  end;

end;

procedure TcDBviewer.Action3Execute(Sender: TObject);
var
  pDD: TcShowDEPparam1;
  j1: Integer;
begin
// �������� ������ ���������� ��
  j1 := findRegistryObjType(taskParam, pc005_103_jMain);
  if j1 > 0 then
  begin
    (taskParam.treeObj[j1].cls as TForm).WindowState := wsNormal;
    (taskParam.treeObj[j1].cls as TForm).Show;
    Exit;
  end;

// ������� ������
  pDD := TcShowDEPparam1.Create(self);
  pDD.taskParam := taskParam;
  registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
  pDD.bTag  := True;
  pDD.bGeom := True;
  pDD.getParam;
  pDD.CreateIMG(job.DEPdepParam);
  pDD.Show;
end;

procedure TcDBviewer.Action5Execute(Sender: TObject);
var
  bDoit: boolean;
begin
  inherited;
// ������� �������
  bDoit := false;
  if self.BlockWorking.isBlockRsrc then
  begin
    ShowMessage(pc006_01_1103);
    Exit;
  end;

  try

    if not QueryReportCheck then Exit;

  // ������������ ������ �� ������
    if QueryReportCreate then
    begin
      self.depImgParam.crntStep := 0;
      self.depImgParam.crntShft := 0;
      self.depImgParam.crntStepIndx := -1;
      self.cArchiv.Count := 0;

      destoyHread1;

      self.printMsg(formatDateTime(pc006_01_1114, Now) + pc006_01_1115);

  // ������ �������� �������
      procDB := TreadDBproc1.Create(true); // ������� ������� �������
      procDB.jTimeOut := pc006_01_Hread_01;
      procDB.Priority := tpNormal; // tpNormal; //tpHigher; // tpLower;
      procDB.jUniType := pc006_01_Hread_02;
      procDB.jUniKeyBoss := jUniKeySelf;
  //    registryObj(taskParam, procDB.jUniKeySelf, procDB.jUniKeyBoss, procDB.jUniType, procDB);
      procDB.Caption  := pc006_01_Proc1Caption;
      procDB.FreeOnTerminate := false;
      procDB.taskParam := taskParam;
      procDB.bNoUnReg := True;
      ShowProcess(taskParam, jUniKeySelf, True, pc006_01_1104, nil); // �������� ��������
      procDB.processMode := pc006_01_MsgCode_04;
      procDB.Resume;

      bDoit := true; // ������!
    end;

  finally
    if not bDoit then
    begin
      self.BlockWorking.bBlockRsrc := false;
    end;
  end;
end;

function TcDBviewer.QueryReportCheck: Boolean;
var
  pDD: TcDBVgrafQuery;
begin
// ������� ������
  pDD := TcDBVgrafQuery.Create(self);
  pDD.taskParam := taskParam;
  registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
  pDD.bTag  := True;
  pDD.bGeom := True;
  pDD.getParam;
  pDD.CreateIMG(job);
  pDD.ShowModal;

  result := job.DOit;
end;

function TcDBviewer.QueryReportCreate: Boolean;
var
  jC1: Integer;
  listCh: TTrackPattern;
begin
  result := false;
// ������ � ��������� �������
//  job.DEPqueParam.dBeg := self.job.dDEPqueParam.
//  job.DEPqueParam.dEnd := job.DEPqueParam.dBeg + 1;

// ���������� �������� ��� ������
  job.DEPqueParam.valReport.clrField;
  job.DEPqueParam.listReport.Count := 0;

// ���������� �������� ��� ������
  addNewSGTParam;

  listCh := self.job.DEPGrhDescr.GraphListPatterns.GetObjPnt(
         self.job.DEPGrhDescr.GraphListPatterns.SelectedPattern).getGraficsList;

  try

    for jC1 := 1 to listCh.Count do
    begin
      if not listCh[jC1].active then continue;
      if listCh[jC1].nChanal <= 0 then continue;
      addNewGRFParam(listCh[jC1].nChanal);
    end;

  finally
    listCh.Free
  end;

  if job.DEPqueParam.listReport.Count = 0 then
  begin
    ShowMessage(pc006_01_1122);
    Exit;
  end;

  result := true;
end;

procedure TcDBviewer.addNewGRFParam(numbe_prm: Integer);
var
  j1: integer;
begin
  j1 := self.job.DEPqueParam.listReport.Find(@numbe_prm, 1);
  if j1 > 0 then exit;
  self.job.DEPqueParam.listReport.Append( @numbe_prm ); // ����� ���������
  self.job.DEPqueParam.valReport.addField(ftSingle, 0); // Single �� ���������
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
  cDBviewer.printMsg( IntToStr(jCicle) );
  Application.ProcessMessages;
end;

procedure TreadDBproc1.doProcess;
begin
  FbCalc := True;

//1. ������������ ������� � DLL
//2. ����� ��������� �������� �����
//3. ������ � ���������� �����

  GetByTime1;
//  TestDepth1;
//  Test1;

  FbCalc := False;
end;

procedure TreadDBproc1.endProc;
begin
  cDBviewer.printMsg(formatDateTime(pc006_01_1114, Now) + pc006_01_1116);
  Application.ProcessMessages;
end;

procedure TreadDBproc1.errProc;
var
  s1: string;
begin
  if Pos(#13, sErr) > 0 then
    s1 := #13#10
  else
    s1 := ' ';

  cDBviewer.printMsg(formatDateTime(pc006_01_1114, Now) + s1 + sErr);
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

  cDEPReportSGTv1.BlockWorking.bBlockRsrc := false;
  if not isTerminated then Synchronize( endProc );
  Synchronize( cDEPReportSGTv1.CloseProcShow );
end;
}
procedure TcDBviewer.destoyHread1;
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

procedure TreadDBproc1.GetByTime1;
var
  jCnt, procResult: Integer;
  bFinish: boolean;
begin
  procResult := -1;
  try

    jCnt := 0;
    bFinish := false;
    repeat
      cDBviewer.job.sErr := '';
      try
        if jCnt > 0 then
        begin
          Sleep(uOreolProtocol6.cdbConnectWhite);
        end;

        Inc(jCnt);

// ����� ��������� ������ �� ��
        procResult := cDBviewer.job.CreateDataFileByTime(
                        cDBviewer.job.DEPqueParam.listReport,
                        cDBviewer.job.DEPqueParam.valReport,
                        cDBviewer.job.DEPqueParam.dBeg,
                        cDBviewer.job.DEPqueParam.dEnd,
                        uOreolProtocol6.cdbTOutVal);

        sErr := Trim( cDBviewer.job.sErr );
        if Length(sErr) > 0 then Synchronize( errProc );

        case procResult of
          0, 1:
          begin
            bFinish := true;
          end;

          else
          begin
            bFinish := false;
          end;
        end;

      except
        on E: Exception do
        begin
          bFinish := false;
          procResult := -1;
          sErr   := E.Message;
          Synchronize( errProc );
        end;
      end;

      if isTerminated then Exit;
    until bFinish or (jCnt >= cDBviewer.job.ConnectCount);

    if procResult < 0 then
    begin
      Synchronize( errProc );
      Exit;
    end
    else
    if procResult = 0 then
    begin
      sErr := pc006_01_007;
      Synchronize( errProc );
    end
    else
    if procResult = 1 then
    begin
      sErr := pc006_01_011;
      Synchronize( errProc );
      procResult := 0;
    end
    else
    begin
//      sErr := Trim( cDBviewer.job.sErr );
//      Synchronize( errProc );
      Exit;
    end;

  finally
    cDBviewer.BlockWorking.bBlockRsrc := false;
    Synchronize( cDBviewer.CloseProcShow );
    if not isTerminated then
    begin
      if procResult = 0 then
      begin
        cDBviewer.SendStringToSelf('', processMode {pc006_01_MsgCode_04});
        Synchronize( endProc );
      end;
    end
    else
    begin
      cDBviewer.job.DEPqueParam.listReport.Count := 0;
      cDBviewer.job.DEPqueParam.valReport.Count := 0;
    end;
  end;
end;

procedure TcDBviewer.Action2Execute(Sender: TObject);
var
  pDD: TcShowREPparam2;
  s1: string;
begin
// ������� ������
  pDD := TcShowREPparam2.Create(self);
  pDD.taskParam := taskParam;
  registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
  pDD.bTag  := True;
  pDD.bGeom := True;
  pDD.getParam;
  pDD.CreateIMG(job.DEPqueParam);
  pDD.ShowModal;
  if job.DEPqueParam.Modify then
  begin
    _LoadParam(s1); // ����������� ���������
    if Length(s1) <> 0 then ShowMessage(s1);
  end;
end;

procedure TcDBviewer.Action4Execute(Sender: TObject);
var
  xls: TprqExcel;
  s1: string;
begin
  inherited;
// �������� ��������� ������
  if not FileExists(self.job.xlsSgtGraphReprtName) then
  begin
    ShowMessage(pc006_01_010);
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
      s1 := self.job.xlsSgtGraphReprtName;
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
//    xls.Quit;
  finally
    xls.Free;
  end;
end;

procedure TcDBviewer.printMsg(const s: string);
begin
  self.protocol.Add(s);
  while self.Memo1.Lines.Count > pc006_01_Protocol_01 do
  begin
    self.Memo1.Lines.Delete(0);
  end;
  self.Memo1.Lines.Add(s);
  Application.ProcessMessages;
end;

procedure TcDBviewer.Action6Execute(Sender: TObject);
var
  pDD: TcDEPprotShow1;
  j1: Integer;
begin
// �������� ��������
  j1 := findRegistryObjType(taskParam, pc005_108_jMain);
  if j1 > 0 then
  begin
    (taskParam.treeObj[j1].cls as TcDEPprotShow1).Memo1.Lines.Text := self.protocol.Text;
    (taskParam.treeObj[j1].cls as TForm).WindowState := wsNormal;
    (taskParam.treeObj[j1].cls as TForm).Show;
    Exit;
  end;

// ������� ������
  pDD := TcDEPprotShow1.Create(self);
  pDD.taskParam := taskParam;
  registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
  pDD.bTag  := True;
  pDD.bGeom := True;
  pDD.getParam;
  pDD.Memo1.Lines.Text := self.protocol.Text;
  pDD.Show;
end;

procedure TcDBviewer.ShowGrafList;
var
  uSh_Im: TcShowImage3;
begin
  if Assigned(job.gList) then job.gList.Free;
  job.gList := TprqRptGrafList4.Create;
  job.OtherParams.Count := 0;

  setGrafParam(job.gList); // ������� �������� �� �����������... � gList;

// ������������ ������ �������
  uSh_Im := TcShowImage3.Create(self);
  uSh_Im.taskParam := taskParam;
  registryObj(taskParam, uSh_Im.jUniKeySelf, jUniKeySelf, uSh_Im.jUniType, uSh_Im);
  uSh_Im.bTag  := True;
  uSh_Im.bGeom := True;
  uSh_Im.getParam;

  uSh_Im.Init(job, depImgParam, self.cArchiv);
  uSh_Im.ShowModal;
end;

procedure TcDBviewer.addNewSGTParam;
begin
  self.job.DEPqueParam.valReport.addField(uAbstrArray.ftInteger, 0); // ������
  self.job.DEPqueParam.valReport.addField(uAbstrArray.ftDouble, 0); // �����
  self.job.DEPqueParam.valReport.addField(uAbstrArray.ftSingle, 0); // ������� �����
end;

procedure TcDBviewer.setGrafParam(gList: TprqRptGrafList4);
var
  j1, nomChan, jChan, Jndex, jc2, jC1: Integer;
  pGW: TprqRptGrafWindow;
  grf: TprqRptGraf1;
  rcd: rcdTcontainer;
  shPattern: TGraphListPattern;
  trPattern: TTrackPattern;
begin
  setGrafParam_Page(gList);

  shPattern := job.DEPGrhDescr.GraphListPatterns.GetObjPnt(
                     job.DEPGrhDescr.GraphListPatterns.SelectedPattern
                                                          );

  // ���������� ������ ������ ����� ��������
  shPattern.setScaleFontSize(self.job.DEPGrhDescr.Graphiks.fnSize);
  gList.sizeHead := self.job.DEPGrhDescr.Pages.sizeZGL * 10;
  gList.sizeScale := self.job.DEPGrhDescr.Graphiks.fnSize * 10;
  gList.sizeTimes := self.job.DEPGrhDescr.Graphiks.TSclSize * 10;

  nomChan := 0;

  for jC1 := 1 to gList.GrafWindows.Count do
  begin
    pGW  := gList.GrafWindows[jC1].ukz as TprqRptGrafWindow;

    // ����������� �����
    pGW.bSignScaleVal := self.job.DEPGrhDescr.Graphiks.bSignScaleVal;

    trPattern := shPattern.GetObjPnt(jC1);

    pGW.jDraw := 0; // �������� ���� �� ��������?
    if trPattern <> nil then
    begin
      if trPattern.active then
      begin
        pGW.jDraw := 1;
      end;
    end;
    if pGW.jDraw = 0 then continue;


    setGrafParam_List(gList, pGW);

// ������ �������
    for jC2 := 1 to trPattern.Count do
    begin
//      if not trPattern.active then continue;
      jChan := trPattern[jC2].nChanal;
      if jChan < 0 then continue;
      if not trPattern[jC2].active then continue;
//      Inc(nomChan);

      rcd.key := jC2;
      rcd.ukz := TprqRptGraf1.Create;
      pGW.Grafiks.Append(@rcd);

      Jndex := pGW.Grafiks.Count;
      grf  := pGW.Grafiks[Jndex].ukz as TprqRptGraf1;

      setGrafParam_Graph(gList, trPattern, grf, jC2);

      // ������ ������ �� �������������� ������ � ������ // � 1-� ������� �������� �����
      rcd.key := jChan;
      j1 := self.job.OtherParams.Find(@rcd, 1);
      if j1 = 0 then
      begin
        Inc(nomChan);
        rcd.ukz := TprqRptTX.Create;
        self.job.OtherParams.Append(@rcd);
        j1 := self.job.OtherParams.Count;

        if self.job.loadGrafik(nomChan, job.OtherParams[j1].ukz as TprqRptTX) <> 0 then
        begin
          ShowMessage(pc006_01_1007);
          continue;
        end;
      end;
    end;
  end;

end;

procedure TcDBviewer.RepaintGrafList;
var
  uSh_Im: TcShowImage3;
  b1: boolean;
  jC1: Integer;
begin
  b1 := false;
  if job.OtherParams.Count > 0 then
  for jC1 := 1 to job.OtherParams.Count do
  begin
    if (job.OtherParams[jC1].ukz as TprqRptTX).yTime.Count = 0 then continue;
    b1 := true;
    break;
  end;

  if not b1 then
  begin
    ShowMessage(pc006_01_102);
    Exit;
  end;

  if not Assigned(job.gList) then
  begin
    ShowMessage(pc006_01_102);
    Exit;
  end;

  updGrafParam(job.gList);

// ������������ ������ �������
  uSh_Im := TcShowImage3.Create(self);
  uSh_Im.taskParam := taskParam;
  registryObj(taskParam, uSh_Im.jUniKeySelf, jUniKeySelf, uSh_Im.jUniType, uSh_Im);
  uSh_Im.bTag  := True;
  uSh_Im.bGeom := True;
  uSh_Im.getParam;

  uSh_Im.Init(job, depImgParam, self.cArchiv);
  uSh_Im.ShowModal;
end;

procedure TcDBviewer.Action8Execute(Sender: TObject);
begin
  inherited;
// ������������ �������
  RepaintGrafList;
end;

procedure TcDBviewer.CreateRaport;
var
  jC: Integer;
begin
  self.job.sErr := '';
  jC := self.job.CreateRaport;
  if Length(self.job.sErr) <> 0 then
  begin
    ShowMessage(self.job.sErr);
  end;
  if jC = 0 then
  begin
    printMsg(formatDateTime(pc006_01_1114, Now) + ' ' + format(pc006_01_009, [self.job.lastDoc]));
    Action4Execute(nil);
  end;
end;

procedure TcDBviewer.setGrafParam_Page(gList: TprqRptGrafList4);
begin
  self.job.gList.dtJobBeg     := self.job.DEPqueParam.dBeg;
  self.job.gList.dtJobEnd     := self.job.DEPqueParam.dEnd;

  self.job.gList.WorkData     := FormatDateTime('dd.mm.yyyy', self.job.DEPqueParam.dBeg);
  self.job.gList.AllTime      := '';
  self.job.gList.AllVolume    := '';
  self.job.gList.Mestorogd    := Trim(Edit1.Text);
  self.job.gList.Kust         := Trim(Edit2.Text);
  self.job.gList.Skvagina     := Trim(Edit3.Text);
  self.job.gList.Rabota       := Trim(Edit4.Text);
  self.job.gList.MainPersons  := Trim(Edit5.Text);

  self.job.gList.fntDefault   := Font;
  self.job.gList.penDefault   := Canvas.Pen;
  self.job.gList.BrushDefault := Canvas.Brush;
  self.job.gList.LogHeight    := self.job.DEPGrhDescr.Pages.Height;
  self.job.gList.LogWidth     := self.job.DEPGrhDescr.Pages.Width;
  self.job.gList.LogOtsLeft   := self.job.DEPGrhDescr.Pages.shiftLeft;
  self.job.gList.LogOtsRight  := self.job.DEPGrhDescr.Pages.shiftRight;
  self.job.gList.LogOtsTop    := self.job.DEPGrhDescr.Pages.shiftTop;
  self.job.gList.LogOtsBottom := self.job.DEPGrhDescr.Pages.shiftBottom;
  self.job.gList.ramColor     := self.job.DEPGrhDescr.Pages.ramColor;
  self.job.gList.ramWidth     := self.job.DEPGrhDescr.Pages.ramWidth;
  self.job.gList.OnlyEtapDrow := false;
  self.job.gList.etpColor     := clRed;
  self.job.gList.etpColorEnd  := clRed;
  self.job.gList.etpWidth     := 10;
  self.job.gList.etpDTime     := 0;
  self.job.gList.jTOut        := self.job.DEPGrhDescr.Pages.sizeTOUT;
  self.job.gList.etpSign      := false;
  self.job.gList.etpFntSize   := 10;
  self.job.gList.HeadFSize    := self.job.DEPGrhDescr.Pages.sizeZGL;
end;

procedure TcDBviewer.setGrafParam_List(gList: TprqRptGrafList4; pGW: TprqRptGrafWindow);
begin
  pGW.netColor := self.job.DEPGrhDescr.Graphiks.netColor;
  pGW.netWidth := self.job.DEPGrhDescr.Graphiks.netWidth;
  pGW.netYStep := self.job.DEPGrhDescr.Graphiks.netYStep;
  pGW.cntXStep := self.job.DEPGrhDescr.Graphiks.cntXStep;
  pGW.ramColor := self.job.DEPGrhDescr.Graphiks.ramColor;
  pGW.ramWidth := self.job.DEPGrhDescr.Graphiks.ramWidth;
  pGW.TSclSize := self.job.DEPGrhDescr.Graphiks.TSclSize;
  pGW.jDraw    := 1;
end;

procedure TcDBviewer.setGrafParam_Graph(gList: TprqRptGrafList4; trPattern: TTrackPattern;
                                         grf: TprqRptGraf1; j1: integer);
begin
  grf.RoundMode  := 0;
  grf.dTOut      := self.job.gList.jTOut;
  grf.bActive    := trPattern[j1].active;
  grf.diaMin     := trPattern[j1].diaMin;
  grf.diaMax     := trPattern[j1].diaMax;
  grf.xLogSize   := trPattern[j1].xLogSize;
  grf.xLogStep   := trPattern[j1].xLogStep;
  grf.nChanal    := trPattern[j1].nChanal;
  grf.sName      := trPattern[j1].sPodp;
  grf.sEdIzm     := trPattern[j1].sEdIzm;
  grf.Color      := trPattern[j1].Color;
  grf.fnSize     := trPattern[j1].fnSize;
  grf.sFormat    := '%' + IntToStr(trPattern[j1].Precision + 2) +
                    '.' + IntToStr(trPattern[j1].Precision) + 'f';
  grf.yNormalVol := false;
end;

procedure TcDBviewer.updGrafParam(gList: TprqRptGrafList4);
var
  j1, jc2, jC1: Integer;
  pGW: TprqRptGrafWindow;
  grf: TprqRptGraf1;
  rcd: rcdTcontainer;
  shPattern: TGraphListPattern;
  trPattern: TTrackPattern;
begin
  setGrafParam_Page(gList);

  shPattern := job.DEPGrhDescr.GraphListPatterns.GetObjPnt(job.DEPGrhDescr.GraphListPatterns.SelectedPattern);

  for jC1 := 1 to gList.GrafWindows.Count do
  begin
    pGW  := gList.GrafWindows[jC1].ukz as TprqRptGrafWindow;
    pGW.jDraw := 0; // �������� ���� �� ��������?

    trPattern := shPattern.GetObjPnt(jC1);

    setGrafParam_List(gList, pGW);

// ������ �������
    for jC2 := 1 to trPattern.Count do
    begin
      rcd.key := jC2;
      j1 := pGW.Grafiks.Find(@rcd, 1);
      if j1 = 0 then continue;

      grf  := pGW.Grafiks[j1].ukz as TprqRptGraf1;

      setGrafParam_Graph(gList, trPattern, grf, jC2);
    end;
  end;
end;

function TcDBviewer._LoadParam(var sAvr: string): integer;
var
  j1: integer;
  s1: string;
begin
  job.sErr := '';
  sAvr  := '';
  self.job.cnfDbdParamName := self.job.DEPqueParam.RefrPath + pc006_01_ConfigDBDparName;
  self.job.cnfDbdWorksName := self.job.DEPqueParam.RefrPath + pc006_01_ConfigDBDwrkName;
  result := job.dbdParamLoad;
  if result = 0 then
  begin
    result := job.dbdWorkLoad(self.XMLDocument1);
  end;

  j1 := self.job.WorkList.GetActiveWork();
  if j1 > 0 then
  begin
    s1 := self.job.WorkList[j1].Mesto;
    if Length(s1) > 0 then self.Edit1.Text := s1;
    s1 := self.job.WorkList[j1].Kust;
    if Length(s1) > 0 then self.Edit2.Text := s1;
    s1 := self.job.WorkList[j1].Skvzh;
    if Length(s1) > 0 then self.Edit3.Text := s1;
    s1 := self.job.WorkList[j1].Works;
    if Length(s1) > 0 then self.Edit4.Text := s1;
  end;
  sAvr := self.job.sErr;
end;

procedure TcDBviewer.Action9Execute(Sender: TObject);
var
  cDial: TcDBviewer_TuneDB;
begin
  inherited;
// ��������� ����� � ��
  cDial := TcDBviewer_TuneDB.Create(self);
  try

    cDial.bMustSave := True;
    cDial.bNoUnReg  := True;
    cDial.taskParam := taskParam;
    cDial.jUniKeyBoss  := jUniKeySelf;
  //  registryObj(taskParam, cDial.jUniKeySelf, jUniKeySelf, cDial.jUniType, pBT);
    cDial.bTag  := False;
    cDial.bGeom := True;
    cDial.getParam;

    cDial.Init;
    if  Assigned(Sender) then
    begin
      cDial.DEPgrafJob := self.job;
      cDial.Edit2.PasswordChar := '*';

        cDial.ShowModal;

      cDial.Edit2.PasswordChar := #0;
    end
    else
    begin
      cDial.bSetNewParam := true;
    end;


    if cDial.bSetNewParam then
    begin
// ��������� � ������� ����� ���������
      self.job.gbl_DataSource := Trim(cDial.Edit1.Text);
      self.job.gbl_DBUserPass := Trim(cDial.Edit2.Text);
      self.job.bServProj := cDial.RadioButton1.Checked;
      cDial.saveParam;
    end;

  finally
    cDial.Free;
  end;
end;

procedure TcDBviewer.Action10Execute(Sender: TObject);
var
  bDoit: boolean;
begin
  inherited;
// ������� �����
  bDoit := false;
  if self.BlockWorking.isBlockRsrc then
  begin
    ShowMessage(pc006_01_1103);
    Exit;
  end;

  try

    if not QueryDaylyCheck then Exit;

    self.job.DEPqueParam.Mestorogd   := Trim(self.Edit1.Text);
    self.job.DEPqueParam.Kust        := Trim(self.Edit2.Text);
    self.job.DEPqueParam.Skvagina    := Trim(self.Edit3.Text);
    self.job.DEPqueParam.Rabota      := Trim(self.Edit4.Text);
    self.job.DEPqueParam.MainPersons := Trim(self.Edit5.Text);

    // ������������ ������ �� ������
    if QueryDaylyCreate then
    begin
      destoyHread1;

      self.printMsg(formatDateTime(pc006_01_1114, Now) + pc006_01_1115);

      // ������ �������� �������
      procDB := TreadDBproc1.Create(true); // ������� ������� �������
      procDB.jTimeOut := pc006_01_Hread_01;
      procDB.Priority := tpNormal; // tpNormal; //tpHigher; // tpLower;
      procDB.jUniType := pc006_01_Hread_02;
      procDB.jUniKeyBoss := jUniKeySelf;
      //registryObj(taskParam, procDB.jUniKeySelf, procDB.jUniKeyBoss, procDB.jUniType, procDB);
      procDB.Caption  := pc006_01_Proc2Caption;
      procDB.FreeOnTerminate := false;
      procDB.taskParam := taskParam;
      procDB.bNoUnReg := True;
      ShowProcess(taskParam, jUniKeySelf, True, pc006_01_1104, nil); // �������� ��������
      procDB.processMode := pc006_01_MsgCode_05;
      procDB.Resume;

      bDoit := true; // ������!
    end;

  finally
    if not bDoit then
    begin
      self.BlockWorking.bBlockRsrc := false;
    end;
  end;
end;

function TcDBviewer.QueryDaylyCheck: Boolean;
var
  j1: integer;
  s1: string;
  pDD: TcDBVreportQuery;
begin
// ������� ������    uDBVdaylyQuery
  pDD := TcDBVreportQuery.Create(self);
  pDD.taskParam := taskParam;
  registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
  pDD.bTag  := True;
  pDD.bGeom := True;
  pDD.getParam;
  pDD.CreateIMG(job);
  j1 := self.job.WorkList.GetActiveWork();
  if j1 > 0 then
  begin
    s1 := self.job.WorkList[j1].customer;
    if Length(s1) > 0 then pDD.Edit10.Text := s1;

    s1 := self.job.WorkList[j1].performer;
    if Length(s1) > 0 then pDD.Edit11.Text := s1;
  end;

  pDD.ShowModal;

  result := job.DOit;
end;

function TcDBviewer.QueryDaylyCreate: Boolean;
var
  jC1: Integer;
begin
  result := false;
// ������ � ��������� �������
//  job.DEPqueParam.dBeg := self.job.dDEPqueParam.
//  job.DEPqueParam.dEnd := job.DEPqueParam.dBeg + 1;

// ���������� �������� ��� ������
  job.DEPqueParam.valReport.clrField;
  job.DEPqueParam.listReport.Count := 0;

// ���������� �������� ��� ������
  addNewSGTParam;

  for jC1 := 1 to job.DEPsgtParam.Count do
  begin
    if job.DEPsgtParam[jC1].SGTparNum = pc006_503_SGTpar1nb then
    begin
      // ����� ����� �������
      if job.DEPsgtParam[jC1].DEPparNum >= 0 then
      begin
        addNewGRFParam(job.DEPsgtParam[jC1].DEPparNum);
        break;
      end;
    end;
  end;

  for jC1 := 1 to job.DEPsgtParam.Count do
  begin
    if job.DEPsgtParam[jC1].SGTparNum = pc006_503_SGTpar2nb then
    begin
      // ����� ����� ������� �����
      if job.DEPsgtParam[jC1].DEPparNum >= 0 then
      begin
        addNewGRFParam(job.DEPsgtParam[jC1].DEPparNum);
        break;
      end;
    end;
  end;

  if job.DEPqueParam.listReport.Count = 0 then
  begin
    ShowMessage(pc006_01_1123);
    Exit;
  end;

  result := true;
end;

procedure TcDBviewer.CreateDayliReport;
var
  procResult: integer;
  sErr: string;
begin
  sErr := '';
  // ���������� ������� - �������� XLS �����
  try

  procResult := job.createDayliRaport;
  sErr := job.sErr;
//  ShowMessage('OK');

  except
    on E: Exception do
    begin
      procResult := -1;
      sErr   := E.Message;
    end;
  end;

  if Length(sErr) > 0 then
  begin
    ShowMessage(sErr);
  end;

// �������� ������
  if procResult = 0 then
  begin
    Action11Execute(nil);
  end;
end;

procedure TcDBviewer.Action11Execute(Sender: TObject);
var
  xls: TprqExcel;
  s1: string;
begin
  inherited;
// �������� � ������ ���������� ������
  if self.BlockWorking.isBlockRsrc then
  begin
    ShowMessage(pc006_01_1103);
    Exit;
  end;

  try
    if not FileExists(self.job.xlsSgtRptReprtName) then
    begin
      ShowMessage(pc006_01_012);
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

procedure TcDBviewer.Action12Execute(Sender: TObject);
var
  pExXLS: TcExportXLS;
begin
  if self.BlockWorking.isBlockRsrc then
  begin
    MessageBox(self.Handle, pc006_01_1103, pc006_01_ProjectZGL, MB_OK);
  end
  else
  begin
    try

    // ������� ����� �������
      pExXLS := TcExportXLS.Create(self);
      pExXLS.taskParam := taskParam;
      registryObj(taskParam, pExXLS.jUniKeySelf, jUniKeySelf, pExXLS.jUniType, pExXLS);
      pExXLS.jUniKeyBoss := jUniKeySelf;
      pExXLS.bTag  := True;
      pExXLS.bGeom := True;

      pExXLS.getParam;
      pExXLS.jobExp      := self.jobXLS;
      pExXLS.jobAll      := self.job;
      pExXLS.listParam   := self.job.DEPdepParam;
      pExXLS.Init;

      pExXLS.ShowModal;

    finally
      self.BlockWorking.bBlockRsrc := false;
    end;
  end;
end;

procedure TcDBviewer.Action13Execute(Sender: TObject);
var
  pDD: TcQueryDopCond;
begin
// �������������� ������� ������
// ������� ������
  pDD := TcQueryDopCond.Create(self);
  try
    pDD.taskParam := taskParam;
  //  registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
    pDD.bTag  := True;
    pDD.bGeom := True;
    pDD.getParam;
    if Assigned(Sender) then
    begin
      pDD.CreateIMG(job);
      pDD.ShowModal;
    end
    else
    begin
      pDD.CheckBox1.Checked := false; // ��������� �� ��������� ��� ������
      pDD.CreateIMG(job);
      pDD.saveDBaseList;
    end;

  finally
    pDD.Free;
  end;
end;

procedure TcDBviewer.Action15Execute(Sender: TObject);
// ������� ������ � LASS ������
var
  pExLAS: TcExportLAS;
begin
  inherited;

  if self.BlockWorking.isBlockRsrc then
  begin
    MessageBox(self.Handle, pc006_01_1103, pc006_01_ProjectZGL, MB_OK);
  end
  else
  begin
    try

    // ������� ����� �������
      pExLAS := TcExportLAS.Create(self);
      pExLAS.taskParam := taskParam;
      registryObj(taskParam, pExLAS.jUniKeySelf, jUniKeySelf, pExLAS.jUniType, pExLAS);
      pExLAS.jUniKeyBoss := jUniKeySelf;
      pExLAS.bTag  := True;
      pExLAS.bGeom := True;

      pExLAS.getParam;
      pExLAS.jobExp      := self.jobLAS;
      pExLAS.jobAll      := self.job;
      pExLAS.listParam   := self.job.DEPdepParam;
      pExLAS.Init;

      pExLAS.ShowModal;

    finally
      self.BlockWorking.bBlockRsrc := false;
    end;
  end;

end;

procedure TcDBviewer.Action16Execute(Sender: TObject);
var
  j1, jC1: integer;
  rcdCT: rcdCrossTableTab;
  rcdTL: rcdSGTtableList;
  pDD: TcTransfer1;
begin
  inherited;
// ������� ������ �� �����������

  if self.BlockWorking.isBlockRsrc then
  begin
    MessageBox(self.Handle, pc006_01_1103, pc006_01_ProjectZGL, MB_OK);
  end
  else
  begin
    try

      // ������� ����� �������
      pDD := TcTransfer1.Create(self);
      pDD.taskParam := taskParam;
      registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
      pDD.jUniKeyBoss := jUniKeySelf;
      pDD.bTag  := True;
      pDD.bGeom := True;

      // ��������� ������� ������� ����������� ������
      for jC1 := 1 to pDD.job.CrossTableTab.Count do
      begin
        rcdTL.numbParam := pDD.job.CrossTableTab[jC1].DBNumberChanal;
        j1 := self.job.TableList.Find(@rcdTL, 1);
        if j1 = 0 then
        begin
          pDD.job.CrossTableTab[jC1].DBNameChanal := '';
          pDD.job.CrossTableTab[jC1].guidChanal := '';
          pDD.job.CrossTableTab[jC1].bSaveDB := false;
        end
        else
        begin
          pDD.job.CrossTableTab[jC1].DBNameChanal := self.job.TableList[j1].nameParam;
          pDD.job.CrossTableTab[jC1].guidChanal := self.job.TableList[j1].GUIDParam;
          pDD.job.CrossTableTab[jC1].bSaveDB := self.job.TableList[j1].bSaveDB;
        end;
      end;

      pDD.sDataPath := self.job.DEPqueParam.DataPath;
      pDD.job.filePath := self.job.dirStart + pc006_110_CTpass;
      pDD.xml := self.job.XMLDocument1;
      pDD.getParam;

      self.job.getDataBaseTuning(pDD.sDBUserName, pDD.sDBUserPass, pDD.sDataSource);
      pDD.fFirst := false;
      pDD.Init;

      pDD.ShowModal;

    finally
      self.BlockWorking.bBlockRsrc := false;
    end;
  end;
end;

procedure TcDBviewer.Action17Execute(Sender: TObject);
var
  pDD: TcQueryDopCond;
  c1: TintMsg;
begin
// �������������� ������� ������
// �������� �� � ��� ������
  pDD := TcQueryDopCond.Create(self);
  c1 := Sender as TintMsg;
  try
    pDD.taskParam := taskParam;
    pDD.bTag  := True;
    pDD.bGeom := True;
    pDD.getParam();
    pDD.CreateIMG(job);

    pDD.CheckListBox2.Items.Add(c1.msg);
    pDD.saveDBaseList();
    pDD.saveParam();

  finally
    pDD.Free();
  end;
end;

end.
