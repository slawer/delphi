unit uShowREPparam2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, uShowREPparam2const, StdCtrls, ExtCtrls, Buttons,
  uDEPdescript2, ComCtrls;

type
  TcShowREPparam2 = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    Label7: TLabel;
    Edit7: TEdit;
    BitBtn3: TBitBtn;
    OpenDialog1: TOpenDialog;
    Label9: TLabel;
    BitBtn5: TBitBtn;
    Edit9: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    FrptParam: TDEPrptALL;
    procedure SetrptParam(const Value: TDEPrptALL);
    { Private declarations }
  public
    { Public declarations }
    property rptParam: TDEPrptALL read FrptParam write SetrptParam;
    procedure CreateIMG(DEPrptParam: TDEPrptALL);
  end;

implementation
uses uSupport;

{$R *.dfm}

procedure TcShowREPparam2.FormCreate(Sender: TObject);
begin
  inherited;
  jUniType   := pc006_103_jMain;
  Caption    := pc006_103_Caption;
end;

procedure TcShowREPparam2.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TcShowREPparam2.CreateIMG(DEPrptParam: TDEPrptALL);
begin
  FrptParam := DEPrptParam;
  Edit7.Text := FrptParam.RefrPath;
  Edit9.Text := FrptParam.DocPath;
end;

procedure TcShowREPparam2.SetrptParam(const Value: TDEPrptALL);
begin
  FrptParam := Value;
end;

procedure TcShowREPparam2.BitBtn1Click(Sender: TObject);
begin
  FrptParam.RefrPath  := IncludeTrailingPathDelimiter(Trim(Edit7.Text));
  FrptParam.DocPath   := IncludeTrailingPathDelimiter(Trim(Edit9.Text));
  FrptParam.Modify    := true;
  Close;
end;

procedure TcShowREPparam2.BitBtn3Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.FileName := pc006_103_101;
  if OpenDialog1.Execute then
  begin
    self.Edit7.Text := ExtractFileDir(OpenDialog1.FileName) + '\';
  end;
end;

procedure TcShowREPparam2.BitBtn5Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.FileName := pc006_103_103;
  if OpenDialog1.Execute then
  begin
    self.Edit9.Text := ExtractFileDir(OpenDialog1.FileName) + '\';
  end;
end;

end.
