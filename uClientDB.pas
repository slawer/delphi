unit uClientDB;
//  pc003_23_XX

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, uMainData, uMainConst, upf1, DB, ADODB, StdCtrls, ExtCtrls,
  Buttons, uMsgDial, ScktComp, Math, uAbstrArray, ActnList, Menus,
  uOreolProtocol, DBXpress, SqlExpr, ComCtrls,
  uClientDB3const, uClientDB4const, uKRSfunction;
//  ServerSocket;

type
  TOreolClientDB4 = class;
  myTh = class(prqTHread)
  public
    j1: Integer;
    dbCln: TOreolClientDB4;

    procedure dbCln_doProcess;
    procedure txt;

    procedure doProcess; override;
  end;

  TOreolClientDB4 = class(Tpf2)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    Panel1: TPanel;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Timer1: TTimer;
    SQLConnection1: TSQLConnection;
    OpenDialog1: TOpenDialog;
    Action7: TAction;
    Action8: TAction;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    CheckBox5: TCheckBox;
    Panel4: TPanel;
    Label3: TLabel;
    CheckBox4: TCheckBox;
    CheckBox6: TCheckBox;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    TabSheet4: TTabSheet;
    Label4: TLabel;
    Edit2: TEdit;
    BitBtn4: TBitBtn;
    Panel5: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Panel6: TPanel;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Label8: TLabel;
    Edit3: TEdit;
    Label9: TLabel;
    Edit5: TEdit;
    Label11: TLabel;
    Panel7: TPanel;
    Label12: TLabel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    Label13: TLabel;
    BitBtn5: TBitBtn;
    Action9: TAction;
    Label5: TLabel;
    Edit4: TEdit;
    Action10: TAction;
    Panel8: TPanel;
    Label10: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    BitBtn6: TBitBtn;
    CheckBox7: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure ClearCommandList(jH: Integer; bAll: Boolean);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
  private
    procDB: myTh; // Процесс обслуживания БД

    dirName       : String;       // Дир программы
    dirProtName   : String;       // Дир протокола программы
    fileProtTxt   : TextFile;
    flleProtName  : string;
    bProt         : Boolean;
    jClientDBcount: Integer;

//    fLengthS: Integer;
    oreolDB:     TOreolDBase4;
    cmdPaket:    prqTcommand;   // Список команд, полученных от клиента
    prdPaket:    prqTcommand;   // Список команд, Поставленных на выполнение
    bActiveMode: Boolean;       // Флаг запуска сервиса
    procedure iconMessage(var Msg: TMessage); message WM_User_HideTrey;
    procedure produceCommand(const rcd: rcdTcommand; setPack: prqTobject);
    procedure appPack(msg: TOreolProtocol; setPack: prqTobject);
    procedure insMessage(const msg: String);
    procedure insDTMessage(const msg: String);
    procedure LockUnlockNamePass(bMode: Boolean);
    procedure LockUnlockDBpath(bMode: Boolean);
    { Private declarations }
  public
    ServerSocket1: TServerSocket;
    function  isActiveMode: Boolean;
    procedure unknowDialogMessage(var Msg: TMessage; kode: Integer); override;

    procedure addLine(ln: string);

    procedure getPacket(var rcd: rcdTcommand);
    procedure produce(const rcd: rcdTcommand);
    procedure doProcess;
    { Public declarations }
  end;

var
  OreolClientDB4: TOreolClientDB4;

implementation
uses uSupport, ShellAPI;

{$R *.dfm}

var
  NID: TNotifyIconData;

procedure TOreolClientDB4.FormCreate(Sender: TObject);
var
  jC1: Integer;
begin
  jClientDBcount    := 0;
  Application.Title := pc006_04_Title;
            Caption := pc006_04_Title;
      ServerSocket1 := TServerSocket.Create(nil);
  ServerSocket1.OnClientConnect    := ServerSocket1ClientConnect;
  ServerSocket1.OnClientDisconnect := ServerSocket1ClientDisconnect;
  ServerSocket1.OnClientRead       := ServerSocket1ClientRead;
  ServerSocket1.OnClientError      := ServerSocket1ClientError;
                  bProt := False;
              taskParam := TtaskParam.Create;
  taskParam.ProjectName := pc003_23_ProjectName;
  taskParam.MainGUID    := pc006_04_MainGUID;
  taskParam.mainPath    := pc006_04_SoftPath;
  taskParam.regTask;

  inherited;

  bTag  := True;
  bGeom := True;
// Зарегистрировать форму Create and register object
  jUniType := tobjMain;
  jUniKeyBoss := 0;
  registryObj(taskParam, jUniKeySelf, jUniKeyBoss, jUniType, self);
  taskParam.mainKey := jUniKeySelf;
// Восстановить параметры Restore parameters
  getParam;

// Создать протокол
  dirName := extractFilePath(paramStr(0));
  dirProtName := Trim(Edit2.Text);
  Action8Execute(Self);

// Восстановить номер порта
  try
    jC1 := StrToInt( Edit1.Text );
    ServerSocket1.Port := jC1;
  except
      on E: Exception do
      begin
        insDTMessage(E.Message);
        ShowMessage( E.Message + #13#10 + pc003_23_02);
        Edit1.Text := pc003_23_01;
      end;
  end;

  NID.cbSize := SizeOf(TNotifyIconData);
  NID.Wnd    := Handle;
  NID.uID    := 1;
  NID.uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
  NID.uCallbackMessage := WM_User_HideTrey;
  NID.hIcon  := Application.Icon.Handle;
  for jC1 := 1 to Length(Caption) do
  begin
    NID.szTip[jC1-1] := Caption[jC1];
  end;
  NID.szTip[Length(Caption)] := Char(0);

  cmdPaket:= prqTcommand.Create;
  prdPaket:= prqTcommand.Create;
  oreolDB := TOreolDBase4.Create;
  oreolDB.setDBType(ADOConnection1);

//  oreolDB.dCounter := 0;
// Чтобы включить отладку, надо так же раскомментировать строчку
//        rcdMeas.val_depth := getDepthORtest(pMss.val_depth);
// в протоколе


// Запуск процесса обмена с БД
  procDB := myTh.Create(True);
  procDB.jTimeOut := 10000;
  procDB.Priority := tpNormal; //tpHigher; // tpLower;
  procDB.jUniType := pc003_23_jProcessDB;
  procDB.jUniKeyBoss := jUniKeySelf;
  registryObj(taskParam, procDB.jUniKeySelf, procDB.jUniKeyBoss, procDB.jUniType, procDB);
  procDB.Caption  := 'Process to service Oreol DB';
  procDB.dbCln    := self;
  procDB.FreeOnTerminate := True;
  procDB.taskParam := taskParam;
  procDB.bNoUnReg := True;

  procDB.Resume;

  Timer1.Enabled := True;

  if CheckBox2.Checked then Action5Execute(self);
  if RadioButton2.Checked then Action6Execute(self);
  LockUnlockNamePass(not RadioButton5.Checked);
  Application.ProcessMessages;
end;

procedure TOreolClientDB4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// Содержательные действия
  inherited;
  if bProt then
  begin
    try CloseFile(fileProtTxt) except end;
  end;
  try
    ServerSocket1.Free;
  except end;
  try
    oreolDB.disConnectDB(0);
  except end;
  try
    oreolDB.Free;
  except end;
  taskParam.Free;
  cmdPaket.Free;
  prdPaket.Free;
end;

procedure TOreolClientDB4.iconMessage(var Msg: TMessage);
begin
  if Msg.LParam = WM_LBUTTONUP {WM_LBUTTONDBLCLK} then
  begin
    Show;
    SetForegroundWindow(Handle);
    Shell_NotifyIcon(NIM_DELETE, @NID);
  end;
end;

function TOreolClientDB4.isActiveMode: Boolean;
begin
  result := bActiveMode;
end;

procedure TOreolClientDB4.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  s1: string;
  msgOreol: TOP_ErrorMsg;
begin
  msgOreol := TOP_ErrorMsg.Create(copErr_CLVersion, pc006_04_CLVersion);
  try
    msgOreol.SendBuf(Socket);
  finally
    msgOreol.Free;
  end;
  Inc(jClientDBcount);
  s1 := getTitleStr(Socket, True) + pc003_23_11;
  prqTgetString.putString(s1, Handle, Socket.Handle);
  PostMessage (Handle, WM_User_Dialog, 110, Socket.Handle);
end;

procedure TOreolClientDB4.unknowDialogMessage(var Msg: TMessage;
  kode: Integer);

procedure unknowDM;
var
  s1: String;
begin
  s1 := format(pc003_23_44, [kode, Msg.WParam, Msg.LParam]);
  if CheckBox1.Checked or CheckBox4.Checked then addLine(s1);
  insMessage(s1);
end;

procedure PrintMessage(b1, b2: Boolean);
var
  s1: String;
  sStr: TStringList;
  jC1: Integer;
begin
  s1 := extStr.movePull(Msg.LParam);
  sStr := TStringList.Create;
  try
    sStr.Text := s1;
    for jC1 := 1 to sStr.Count do
    begin
      s1 := sStr.Strings[jC1-1];
      if Length(s1) > 0 then
      begin
        if b1 then addLine(FormatDateTime(pc003_23_10, Now) + '> ' + s1);
        if b2 then insDTMessage(s1);
      end;
    end;
  finally
    sStr.Free;
  end;
end;


var
  s1: String;
begin
  try
  if kode = WM_User_Dialog then
  begin
    case Msg.WParamLo of
      101:
      begin
        PrintMessage(CheckBox1.Checked, CheckBox5.Checked);
      end;

      102: //repeat
              procDB.Resume;
//PostMessage (Handle, WM_User_Dialog, 177, 5);
           //until not procDB.Suspended;
      103: BitBtn1.Caption := pc003_23_03;
      104: BitBtn1.Caption := pc003_23_04;
      105: CheckBox1.Checked := True;
      106: CheckBox1.Checked := False;
      107: if CheckBox1.Checked then Memo1.Clear;

      110:
      begin
        PrintMessage(CheckBox4.Checked, CheckBox6.Checked);
      end;

      177:
      begin
        s1 := IntToStr(Msg.LParam);
//        addLine(s1);
      end;

      else unknowDM;
    end;
  end
  else
  begin
    unknowDM;
  end;

  finally
    Application.ProcessMessages;
  end;
end;

procedure TOreolClientDB4.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if isActiveMode then
  begin
    if ServerSocket1.Active then
    begin
      if ServerSocket1.Socket.ActiveConnections <> 0 then
      begin
        if not CheckBox3.Checked then
        if MessageDlg(pc003_23_05, mtWarning, [mbYes, mbNo], 0) <> mrYes then
        begin
          CanClose := False;
          Exit;
        end;
      end;
      ServerSocket1.Active := False;
    end;
    bActiveMode := False;
  end;

  inherited;
end;

procedure TOreolClientDB4.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  s1: string;
  jH: Integer;
begin
  inherited;
  jH := Socket.Handle;
  s1 := getTitleStr(Socket, True) + pc003_23_12;
  prqTgetString.putString(s1, Handle, Socket.Handle);
  Dec(jClientDBcount);
  if jClientDBcount <= 0 then
  begin
    jClientDBcount := 0;
  end;

  if oreolDB.keyConnect = jH then
  begin
    ClearCommandList(0, True);
    oreolDB.disConnectDB(oreolDB.keyConnect);
  end
  else
  begin
    if jClientDBcount = 0 then
    begin
      ClearCommandList(0, True);
      oreolDB.disConnectDB(oreolDB.keyConnect);
    end
    else
    begin
      ClearCommandList(jH, False);
    end;
  end;

  PostMessage (Handle, WM_User_Dialog, 110, Socket.Handle);
end;

procedure TOreolClientDB4.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  rcd: rcdTcommand;
  jCP: Integer;
begin
  inherited;
// Определяемся с режимом ввода
  rcd.Handle := Socket.Handle;
  rcd.cmd    := copTP_NewCmd;
  rcd.Socket := Socket;
  cmdPaket.csPaket.Enter;
  cmdPaket.csPaket.bBlockRsrc := True;
  try
    jCP := cmdPaket.Find(@rcd, 2);
    if jCP = 0 then
    begin
      cmdPaket.Append(@rcd);
      jCP := cmdPaket.Count;
      cmdPaket[jCP].NewCmd.lPack :=      0;
      cmdPaket[jCP].NewCmd.lCrnt :=      0;
      cmdPaket[jCP].NewCmd.rcdPC :=    nil;
    end;
    rcd := cmdPaket[jCP]^;
  finally
    cmdPaket.csPaket.bBlockRsrc := False;
    cmdPaket.csPaket.Leave;
  end;
  getPacket(rcd);

//  PostMessage (Handle, WM_User_Dialog, 102, 0);
end;

procedure TOreolClientDB4.Action1Execute(Sender: TObject);
begin
  inherited;
  Memo1.Clear;
  Application.ProcessMessages;
end;

procedure TOreolClientDB4.Action2Execute(Sender: TObject);
var
  jC1: Integer;
begin
  inherited;
  for jC1 := 0 to ServerSocket1.Socket.ActiveConnections - 1 do
    with ServerSocket1.Socket.Connections [jC1] do
      addLine(
        RemoteAddress + ' (' +
        RemoteHost + ') ' +
        IntToStr(Handle) );
end;

procedure TOreolClientDB4.Action3Execute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TOreolClientDB4.Action4Execute(Sender: TObject);
var
  jC1: Integer;
begin
  inherited;
  if isActiveMode then
  begin
    ShowMessage(pc003_23_06);
    Exit;
  end;

// Изменить номер порта
  try
    jC1 := StrToInt( Edit1.Text );
    ServerSocket1.Port := jC1;
  except
    on E: Exception do
    begin
      insDTMessage(E.Message);
      ShowMessage( E.Message + #13#10 + pc003_23_07);
      Exit;
    end;
  end;
end;

procedure TOreolClientDB4.Action5Execute(Sender: TObject);
var
  s1: String;
begin
  inherited;
  if isActiveMode then
  begin
    if ServerSocket1.Active then
    begin
      if ServerSocket1.Socket.ActiveConnections <> 0 then
      begin
        if MessageDlg(pc003_23_05, mtWarning, [mbYes, mbNo], 0) <> mrYes then Exit;
      end;
      ClearCommandList(0, True);
      oreolDB.disConnectDB(oreolDB.keyConnect);
      ServerSocket1.Active := False;
      s1 := pc003_23_08;
      prqTgetString.putString(s1, Handle, 0);
      PostMessage (Handle, WM_User_Dialog, 110, 0);
    end;
    bActiveMode := False;
    PostMessage (Handle, WM_User_Dialog, 103, 0);
  end
  else
  begin
    bActiveMode := True;
    ServerSocket1.Active := True;
    PostMessage (Handle, WM_User_Dialog, 104, 0);
    s1 := pc003_23_09;
    prqTgetString.putString(s1, Handle, 0);
    PostMessage (Handle, WM_User_Dialog, 110, 0);
  end;
end;

procedure TOreolClientDB4.Action6Execute(Sender: TObject);
begin
  inherited;
  Shell_NotifyIcon(NIM_ADD, @NID);
  Application.ShowMainForm := False;
  Visible := False;
end;

procedure TOreolClientDB4.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
var
  s1: string;
  jH: Integer;
begin
  jH := Socket.Handle;

  s1 := getTitleStr(Socket, True);

    case ErrorEvent of
eeGeneral:
begin
  s1 := s1 + 'The socket received an uncknown error message';
end;
eeSend:
begin
  s1 := s1 + 'An error occurred when trying to write to the socket connection';
end;
eeReceive:
begin
  s1 := s1 + 'An error occurred when trying to read from the socket connection';
end;
eeConnect:
begin
  s1 := s1 + 'A connection request that was already accepted could not be completed';
end;
eeDisconnect:
begin
  s1 := s1 + 'An error occurred when trying to close a connection';
end;
eeAccept:
begin
  s1 := s1 + 'A problem occurred when trying to accept a client connection request';
end;
  end;

  prqTgetString.putString(s1, Handle, jH);
  PostMessage (Handle, WM_User_Dialog, 110, jH);

  if oreolDB.keyConnect = jH then
  begin
    ClearCommandList(0, True);
    oreolDB.disConnectDB(oreolDB.keyConnect);
  end
  else
    ClearCommandList(jH, False);

  try
    if Socket.Connected then
    begin

      Socket.Disconnect(Socket.SocketHandle);
    
    end;

  except end;

  ErrorCode := 0;
end;

procedure TOreolClientDB4.produceCommand(const rcd: rcdTcommand;
setPack: prqTobject);
var
  rcd_New: rcdTcommand;
  jDBLength, jCP_P, jC1: Integer;
  sMesto, sKust, sSkvazhina, sRabota, sPath, sFLBD, sNMadmin, sPSadmin,
    s1, s2, s3, s4, s5: string;
  msg: TOP_ErrorMsg;
  msgVer: TOP_ErrorMsg;
  msgPutLParam: TOP_putLParam;
  msgPutLOper: TOP_putLOper;
  msgDescript:  TOP_Descript;
  msgOper:  TOP_Operation;
  msgMeasuring: TOP_Measuring;
  msgRequest: prqTobject;
  msgServ: TOP_ServParam;
  msgArrMark: TOP_Marker;
  bRes: Boolean;

procedure doCreateDB;
var
  s1: string;
begin
  if oreolDB.isConnected then
  begin
    ClearCommandList(0, True);
    oreolDB.disConnectDB(0);
  end;

  if RadioButton5.Checked then
  begin
    sNMadmin := ''; sPSadmin := ''; // По учетной записи Windows
  end
  else
  begin // По параметрам из настроек
    sNMadmin := Trim(Edit3.Text); sPSadmin := Trim(Edit5.Text);
  end;

  if RadioButton3.Checked then
  begin // путь к БД из настроек клиента
    s1 := Trim(Edit6.Text);
    if Length(s1) > 0 then
    begin
      if s1[Length(s1)] <> '\' then s1 := s1 + '\';
    end;
    sFLBD := s1 + 'fl_' + s4 + '.mdf';
  end
  else
  begin // путь к БД из реестра (в папке проекта)
    Tkrs6Function.ReadMestoParam1(sMesto, sKust, sSkvazhina, sRabota, sPath);
    s1 := Trim(sPath);
    if Length(s1) > 0 then
    begin
      if s1[Length(s1)] <> '\' then s1 := s1 + '\';
    end;
    sFLBD := s1 + 'fl_' + s4 + '.mdf';
  end;
  try
    jDBLength := StrToInt(Trim(Edit7.Text))
  except
    jDBLength := 10;
  end;
  if not CheckBox5.Checked then insDTMessage(getTitleStr(rcd.Socket, True) + s5);
end;

function GetBaseMeasuring: Boolean;
var
  jProC1: Integer;
begin
  msgRequest := prqTobject.Create;
  try
    result := oreolDB.GetMeasuring(rcd.GetMeasuring, msgRequest, msg);
    appPack(msg, setPack);
    for jProC1 := 1 to msgRequest.Count do
    begin
      appPack(msgRequest[jProC1].ukz as TOreolProtocol, setPack);
      msgRequest[jProC1].ukz := nil;
    end;
  finally
    msgRequest.Free;
  end;
end;

function GetPrevMeasuring: Boolean;
var
  jProC1: Integer;
begin
  msgRequest := prqTobject.Create;
  try
    result := oreolDB.GetPrevMeasuring(rcd.GetPrevMeas, msgRequest, msg);
    appPack(msg, setPack);
    for jProC1 := 1 to msgRequest.Count do
    begin
      appPack(msgRequest[jProC1].ukz as TOreolProtocol, setPack);
      msgRequest[jProC1].ukz := nil;
    end;
  finally
    msgRequest.Free;
  end;
end;

function GetLastMeasuring: Boolean;
var
  jProC1: Integer;
begin
  msgRequest := prqTobject.Create;
  try
    result := oreolDB.GetLastMeasuring(rcd.GetLastMeas, msgRequest, msg);
    appPack(msg, setPack);
    for jProC1 := 1 to msgRequest.Count do
    begin
      appPack(msgRequest[jProC1].ukz as TOreolProtocol, setPack);
      msgRequest[jProC1].ukz := nil;
    end;
  finally
    msgRequest.Free;
  end;
end;

begin
    case rcd.cmd of

copTP_ErrorMsg:    // Диагностическое сообщение
  begin
// Разборка диагностического сообщения
      s1 := DePackString(rcd.ErrorMsg.lStr, rcd.ErrorMsg.rcd);


      s1 := format(pc006_04_005, [rcd.ErrorMsg.code, s1]);
      msgServ := TOP_ServParam.Create(copTP_OtherText, s1);
      appPack(msgServ, setPack);
  end;


copTP_getLParam:   //   1. Запрос списка параметров (только от браузера к клиенту БД)
  begin
    msgServ := TOP_ServParam.Create(copTP_OtherText,
                                    getTitleStr(rcd.Socket, True) + pc003_23_29);
    appPack(msgServ, setPack);
    msgPutLParam := nil;
    msg := nil;
    oreolDB.listAllParam(msgPutLParam, msg);
    appPack(msg, setPack); appPack(msgPutLParam, setPack);
  end;


  copTP_putLParam: //   2. Список параметров (только от клиента БД к браузеру)
  begin
  end;


  copTP_getParam:  //   3. Запрос описания параметра (только от браузера к клиенту БД)
  begin
    msgDescript := nil;
    msg := nil;
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) +
                                    format(pc003_23_33, [rcd.getParam.nPar]));
    appPack(msgServ, setPack);
    oreolDB.GetParam(rcd.getParam, msgDescript, msg);
    appPack(msg, setPack);
    appPack(msgDescript, setPack);
  end;


  copTP_Descript:  //   4. Передача описания параметра в БД
  begin
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) +
                                    format(pc003_23_35, [rcd.Descript.nPar]));
    appPack(msgServ, setPack);
    msg := nil;
    if oreolDB.keyConnect = rcd.Handle then
    begin
      oreolDB.SendParam(rcd.Descript, msg);
    end
    else
    begin
      msg := TOP_ErrorMsg.Create(copErr_CnctInUse, sqlErr_CnctInUse1);
    end;
    appPack(msg, setPack);
  end;


  copTP_Measuring: //   5. Передача измерений в Базу Данных
  begin
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) +
                     format(pc003_23_39, [rcd.Measuring.meass.Count]));
    appPack(msgServ, setPack);
    msgMeasuring := nil;
    msg := nil;

    if oreolDB.keyConnect = rcd.Handle then
    begin
      oreolDB.SendMeasuring(rcd.Measuring, msgMeasuring, msg);
      appPack(msg, setPack);
      appPack(msgMeasuring, setPack);
    end
    else
    begin
      msg := TOP_ErrorMsg.Create(copErr_CnctInUse, sqlErr_CnctInUse1);
      appPack(msg, setPack);
    end;
  end;


  copTP_Line:      //   6. Строковый пакет
begin
end;


  copTP_CollectP:  //   7. Набор пакетов
  begin
    jC1 := 1;
    while jC1 <= rcd.CollectP.lPack do
    begin
      cmdPaket.csPaket.Enter;
      cmdPaket.csPaket.bBlockRsrc := True;
      try
        jCP_P := cmdPaket.Find(@rcd, 1);
        rcd_New := cmdPaket[jCP_P]^;
        cmdPaket.Delete(jCP_P);
      finally
        cmdPaket.csPaket.bBlockRsrc := False;
        cmdPaket.csPaket.Leave;
      end;
      produceCommand(rcd_New, setPack);
      prqTcommand.FreeRcd(@rcd_New);
      Inc(jC1);
    end;
  end;


  copTP_GetMeasuring: //8. Передача измерений из Базы Данных
  begin
    if rcd.GetMeasuring.pFld <> nil then
    begin
      if rcd.GetMeasuring.dtBeg <= 0 then // запрос по глубине
      begin
        msgServ := TOP_ServParam.Create(copTP_OtherText,
                                        getTitleStr(rcd.Socket, True) +
                                        format(pc003_23_53, [rcd.GetMeasuring.tySd,
                                                             Trim(format(pc003_23_54, [-rcd.GetMeasuring.dtBeg])),
                                                             Trim(format(pc003_23_54, [rcd.GetMeasuring.dtEnd]))]));
      end
      else
      begin
        msgServ := TOP_ServParam.Create(copTP_OtherText,
                                        getTitleStr(rcd.Socket, True) +
                                        format(pc003_23_42, [rcd.GetMeasuring.tySd,
                                                             formatDateTime(pc003_23_10, rcd.GetMeasuring.dtBeg),
                                                             formatDateTime(pc003_23_10, rcd.GetMeasuring.dtEnd)]));
      end;
      appPack(msgServ, setPack);
    end;

    msg := nil;
    GetBaseMeasuring;
  end;


  copTP_Hello:     //  10. Установить контакт с БД
  begin
    if oreolDB.isConnected then
    begin
      ClearCommandList(0, True);
      oreolDB.disConnectDB(0);
    end;
    s1 := DePackString(rcd.Hello.lName, rcd.Hello.rcdNm);
    s2 := DePackString(rcd.Hello.lPass, rcd.Hello.rcdPs);
    if not CheckBox7.Checked then
      s3 := Trim(Edit4.Text)
    else
      s3 := DePackString(rcd.Hello.lServ, rcd.Hello.rcdSr);
    s4 := DePackString(rcd.Hello.lDBas, rcd.Hello.rcdDB);
//    s5 := format(pc006_04_001, [s1, s2, s3, s4]); // 13:22 02.06.2012
    s5 := format(pc006_04_001, [s1, '', s3, s4]); // 13:22 02.06.2012
    if not CheckBox5.Checked then insDTMessage(getTitleStr(rcd.Socket, True) + s5);
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) + s5);
    appPack(msgServ, setPack);
    msg:= nil;
    bRes := oreolDB.ConnectDB(s1,s2,s3,s4, msg, rcd.Handle);
    appPack(msg, setPack);
    if bRes then
    begin
      msgVer := TOP_ErrorMsg.Create(copErr_DBVersion, format(sql_PrefixVer2, [oreolDB.NomVerDB]));
      appPack(msgVer, setPack); 
      msgVer := TOP_ErrorMsg.Create(copErr_DBCparam,  format(sql_Param_D_T_D_DB,
                                                            [ FloatTostr(oreolDB.getLastDepth),
                                                              FloatTostr(oreolDB.getLastTime),
                                                              FloatTostr(Now) ]));
      appPack(msgVer, setPack);
    end;
  end;


  copTP_HelloRead:     //  18. Установить контакт пользователя с Сервером только для чтения
  begin
    s1 := DePackString(rcd.HelloRead.lName, rcd.HelloRead.rcdNm);
    s2 := DePackString(rcd.HelloRead.lPass, rcd.HelloRead.rcdPs);
    if not CheckBox7.Checked then s3 := Trim(Edit4.Text) else
      s3 := DePackString(rcd.HelloRead.lServ, rcd.HelloRead.rcdSr);
    s4 := DePackString(rcd.HelloRead.lDBas, rcd.HelloRead.rcdDB);
//    s5 := format(pc006_04_002, [s1, s2, s3, s4]); // 13:22 02.06.2012
    s5 := format(pc006_04_002, [s1, '', s3, s4]); // 13:22 02.06.2012
    if not CheckBox5.Checked then insDTMessage(getTitleStr(rcd.Socket, True) + s5);
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) + s5);
    appPack(msgServ, setPack);
    msg:= nil;
    bRes := oreolDB.ConnectDB(s1,s2,s3,s4, msg, 0);
    appPack(msg, setPack);
    if bRes then
    begin
      msgVer := TOP_ErrorMsg.Create(copErr_DBVersion, format(sql_PrefixVer2, [oreolDB.NomVerDB]));
      appPack(msgVer, setPack);
      msgVer := TOP_ErrorMsg.Create(copErr_DBCparam,  format(sql_Param_D_T_D_DB,
                                                            [ FloatTostr(oreolDB.getLastDepth),
                                                              FloatTostr(oreolDB.getLastTime),
                                                              FloatTostr(Now) ]));
      appPack(msgVer, setPack);
    end;
  end;


  copTP_CreateDB:     //  20. Установить контакт с БД
  begin
    s1 := DePackString(rcd.CreateDB.lName, rcd.CreateDB.rcdNm);
    s2 := DePackString(rcd.CreateDB.lPass, rcd.CreateDB.rcdPs);
    if not CheckBox7.Checked then s3 := Trim(Edit4.Text) else s3 := DePackString(rcd.CreateDB.lServ, rcd.CreateDB.rcdSr);
    s4 := DePackString(rcd.CreateDB.lDBas, rcd.CreateDB.rcdDB);
//    s5 := format(pc006_04_003, [s1, s2, s3, s4]); // 13:22 02.06.2012
    s5 := format(pc006_04_003, [s1, '', s3, s4]); // 13:22 02.06.2012
    doCreateDB;
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) + s5);
    appPack(msgServ, setPack);
    msg:= nil;
    oreolDB.CreateDB(s1,s2,s3,s4, msg, sNMadmin,sPSadmin,sFLBD, jDBLength);
    appPack(msg, setPack);
  end;

  copTP_CreateDBv:     //  21. Установить контакт с БД
  begin
    s1 := DePackString(rcd.CreateDBv.lName, rcd.CreateDBv.rcdNm);
    s2 := DePackString(rcd.CreateDBv.lPass, rcd.CreateDBv.rcdPs);
    if not CheckBox7.Checked then s3 := Trim(Edit4.Text) else s3 := DePackString(rcd.CreateDBv.lServ, rcd.CreateDBv.rcdSr);
    s4 := DePackString(rcd.CreateDBv.lDBas, rcd.CreateDBv.rcdDB);

//    s5 := format(pc006_04_004, [s1, s2, s3, s4, IntToStr(rcd.CreateDBv.nomVer)]); // 13:22 02.06.2012
    s5 := format(pc006_04_004, [s1, '', s3, s4, IntToStr(rcd.CreateDBv.nomVer)]); // 13:22 02.06.2012
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) + s5);
    appPack(msgServ, setPack);
    doCreateDB;
    msg:= nil;
    oreolDB.CreateDB(s1,s2,s3,s4, msg, sNMadmin,sPSadmin,sFLBD, jDBLength, rcd.CreateDBv.nomVer);
    appPack(msg, setPack);
  end;



copTP_Buy:       //    11. Разорвать контакт пользователя с Сервером
  begin
    if oreolDB.keyConnect = rcd.Handle then
    begin
      ClearCommandList(0, True);
    end
    else
    begin
      ClearCommandList(rcd.Handle, False);
    end;
    oreolDB.disConnectDB(rcd.Handle);

    if not CheckBox5.Checked then insDTMessage(getTitleStr(rcd.Socket, True) + pc003_23_30);
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) + pc003_23_30);
    appPack(msgServ, setPack);
    msg := TOP_ErrorMsg.Create(copErr_LoginBDOk, '');
    appPack(msg, setPack);
  end;


copTP_getLOper:  // Запрос списка операций (только от браузера к клиенту БД)
  begin
    msgServ := TOP_ServParam.Create(copTP_OtherText,
                                    getTitleStr(rcd.Socket, True) + pc003_23_48);
    appPack(msgServ, setPack);
    msgPutLOper := nil;
    msg := nil;
    oreolDB.listAllOper(msgPutLOper, msg);
    appPack(msg, setPack); appPack(msgPutLOper, setPack);
  end;

copTP_Operation:  // Передача описания операции (Тип маркера) (в обе стороны)
  begin
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) +
                                    format(pc003_23_49, [rcd.Operation.nOper]));
    appPack(msgServ, setPack);
    msg := nil;
    if oreolDB.keyConnect = rcd.Handle then
    begin
      oreolDB.SendOper(rcd.Operation, msg);
      appPack(msg, setPack);
    end
    else
    begin
      msg := TOP_ErrorMsg.Create(copErr_CnctInUse, sqlErr_CnctInUse1);
      appPack(msg, setPack);
    end;
  end;


copTP_GetOper:    // Запрос описания операции (только от браузера к клиенту БД)
  begin
    msgOper := nil;
    msg := nil;
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) +
                                    format(pc003_23_50, [rcd.GetOper.nPar]));
    appPack(msgServ, setPack);
    oreolDB.GetOper(rcd.GetOper, msgOper, msg);
    appPack(msg, setPack);
    appPack(msgOper, setPack);
  end;


copTP_ArrMark:    // Передача Маркера (в обе стороны)
  begin
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) +
                     format(pc003_23_51, [rcd.ArrMark.arr.Count]));
    appPack(msgServ, setPack);
    msg := nil;
    if oreolDB.keyConnect = rcd.Handle then
    begin
      oreolDB.SendArrMark(rcd.ArrMark, msg);
      appPack(msg, setPack);
    end
    else
    begin
      msg := TOP_ErrorMsg.Create(copErr_CnctInUse, sqlErr_CnctInUse1);
      appPack(msg, setPack);
    end;
  end;


copTP_GetMarker:  // Запрос Маркера (только от браузера к клиенту БД)
  begin
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) +
                     format(pc003_23_52,
                            [formatDateTime(pc003_23_10, rcd.GetMarker.dtBeg),
                            formatDateTime(pc003_23_10, rcd.GetMarker.dtEnd)]));
    appPack(msgServ, setPack);
    msgArrMark := nil;
    msg := nil;
    oreolDB.GetArrMark(rcd.GetMarker, msgArrMark, msg);
    appPack(msg, setPack);
    appPack(msgArrMark, setPack);
  end;


  copTP_GetPrevMeas: //101. Передача Предваряющего пакета из Базы Данных
  begin
    if oreolDB.NomVerDB > 0 then
    begin
      msg := nil;
      GetPrevMeasuring;
    end;
  end;


  copTP_GetLastMeas: //102. Передача Завершающего  пакета из Базы Данных
  begin
    if oreolDB.NomVerDB > 0 then
    begin
      msg := nil;
      GetLastMeasuring;
    end;
  end;


copTP_GetStr:      // Принять строку текста
  begin
    s1 := DePackString(rcd.GetStr.lStr, rcd.GetStr.rcd);
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) + s1);
    appPack(msgServ, setPack);
  end;


copTP_GetStrEho:   // Принять строку текста и вернуть ответ
  begin
    s1 := DePackString(rcd.GetStr.lStr, rcd.GetStr.rcd);
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) + s1);
    appPack(msgServ, setPack);
    msg := TOP_ErrorMsg.Create(copErr_Ok);
    appPack(msg, setPack);
  end;


copTP_GetArr:      // Принять массив двоичных данных
  begin
  end;


copTP_GetArrEho:   // Принять массив двоичных данных и вернуть ответ
  begin // Принять строку текста
    msg := TOP_ErrorMsg.Create(copErr_Ok);
    appPack(msg, setPack);
  end;


copTP_HelloTst:    // 211. Установить контакт с тестовой БД
  begin
    s4 := DePackString(rcd.HelloTst.lDBas, rcd.HelloTst.rcdDB);
    s5 := format(pc006_04_006, [s4]);
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) + s5);
    appPack(msgServ, setPack);
    bRes := oreolDB.ConnectDB(s4, msg);
    appPack(msg, setPack);
    if bRes then
    begin
      msgVer := TOP_ErrorMsg.Create(copErr_DBVersion, format(sql_PrefixVer2, [oreolDB.NomVerDB]));
      appPack(msgVer, setPack);
      msgVer := TOP_ErrorMsg.Create(copErr_DBCparam,  format(sql_Param_D_T_D_DB,
                                                            [ FloatTostr(oreolDB.getLastDepth),
                                                              FloatTostr(oreolDB.getLastTime),
                                                              FloatTostr(Now) ]));
      appPack(msgVer, setPack);
    end;
  end;

copTP_CreateMainT: //+ 212. Создать упр таб (в тестовой БД)
  begin
    s1 := pc003_23_43;
    msgServ := TOP_ServParam.Create(copTP_OtherText, getTitleStr(rcd.Socket, True) + s1);
    appPack(msgServ, setPack);
    oreolDB.CreateMainTab(msg);
    appPack(msg, setPack);
  end;

copTP_protklOn:    // 251. Включить протокол с диагностическими сообщениями
  begin
    msgServ := TOP_ServParam.Create(copTP_protklOn);
    appPack(msgServ, setPack);
  end;

copTP_protklOff:   // 252. Выключить протокол с диагностическими сообщениями
  begin
    msgServ := TOP_ServParam.Create(copTP_protklOff);
    appPack(msgServ, setPack);
  end;

copTP_protklClr:   // 253. Очистить протокол с диагностическими сообщениями
  begin
    msgServ := TOP_ServParam.Create(copTP_protklClr);
    appPack(msgServ, setPack);
  end;

    end; // конец разборки вариантов
end;

procedure TOreolClientDB4.appPack(msg: TOreolProtocol; setPack: prqTobject);
var
  rcd: rcdTcontainer;
begin
  if msg = nil then Exit;
  rcd.ukz := msg; setPack.Append(@rcd);
end;

procedure TOreolClientDB4.doProcess;
var
  ErrorCode, jPnt, jC1: Integer;
  rcd: rcdTcommand;
  bEmpty: Boolean;
begin
repeat

  try
    repeat
      bEmpty := True;
//PostMessage (Handle, WM_User_Dialog, 177, 1);
      cmdPaket.csPaket.Enter;
      cmdPaket.csPaket.bBlockRsrc := True;
      try

        jC1 := 1;
        while jC1 <= cmdPaket.Count do
        begin
          if not Assigned(cmdPaket[jC1].Socket) then
          begin
            cmdPaket.Delete(jC1);
            bEmpty := False;
            insDTMessage(pc003_23_e00 + pc003_23_e01);
            break;
          end;

          if cmdPaket[jC1].cmd = copTP_NewCmd then
          begin
            Inc(jC1); continue;
          end
          else
          if cmdPaket[jC1].cmd = copTP_NewCmdFin then
          begin
            jPnt := 0;
            prdPaket.csPaket.Enter;
            prdPaket.csPaket.bBlockRsrc := True;
            try

              if oreolDB.NomVerDB > 0 then
              begin
                prdPaket.transPaket2(cmdPaket[jC1]^, ErrorCode, jPnt);
              end
              else
                prdPaket.transPaket(cmdPaket[jC1]^, ErrorCode, jPnt);

              cmdPaket.Delete(jC1);
            finally
              prdPaket.csPaket.bBlockRsrc := False;
              prdPaket.csPaket.Leave;
            end;
            bEmpty := False;
            break;
          end
          else
          begin
            cmdPaket.Delete(jC1);
            bEmpty := False;
            insDTMessage(pc003_23_e00 + pc003_23_e02);
            break;
          end;
        end;

      finally
        cmdPaket.csPaket.bBlockRsrc := False;
        cmdPaket.csPaket.Leave;
      end;

    until bEmpty;
  except
    on E: Exception do
    begin
      insDTMessage(pc003_23_CP01 + E.Message);
    end;
  end;

//PostMessage (Handle, WM_User_Dialog, 177, 2);
  if (prdPaket.Count = 0) then Exit;


  try
    repeat
      bEmpty := True;
      prdPaket.csPaket.Enter;
      prdPaket.csPaket.bBlockRsrc := True;
      try

        jC1 := 1;
        while jC1 <= prdPaket.Count do
        begin
          if not Assigned(prdPaket[jC1].Socket) then
          begin
            prdPaket.Delete(jC1);
            bEmpty := False;
            insDTMessage(pc003_23_e00 + pc003_23_e01);
            break;
          end;

          rcd := prdPaket[jC1]^;
          prdPaket[jC1].cmd := copTP_ClrCommand;
          prdPaket.Delete(jC1);
          prdPaket.csPaket.bBlockRsrc := False;
          prdPaket.csPaket.Leave;
          bEmpty := False;
          produce(rcd);
          prqTcommand.FreeRcd(@rcd);
          break;
        end;

      finally
        if prdPaket.csPaket.bBlockRsrc then
        begin
          prdPaket.csPaket.bBlockRsrc := False;
          prdPaket.csPaket.Leave;
        end;
      end;

    until bEmpty;
  except
    on E: Exception do
    begin
      insDTMessage(pc003_23_CP02 + E.Message);
    end;
  end;

until False;
//PostMessage (Handle, WM_User_Dialog, 177, 3);
end;

procedure TOreolClientDB4.produce(const rcd: rcdTcommand);
var
  jCP_P: Integer;
//  PackSize,
  jLCOll, jC1: Integer;
  msgCollectP: TOP_CollectP;
  rcd_New: rcdTcommand;
  setPack: prqTobject;
  Collect: array of TOreolProtocol;
  s1: String;
  bCollect: Boolean;
begin
  try

    setPack := prqTobject.Create;
    try

      if rcd.cmd = copTP_CollectP then
      begin
        bCollect := True;
        jC1  := 1;
        while jC1 <= rcd.CollectP.lPack do
        begin
          prdPaket.csPaket.Enter;
          prdPaket.csPaket.bBlockRsrc := True;
          try
            jCP_P := prdPaket.Find(@rcd, 1);
            rcd_New := prdPaket[jCP_P]^;
            prdPaket[jCP_P].cmd := copTP_ClrCommand;
            prdPaket.Delete(jCP_P);
          finally
            prdPaket.csPaket.bBlockRsrc := False;
            prdPaket.csPaket.Leave;
          end;
          produceCommand(rcd_New, setPack);
          prqTcommand.FreeRcd(@rcd_New);
          Inc(jC1);
        end;
      end
      else
      begin
        bCollect := False;
        produceCommand(rcd, setPack);
      end;

      if setPack.Count > 0 then
      begin

        jLCOll := 0;
        for jC1 := 1 to setPack.Count do
        begin
          if setPack[jC1].ukz is TOP_ServParam then
          begin
            case (setPack[jC1].ukz as TOP_ServParam).CodeOpr of
                  copTP_protklOn:  PostMessage (Handle, WM_User_Dialog, 105, 0);
                  copTP_protklOff: PostMessage (Handle, WM_User_Dialog, 106, 0);
                  copTP_protklClr: PostMessage (Handle, WM_User_Dialog, 107, 0);
                  copTP_OtherText:
                  begin
                    if Length((setPack[jC1].ukz as TOP_ServParam).txtMsg) > 0 then
                    begin
                      s1 := (setPack[jC1].ukz as TOP_ServParam).txtMsg;
                      prqTgetString.putString(s1, Handle, rcd.Socket.Handle);
                      PostMessage (Handle, WM_User_Dialog, 101, rcd.Socket.Handle);
                    end;
                  end;
            end;
            Application.ProcessMessages;
            continue;
          end
          else
          begin
            if setPack[jC1].ukz is TOP_ErrorMsg then
            begin
              if Length((setPack[jC1].ukz as TOP_ErrorMsg).txtMsg) > 0 then
              begin
                s1 := (setPack[jC1].ukz as TOP_ErrorMsg).txtMsg;
                prqTgetString.putString(s1, Handle, rcd.Socket.Handle);
//                PostMessage (Handle, WM_User_Dialog, 110, rcd.Socket.Handle);
                if (setPack[jC1].ukz as TOP_ErrorMsg).fECode < 0 then
                  PostMessage (Handle, WM_User_Dialog, 110, rcd.Socket.Handle)
                else
                  PostMessage (Handle, WM_User_Dialog, 101, rcd.Socket.Handle);
              end;
            end;
          end;

          Inc(jLCOll);
          SetLength(Collect, jLCOll);
          Collect[jLCOll-1] := setPack[jC1].ukz as TOreolProtocol;
          setPack[jC1].ukz := nil;
        end;

        if jLCOll > 0 then
        begin
{
          PackSize := 0;
          for jC1 := Low(Collect) to High(Collect) do
          begin
            Inc(PackSize, Collect[jC1].FullSize);
          end;

          if (jLCOll = 1) or (PackSize > MaxPacketSize) then
}

          if not bCollect then
          begin
            for jC1 := Low(Collect) to High(Collect) do
            begin
              try
                Collect[jC1].SendBuf(rcd.Socket);
              except
                on E: Exception do
                begin
                  insDTMessage(pc003_23_CP04 + E.Message);
                end;
              end;
            end;
          end
          else
          begin
            msgCollectP := TOP_CollectP.Create(Collect);
            try
              try
                msgCollectP.SendBuf(rcd.Socket);
              except
                on E: Exception do
                begin
                  insDTMessage(pc003_23_CP05 + E.Message);
                end;
              end;
            finally
              msgCollectP.Free;
            end;
          end;
        end;
      end;

//      if CheckBox1.Checked then addLine( IntToStr(fLengthS) );

    finally
      if Length(Collect) > 0 then
      begin
        for jC1 := Low(Collect) to High(Collect) do
        begin
          Collect[jC1].Free; Collect[jC1] := nil;
        end;
        SetLength(Collect, 0);
      end;
      setPack.Free;
    end;

  except
    on E: Exception do
    begin
      insDTMessage(pc003_23_CP03 + E.Message);
    end;
  end;
end;

procedure TOreolClientDB4.getPacket(var rcd: rcdTcommand);
var
  rcdErr: rcdTcommand;
  jCP: Integer;
  b1: Boolean;
begin
  b1 := False;
  cmdPaket.csPaket.Enter;
  cmdPaket.csPaket.bBlockRsrc := True;
  try
    TOreolProtocol.getPacket(rcd);
    if rcd.NewCmd.lPack = 0 then Exit;
    jCP := cmdPaket.Find(@rcd, 2);
    if jCP = 0 then
    begin
      TOP_ErrorMsg.DePackError(rcdErr, copErr_Program);
      cmdPaket.Append(@rcdErr);
      prqTcommand.FreeRcd(@rcd);
      Exit;
    end;

    cmdPaket[jCP].NewCmd := rcd.NewCmd;
    if rcd.NewCmd.lPack = 0 then Exit;
    if rcd.NewCmd.lPack <> rcd.NewCmd.lCrnt then Exit;
    cmdPaket[jCP].cmd := copTP_NewCmdFin;
    b1 := True;

  finally
    cmdPaket.csPaket.bBlockRsrc := False;
    cmdPaket.csPaket.Leave;
    if b1 then PostMessage (Handle, WM_User_Dialog, 102, 0);
  end;
end;

{ myTh }

procedure myTh.dbCln_doProcess;
begin
  dbCln.doProcess;
end;

procedure myTh.doProcess;
begin
  repeat
    Inc(j1);
    if isTerminated then break;

      FbCalc := True;

              Synchronize( dbCln_doProcess );
//PostMessage (dbCln.Handle, WM_User_Dialog, 177, 4);

      FbCalc := False;

    if isTerminated then break;

//    sleep(10);
//    if (dbCln.prdPaket.Count = 0) then
        suspend;

              Synchronize( txt );

  until False;
  FbCalc := False;
end;

procedure TOreolClientDB4.insMessage(const msg: String);
begin
  if bProt then
  begin
    WriteLn(fileProtTxt, msg);
    Flush(fileProtTxt);
  end;
end;

procedure TOreolClientDB4.insDTMessage(const msg: String);
begin
  if bProt then
  begin
    WriteLn(fileProtTxt,
            FormatDateTime(pc003_23_10, Now) + '> ' + msg);
    Flush(fileProtTxt);
  end;
end;

procedure TOreolClientDB4.addLine(ln: string);
begin
  if Memo1.Lines.Count >= pc003_23_LengthMemPr then
  begin
    Memo1.Lines.Delete(0);
  end;
  Memo1.Lines.Add(ln);
end;

procedure TOreolClientDB4.ClearCommandList(jH: Integer; bAll: Boolean);
var
  jC1: Integer;
begin
  if not cmdPaket.csPaket.bBlockRsrc then cmdPaket.csPaket.Enter;
  try
    for jC1 := 1 to cmdPaket.Count do
    begin
      if bAll or (cmdPaket[jC1].Handle = jH) then cmdPaket[jC1].Socket := nil;
    end;
  finally
    if not cmdPaket.csPaket.bBlockRsrc then cmdPaket.csPaket.Leave;
  end;

  if not prdPaket.csPaket.bBlockRsrc then prdPaket.csPaket.Enter;
  try
    for jC1 := 1 to prdPaket.Count do
    begin
      if bAll or (prdPaket[jC1].Handle = jH) then prdPaket[jC1].Socket := nil;
    end;
  finally
    if not prdPaket.csPaket.bBlockRsrc then prdPaket.csPaket.Leave;
  end;


  PostMessage (Handle, WM_User_Dialog, 102, 0);
end;

procedure TOreolClientDB4.Timer1Timer(Sender: TObject);
//var
  //jC1: Integer; d1: Double;
begin
  inherited;

  procDB.Resume;
  Application.ProcessMessages;
//  PostMessage (Handle, WM_User_Dialog, 102, 0);
end;

procedure myTh.txt;
begin
//  dbCln.Memo1.Lines.Add('sus= ' + IntToStr(j1));
end;

procedure TOreolClientDB4.Action7Execute(Sender: TObject);
begin
  inherited;
// Путь к протоколу
  OpenDialog1.FileName := 'Протокол.txt';
  if OpenDialog1.Execute then
  begin
    dirProtName := extractFilePath(OpenDialog1.FileName);
    Edit2.Text := dirProtName;
    if bProt then
    begin
      try CloseFile(fileProtTxt) except end;
    end;
    Action8Execute(Self);
  end;
end;

procedure TOreolClientDB4.Action8Execute(Sender: TObject);
begin
  inherited;
// Создать протокол
  bProt := False;
  flleProtName := dirProtName + pc003_23_PrtFileName +
                  FormatDateTime('yyyy_mm', Now) +
//                  FormatDateTime('yyyy_mm_dd hh_nn_ss', Now) +
                  '.txt';
  AssignFile(fileProtTxt, flleProtName);
  try
    Append(fileProtTxt);
    bProt := True;
  except
  end;

  if not bProt then
  begin
    try
      Rewrite(fileProtTxt);
      bProt := True;
    except
      on E: Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
  end;
end;

procedure TOreolClientDB4.RadioButton5Click(Sender: TObject);
begin
  inherited;
  LockUnlockNamePass(not RadioButton5.Checked);
end;

procedure TOreolClientDB4.RadioButton6Click(Sender: TObject);
begin
  inherited;
  LockUnlockNamePass(RadioButton6.Checked);
end;

procedure TOreolClientDB4.LockUnlockNamePass(bMode: Boolean);
begin
  Edit3.Enabled := bMode;
  Edit5.Enabled := bMode;
  if bMode then
  begin
    Edit3.Color :=clWindow;
    Edit5.Color :=clWindow;
  end
  else
  begin
    Edit3.Color :=clActiveBorder;
    Edit5.Color :=clActiveBorder;
  end;
end;

procedure TOreolClientDB4.RadioButton3Click(Sender: TObject);
begin
  inherited;
  LockUnlockDBpath(RadioButton3.Checked);
end;

procedure TOreolClientDB4.RadioButton4Click(Sender: TObject);
begin
  inherited;
  LockUnlockDBpath(not RadioButton4.Checked);
end;

procedure TOreolClientDB4.LockUnlockDBpath(bMode: Boolean);
begin
  Edit6.Enabled := bMode;
  if bMode then
  begin
    Edit6.Color :=clWindow;
  end
  else
  begin
    Edit6.Color :=clActiveBorder;
  end;
end;

procedure TOreolClientDB4.Action9Execute(Sender: TObject);
var
  cErr: TOP_ErrorMsg;
  bRes: Boolean;
begin
// Проверить соединение
  if oreolDB.isConnected then
  begin
    ShowMessage(pc003_23_34);
    Exit;
  end;

  SetCursorONForm(self, crHourGlass);
  Application.ProcessMessages;
  try
    if RadioButton5.Checked then
    begin
      bRes := oreolDB.ConnectDB('', '', Trim(Edit4.Text), '', cErr, 0)
    end
    else
    begin
      bRes := oreolDB.ConnectDB(Trim(Edit3.Text), Trim(Edit5.Text), Trim(Edit4.Text), '', cErr, 0)
    end;
    oreolDB.disConnectDB(0);
  finally
    SetCursorONForm(self, crDefault);
    Application.ProcessMessages;
  end;

  if bRes then
  begin
    ShowMessage(pc003_23_31);
  end
  else
  begin
    ShowMessage(pc003_23_32 + cErr.txtMsg);
  end;
end;

procedure TOreolClientDB4.Action10Execute(Sender: TObject);
var
  cErr: TOP_ErrorMsg;
  bRes: Boolean;
begin
  inherited;
// Создать пользователя
  if oreolDB.isConnected then
  begin
    ShowMessage(pc003_23_34);
    Exit;
  end;

  SetCursorONForm(self, crHourGlass);
  Application.ProcessMessages;
  try
    if RadioButton5.Checked then
    begin
      bRes := oreolDB.ConnectDB('', '', Trim(Edit4.Text), '', cErr, 0)
    end
    else
    begin
      bRes := oreolDB.ConnectDB(Trim(Edit3.Text), Trim(Edit5.Text), Trim(Edit4.Text), '', cErr, 0)
    end;

    if bRes then
    begin
      oreolDB.getCreateUserStr('master', Trim(Edit8.Text), Trim(Edit9.Text), ADOQuery1.SQL );
      bRes := execSQL( ADOQuery1 );
    end;

    oreolDB.disConnectDB(0);
  finally
    SetCursorONForm(self, crDefault);
    Application.ProcessMessages;
  end;

  if bRes then
  begin
    ShowMessage(pc003_23_36);
  end
  else
  begin
    if cErr <> nil then
      ShowMessage(pc003_23_37 + cErr.txtMsg);
  end;
end;

end.
