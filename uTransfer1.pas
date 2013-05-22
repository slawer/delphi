unit uTransfer1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, ExtCtrls, uTransfer1const, StdCtrls,
  xmldom, XMLIntf, msxmldom, XMLDoc, DB, ADODB, CheckLst, Grids, ComCtrls,
  Buttons, Math, Spin, uOreolProtocol6, uOreolDBDirect2,
  uMainData, uMainConst, uAbstrArray, uMsgDial,
  ScktComp, uDEPdescript2;

type
  TacTransfDBproc1 = class(prqTHread)
  private
    HandleBoss: THandle;

    sDBname, sServer, sFLBD, sNMadmin, sPSadmin: string;

    jCountLine, jCountTOut: integer;
    sErr: string;

    procedure putToProtocol(s1: string; LParam: integer);
    procedure showErr;
    procedure putToDopList(s1: string; LParam: integer);

    function  CreateDB: integer;
// CreateDB = 0 == ���������
// CreateDB = 1 == �� ���������� ���������
// CreateDB = 2 == ��������, ������ � sErr

    function  CreateParamTable: integer;
// CreateParamTable = 0 == ���������
// CreateParamTable = 1 == �� ���������� ���������
// CreateParamTable = 2 == ��������, ������ � sErr

    function  TransferToDB: integer;
// TransferToDB = 0 == ���������
// TransferToDB = 1 == �� ���������� ���������
// TransferToDB = 2 == ��������, ������ � sErr

    function  putTOutToDB(dtTime: double; CrossTableTab: TCrossTableTab;
var rcd: rcdCMD_Measuring; var bTOutFlags: array of boolean): integer;
// putTOutToDB = 0 == ���������
// putTOutToDB = 1 == �� ���������� ���������
// putTOutToDB = 2 == ��������, ������ � sErr

    procedure produceTransfer;
  protected

  public
    procedure doProcess; override;
    constructor Create(susp: Boolean);
    destructor Destroy; override;
  published
  end;

  TacConnectFLproc1 = class(prqTHread)
  private
    HandleBoss: THandle;

    procedure hrErr0;
    procedure hrErr1;
    procedure hrErr2;
    procedure hrErr3;


    procedure Connect1;
  protected

  public
    procedure doProcess; override;
    constructor Create(susp: Boolean);
    destructor Destroy; override;
  published
  end;

  TcTransfer1 = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    Panel7: TPanel;
    Panel5: TPanel;
    Panel8: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit1: TEdit;
    BitBtn5: TBitBtn;
    Panel6: TPanel;
    OpenDialog1: TOpenDialog;
    Panel12: TPanel;
    Panel13: TPanel;
    Edit7: TEdit;
    Edit6: TEdit;
    Edit5: TEdit;
    Edit4: TEdit;
    Edit3: TEdit;
    Edit2: TEdit;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Panel14: TPanel;
    Panel15: TPanel;
    StringGrid3: TStringGrid;
    Edit8: TEdit;
    Edit9: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    StringGrid1: TStringGrid;
    Panel10: TPanel;
    Panel16: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    StringGrid5: TStringGrid;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Shape1: TShape;
    Shape2: TShape;
    TabSheet3: TTabSheet;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckListBox1: TCheckListBox;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    Panel9: TPanel;
    Label9: TLabel;
    Edit10: TEdit;
    BitBtn11: TBitBtn;
    ADOConnection1: TADOConnection;
    CheckBox5: TCheckBox;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure TabSheet4Show(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
  private
    { Private declarations }
    fPath, fChB1, fChB2, fChB4, fEdtMode: boolean;

    BlockWorking:   prqTBlockRsrc;
    procDB:         prqTHread; // ������ �� �������

    oreolDB: TOreolDBDirect2;
    sDBname: string;

    sinchroMessage: string;

    procedure restoryCrossTable;
    procedure saveCrossTable;
    procedure setSizeMyObject;

    procedure destoyHread1;
    procedure CloseProcShow;

    procedure _updFolder;
    procedure _updNetwork;

    procedure showPath;
    procedure setPath;

    function isBlocking: boolean;

    function FindFirstInt: Integer;
    function FindLastCheckInt(top: Integer): Integer;
    procedure setTransfInt;
    procedure synchroShowMessage;
  public
    { Public declarations }
    fFirst: boolean;

    xml: TXMLDocument;
    sDBUserName: String; // ��� ������������
    sDBUserPass: String; // ������ ������������ ������������
    sDataSource: String; // ������ �� ������ �������� ������
    sDataPath: String;   // ���� � ������ � �� ������

    job: prqTACTJob;
    CrossTableTabOLD: TCrossTableTab;

    procedure Init;
    procedure ShowCrossTabParam;
    procedure ShowFileParam;
    procedure ClearFileParam;

    procedure produceFinMsg(var Msg: TMessage); override;
    procedure CloseProcessAvr;
  end;

var
  ImSelf: TcTransfer1;

implementation
uses uSupport;

{$R *.dfm}

procedure TcTransfer1.FormCreate(Sender: TObject);
var
  jC1: integer;
  rcdCT: rcdCrossTableTab;
begin
  inherited;
  self.jUniType   := pc006_110_jMain;
  self.Caption    := pc006_110_Caption;
  self.fEdtMode   := false;
  self.fFirst     := true;

  self.job := prqTACTJob.Create;
  self.CrossTableTabOLD := TCrossTableTab.Create;

  // ����������� ������� ����������
  job.CrossTableTab   := TCrossTableTab.Create;
  for jC1 := 1 to pc006_110_SGTcnhCount do
  begin
    rcdCT.DBNumberChanal := jC1;
    rcdCT.DBNameChanal   := '';
    rcdCT.FlNumberChanal := -1;
    rcdCT.bSaveDB        := false;
    rcdCT.bActive        := false;
    self.job.CrossTableTab.Append(@rcdCT);
  end;

  BlockWorking := prqTBlockRsrc.Create;
  BlockWorking.bBlockRsrc := false;
  procDB := nil;
  fPath := false;

// �������� �������� ��
  self.oreolDB := TOreolDBDirect2.Create;
  self.oreolDB.setDBType(ADOConnection1);

  ImSelf := self;
end;

procedure TcTransfer1.setSizeMyObject;
begin
  setALlGridColWidth3(StringGrid1, [0]);
  setALlGridColWidth3(StringGrid3, [0]);
  setGridColWidth(StringGrid5, 1);
end;

procedure TcTransfer1.FormActivate(Sender: TObject);
begin
  inherited;
  setSizeMyObject;
end;

procedure TcTransfer1.Init;
begin
// ��������� �������
  StringGrid1.Cells[0,0] := pc006_110_sg1_00_00;
  StringGrid1.Cells[1,0] := pc006_110_sg1_01_00;
  StringGrid1.Cells[2,0] := pc006_110_sg1_02_00;
  StringGrid1.Cells[0,1] := pc006_110_sg1_00_01;
  StringGrid1.Cells[0,2] := pc006_110_sg1_00_02;

  StringGrid3.Cells[0,0] := pc006_110_sg3_00_00;
  StringGrid3.Cells[1,0] := pc006_110_sg3_01_00;
  StringGrid3.Cells[2,0] := pc006_110_sg3_02_00;
  StringGrid3.Cells[3,0] := pc006_110_sg3_03_00;
  StringGrid3.Cells[4,0] := pc006_110_sg3_04_00;

  StringGrid5.Cells[0,0] := pc006_110_sg5_00_00;
  StringGrid5.Cells[1,0] := pc006_110_sg5_01_00;
  StringGrid5.Cells[2,0] := pc006_110_sg5_02_00;

  self.job.allParamLoad(self.xml);
  if Length(self.job.sErr) > 0 then
  begin
    ShowMessage(job.sErr);
  end;

  ShowCrossTabParam;
  ShowFileParam;
  showPath;
end;

procedure TcTransfer1.BitBtn1Click(Sender: TObject);
var
  dBeg, tBeg, dEnd, tEnd: TDateTime;
  jC1, jR, jC: Integer;
begin
  inherited;
  if self.fEdtMode then
  begin
    ShowMessage(pc006_110_025);
    Exit;
  end;

  self.sDBname := Trim(Edit10.Text);
  if Length(self.sDBname) = 0 then
  begin
    ShowMessage(pc006_110_036);
    Exit;
  end;


  if self.BlockWorking.bBlockRsrc then
  begin
    ShowMessage(pc006_110_023);
    Exit;
  end;

// �������� ��������� �������
  if self.job.fileDescript.j_ParmCnt <= 0 then
  begin
    ShowMessage(pc006_110_012);
    Exit;
  end;

  if self.job.CrossTableTab.getActiveParam = 0 then
  begin
    ShowMessage(pc006_110_013);
    Exit;
  end;

  for jC1 := 1 to self.job.CrossTableTab.Count do
  begin
    if self.job.CrossTableTab[jC1].FlNumberChanal >= self.job.fileDescript.j_ParmCnt then
    begin
      ShowMessage(format(pc006_110_019,
                          [self.job.CrossTableTab[jC1].DBNumberChanal,
                           self.job.fileDescript.j_ParmCnt-1]));
      Exit;
    end;
  end;


  self.job.bDopProtokol := self.CheckBox3.Checked;

// ������ � ��������� �������
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
      ShowMessage(format(pc006_110_frm02, [jR, jC]));
      Exit;
    end;
  end;
  dBeg := dBeg + tBeg; dEnd := dEnd + tEnd;
  if dBeg >= dEnd then
  begin
    ShowMessage(pc006_110_001);
    Exit;
  end;

// ����� ����� �������, ��������������� �������
  if not self.job.fileDescript.MetTdesript.FindInterval(dBeg, dEnd) then
  begin
    ShowMessage(self.job.fileDescript.MetTdesript.Err);
    Exit;
  end;

  self.job.dtBeg := dBeg;
  self.job.dtEnd := dEnd;

// �������� ��������, ������ �� ����������
  procDB := TacTransfDBproc1.Create(true); // ������� ������� �������
  procDB.jTimeOut := pc006_110_Hread_01tim;
  procDB.Priority := tpNormal;                     // tpNormal; //tpHigher; // tpLower;
  procDB.jUniType := pc006_110_Hread_01typ;
  procDB.jUniKeyBoss := jUniKeySelf;
//    registryObj(taskParam, procDB.jUniKeySelf, procDB.jUniKeyBoss, procDB.jUniType, procDB);
  procDB.Caption  := pc006_110_Hread_02cpt;
  procDB.FreeOnTerminate := true;
  procDB.taskParam := taskParam;
  procDB.bNoUnReg := True;
  ShowProcess(taskParam, jUniKeySelf, True, pc006_110_034, nil, aviFindFolder); // �������� ��������
  procDB.Resume;
end;

procedure TcTransfer1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if self.BlockWorking.bBlockRsrc then
  begin
    if MessageDlg( pc006_110_024, mtConfirmation, [mbYes,mbNo], 0 ) <> mrYes then
    begin
      Action := caNone;
      Exit;
    end;
    self.destoyHread1;
  end;

  if self.fEdtMode then
  begin
    if MessageDlg(pc006_110_010, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    begin
      Action := caNone;
      Exit;
    end;
    self.restoryCrossTable;
  end;

  if self.fPath then
  begin
//    self.setPath;
    self.job.allParamSave;
    self.fPath := false;
  end;

//  SavePFParComp(taskParam.getNamRegDivision(self, jUniType), StringGrid1);
  self.CrossTableTabOLD.Free;
  self.BlockWorking.Free;
  self.job.Free;

  if Assigned(self.oreolDB) then
  begin
    self.oreolDB.disConnectDB(0);
    self.oreolDB.Free;
  end;

  inherited;
end;

procedure TcTransfer1.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TcTransfer1.RadioButton2Click(Sender: TObject);
begin
  inherited;
  if self.fFirst then
  begin
    Exit;
  end;
  showPath;
end;

procedure TcTransfer1.RadioButton1Click(Sender: TObject);
begin
  inherited;
  if self.fFirst then
  begin
    Exit;
  end;
  showPath;
end;

procedure TcTransfer1.showPath;
begin
  if self.RadioButton1.Checked then
  begin
    self.Edit1.Text := self.job.fileDescript.pathNET;
  end
  else
  begin
    self.Edit1.Text := self.job.fileDescript.pathFld;
  end;
end;

procedure TcTransfer1.BitBtn5Click(Sender: TObject);
begin
  inherited;
  if self.RadioButton1.Checked then
  begin
    _updNetwork;
  end
  else
  begin
    _updFolder;
  end;
end;

procedure TcTransfer1._updFolder;
begin
  if self.OpenDialog1.Execute then
  begin
    self.fPath := true;
    self.Edit1.Text := self.OpenDialog1.FileName;
    self.job.fileDescript.pathFld := self.Edit1.Text;
  end;
end;

procedure TcTransfer1._updNetwork;
begin
  if self.OpenDialog1.Execute then
  begin
    self.fPath := true;
    self.Edit1.Text := self.OpenDialog1.FileName;
    self.job.fileDescript.pathNET := self.Edit1.Text;
  end;
end;

procedure TcTransfer1.BitBtn3Click(Sender: TObject);
begin
  inherited;
  if self.fEdtMode then
  begin
    ShowMessage(pc006_110_025);
    Exit;
  end;

  if self.BlockWorking.isBlockRsrc then
  begin
    Exit;
  end;

  self.Edit1.Text := Trim(self.Edit1.Text);
  self.fPath := true;
  self.setPath;
  fChB4 := self.CheckBox4.Checked;

// �������� ��������, ������ �� ����������
  procDB := TacConnectFLproc1.Create(true); // ������� ������� �������
  procDB.jTimeOut := pc006_110_Hread_01tim;
  procDB.Priority := tpNormal;                     // tpNormal; //tpHigher; // tpLower;
  procDB.jUniType := pc006_110_Hread_01typ;
  procDB.jUniKeyBoss := jUniKeySelf;
//    registryObj(taskParam, procDB.jUniKeySelf, procDB.jUniKeyBoss, procDB.jUniType, procDB);
  procDB.Caption  := pc006_110_Hread_01cpt;
  procDB.FreeOnTerminate := true;
  procDB.taskParam := taskParam;
  procDB.bNoUnReg := True;
  ShowProcess(taskParam, jUniKeySelf, True, pc006_110_026, nil, aviFindFolder); // �������� ��������
  procDB.Resume;
end;

procedure TcTransfer1.setPath;
begin
  self.job.fileDescript.path := Trim(self.Edit1.Text);
  if self.RadioButton1.Checked then
  begin
    self.job.fileDescript.pathNET := self.job.fileDescript.path;
  end
  else
  begin
    self.job.fileDescript.pathFld := self.job.fileDescript.path;
  end;
end;

procedure TcTransfer1.Panel2Resize(Sender: TObject);
begin
  inherited;
  setSizeMyObject;
end;

procedure TcTransfer1.ClearFileParam;
begin
  prqClearGridUserR(StringGrid3);
  self.CheckListBox1.Clear;
  self.Edit2.Text := '';
  self.Edit3.Text := '';
  self.Edit4.Text := '';
  self.Edit5.Text := '';
  self.Edit6.Text := '';
  self.Edit7.Text := '';
  self.Edit8.Text := '';
  self.Edit9.Text := '';
end;

procedure TcTransfer1.ShowFileParam;
var
  jC1: integer;
  s1:  string;
begin
  if self.job.fileDescript.j_ParmCnt <= 0 then
  begin
    ClearFileParam;
    Exit;
  end;

  self.Edit2.Text := IntToStr(self.job.fileDescript.j_SizeBuf);
  self.Edit3.Text := IntToStr(self.job.fileDescript.j_MetTCnt);
  try
    self.Edit4.Text := IntToStr(self.job.fileDescript.j_DataSze div self.job.fileDescript.j_SizeBuf);
  except
  end;
  self.Edit5.Text := IntToStr(self.job.fileDescript.j_MetTSft);
  self.Edit6.Text := IntToStr(self.job.fileDescript.j_DataSft);
  self.Edit7.Text := IntToStr(self.job.fileDescript.j_ParmCnt);
  self.Edit8.Text := IntToStr(self.job.fileDescript.j_MetTPrd);
  self.Edit9.Text := IntToStr(self.job.fileDescript.j_DataPrd);

  self.CheckListBox1.Clear;
  if self.job.fileDescript.DatInterval.Count = 0 then
  begin
    self.StringGrid3.RowCount := 2;
    prqClearGridUserR(StringGrid3);
    Exit;
  end;

  self.StringGrid3.RowCount := self.job.fileDescript.DatInterval.Count + 1;
  for jC1 := 1 to self.job.fileDescript.DatInterval.Count do
  begin
    self.StringGrid3.Cells[0, jC1] :=  IntToStr(jC1);
    self.StringGrid3.Cells[1, jC1] := DateToStr(self.job.fileDescript.DatInterval[jC1].rcdFrom.DateTime);
    self.StringGrid3.Cells[2, jC1] := TimeToStr(self.job.fileDescript.DatInterval[jC1].rcdFrom.DateTime);
    self.StringGrid3.Cells[3, jC1] := DateToStr(self.job.fileDescript.DatInterval[jC1].rcdTo.DateTime);
    self.StringGrid3.Cells[4, jC1] := TimeToStr(self.job.fileDescript.DatInterval[jC1].rcdTo.DateTime);

    s1 := format( pc006_110_CBL_01_00, [
                                          self.StringGrid3.Cells[1, jC1],
                                          self.StringGrid3.Cells[2, jC1],
                                          self.StringGrid3.Cells[3, jC1],
                                          self.StringGrid3.Cells[4, jC1]
                                       ]);
    self.CheckListBox1.Items.Add(s1);
  end;
end;

procedure TcTransfer1.ShowCrossTabParam;
var
  jLine, j1, jC1: integer;
  bHideNotActive, bHideNotSaved: boolean;
begin
  bHideNotActive := self.CheckBox1.Checked;
  bHideNotSaved  := self.CheckBox2.Checked;
  jLine          := self.job.CrossTableTab.lineCount(bHideNotActive, bHideNotSaved);
  if jLine = 0 then
  begin
    StringGrid5.RowCount := 2;
    uSupport.prqClearGridUserR(StringGrid5);
    StringGrid5.Cells[0,1] := '';
    StringGrid5.Cells[1,1] := '';
    Exit;
  end
  else
  begin
    StringGrid5.RowCount := jLine + 1;
  end;

  j1 := 0;
  for jC1 := 1 to self.job.CrossTableTab.Count do
  begin
    if bHideNotActive then
    begin
      if self.job.CrossTableTab[jC1].FlNumberChanal < 0 then continue;
    end;
    if bHideNotSaved then
    begin
      if not self.job.CrossTableTab[jC1].bSaveDB then continue;
    end;

    Inc(j1);
    StringGrid5.Cells[0,j1] := IntToStr(self.job.CrossTableTab[jC1].DBNumberChanal);
    StringGrid5.Cells[1,j1] := self.job.CrossTableTab[jC1].DBNameChanal;
    if self.job.CrossTableTab[jC1].FlNumberChanal < 0 then
    begin
      StringGrid5.Cells[2,j1] := pc006_110_008;
    end
    else
    begin
      StringGrid5.Cells[2,j1] := IntToStr(self.job.CrossTableTab[jC1].FlNumberChanal);
    end;
  end;
end;


procedure TcTransfer1.TabSheet1Show(Sender: TObject);
begin
  inherited;
  setALlGridColWidth3(StringGrid1, [0]);
end;

procedure TcTransfer1.TabSheet4Show(Sender: TObject);
begin
  inherited;
  setALlGridColWidth3(StringGrid3, [0]);
end;

procedure TcTransfer1.TabSheet2Show(Sender: TObject);
begin
  inherited;
  setGridColWidth(StringGrid5, 1);
end;

procedure TcTransfer1.CheckBox1Click(Sender: TObject);
begin
  inherited;
  if self.fFirst then
  begin
    Exit;
  end;
  ShowCrossTabParam;
end;

procedure TcTransfer1.CheckBox2Click(Sender: TObject);
begin
  inherited;
  if self.fFirst then
  begin
    Exit;
  end;
  ShowCrossTabParam;
end;

procedure TcTransfer1.BitBtn4Click(Sender: TObject);
begin
  inherited;
  if self.fEdtMode then
  begin
    Exit;
  end;

  if self.BlockWorking.bBlockRsrc then
  begin
    ShowMessage(pc006_110_023);
    Exit;
  end;

  self.fEdtMode := true;
  self.StringGrid5.Options := self.StringGrid5.Options + [goEditing,goAlwaysShowEditor];
  fChB1 := self.CheckBox1.Checked;
  fChB2 := self.CheckBox2.Checked;
  self.CheckBox1.Checked := false;
  self.CheckBox2.Checked := false;
  self.StringGrid5.SetFocus;

  self.saveCrossTable;
end;

procedure TcTransfer1.BitBtn7Click(Sender: TObject);
begin
  inherited;
  if not self.fEdtMode then
  begin
    exit;
  end;

  restoryCrossTable;

  self.StringGrid5.Options := self.StringGrid5.Options - [goEditing,goAlwaysShowEditor];
  self.fEdtMode := false;
  self.CheckBox1.Checked := fChB1;
  self.CheckBox2.Checked := fChB2;
  self.StringGrid5.SetFocus;
  self.BitBtn7.SetFocus;
  ShowCrossTabParam;
end;

procedure TcTransfer1.BitBtn6Click(Sender: TObject);
var
  s1: string;
  j1, jC1, jChanal: integer;
  rcdCT: rcdCrossTableTab;
begin
  inherited;
  if not self.fEdtMode then
  begin
    exit;
  end;

// �������� �����
  for jC1 := 1 to self.StringGrid5.RowCount - 1 do
  begin
    s1 := Trim(self.StringGrid5.Cells[2,jC1]);
    if Length(s1) = 0 then
    begin
      jChanal := -1;
    end
    else
    begin
      if not uSupport.prqStrToInt(s1, jChanal) then
      begin
        ShowMessage(format(pc006_110_006, [self.StringGrid5.Cells[0,jC1]]));
        Exit;
      end
      else
      begin
        if (jChanal < 0) or (jChanal >= pc006_110_CNTcnhCount) then
        begin
          ShowMessage(format(pc006_110_007, [self.StringGrid5.Cells[0,jC1], pc006_110_CNTcnhCount-1]));
          Exit;
        end;
      end;
    end;

    if not uSupport.prqStrToInt(self.StringGrid5.Cells[0,jC1], rcdCT.DBNumberChanal) then
    begin
      ShowMessage(pc006_110_Err1);
      continue;
    end;
    j1 := self.job.CrossTableTab.Find(@rcdCT, 1);
    if j1 = 0 then
    begin
      ShowMessage(pc006_110_Err2);
      continue;
    end;
    self.job.CrossTableTab[j1].FlNumberChanal := jChanal;
  end;

  self.job.allParamSave;
  fPath := false;

  
  self.StringGrid5.Options := self.StringGrid5.Options - [goEditing,goAlwaysShowEditor];
  self.fEdtMode := false;
  self.CheckBox1.Checked := fChB1;
  self.CheckBox2.Checked := fChB2;
  self.StringGrid5.SetFocus;
  self.BitBtn6.SetFocus;
  ShowCrossTabParam;
end;

procedure TcTransfer1.BitBtn8Click(Sender: TObject);
var
  s1: string;
  jC1, jCrossTab, fEdtRow:  integer;
  rcdCT: rcdCrossTableTab;
  sSaved: array of string;
begin
  inherited;
  if not self.fEdtMode then
  begin
    exit;
  end;

// ����� ������
  fEdtRow := self.StringGrid5.Selection.Top;
  if (fEdtRow < 1)  OR  (fEdtRow >= self.StringGrid5.RowCount) then
  begin
    ShowMessage(pc006_110_009);
    Exit;
  end;

// ��������: ��������� �� �������!!!
  if self.StringGrid5.RowCount < 3 then
  begin
    ShowMessage(pc006_110_021);
    Exit;
  end;

// ����� ������� � CrossTableTab
  s1 := self.StringGrid5.Cells[0, fEdtRow];
  uSupport.prqStrToInt(s1, rcdCT.DBNumberChanal);
  jCrossTab := self.job.CrossTableTab.Find(@rcdCT, 1);
  if jCrossTab = 0 then
  begin
    ShowMessage(pc006_110_Err3);
    Exit;
  end;

// �������� �������� ������
  if
     self.job.CrossTableTab[jCrossTab].bSaveDB  OR
     (self.job.CrossTableTab[jCrossTab].FlNumberChanal >= 0)
  then
  begin
    if self.job.CrossTableTab[jCrossTab].bSaveDB then
    begin
      s1 := format(pc006_110_014, [self.job.CrossTableTab[jCrossTab].DBNumberChanal,
                                   self.job.CrossTableTab[jCrossTab].DBNameChanal]);
      if MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      begin
        Exit;
      end;
    end;
    if self.job.CrossTableTab[jCrossTab].FlNumberChanal >= 0 then
    begin
      s1 := format(pc006_110_015, [self.job.CrossTableTab[jCrossTab].DBNumberChanal,
                                   self.job.CrossTableTab[jCrossTab].DBNameChanal]);
      if MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      begin
        Exit;
      end;
    end;
  end
  else
  begin
    if self.job.CrossTableTab[jCrossTab].FlNumberChanal >= 0 then
    begin
      s1 := format(pc006_110_016, [self.job.CrossTableTab[jCrossTab].DBNumberChanal,
                                   self.job.CrossTableTab[jCrossTab].DBNameChanal]);
      if MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      begin
        Exit;
      end;
    end;
  end;

// ���������� ����� �������� ����������
  SetLength(sSaved, self.StringGrid5.RowCount - 1);
  try
    for jC1 := 1 to self.StringGrid5.RowCount - 1 do
    begin
      sSaved[jC1-1] := self.StringGrid5.Cells[2, jC1];
    end;

    self.job.CrossTableTab.Delete(jCrossTab);

    ShowCrossTabParam;

    for jC1 := 1 to self.StringGrid5.RowCount - 1 do
    begin
      if jC1 < fEdtRow then
      begin
        self.StringGrid5.Cells[2, jC1] := sSaved[jC1-1]
      end
      else
      begin
        self.StringGrid5.Cells[2, jC1] := sSaved[jC1]
      end;
    end;
  finally
    SetLength(sSaved, 0);
  end;

  self.StringGrid5.SetFocus;
end;

procedure TcTransfer1.restoryCrossTable;
var
  jC1: Integer;
begin
  self.job.CrossTableTab.Count := 0;
  for jC1 := 1 to self.CrossTableTabOLD.Count do
  begin
    self.job.CrossTableTab.Append(self.CrossTableTabOLD[jC1]);
  end;
end;

procedure TcTransfer1.saveCrossTable;
var
  jC1: Integer;
begin
  self.CrossTableTabOLD.Count := 0;
  for jC1 := 1 to self.job.CrossTableTab.Count do
  begin
    self.CrossTableTabOLD.Append(self.job.CrossTableTab[jC1]);
  end;
end;

procedure TcTransfer1.CheckListBox1ClickCheck(Sender: TObject);
var
  jC1, jFirst, jLast, jCurr: integer;
begin
  inherited;
  if self.fFirst then
  begin
    Exit;
  end;
  if self.job.fileDescript.DatInterval.Count = 0 then Exit;

  jCurr := self.CheckListBox1.ItemIndex + 1;
  if jCurr <= 0 then Exit;

// ����� ������� ����������� ��������
  jFirst := self.FindFirstInt;
  if jFirst < 0 then
  begin
    Exit;
  end;


  self.CheckListBox1.Cursor := crHourGlass;
  try
// ����� ���������� ����������� ��������
    jLast := FindLastCheckInt(jFirst);

  // ������ >= �������
    if jFirst >= jCurr then
    begin
  // �������� ��� � ���������
      for jC1 := jCurr + 1 to jLast do
      begin
        if not self.CheckListBox1.Checked[jC1 - 1] then self.CheckListBox1.Checked[jC1 - 1] := true;
      end;
      Exit;
    end;

  // ��������� <= �������
    if jLast <= jCurr then
    begin
  // �������� ��� � ���������
      for jC1 := jFirst + 1 to jCurr - 1 do
      begin
        if not self.CheckListBox1.Checked[jC1 - 1] then self.CheckListBox1.Checked[jC1 - 1] := true;
      end;
      Exit;
    end;

  // ����� ������� ������������� ��������
    jLast := self.job.fileDescript.DatInterval.Count;
    for jC1 := jFirst + 1 to self.job.fileDescript.DatInterval.Count do
    begin
      if not self.CheckListBox1.Checked[jC1 - 1] then
      begin
        jLast := jC1;
        break;
      end;
    end;

  // �������� ����������� �����
    for jC1 := jLast + 1 to self.job.fileDescript.DatInterval.Count do
    begin
      if self.CheckListBox1.Checked[jC1 - 1] then self.CheckListBox1.Checked[jC1 - 1] := false;
    end;

  finally
    self.CheckListBox1.Cursor := crDefault;
    self.setTransfInt;
  end;
end;

function TcTransfer1.FindFirstInt: Integer;
var
  jC1: integer;
begin
  result := -1;
  for jC1 := 1 to self.job.fileDescript.DatInterval.Count do
  begin
    if self.CheckListBox1.Checked[jC1 - 1] then
    begin
      result := jC1;
      Exit;
    end;
  end;
end;

function TcTransfer1.FindLastCheckInt(top: Integer): Integer;
var
  jC1: integer;
begin
  result := top;
  for jC1 := top + 1 to self.job.fileDescript.DatInterval.Count do
  begin
    if self.CheckListBox1.Checked[jC1 - 1] then
    begin
      result := jC1;
    end;
  end;
end;

procedure TcTransfer1.setTransfInt;
var
  jFirst, jLast: integer;
begin
  if self.job.fileDescript.DatInterval.Count = 0 then Exit;
  jFirst := self.FindFirstInt;
  if jFirst = 0 then Exit;
  jLast  := self.FindLastCheckInt(jFirst);

  self.StringGrid1.Cells[1, 1] := DateToStr(self.job.fileDescript.DatInterval[jLast].rcdFrom.DateTime);
  self.StringGrid1.Cells[2, 1] := TimeToStr(self.job.fileDescript.DatInterval[jLast].rcdFrom.DateTime);
  self.StringGrid1.Cells[1, 2] := DateToStr(self.job.fileDescript.DatInterval[jFirst].rcdTo.DateTime);
  self.StringGrid1.Cells[2, 2] := TimeToStr(self.job.fileDescript.DatInterval[jFirst].rcdTo.DateTime);
end;

procedure TcTransfer1.destoyHread1;
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

procedure TcTransfer1.CloseProcShow;
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

{ TacConnectFLproc1 }

procedure TacConnectFLproc1.Connect1;
var
  s1, sErr, FileName: string;
  FileStream: TFileStream;
  rcd: rcdMetTdesript;
  rcdDatInt: rcdDatInterval;
  j1, jMaxData, jC1: Integer;
  bDT, bFirst, bFirstMtk: Boolean;
  dtInt: TDateTime;
  MetTDesript: TMetTdesript;
  Msg: TMessage;
begin
// ������������� ��� �����
  FileName := Trim(ImSelf.Edit1.Text);

  j1 := uSupport.findRegistryObjSelf(ImSelf.taskParam, ImSelf.jUniKeyBoss);
  if j1 > 0 then
  begin
    HandleBoss := (ImSelf.taskParam.treeObj[j1].cls as TForm).Handle;
    Msg.WParamLo := pc006_110_Msg1;
    Msg.WParamHi := 0;
  end
  else
  begin
    HandleBoss := 0;
  end;

// ������� ����!
  try

    MetTDesript := TMetTdesript.Create;
    FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    try

      if HandleBoss <> 0 then
      begin
        s1 := formatDateTime(pc006_110_frm4, Now) + ' ' + pc006_110_028;
        uSupport.putString(s1, HandleBoss, pc006_110_jMainProc1);
        Msg.LParam   := pc006_110_jMainProc1;
        SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
      end;

  // ��������� ���������
      FileStream.Seek(0, soFromBeginning);
//1
      FileStream.Read(ImSelf.job.fileDescript.j_SizeBuf, SizeOf(ImSelf.job.fileDescript.j_SizeBuf));
//2
      FileStream.Read(ImSelf.job.fileDescript.j_MetTCnt, SizeOf(ImSelf.job.fileDescript.j_MetTCnt));
//3
      FileStream.Read(ImSelf.job.fileDescript.j_DataSze, SizeOf(ImSelf.job.fileDescript.j_DataSze));
//4
      FileStream.Read(ImSelf.job.fileDescript.j_MetTSft, SizeOf(ImSelf.job.fileDescript.j_MetTSft));
//5
      FileStream.Read(ImSelf.job.fileDescript.j_DataSft, SizeOf(ImSelf.job.fileDescript.j_DataSft));
//6
      FileStream.Read(ImSelf.job.fileDescript.j_ParmCnt, SizeOf(ImSelf.job.fileDescript.j_ParmCnt));
//7
      FileStream.Read(ImSelf.job.fileDescript.j_MetTPrd, SizeOf(ImSelf.job.fileDescript.j_MetTPrd));
//8
      FileStream.Read(ImSelf.job.fileDescript.j_DataPrd, SizeOf(ImSelf.job.fileDescript.j_DataPrd));

      jMaxData := FileStream.Size - ImSelf.job.fileDescript.j_DataSft;
      if ImSelf.job.fileDescript.j_DataSze > jMaxData then
      begin
        ImSelf.job.fileDescript.j_DataSze := jMaxData;
      end;

      if ImSelf.job.fileDescript.j_ParmCnt <= 0 then
      begin
        hrErr1;
        Exit;
      end;

// ������������ ���������
      ImSelf.job.fileDescript.MetTdesript.Count := 0;
      ImSelf.job.fileDescript.DatInterval.Count := 0;
      FileStream.Seek(ImSelf.job.fileDescript.j_MetTSft, soFromBeginning);
      bFirstMtk := true;
      for jC1 := 1 to ImSelf.job.fileDescript.j_MetTCnt do
      begin
        if self.isTerminated then
        begin
          ImSelf.job.fileDescript.MetTdesript.Count := 0;
          ImSelf.job.fileDescript.DatInterval.Count := 0;
          hrErr2;
          Exit;
        end;

        FileStream.Read(rcd, SizeOf(rcd));
        if rcd.DateTime = 0 then continue;
        if rcd.FirstIndex <> rcd.CheckIndex then continue;
        MetTDesript.Append(@rcd);

        if ImSelf.fChB4 then
        begin
          if HandleBoss <> 0 then
          begin
            if bFirstMtk then
            begin
              s1 := pc006_110_020;
              uSupport.putString(s1, HandleBoss, pc006_110_jMainProc1);
              Msg.LParam   := pc006_110_jMainProc1;
              SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
              bFirstMtk := false;
            end;

            s1 := formatDateTime(pc006_110_frm3, rcd.DateTime) + '; ' +
                                 IntToStr(rcd.FirstIndex div 512) + '; ' +
                                 IntToStr(rcd.FirstIndex);
//            uSupport.putString(s1, HandleBoss, pc006_110_jMainProc1 + jC1);
//            Msg.LParam   := pc006_110_jMainProc1 + jC1;
            uSupport.putString(s1, HandleBoss, pc006_110_jMainProc1);
            Msg.LParam   := pc006_110_jMainProc1;
            SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
          end;
        end;
      end;

      if MetTdesript.Count = 0 then
      begin
        hrErr3;
        Exit;
      end;

      MetTdesript.Sort(-1);

// ������� ��������� ������
      for jC1 := 1 to MetTdesript.Count do
      begin
        if ImSelf.job.fileDescript.MetTdesript.Find(MetTdesript[jC1], 2) = 0 then
        begin
          ImSelf.job.fileDescript.MetTdesript.Append(MetTdesript[jC1]);
        end;
      end;

// ��������� ������� �� ���������
      dtInt  := 1;
      dtInt  := (dtInt / 86400000) * ImSelf.job.fileDescript.j_MetTPrd * 1.9;

      bFirst := true;
      rcdDatInt.rcdTo.DateTime   := 0;
      rcdDatInt.rcdFrom.DateTime := 0;
      for jC1 := 1 to ImSelf.job.fileDescript.MetTdesript.Count do
      begin
        if bFirst then
        begin
          rcdDatInt.rcdTo   := ImSelf.job.fileDescript.MetTdesript[jC1]^;
          rcdDatInt.rcdFrom := rcdDatInt.rcdTo;
          bFirst := false;
        end

        else

        begin
          bDt := ((rcdDatInt.rcdFrom.DateTime - ImSelf.job.fileDescript.MetTdesript[jC1].DateTime) < dtInt);
          if bDt then
          begin
            rcdDatInt.rcdFrom := ImSelf.job.fileDescript.MetTdesript[jC1]^;
          end
          else
          begin
            ImSelf.job.fileDescript.DatInterval.Append(@rcdDatInt);
            rcdDatInt.rcdTo   := ImSelf.job.fileDescript.MetTdesript[jC1]^;
            rcdDatInt.rcdFrom := rcdDatInt.rcdTo;
          end;
        end;
      end;

      if not bFirst then
      begin
        ImSelf.job.fileDescript.DatInterval.Append(@rcdDatInt);
      end;

      hrErr0;

    finally
      MetTDesript.Free;
      FileStream.Free;
      ImSelf.BlockWorking.bBlockRsrc := false;
      Synchronize( ImSelf.CloseProcShow );
    end;

  except
    on E: Exception do
    begin
      ImSelf.BlockWorking.bBlockRsrc := false;
      sErr := E.Message;
      if HandleBoss <> 0 then
      begin
        s1 := formatDateTime(pc006_110_frm4, Now) + ' ' + sErr;
        uSupport.putString(s1, HandleBoss, pc006_110_jMainProc1);
        Msg.WParamLo := pc006_110_Msg1;
        Msg.WParamHi := 0;
        Msg.LParam   := pc006_110_jMainProc1;
        SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
      end;
      Synchronize( ImSelf.CloseProcShow );
      Synchronize( ImSelf.ClearFileParam );

      if HandleBoss <> 0 then
      begin
        uSupport.showString(sErr, HandleBoss, Msg.LParam + 1);
      end;
    end;
  end;
end;

constructor TacConnectFLproc1.Create(susp: Boolean);
begin
  inherited Create(susp);
  self.HandleBoss := uSupport.getHandleRegistryObj(ImSelf.taskParam, ImSelf.jUniKeyBoss);
end;

destructor TacConnectFLproc1.Destroy;
begin

  inherited;
end;

procedure TacConnectFLproc1.doProcess;
begin
  FbCalc := True;

    self.Connect1; // Test1;

  FbCalc := False;
end;

procedure TacConnectFLproc1.hrErr0;
var
  s1: string;
  Msg: TMessage;
begin
  if HandleBoss <> 0 then
  begin
    s1 := formatDateTime(pc006_110_frm4, Now) + ' ' + pc006_110_029;
    uSupport.putString(s1, HandleBoss, pc006_110_jMainProc1);
    Msg.WParamLo := pc006_110_Msg1;
    Msg.WParamHi := 0;
    Msg.LParam   := pc006_110_jMainProc1;
    SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
  end;
  Synchronize( ImSelf.ShowFileParam );
end;

procedure TacConnectFLproc1.hrErr1;
var
  s1: string;
  Msg: TMessage;
begin
  if HandleBoss <> 0 then
  begin
    s1 := formatDateTime(pc006_110_frm4, Now) + ' ' + pc006_110_012;
    uSupport.putString(s1, HandleBoss, pc006_110_jMainProc1);
    Msg.WParamLo := pc006_110_Msg1;
    Msg.WParamHi := 0;
    Msg.LParam   := pc006_110_jMainProc1;
    SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
  end;
  Synchronize( ImSelf.ShowFileParam );

  if HandleBoss <> 0 then
  begin
    uSupport.showString(pc006_110_012, HandleBoss, Msg.LParam + 1);
  end;
end;

procedure TacConnectFLproc1.hrErr2;
var
  s1: string;
  Msg: TMessage;
begin
  if HandleBoss <> 0 then
  begin
    s1 := formatDateTime(pc006_110_frm4, Now) + ' ' + pc006_110_027;
    uSupport.putString(s1, HandleBoss, pc006_110_jMainProc1);
    Msg.WParamLo := pc006_110_Msg1;
    Msg.WParamHi := 0;
    Msg.LParam   := pc006_110_jMainProc1;
    SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
  end;
  Synchronize( ImSelf.ShowFileParam );
end;

procedure TacConnectFLproc1.hrErr3;
var
  s1: string;
  Msg: TMessage;
begin
  if HandleBoss <> 0 then
  begin
    s1 := formatDateTime(pc006_110_frm4, Now) + ' ' + pc006_110_018;
    uSupport.putString(s1, HandleBoss, pc006_110_jMainProc1);
    Msg.WParamLo := pc006_110_Msg1;
    Msg.WParamHi := 0;
    Msg.LParam   := pc006_110_jMainProc1;
    SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
  end;
  Synchronize( ImSelf.ShowFileParam );

  if HandleBoss <> 0 then
  begin
    uSupport.showString(pc006_110_018, HandleBoss, Msg.LParam + 1);
  end;
end;

procedure TcTransfer1.produceFinMsg(var Msg: TMessage);
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

procedure TcTransfer1.CloseProcessAvr;
begin
  destoyHread1;
  self.BlockWorking.bBlockRsrc := false;
end;

procedure TcTransfer1.BitBtn9Click(Sender: TObject);
var
  jC1: integer;
begin
// �������� ���
  inherited;
  if self.isBlocking then Exit;

  self.CheckListBox1.Cursor := crHourGlass;
  try

    for jC1 := 1 to self.job.fileDescript.DatInterval.Count do
    begin
      self.CheckListBox1.Checked[jC1 - 1] := true;
    end;
    self.setTransfInt;

  finally
    self.CheckListBox1.Cursor := crDefault;
  end;
end;

procedure TcTransfer1.BitBtn10Click(Sender: TObject);
var
  jC1: integer;
begin
// �������� ���
  inherited;
  if self.isBlocking then Exit;

  self.CheckListBox1.Cursor := crHourGlass;
  try

    for jC1 := 1 to self.job.fileDescript.DatInterval.Count do
    begin
      self.CheckListBox1.Checked[jC1 - 1] := false;
    end;

  finally
    self.CheckListBox1.Cursor := crDefault;
  end;
end;

function TcTransfer1.isBlocking: boolean;
begin
  result := true;
  if self.fEdtMode then
  begin
    ShowMessage(pc006_110_025);
    Exit;
  end;

  if self.BlockWorking.bBlockRsrc then
  begin
    ShowMessage(pc006_110_023);
    Exit;
  end;

  result := false;
end;

procedure TcTransfer1.BitBtn11Click(Sender: TObject);
begin
  inherited;
  self.Edit10.Text := format(pc006_110_frm5, [formatDateTime(pc006_110_frm6, Now)]);
end;

{ TacTransfDBproc1 }

function TacTransfDBproc1.CreateDB: integer;
var
  jDBLength: integer;
  msg: TOP_ErrorMsg;
begin
// �������� ��
// CreateDB = 0 == ���������
// CreateDB = 1 == �� ���������� ���������
// CreateDB = 2 == ��������, ������ � sErr
  self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + pc006_110_030, pc006_110_jMainProc1);

  if ImSelf.oreolDB.isConnected then
  begin
    ImSelf.oreolDB.disConnectDB(0);
  end;

  sNMadmin := ImSelf.sDBUserName;
  sPSadmin := ImSelf.sDBUserPass;
  sServer := ImSelf.sDataSource;
  sDBname := ImSelf.sDBname;

  sFLBD := ImSelf.sDataPath + ImSelf.sDBname + '.mdf';
  jDBLength := pc006_110_defDBsize;

  msg:= nil;
  try

    if ImSelf.oreolDB.CreateDB(sNMadmin, sPSadmin, sServer, sDBname, msg, sNMadmin, sPSadmin, sFLBD, jDBLength, pc006_110_verDBnumb) then
    begin
      result := 0;
    end
    else
    begin
      if Assigned(msg) then
      begin
        self.sErr := msg.txtMsg;
      end
      else
      begin
        self.sErr := pc006_110_037;
      end;
      result := 2;
    end;

  finally
    msg.Free;
  end;
end;

constructor TacTransfDBproc1.Create(susp: Boolean);
begin
  inherited Create(susp);
  self.HandleBoss := uSupport.getHandleRegistryObj(ImSelf.taskParam, ImSelf.jUniKeyBoss);
end;

destructor TacTransfDBproc1.Destroy;
begin

  inherited;
end;

procedure TacTransfDBproc1.doProcess;
begin
  FbCalc := True;

    produceTransfer;

  FbCalc := False;
end;

procedure TacTransfDBproc1.produceTransfer;
begin
  self.sErr := '';
  try

    // �������� ��
    case self.CreateDB() of
      0:
      begin
      end;
      1:
      begin
        self.sErr := pc006_110_027;
        self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + self.sErr, pc006_110_jMainProc1);
        Exit;
      end;
      2:
      begin
        self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + self.sErr, pc006_110_jMainProc1);
        Exit;
      end;
    end;
    if self.isTerminated then
    begin
      self.sErr := pc006_110_027;
      self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + self.sErr, pc006_110_jMainProc1);
      Exit;
    end;

    // �������� ������
    case self.CreateParamTable() of
      0:
      begin
      end;
      1:
      begin
        self.sErr := pc006_110_027;
        self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + self.sErr, pc006_110_jMainProc1);
        Exit;
      end;
      2:
      begin
        self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + self.sErr, pc006_110_jMainProc1);
        Exit;
      end;
    end;
    if self.isTerminated then
    begin
      self.sErr := pc006_110_027;
      self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + self.sErr, pc006_110_jMainProc1);
      Exit;
    end;

    // ������� ������ �� ����� � ��
    case self.TransferToDB of
      0:
      begin
        self.putToProtocol(format(pc006_110_032, [self.jCountLine]), pc006_110_jMainProc1);
        if self.jCountTOut > 0 then Dec(self.jCountTOut);
        self.putToProtocol(format(pc006_110_033, [self.jCountTOut]), pc006_110_jMainProc1);
        self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + pc006_110_031, pc006_110_jMainProc1);
        if ImSelf.CheckBox5.Checked then
        begin
          self.putToDopList(ImSelf.sDBname, pc006_110_jMainProc2);
        end;
        self.sErr := pc006_110_031;
      end;
      1:
      begin
        self.sErr := pc006_110_027;
        self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + self.sErr, pc006_110_jMainProc1);
        Exit;
      end;
      2:
      begin
        self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + self.sErr, pc006_110_jMainProc1);
        Exit;
      end;
    end;

  finally
    if ImSelf.oreolDB.isConnected then
    begin
      ImSelf.oreolDB.disConnectDB(0);
    end;

    ImSelf.BlockWorking.bBlockRsrc := false;
    Synchronize( ImSelf.CloseProcShow );
    if Length(self.sErr) > 0 then
    begin
      self.showErr();
    end;
  end;
end;

function TacTransfDBproc1.putTOutToDB(dtTime: double;
  CrossTableTab: TCrossTableTab; var rcd: rcdCMD_Measuring;
  var bTOutFlags: array of boolean): integer;
var
  j1, jC1, jPar: integer;
  mMeasuring: TOP_Measuring;
  prm: rcdODBparVal;
  cErr: TOP_ErrorMsg;
begin
  try
    cErr := nil;
    mMeasuring := nil;
    jPar := CrossTableTab.Count;
    rcd.meass[1].val_Time  := dtTime;
    rcd.meass[1].param.Count := 0;
    for jC1 := 1 to jPar do
    begin
      j1 := Low(bTOutFlags) + (jC1 - 1);
      if bTOutFlags[j1] then continue;

      if CrossTableTab[jC1].bSaveDB then
      begin
        prm.numbe_prm := CrossTableTab[jC1].DBNumberChanal - 1;
        prm.val_prm   := cdbTOutVal;
        rcd.meass[1].param.Append(@prm);
        bTOutFlags[j1] := true;
      end;
    end;

    if rcd.meass[1].param.Count > 0 then
    begin
      if not ImSelf.oreolDB.SendMeasuring(rcd, mMeasuring, cErr) then
      begin // ��������� � �� ���� ���������� �� ������ �������
        sErr := cErr.txtMsg;
        result := 2;
        exit;
      end;
      Inc(jCountTOut);
    end;

    result := 0;
  except
    on E: Exception do
    begin
      sErr := E.Message;
      result := 2;
    end;
  end;
end;

function TacTransfDBproc1.TransferToDB: integer;
var
  j1, shftCurr, jC1, jC1inBlock, jCcurBlock: Integer;
  dCrnt, dCrntNext, dCrntPrev: TDateTime;
  sCrnt, sCrntPrev: String;
  vCrnt: single;
  FileStream: TFileStream;
  StartDateTime, StopDateTime: Double;
  jBeg, jEnd: Integer;
  CrossTableTab: TCrossTableTab;
  rcdCT: rcdCrossTableTab;
  bTransf: boolean;
  bNotValid: boolean;

  jFlag, jPar: Integer;
  rcdTO: rcdCMD_Measuring;
  rcdDT: rcdCMD_Measuring;
  prm: rcdODBparVal;
  dPrd, dTout: Double;
  mMeasuring: TOP_Measuring;
  cErr: TOP_ErrorMsg;
  bTOutFlags: array of boolean;
begin
// TransferToDB = 0 == ���������
// TransferToDB = 1 == �� ���������� ���������
// TransferToDB = 2 == ��������, ������ � sErr
  jCountLine:= 0;
  jCountTOut:= 0;
  self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + pc006_110_035, pc006_110_jMainProc1);

  StartDateTime := ImSelf.job.dtBeg;
  StopDateTime  := ImSelf.job.dtEnd;
  jBeg          := ImSelf.job.fileDescript.MetTdesript.IndexBeg;
  jEnd          := ImSelf.job.fileDescript.MetTdesript.IndexEnd;
  mMeasuring    := nil;
  cErr          := nil;

// ���������� ����� ������ � ��
  rcdTO.tySd := 0;
  rcdDT.tySd := 0;
  dPrd := 1 / (24 * 3600 * (ImSelf.job.fileDescript.j_DataPrd / 1000));
  dTout:= 2 * dPrd;
  CrossTableTab := TCrossTableTab.Create;

  rcdTO.meass := TODBmeasVal.Create;  // ������� ��������� ����� ��� ��������
  rcdTO.meass.Count := 1;
  rcdTO.meass[1].val_depth := 0;
  rcdTO.meass[1].param := TOdbParVal.Create;

  rcdDT.meass := TODBmeasVal.Create;  // ������� ��������� ����� ���������� �� ������ �������
  rcdDT.meass.Count := 1;
  rcdDT.meass[1].val_depth := 0;
  rcdDT.meass[1].param := TOdbParVal.Create;

  try
    for jC1 := 1 to ImSelf.job.CrossTableTab.Count do
    begin
      if ImSelf.job.CrossTableTab[jC1].FlNumberChanal >= 0 then
      begin
        CrossTableTab.Append(ImSelf.job.CrossTableTab[jC1]);
      end;
    end;
    CrossTableTab.Sort(1);
    jPar := CrossTableTab.Count;
    SetLength(bTOutFlags, jPar);
    for jC1 := Low(bTOutFlags) to High(bTOutFlags) do
    begin
      bTOutFlags[jC1] := false;
    end;


// ==========================
// ����� ����� timeOut'a
    result := putTOutToDB(StartDateTime - dPrd, CrossTableTab, rcdTO, bTOutFlags);
    if result <> 0 then Exit;
    ImSelf.oreolDB.firstMeas[1].id        := ImSelf.oreolDB.lastMeas[1].id;
    ImSelf.oreolDB.firstMeas[1].val_Time  := StartDateTime - dPrd;
    ImSelf.oreolDB.firstMeas[1].val_depth := 0;


// ==========================
// ���� �� t_Val_XXX, ����� ������
    bTransf := false;
    ImSelf.job.fileDescript.b_Revolut := false;
    FileStream := nil;
    try
      FileStream := TFileStream.Create(ImSelf.job.fileDescript.path, fmOpenRead or fmShareDenyNone);
      try

        ImSelf.job.fileDescript._InitInerval(jBeg, jEnd);
        shftCurr := ImSelf.job.fileDescript.MetTdesript[jBeg].FirstIndex;
        FileStream.Seek(shftCurr, soFromBeginning);
        dCrntPrev := 0;

        while true do
        begin
          if not ImSelf.job.fileDescript._isInternal(shftCurr, jBeg, jEnd) then
          begin
            break;
          end;

          FileStream.Read(dCrnt, SizeOf(dCrnt));

          if ImSelf.job.bDopProtokol then
          begin
            self.sErr := formatDateTime(pc006_110_frm3, dCrnt) + '; ' +
                           IntToStr(shftCurr div 512) + '; ' +
                           IntToStr(shftCurr) + '; ' + FloatToStr(dCrnt);
            self.putToProtocol(self.sErr, pc006_110_jMainProc1);
          end;

          if dCrnt > StopDateTime then break;

          if (dCrntPrev >= dCrnt)      OR
             (dCrnt = 0)               OR
             (dCrnt < StartDateTime)
          then
          begin
            ImSelf.job.fileDescript._NextBlock(shftCurr, true, FileStream);
            continue;
          end;

          rcdDT.meass[1].val_Time  := dCrnt;
          jC1inBlock := 0;
          jCcurBlock := 0;
          rcdDT.meass[1].param.Count := 0;
          for jC1 := 1 to ImSelf.job.fileDescript.j_ParmCnt do
          begin
            Inc(jC1inBlock);
            if jC1inBlock > pc006_110_BlckPrmCnt then
            begin
              jC1inBlock := 1;

              FileStream.Read(dCrntNext, SizeOf(dCrnt));
              try
                if dCrnt <> dCrntNext then break;
              except
                break;
              end;
            end;

            FileStream.Read(vCrnt, SizeOf(vCrnt));
            rcdCT.FlNumberChanal := jCcurBlock;
            Inc(jCcurBlock);
            j1 := CrossTableTab.Find(@rcdCT, 2);
            if j1 = 0 then continue;
            jFlag := Low(bTOutFlags) + (j1 - 1);

            bNotValid := false;
            if Math.isNan(vCrnt)  or  Math.IsInfinite(vCrnt) then bNotValid := true
            else
            begin
              try
                if vCrnt > cdbTServVal1 then bNotValid := true;
                if vCrnt < -cdbTServVal1 then bNotValid := true;
              except
                bNotValid := true;
              end;
            end;

            if bNotValid then
            begin
              if bTOutFlags[jFlag] then
              begin
               continue;
              end
              else
              begin
                prm.numbe_prm := CrossTableTab[j1].DBNumberChanal - 1;
                prm.val_prm   := cdbTOutVal;
                rcdDT.meass[1].param.Append(@prm);
                bTOutFlags[jFlag] := true;
              end;
            end
            else
            begin
              if isZero(vCrnt, cdbLikeZero) then vCrnt := 0;
              prm.numbe_prm := CrossTableTab[j1].DBNumberChanal - 1;
              prm.val_prm   := vCrnt;
              rcdDT.meass[1].param.Append(@prm);
              bTOutFlags[jFlag] := false;
              bTransf := true;
            end;
          end;

          if bTransf then
          begin
// ����� ��������
            if dCrntPrev > 0 then
            begin
              if  (dCrnt - dCrntPrev) >= dTout then
              begin
                result := putTOutToDB(dCrntPrev + dPrd, CrossTableTab, rcdTO, bTOutFlags);
                if result <> 0 then Exit;
              end;
            end;

            if not ImSelf.oreolDB.SendMeasuring(rcdDT, mMeasuring, cErr) then
            begin // ��������� � �� ���� ���������� �� ������ �������
              sErr := cErr.txtMsg;
              result := 2;
              exit;
            end;
            Inc(self.jCountLine);

            if self.isTerminated then
            begin // �������� �������������
              result := 1;
              exit;
            end;

            bTransf := false;
            dCrntPrev := dCrnt;
          end;
          ImSelf.job.fileDescript._NextBlock(shftCurr, true, FileStream);
        end;

    // �����
        result := 0;
      finally
        FileStream.Free;
        FileStream := nil;
      end;
    except
      on E: Exception do
      begin
        FileStream.Free;
        sErr := E.Message;
        result := 2;
      end;
    end;

// ==========================
// ����� ��������
    result := putTOutToDB(StopDateTime + dPrd, CrossTableTab, rcdTO, bTOutFlags);

  finally
    CrossTableTab.Free;
    rcdTO.meass.Free;
    rcdDT.meass.Free;
    mMeasuring.Free;
    cErr.Free;
  end;
end;

procedure TacTransfDBproc1.putToProtocol(s1: string; LParam: integer);
var
  Msg: TMessage;
begin
  if self.HandleBoss <> 0 then
  begin
    uSupport.putString(s1, HandleBoss, LParam);
    Msg.WParamLo := pc006_110_Msg1;
    Msg.WParamHi := 0;
    Msg.LParam   := LParam;
    SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
  end;
end;

function TacTransfDBproc1.CreateParamTable: integer;
var
  j1, nPar, jC1: integer;
  msg: TOP_ErrorMsg;
  mDescript: rcdCMD_Descript;
begin
// CreateParamTable = 0 == ���������
// CreateParamTable = 1 == �� ���������� ���������
// CreateParamTable = 2 == ��������, ������ � sErr
  self.putToProtocol(formatDateTime(pc006_110_frm4, Now) + ' ' + pc006_110_038, pc006_110_jMainProc1);

{
  if ImSelf.oreolDB.isConnected then
  begin
    ImSelf.oreolDB.disConnectDB(0);
  end;

  // ������� � DB
  msg:= nil;
  if not ImSelf.oreolDB.ConnectDB(sNMadmin, sPSadmin, sServer, sDBname, msg, pc006_110_jMain) then
  begin
    if Assigned(msg) then
    begin
      self.sErr := msg.txtMsg;
      result := 2;
      msg.Free;
    end
    else
    begin
      self.sErr := pc006_110_039;
      result := 2;
    end;
    Exit;
  end;
  msg.Free;
}

  // ���� �������� ����������
  for jC1 := 1 to ImSelf.job.CrossTableTab.Count do
  begin
    j1 := ImSelf.job.CrossTableTab[jC1].FlNumberChanal;
    if j1 < 0 then continue; // ���������� ���������� ���������

    nPar := ImSelf.job.CrossTableTab[jC1].DBNumberChanal - 1;
    if nPar < 0 then continue;

    mDescript.pFld := prqTInteger.Create();
    msg:= nil;
    try

      TODBhistTab.clearRcd(mDescript.rcd);
      mDescript.tySd := 0;
      mDescript.nPar := nPar;
      j1 := 4; mDescript.pFld.Append(@j1);
      j1 := 5; mDescript.pFld.Append(@j1);
      mDescript.rcd.numbe_prm := nPar;
      mDescript.rcd.name_prm  := ImSelf.job.CrossTableTab[jC1].DBNameChanal;

      if not ImSelf.oreolDB.SendParam(mDescript, msg, ImSelf.job.CrossTableTab[jC1].guidChanal) then
      begin
        result := 2;
        if Assigned(msg) then
        begin
          self.sErr := msg.txtMsg;
        end
        else
        begin
          self.sErr := format(pc006_110_040, [nPar]);;
        end;
        Exit;
      end;

    finally
      msg.Free;
      mDescript.pFld.Free;
    end;
  end;

  result := 0;
end;

procedure TcTransfer1.synchroShowMessage;
begin
  ShowMessage(sinchroMessage);
end;

procedure TacTransfDBproc1.showErr;
begin
  ImSelf.sinchroMessage := self.sErr;
  Synchronize(ImSelf.synchroShowMessage)
end;

procedure TacTransfDBproc1.putToDopList(s1: string; LParam: integer);
var
  Msg: TMessage;
begin
  if self.HandleBoss <> 0 then
  begin
    uSupport.putString(s1, HandleBoss, LParam);
    Msg.WParamLo := pc006_110_Msg1;
    Msg.WParamHi := 1;
    Msg.LParam   := LParam;
    SendMessage(HandleBoss, WM_User_Dialog, Msg.WParam, Msg.LParam);
  end;
end;

end.
