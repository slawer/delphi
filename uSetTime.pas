unit uSetTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, Buttons, ScktComp,
  Dialogs, upf2, uAbstrArray, uMainData, uMainConst,
  uSetTimeConst,
  uOreolNWTune1, uOreolBtnTune2, uOreolButton2data, uOreolSetTime2BegTune,
  uOreolProtocol, uDNSprotocol, ActnList, Menus, IniFiles,
  uAbstrButtonPanel, uMsgDial, uInputPassword, jpeg;

type
  TcSetTime = class(Tpf2)
    Panel1: TPanel;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Action7: TAction;
    N9: TMenuItem;
    N10: TMenuItem;
    Action8: TAction;
    Timer2: TTimer;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    Panel3: TPanel;
    Label1: TLabel;
    Image1: TImage;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    ClientSocket1: TClientSocket;
    pNW: TOreolNWTune1;
    pBT: TOreolSetTime2BegTune;
    bAuto, bNotQ: Boolean;
    bModify: Boolean;
    bFirst: Boolean;
    sConfFile: string;
    ParamCurent: prqTODButton2Par1;
    jMode: Integer;
    jNumber: Integer;
    Panel: prqTobject; // Коллекция панелей

    procedure PanelResize(bCr: Boolean);
    procedure signButton;
    procedure iniParam(iniFile: TMemIniFile; Number: Integer);
    procedure setParam(iniFile: TMemIniFile; Number: Integer);
    procedure SendStr(s1: String);
  public
    { Public declarations }
    procedure unknowDialogMessage(var Msg: TMessage; kode: Integer); override;
  end;

var
  cSetTime: TcSetTime;

implementation
uses uSupport;

{$R *.dfm}

procedure TcSetTime.FormCreate(Sender: TObject);
begin
  ClientSocket1 := TClientSocket.Create(self);
  ClientSocket1.OnConnect := ClientSocket1Connect;
  ClientSocket1.OnError :=ClientSocket1Error;
  ClientSocket1.OnRead := ClientSocket1Read;

  DecimalSeparator := '.';
  bFirst := True;
  jMode  := 0;

  Application.Title := pc006_03_ProjectName;
  Caption := pc006_03_Caption;

  Panel := prqTobject.Create;
  ParamCurent := prqTODButton2Par1.Create;
  ParamCurent.Count := 16;
  ParamCurent.initSelf;

  taskParam := TtaskParam.Create;
  taskParam.ProjectName := pc006_03_ProjectName;
  taskParam.MainGUID    := pc006_03_MainGUID;
  taskParam.mainPath    := pc006_03_SoftPath;
  taskParam.regTask;

  inherited;

// Зарегистрировать форму Create and register object
  jUniType := tobjMain;
  jUniKeyBoss := 0;
  registryObj(taskParam, jUniKeySelf, jUniKeyBoss, jUniType, self);
  taskParam.mainKey := jUniKeySelf;

// Восстановить параметры Restore parameters
  bTag  := False;
  bGeom := True;
  getParam;


// Создать диалог Начальная Настройка
  pBT := TOreolSetTime2BegTune.Create(self);
  pBT.bMustSave := True;
  pBT.bNoUnReg := True;
  pBT.taskParam := taskParam;
//  registryObj(taskParam, pBT.jUniKeySelf, jUniKeySelf, pBT.jUniType, pBT);
  pBT.bTag  := True;
  pBT.bGeom := True;
  pBT.OpenDialog1 := OpenDialog1;
  pBT.getParam;

// Создать диалог Настройка Сети
  pNW := TOreolNWTune1.Create(self);
  pNW.bMustSave := True;
  pNW.bNoUnReg := True;
  pNW.taskParam := taskParam;
//  registryObj(taskParam, pNW.jUniKeySelf, jUniKeySelf, pNW.jUniType, pNW);
  pNW.bTag  := False;
  pNW.bGeom := True;
  pNW.getParam;

  pBT.getParamNW(bAuto, bNotQ, sConfFile);
  Action5Execute(self); // Настроить конфигурацию

  if bAuto then Action4Execute(self);

//  Panel1Resize(Self);

  Timer1.Enabled := True;
  Application.ProcessMessages;
end;

procedure TcSetTime.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  try
    Action6Execute(self);
    ClientSocket1.Free;
    if isCanCloseChilObj(taskParam, jUniKeySelf, True) then
      UnregChildTreeObj(taskParam, jUniKeySelf, jUniKeySelf);
  except end;

  inherited;

  taskParam.Free;
  pNW.Free;
  pBT.Free;
  ParamCurent.Free;
  Panel.Free;
end;

procedure TcSetTime.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
//var
  //s1: String;
begin
  inherited;
//  s1 := pc004_01_Connect1 + pc004_01_Fin;
  //SendStr(s1);
end;

procedure TcSetTime.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  try
    self.ClientSocket1.Active := false;
  except
  end;
{
  inherited;
eeGeneral	The socket received an error message that does not fit into any of the following categories.
eeSend	An error occurred when trying to write to the socket connection.
eeReceive	An error occurred when trying to read from the socket connection.
eeConnect	A connection request that was already accepted could not be completed.
eeDisconnect	An error occurred when trying to close a connection.
eeAccept	A problem occurred when trying to accept a client connection request.

  case ErrorEvent of
eeGeneral:
begin
  Memo1.Lines.Add('The socket received an uncknown error message');
end;
eeSend:
begin
  Memo1.Lines.Add('An error occurred when trying to write to the socket connection');
end;
eeReceive:
begin
  Memo1.Lines.Add('An error occurred when trying to read from the socket connection');
end;
eeConnect:
begin
  Memo1.Lines.Add('A connection request that was already accepted could not be completed');
  BitBtn3.Caption := pc003_07_02;
end;
eeDisconnect:
begin
  Memo1.Lines.Add('An error occurred when trying to close a connection');
  BitBtn3.Caption := pc003_07_04;
end;
eeAccept:
begin
  Memo1.Lines.Add('A problem occurred when trying to accept a client connection request');
end;
  end;
}
end;

procedure TcSetTime.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
var
  FpntArr: prqPByteArray;
  sBuf: array[1..30000] of Byte;
  s1: String;
//  jC1, lS: Integer;
begin
  inherited;
// Ввод переданного пакета

  FpntArr := prqPByteArray(@sBuf[1]);
  TOreolProtocol.getBuffSocket(Socket, FpntArr, SizeOf(sBuf));
{
  lS := TOreolProtocol.getBuffSocket(Socket, FpntArr, SizeOf(sBuf));
  SetLength(s1, lS);
  for jC1 := 1 to lS do
  begin
    s1[jC1] := Char(sBuf[jC1]);
  end;
  ShowMessage(s1);
}
  if bFirst then
  begin
    s1 := pc004_01_Connect1 + pc004_01_Fin;
    SendStr(s1);
    bFirst := False;
  end;
end;

procedure TcSetTime.Timer1Timer(Sender: TObject);
begin
  if ClientSocket1.Active then
  begin
    CheckBox1.Font.Color := clGreen;
    Label1.Font.Color  := clGreen;
    Label1.Caption      := pc006_03_01;
  end
  else
  begin
    CheckBox1.Font.Color := clRed;
    Label1.Font.Color  := clRed;
    Label1.Caption      := pc006_03_02;
  end;
end;

procedure TcSetTime.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if bNotQ then Exit;
  if MessageDlg(pc006_03_21, mtWarning, [mbYes, mbNo], 0) <> mrYes then
  begin
    CanClose := False;
  end;
end;

procedure TcSetTime.Action1Execute(Sender: TObject);
begin
  Close;
end;

procedure TcSetTime.Action3Execute(Sender: TObject);
begin
  pNW.bFirst := True;
  pNW.ShowModal;
end;

procedure TcSetTime.Action2Execute(Sender: TObject);
begin
// Начальная настройка
  pBT.bFirst := True;
  pBT.ShowModal;
  if pBT.bSaveParam then
  begin
    if pBT.getParamNW(bAuto, bNotQ, sConfFile) then
    begin // Настроить конфигурацию
      Action5Execute(self);
    end;
  end;
end;

procedure TcSetTime.Action4Execute(Sender: TObject);
var
  sAddr: String;
  jPort: Integer;
begin
  if ClientSocket1.Active then
  begin // Разорвать существующее соединение
    ClientSocket1.Active := False;
  end;

// Проверка Сети
  if not pNW.getParamNW(sAddr, jPort) then
  begin
    ShowMessage(pc006_03_11);
    Exit;
  end;
  ClientSocket1.Host := sAddr;
  ClientSocket1.Port    := jPort;

  ClientSocket1.Active := True;
  bFirst := True;
  jMode  := 1;
  Timer2.Enabled := True;
end;

procedure TcSetTime.Action5Execute(Sender: TObject);
var
  iniFile: TMemIniFile;
begin
// Настройка конфигурации
  if Length(sConfFile) = 0 then
  begin
    ShowMessage(pc006_03_12);
    Exit;
  end;

  iniFile := TMemIniFile.Create(sConfFile);
  try

    iniParam(iniFile, 1);

  finally
    iniFile.Free;
  end;
end;

procedure TcSetTime.Action6Execute(Sender: TObject);
begin
// Остановить опрос
  Timer2.Enabled := False;
  jMode  := 0;
  if ClientSocket1.Active then
  begin
    SendStr(chr(4)+chr(0));
    Sleep(200);
  end;

  ClientSocket1.Active := False;
end;

procedure TcSetTime.iniParam(iniFile: TMemIniFile; Number: Integer);
begin
  ParamCurent.SetStrings(iniFile, Number);
  signButton;
end;

procedure TcSetTime.Action7Execute(Sender: TObject);
var
  iniFile: TMemIniFile;
  pBtnT: TOreolBtnTune2;
begin
// Создать диалог Настройка Сети
  pBtnT := TOreolBtnTune2.Create(self);
  try
    pBtnT.taskParam := nil;
    pBtnT.bNotSaveParam := True;
    pBtnT.bMustSave := True;

    pBtnT.Param := ParamCurent;

      pBtnT.ShowModal;

    bModify := pBtnT.bExit;
  finally
    pBtnT.Free;
  end;


// Настройка конфигурации

  if bModify then
  begin
    signButton;

    if Length(sConfFile) = 0 then
    begin
      pBT.bFirst := True;
      pBT.ShowModal;
      if pBT.bSaveParam then
      begin
        if not pBT.getParamNW(bAuto, bNotQ, sConfFile) then Exit;
      end;
    end;

    iniFile := TMemIniFile.Create(sConfFile);
    try

      setParam(iniFile, 1);

      iniFile.UpdateFile;
    finally
      iniFile.Free;
    end;

  end;
end;

procedure TcSetTime.setParam(iniFile: TMemIniFile;
  Number: Integer);
begin
  ParamCurent.GetStrings(iniFile, Number);
end;

procedure TcSetTime.Panel1Resize(Sender: TObject);
begin
  inherited;
  PanelResize(False);
end;

procedure TcSetTime.Action8Execute(Sender: TObject);
var
  s2, s1, st, sd: String;
  jC1: Integer;
  t1: TDateTime;
begin
  inherited;
  if not ClientSocket1.Active then
  begin
    ShowMessage(pc006_03_13);
    Exit;
  end;

  for jC1 := 1 to ParamCurent.Count do
  begin
    if not CheckBox1.Checked  AND  (ParamCurent[jC1].iD <> jNumber) then continue;
    if ParamCurent[jC1].BKSDNumb = 0 then continue;

    t1 := Now;
    st := FormatDateTime('ssnnhh', t1);
    sd := FormatDateTime('ddmmyy', t1);
    if self.pBT.RadioButton1.Checked then
    begin
      s1 := Format(pc004_01_CmdSetDateTimeOld1, [st, sd]);
    end
    else
    begin
      s1 := Format(pc004_01_CmdSetDateTime, [st, sd]);
    end;

    s1 := pc004_01_ZGLJob1 + IntToHex(ParamCurent[jC1].BKSDNumb, 2) + s1 + pc004_01_Fin;
    s2 := pc004_01_ZGLJob1 + IntToHex(ParamCurent[jC1].BKSDNumb, 2) + pc004_01_CmdRestart + pc004_01_Fin;
    if bNotQ then
    begin
      SendStr(s1);
      Sleep(200);
      SendStr(s2);
    end
    else
    begin
      if MessageDlg(pc006_03_22, mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        SendStr(s1);
        Sleep(200);
        SendStr(s2);
      end;
    end;

  end;
end;

procedure TcSetTime.SendStr(s1: String);
var
  bArr: prqPByteArray;
begin
  bArr := prqPByteArray(@s1[1]);
  TOreolProtocol.fSendBuf(ClientSocket1.Socket, bArr, Length(s1));
end;

procedure TcSetTime.Timer2Timer(Sender: TObject);
begin
  inherited;
  if jMode = 1 then
  begin
    if not ClientSocket1.Active then
    begin
      Timer2.Enabled := False;
      Action4Execute(self);
    end;
  end;
end;

procedure TcSetTime.signButton;
var
  jC1: Integer;
  rcd: rcdTcontainer;
  pP: TPanel; pA: prqTButtonPanel; pB: TBitBtn;
begin
  Panel.Count := 0;
  for jC1 := 1 to ParamCurent.Count do
  begin
    if ParamCurent[jC1].BKSDNumb > 0 then
    begin
      rcd.key := ParamCurent[jC1].iD;
      rcd.ukz := prqTButtonPanel.Create(Handle, rcd.key);
      pA := rcd.ukz as prqTButtonPanel;
      pP := pA.Panel;

      pP.BevelInner := bvNone;
      pP.BevelOuter := bvRaised;
      pP.BevelWidth := Panel2.BevelWidth;
      pB := pA.BitBtn;
      pB.Font.Color := clMaroon;
      pB.Font.Size  := 12;
      pB.Font.Style := [fsBold];
      pB.Caption    := ParamCurent[jC1].BKSDName;
      Panel.Append(@rcd);
    end;
  end;
  Panel.Sort(1);
{
  for jC1 := 1 to Panel.Count do
  begin
    pP := (Panel[jC1].ukz as prqTButtonPanel).Panel;
    pP.Parent := Panel3;
    (Panel[jC1].ukz as prqTButtonPanel).BitBtn.Parent := pP;
  end;
}
  PanelResize(True);
end;

procedure TcSetTime.PanelResize(bCr: Boolean);
var
  j0, jL, jC1, j1: Integer;
  pA: prqTButtonPanel; pP: TPanel;
begin
  inherited;
  jL := Panel.Count; if jL = 0 then Exit;
  j1 := Panel3.ClientHeight div jL;

  j0 := 0;
  for jC1 := 1 to jL do
  begin
    if jC1 = jL then
    begin
      j1 := Panel3.ClientHeight - j0;
    end;
    pA := Panel[jC1].ukz as prqTButtonPanel;

    if bCr then
    begin
      pP := (Panel[jC1].ukz as prqTButtonPanel).Panel;
      pP.Parent := Panel3;
      (Panel[jC1].ukz as prqTButtonPanel).BitBtn.Parent := pP;
    end;

    pA.setSizePanel(j0,0, Panel3.ClientWidth, j1, alNone);
    pA.allocButton(pc006_03_Top0, pc006_03_Lft0, pc006_03_Top0, pc006_03_Lft0);
    Inc(j0, j1);
  end;
end;

procedure TcSetTime.unknowDialogMessage(var Msg: TMessage;
  kode: Integer);
begin
  if kode = WM_User_Dialog then
  begin
    case Msg.WParamLo of
      101:
      begin
        jNumber := Msg.LParam;
        Action8Execute(self);
//        ShowMessage( IntToStr(Msg.LParam) );
      end;
      else inherited;
    end;
    Exit;
  end;
  inherited;
  Application.ProcessMessages;
end;

procedure TcSetTime.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  pSW: TcInputPassword;
begin
  inherited;
  if Shift = [ssCtrl] then
  begin
    if Key = 71 then // Ctrl G
    begin
      pSW := TcInputPassword.Create(self);
      try
        pSW.ShowModal;
        if pSW.Edit1.Text = pc006_03_PathWord0 then
        begin
          self.N4.Enabled := true;
          self.N5.Enabled := true;
          self.N9.Enabled := true;
        end
        else
        begin
          if Length(Trim(pSW.Edit1.Text)) > 0 then
          begin
            ShowMessage(pc006_03_15);
          end;
          self.N4.Enabled := false;
          self.N5.Enabled := false;
          self.N9.Enabled := false;
        end;
      finally
        pSW.Free;
      end;
    end;
  end;
end;

procedure TcSetTime.BitBtn1Click(Sender: TObject);
begin
  inherited;
  self.Close;
end;

end.
