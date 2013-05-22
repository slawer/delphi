unit uOreolNWTune1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, uMainData, uMainConst, uOreolNWTune1const, StdCtrls,
  Buttons, ExtCtrls;

type
  TOreolNWTune1 = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    sE1, sE2: string;
  public
    { Public declarations }
    bSaveParam: Boolean;
    bFirst: Boolean;

    function getParamNW(var sComp: string; var jPort: Integer): boolean;

  end;

implementation

{$R *.dfm}

procedure TOreolNWTune1.FormCreate(Sender: TObject);
begin
  jUniType := pc003_103_jMain;
  Caption := pc003_103_Caption;
end;

procedure TOreolNWTune1.FormActivate(Sender: TObject);
begin
  if bFirst then
  begin
    sE1 := Edit1.Text;
    sE2 := Edit2.Text;
    bSaveParam := False;
    bFirst     := False;
  end;
end;

procedure TOreolNWTune1.BitBtn1Click(Sender: TObject);
begin
  if (Length(Edit1.Text) = 0) OR
     (Length(Edit2.Text) = 0)
  then
  begin
     ShowMessage(pc003_103_01);
     Exit;
  end;

  try
    if StrToInt( Edit2.Text ) < 0 then
    begin
      ShowMessage( pc003_103_02 );
      Exit;
    end;
  except
    ShowMessage( pc003_103_02 );
    Exit;
  end;


  bSaveParam := True;
  Close;
end;

procedure TOreolNWTune1.BitBtn2Click(Sender: TObject);
begin
  bSaveParam := False;
  Close;
end;

procedure TOreolNWTune1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not bSaveParam then
  begin
    Edit1.Text := sE1;
    Edit2.Text := sE2;
  end;

  inherited;
end;

function TOreolNWTune1.getParamNW(var sComp: string;
  var jPort: Integer): boolean;
var
  s2: String;
begin
  result := False;
  sComp := Trim(Edit1.Text); s2 := Trim(Edit2.Text);
  if (Length(sComp) = 0) OR (Length(s2) = 0) then  Exit;

  try
    jPort := StrToInt( s2 );
    if jPort < 0 then
    begin
      Exit;
    end;
    result := True;
  except
    Exit;
  end;
end;

end.
