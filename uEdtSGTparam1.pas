unit uEdtSGTparam1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  uPf2, uEdtSGTparam1const, uDEPdescript2, uShowDEPparam2, StdCtrls,
  Buttons, ExtCtrls;

type

  TcEdtSGTparam1 = class(Tpf2)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel2: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    FRowNumber: Integer;
    FjobSGT: TDEPsgtParam;
    FjobDEP: TDEPdepParam;
    FrcdDepNumber: Integer; // Выбранный пользователем параметр

    procedure SetRowNumber(const Value: Integer);
    procedure SetjobSGT(const Value: TDEPsgtParam);
    procedure SetjobDEP(const Value: TDEPdepParam);
    { Private declarations }
  public
    { Public declarations }
    property RowNumber: Integer read FRowNumber write SetRowNumber;
    property jobSGT: TDEPsgtParam read FjobSGT write SetjobSGT;
    property jobDEP: TDEPdepParam read FjobDEP write SetjobDEP;

    procedure ShowDEPRow;

  end;

implementation
uses
  uSupport;

{$R *.dfm}

procedure TcEdtSGTparam1.FormCreate(Sender: TObject);
var
  p: Pointer;
begin
  jUniType   := pc005_105_jMain;
  Caption    := pc005_105_Caption;
  FrcdDepNumber := 0;
  Edit2.MaxLength := Sizeof(PrcdDEPsgtParam(p).SGTparNameBig) - 1;
  Edit3.MaxLength := Sizeof(PrcdDEPsgtParam(p).SGTparNameShrt) - 1;
  Edit5.MaxLength := Sizeof(PrcdDEPdepParam(p).SGTparNameBig) - 1;
end;

procedure TcEdtSGTparam1.SetjobDEP(const Value: TDEPdepParam);
begin
  FjobDEP := Value;
end;

procedure TcEdtSGTparam1.SetjobSGT(const Value: TDEPsgtParam);
begin
  FjobSGT := Value;
end;

procedure TcEdtSGTparam1.SetRowNumber(const Value: Integer);
begin
  FRowNumber := Value;
end;

procedure TcEdtSGTparam1.ShowDEPRow;
var
  jN: Integer;
  rcd: rcdDEPdepParam;
begin
  self.Edit1.Text := IntToStr( fjobSGT[FRowNumber].SGTparNum );
  self.Edit2.Text := fjobSGT[FRowNumber].SGTparNameBig;
  self.Edit3.Text := fjobSGT[FRowNumber].SGTparNameShrt;
  self.Edit4.Text := IntToStr( fjobSGT[FRowNumber].DEPparNum );

  rcd.DEPparNum := fjobSGT[FRowNumber].DEPparNum;
  jN := fjobDEP.Find(@rcd, 1);
  if jN > 0 then
  begin
    self.Edit5.Text := fjobDEP[jN].SGTparNameBig;
  end
  else
  begin
    self.Edit5.Text := '';
  end;
end;

procedure TcEdtSGTparam1.BitBtn1Click(Sender: TObject);
var
  jN: Integer;
  rcd: rcdDEPdepParam;
  pDD: TcShowDEPparam2;
begin
// Создать диалог

  pDD := TcShowDEPparam2.Create(self);
  try

    pDD.taskParam := taskParam;
    registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
    pDD.bTag  := True;
    pDD.bGeom := True;
    pDD.getParam;

    pDD.CreateIMG(FjobDEP);
    pDD.bMustSave := true;
    pDD.ShowModal;

    rcd.DEPparNum := pDD.selectDEP;
    jN := fjobDEP.Find(@rcd, 1);
    if jN > 0 then
    begin
      self.Edit4.Text := IntToStr(fjobDEP[jN].DEPparNum);
      self.Edit5.Text := fjobDEP[jN].SGTparNameBig;
      FrcdDepNumber   := jN;
    end;

  finally
    pDD.Free;
  end;
end;

procedure TcEdtSGTparam1.BitBtn2Click(Sender: TObject);
var
  s1, s2: String;
begin
  inherited;
  s1 := Trim(Edit2.Text);
  if Length(s1) = 0 then
  begin
    ShowMessage(pc005_105_001);
    Exit;
  end;
  s2 := Trim(Edit3.Text);
  if Length(s2) = 0 then
  begin
    ShowMessage(pc005_105_002);
    Exit;
  end;

  FjobSGT[FRowNumber].SGTparNameBig  := s1;
  FjobSGT[FRowNumber].SGTparNameShrt := s2;
  if FrcdDepNumber > 0 then
  begin
    FjobSGT[FRowNumber].DEPparNum := fjobDEP[FrcdDepNumber].DEPparNum;
  end
  else
  begin
    FjobSGT[FRowNumber].DEPparNum := -1;
  end;
  FjobSGT.Modify := true;
  Close;
end;

procedure TcEdtSGTparam1.BitBtn3Click(Sender: TObject);
begin
  inherited;
    Close;
end;

procedure TcEdtSGTparam1.BitBtn4Click(Sender: TObject);
begin
  inherited;
  self.Edit4.Text := '-1';
  self.Edit5.Text := '';
  FrcdDepNumber   := 0;
end;

end.
