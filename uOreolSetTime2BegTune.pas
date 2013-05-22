unit uOreolSetTime2BegTune;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, uMainData, uMainConst, uOreolBegTuneBtn2const, StdCtrls,
  Buttons, ExtCtrls;

type
  TOreolSetTime2BegTune = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    BitBtn3: TBitBtn;
    Edit1: TEdit;
    CheckBox2: TCheckBox;
    Panel3: TPanel;
    RadioButton1: TRadioButton;
    RadioButton3: TRadioButton;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    bValue1, bValue2: Boolean;
    sEdt1: string;
  public
    { Public declarations }
    bFirst: Boolean;
    bSaveParam: Boolean;
    OpenDialog1: TOpenDialog;

    function getParamNW(var bAuto, bNotQ: Boolean; var strConfFile: string): Boolean;
  end;

implementation

{$R *.dfm}

procedure TOreolSetTime2BegTune.FormCreate(Sender: TObject);
begin
  jUniType   := pc003_119_jMain;
  Caption    := pc003_119_Caption;
end;

procedure TOreolSetTime2BegTune.BitBtn1Click(Sender: TObject);
begin
  bSaveParam := True;
  Close;
end;

procedure TOreolSetTime2BegTune.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TOreolSetTime2BegTune.FormActivate(Sender: TObject);
begin
  if bFirst then
  begin
    bValue1 := CheckBox1.Checked;
    bValue2 := CheckBox2.Checked;
    sEdt1 := Edit1.Text;
    bSaveParam := False;
    bFirst     := False;
  end;
end;

procedure TOreolSetTime2BegTune.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not bSaveParam then
  begin
    CheckBox1.Checked := bValue1;
    CheckBox2.Checked := bValue2;
    Edit1.Text := sEdt1;
  end;

  inherited;
end;

function TOreolSetTime2BegTune.getParamNW(var bAuto, bNotQ: Boolean;
  var strConfFile: string): Boolean;
begin
  bAuto := CheckBox1.Checked;
  bNotQ := CheckBox2.Checked;
  strConfFile := Trim(Edit1.Text);
  if Length(strConfFile) = 0 then result := False else result := True;
end;

procedure TOreolSetTime2BegTune.BitBtn3Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.FilterIndex := 1;
  OpenDialog1.Filter := pc003_119_OpenCnfg;
  if not OpenDialog1.Execute then Exit;
  Edit1.Text := OpenDialog1.FileName;
end;

end.
