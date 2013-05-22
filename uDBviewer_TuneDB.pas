unit uDBviewer_TuneDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, StdCtrls, Buttons, ExtCtrls,
  uDBviewer_TuneDBconst, uOreolDBDirect2, uOreolProtocol6, uDEPgrafJob2;

type
  TcDBviewer_TuneDB = class(Tpf2)
    Panel14: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit1: TEdit;
    BitBtn10: TBitBtn;
    Edit2: TEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label38: TLabel;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
  private
    { Private declarations }
    bCheck1, bCheck2: boolean;
    sCheck, sAddr, sPath: string;
    bFirst: boolean;

    procedure disConnectDB;
  public
    { Public declarations }
    bSetNewParam: boolean;
//    oreolDB: TOreolDBDirect2;

    DEPgrafJob:  TDEPgrafJob1;


    procedure Init;
    procedure setDostup;
  end;

implementation
uses
  uSupport;

{$R *.dfm}

procedure TcDBviewer_TuneDB.FormCreate(Sender: TObject);
begin
  inherited;
  self.jUniType := pc006_102_jMain;
  self.Caption  := pc006_102_Caption;
  self.bSetNewParam := false;
  self.bFirst   := true;
end;

procedure TcDBviewer_TuneDB.Init;
begin
  if not (self.RadioButton1.Checked or self.RadioButton2.Checked) then
  begin
    self.RadioButton1.Checked := false;
    self.RadioButton2.Checked := true;
  end;

  self.bCheck1 := self.RadioButton1.Checked;
  self.bCheck2 := self.RadioButton2.Checked;

  self.sAddr   := Trim(self.Edit1.Text);
  self.sPath   := Trim(self.Edit2.Text);
  self.sCheck  := Trim(self.Edit3.Text);

  self.setDostup;
end;

procedure TcDBviewer_TuneDB.BitBtn2Click(Sender: TObject);
begin
  self.bFirst := true;
  self.RadioButton1.Checked := bCheck1;
  self.RadioButton2.Checked := bCheck2;

  self.Edit1.Text := self.sAddr;
  self.Edit2.Text := self.sPath;
  self.Edit3.Text := self.sCheck;

  self.Close;
end;

procedure TcDBviewer_TuneDB.BitBtn1Click(Sender: TObject);
var
  jRes: integer;
begin
  self.bFirst := true;
  self.bSetNewParam := True;

  if not uSupport.prqStrToInt(Trim(self.Edit3.Text), jRes) then
  begin
    ShowMessage(format(pc006_102_004, [self.Label38.Caption]));
    Exit;
  end;
  if (jRes < 1) or (jRes > uOreolProtocol6.cdbConnectCount) then
  begin
    ShowMessage(format(pc006_102_005, [uOreolProtocol6.cdbConnectCount]));
    Exit;
  end;
  self.DEPgrafJob.ConnectCount := jRes;

  self.Close;
end;

procedure TcDBviewer_TuneDB.FormActivate(Sender: TObject);
begin
  inherited;
  self.bFirst := false;
end;

procedure TcDBviewer_TuneDB.RadioButton2Click(Sender: TObject);
begin
  inherited;
  if self.bFirst then
  begin
    Exit;
  end;
  self.setDostup;
end;

procedure TcDBviewer_TuneDB.setDostup;
begin
  if self.RadioButton1.Checked then
  begin
    self.Edit1.Enabled := false;
    self.Edit2.Enabled := false;
    self.Edit1.Color   := clMedGray;
    self.Edit2.Color   := clMedGray;
//    self.BitBtn10.Enabled := false;
  end
  else
  begin
    self.Edit1.Enabled := true;
    self.Edit2.Enabled := true;
    self.Edit1.Color   := clWindow;
    self.Edit2.Color   := clWindow;
//    self.BitBtn10.Enabled := true;
  end;
end;

procedure TcDBviewer_TuneDB.RadioButton1Click(Sender: TObject);
begin
  inherited;
  if self.bFirst then
  begin
    Exit;
  end;
  self.setDostup;
end;

procedure TcDBviewer_TuneDB.BitBtn10Click(Sender: TObject);
var
  bRes: boolean;
  cnctMsg: TOP_ErrorMsg;
begin
  self.disConnectDB;
  try

    if self.RadioButton1.Checked then
    begin
      bRes := self.DEPgrafJob.oreolDB.ConnectDB(
                                    self.DEPgrafJob.gbl_DBUserName,
                                    self.DEPgrafJob.gbl_DBUserPass,
                                    self.DEPgrafJob.gbl_DataSource,
                                    '',
                                    cnctMsg,
                                    0);
    end
    else
    begin
      bRes := self.DEPgrafJob.oreolDB.ConnectDB(
                                    pc006_102_001,
                                    Trim(self.Edit2.Text),
                                    Trim(self.Edit1.Text),
                                    '',
                                    cnctMsg,
                                    0);
    end;


    if bRes then
    begin
      ShowMessage( pc006_102_002 );
    end
    else
    begin
      ShowMessage(pc006_102_003 + cnctMsg.txtMsg);
    end;

  finally
    self.disConnectDB;
  end;
end;

procedure TcDBviewer_TuneDB.disConnectDB;
begin
  if self.DEPgrafJob.oreolDB.isConnected then
  begin // –азорвать существующее соединение
    try
      self.DEPgrafJob.oreolDB.disConnectDB(0);
    except
    end;
  end;
end;

end.
