unit uGrafTune1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, uAbstrArray, uDEPgrafJob1, uDEPdescript,
  uGrafTune1const, uShowDEPparam2;

type
  TcGrafTune1 = class(Tpf2)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    Edit6: TEdit;
    Label6: TLabel;
    Edit7: TEdit;
    Label7: TLabel;
    Edit8: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label25: TLabel;
    Panel3: TPanel;
    Label11: TLabel;
    Edit10: TEdit;
    ColorDialog1: TColorDialog;
    Label10: TLabel;
    Edit9: TEdit;
    Label12: TLabel;
    BitBtn3: TBitBtn;
    CheckBox1: TCheckBox;
    Label13: TLabel;
    Edit11: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    FDEPgrafJob: TDEPgrafJob1;
    FnPar:  Integer; // ����� �������
    FnChan: Integer; // ����� ��������� �� ��
    FjChnl: Integer; // ������ ������ � ��� ��
    FjDscr: Integer; // ������ ������� � ��� ��������

    function _CheckString(const Txt, Lbl: String): Boolean;
    function _CheckDouble(const Txt, Lbl: String; var dRes: Double): Boolean;
    function _CheckInteger(const Txt, Lbl: String; var jRes: Integer): Boolean;
//    cjListPar: prqTInteger;
//    virtChanal, realChanal: TStringList;
  public
    { Public declarations }

    bUpdate: boolean;

    procedure TuneForms(DEPgrafJob: TDEPgrafJob1; nPar: Integer); overload; // ��������� ��������� �� ������� � �����
    procedure TuneForms; overload; // ��������� ��������� �� ������� � �����
    procedure TuneForms2;
    procedure setjDscr; // ������� ����� ������ � ������� �������� ������� � ���������� �������� �������
    procedure finfjDscr; // ���������� �������� �������
    procedure findjChnl; // ���������� �������� ������� � ������ ������� ��

  end;

implementation
uses
  uSupport;

{$R *.dfm}

procedure TcGrafTune1.FormCreate(Sender: TObject);
begin
  inherited;
  self.jUniType := pc005_109_jMain;
  self.Caption  := pc005_109_Caption;
  self.FjDscr   := 0;
  self.FjChnl   := 0;
  bUpdate       := false;
end;

procedure TcGrafTune1.TuneForms(DEPgrafJob: TDEPgrafJob1; nPar: Integer);
begin
  fnPar  := nPar;
  FDEPgrafJob := DEPgrafJob;

  FnChan := self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.nChanal;
  if FnChan < 0 then
  begin
    Exit;
  end;

  TuneForms;
end;

procedure TcGrafTune1.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TcGrafTune1.BitBtn1Click(Sender: TObject);
var
  diaMin, diaMax, thLine, stGraf: Double;
  fnSize: Integer;
  Precision:Integer;    // ����� ������ ����� ������� � ������������� �����
  Digits:   Integer;    // ������ ���� � ������������� �����
begin
  inherited;
  if self.FnChan < 0 then
  begin
    ShowMessage(pc005_109_001);
    Exit;
  end;

  if not _CheckString(Edit1.Text, Label1.Caption) then Exit;
  if not _CheckDouble(Edit3.Text, Label3.Caption, diaMin) then Exit;
  if not _CheckDouble(Edit4.Text, Label4.Caption, diaMax) then Exit;
  if not _CheckDouble(Edit5.Text, Label5.Caption, thLine) then Exit;
  if not _CheckDouble(Edit6.Text, Label6.Caption, stGraf) then Exit;
  if not _CheckInteger(Edit7.Text, Label7.Caption, fnSize) then Exit;
  if not _CheckInteger(Edit8.Text, Label8.Caption, Digits) then Exit;
  if Digits < 0 then
  begin
    ShowMessage(  format(pc005_109_frm_03, [Label8.Caption])  );
    Exit;
  end;
  if not _CheckInteger(Edit9.Text, Label9.Caption, Precision) then Exit;
  if Precision < 0 then
  begin
    ShowMessage(  format(pc005_109_frm_03, [Label9.Caption])  );
    Exit;
  end;
  if Digits <= Precision  then
  begin
    ShowMessage( format(pc005_109_frm_04, [Label8.Caption, Label9.Caption]) );
    Exit;
  end;

  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.nChanal   := self.FnChan;
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sName     := Trim(Edit11.Text);
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sPodp     := Trim(Edit1.Text);
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sEdIzm    := Trim(Edit2.Text);
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.diaMin    := diaMin;
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.diaMax    := diaMax;
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.Color     := Panel3.Color;
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.xLogSize  := Round(thLine * 10);
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.xLogStep  := Round(stGraf * 10);
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.fnSize    := fnSize;
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.Precision := Precision;
  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.Digits    := Digits;
//  self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sFormat   :=
//                 '%' + IntToStr(Digits) + '.' + IntToStr(Precision) + 'f';

  if (FjDscr = 0)  or  self.CheckBox1.Checked then
  begin
    setjDscr;
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].nChanal   := self.FnChan;
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].sName     := self.fDEPgrafJob.DEPdepParam[FjChnl].SGTparNameBig;
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].sPodp     := Trim(Edit1.Text);
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].sEdIzm    := Trim(Edit2.Text);
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].diaMin    := diaMin;
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].diaMax    := diaMax;
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].Color     := Panel3.Color;
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].xLogSize  := Round(thLine * 10);
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].xLogStep  := Round(stGraf * 10);
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].fnSize    := fnSize;
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].Precision := Precision;
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].Digits    := Digits;
//    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].sFormat   :=
  //               '%' + IntToStr(Digits) + '.' + IntToStr(Precision) + 'f';
  end;

  self.fDEPgrafJob.Modify := true;
  bUpdate := true;
  Close;
end;

procedure TcGrafTune1.Panel3Click(Sender: TObject);
begin
  inherited;
  if ColorDialog1.Execute then
  begin
    Panel3.Color := ColorDialog1.Color;
  end;
end;

procedure TcGrafTune1.BitBtn3Click(Sender: TObject);
var
  jN: Integer;
  rcd: rcdDEPdepParam;
  pDD: TcShowDEPparam2;
begin
// ������� ������

  pDD := TcShowDEPparam2.Create(self);
  try
    pDD.CreateIMG(self.FDEPgrafJob.DEPdepParam);
    pDD.bMustSave := true;
    pDD.ShowModal;

    rcd.DEPparNum := pDD.selectDEP;
    jN := self.FDEPgrafJob.DEPdepParam.Find(@rcd, 1);
    if jN > 0 then
    begin
      self.FnChan := rcd.DEPparNum;
      findjChnl;
      self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sName := self.fDEPgrafJob.DEPdepParam[FjChnl].SGTparNameBig;
      TuneForms2;
    end;
  finally
    pDD.Free;
  end;
end;

procedure TcGrafTune1.TuneForms;
begin
  Edit1.Text   := self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sPodp;
  Edit2.Text   := self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sEdIzm;
  Edit3.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.diaMin));
  Edit4.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.diaMax));
  Edit5.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.xLogSize);
  Edit6.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.xLogStep);
  Edit7.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.fnSize);
  Edit8.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.Digits);
  Edit9.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.Precision);
  Edit10.Text  := IntToStr(FnChan);
  Edit11.Text  := self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sName;
  Panel3.Color := self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.Color;

  finfjDscr;
  findjChnl;
end;

procedure TcGrafTune1.setjDscr;
var
  rcdGRF: rcdDEPlistChanGraphDescr;
begin
  rcdGRF.nChanal := FnChan;
  FjDscr := self.fDEPgrafJob.DEPGrhDescr.listGrfS.Find(@rcdGRF, 1);
  if FjDscr = 0 then
  begin
    FjDscr := self.fDEPgrafJob.DEPGrhDescr.listGrfS.Count + 1;
    self.fDEPgrafJob.DEPGrhDescr.listGrfS.Count := FjDscr;
  end;
end;

function TcGrafTune1._CheckString(const Txt, Lbl: String): Boolean;
var
  s1: string;
begin
  result := false;
  s1 := Trim(Txt);
  if Length(s1) = 0 then
  begin
    ShowMessage(format(pc005_109_frm_02, [Lbl]));
    Exit;
  end;
  result := true;
end;

function TcGrafTune1._CheckDouble(const Txt, Lbl: String; var dRes: Double): Boolean;
var
  s1: string;
begin
  result := false;
  s1 := Trim(Txt);
  if Length(s1) = 0 then
  begin
    ShowMessage(format(pc005_109_frm_02, [Lbl]));
    Exit;
  end;
  if not prqStrToFloat(s1, dRes) then
  begin
    ShowMessage(format(pc005_109_frm_02, [Lbl]));
    Exit;
  end;
  result := true;
end;

function TcGrafTune1._CheckInteger(const Txt, Lbl: String; var jRes: Integer): Boolean;
var
  s1: string;
begin
  result := false;
  s1 := Trim(Txt);
  if Length(s1) = 0 then
  begin
    ShowMessage(format(pc005_109_frm_02, [Lbl]));
    Exit;
  end;
  if not prqStrToInt(s1, jRes) then
  begin
    ShowMessage(format(pc005_109_frm_02, [Lbl]));
    Exit;
  end;
  result := true;
end;

procedure TcGrafTune1.findjChnl;
var
  rcd: rcdDEPdepParam;
begin
  if self.FnChan < 0 then
  begin
    self.FjChnl := 0;
    Exit;
  end;
  rcd.DEPparNum := self.FnChan;
  self.FjChnl := self.FDEPgrafJob.DEPdepParam.Find(@rcd, 1)
end;

procedure TcGrafTune1.finfjDscr;
var
  rcdGRF: rcdDEPlistChanGraphDescr;
begin
  rcdGRF.nChanal := FnChan;
  FjDscr := self.fDEPgrafJob.DEPGrhDescr.listGrfS.Find(@rcdGRF, 1);
end;

procedure TcGrafTune1.TuneForms2;
var
  rcd: rcdDEPlistChanGraphDescr;
  j1: integer;
begin
  rcd.nChanal := FnChan;
  j1 := self.fDEPgrafJob.DEPGrhDescr.listGrfS.Find(@rcd, 1);
  if j1 = 0 then
  begin
    Edit1.Text   := self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sPodp;
    Edit2.Text   := self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sEdIzm;
    Edit3.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.diaMin));
    Edit4.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.diaMax));
    Edit5.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.xLogSize);
    Edit6.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.xLogStep);
    Edit7.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.fnSize);
    Edit8.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.Digits);
    Edit9.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.Precision);
    Edit10.Text  := IntToStr(FnChan);
    Edit11.Text  := self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.sName;
    Panel3.Color := self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.Color;
  end
  else
  begin
    Edit1.Text   := self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].sPodp;
    Edit2.Text   := self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].sEdIzm;
    Edit3.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].diaMin));
    Edit4.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].diaMax));
    Edit5.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].xLogSize);
    Edit6.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].xLogStep);
    Edit7.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].fnSize);
    Edit8.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].Digits);
    Edit9.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].Precision);
    Edit10.Text  := IntToStr(FnChan);
    Edit11.Text  := self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].sName;
    Panel3.Color := self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].Color;
  end;

  finfjDscr;
  findjChnl;
end;

end.
