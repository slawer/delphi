unit uGrafTune2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, uAbstrArray, uDEPgrafJob2, uDEPdescript2,
  uGrafTune1const, uShowDEPparam2;

type
  TcGrafTune2 = class(Tpf2)
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
    Label25: TLabel;
    Panel3: TPanel;
    Label11: TLabel;
    Edit10: TEdit;
    ColorDialog1: TColorDialog;
    Label10: TLabel;
    Edit9: TEdit;
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
    FnPar:  Integer; // Номер графика
    FnChan: Integer; // Номер параметра из БД
    FjChnl: Integer; // Индекс канала в таб БД
    FjDscr: Integer; // Индекс графика в таб графиков

    function _CheckString(const Txt, Lbl: String): Boolean;
    function _CheckDouble(const Txt, Lbl: String; var dRes: Double): Boolean;
    function _CheckInteger(const Txt, Lbl: String; var jRes: Integer): Boolean;
//    cjListPar: prqTInteger;
//    virtChanal, realChanal: TStringList;
  public
    { Public declarations }

    bUpdate: boolean;

    procedure TuneForms(DEPgrafJob: TDEPgrafJob1; nPar: Integer); overload; // Перенести настройки из задания в форму
    procedure TuneForms; overload; // Перенести настройки из задания в форму
    procedure TuneForms2;
    procedure setjDscr; // Завести новую запись в таблице описаний каналов и установить значение индекса
    procedure finfjDscr; // установить значение индекса
    procedure findjChnl; // установить значение индекса в списке каналов БД

  end;

implementation
uses
  uSupport;

{$R *.dfm}

procedure TcGrafTune2.FormCreate(Sender: TObject);
begin
  inherited;
  self.jUniType := pc005_109_jMain;
  self.Caption  := pc005_109_Caption;
  self.FjDscr   := 0;
  self.FjChnl   := 0;
  bUpdate       := false;
end;

procedure TcGrafTune2.TuneForms(DEPgrafJob: TDEPgrafJob1; nPar: Integer);
begin
  fnPar  := nPar;
  FDEPgrafJob := DEPgrafJob;

  // требуется доступ к выбранному каналу выбранного трека выбранного листа
  FnChan := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].nChanal;
//  FnChan := self.fDEPgrafJob.DEPGrhDescr.Chanals[fnPar].graph.nChanal;
  if FnChan < 0 then
  begin
    Exit;
  end;

  TuneForms;
end;

procedure TcGrafTune2.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TcGrafTune2.BitBtn1Click(Sender: TObject);
var
  diaMin, diaMax, thLine, stGraf: Double;
//  fnSize: Integer;
  Precision:Integer;    // Число знаков после запятой в представлении числа
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

  if not _CheckInteger(Edit9.Text, Label10.Caption, Precision) then Exit;
  if Precision < 0 then
  begin
    ShowMessage(  format(pc005_109_frm_03, [Label10.Caption])  );
    Exit;
  end;
{
  if Digits <= Precision  then
  begin
    ShowMessage( format(pc005_109_frm_04, [Label8.Caption, Label9.Caption]) );
    Exit;
  end;
}

  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].nChanal   := self.FnChan;
  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].sName     := Trim(Edit11.Text);
  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].sPodp     := Trim(Edit1.Text);
  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].sEdIzm    := Trim(Edit2.Text);
  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].diaMin    := diaMin;
  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].diaMax    := diaMax;
  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].Color     := Panel3.Color;
  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].xLogSize  := Round(thLine * 10);
  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].xLogStep  := Round(stGraf * 10);
//  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].fnSize    := fnSize;
  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].Precision := Precision;
//  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].Digits    := Digits;

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
//    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].fnSize    := fnSize;
    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].Precision := Precision;
//    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].Digits    := Digits;
//    self.fDEPgrafJob.DEPGrhDescr.listGrfS[FjDscr].sFormat   :=
  //               '%' + IntToStr(Digits) + '.' + IntToStr(Precision) + 'f';
  end;

  self.fDEPgrafJob.Modify := true;
  bUpdate := true;
  Close;
end;

procedure TcGrafTune2.Panel3Click(Sender: TObject);
begin
  inherited;
  if ColorDialog1.Execute then
  begin
    Panel3.Color := ColorDialog1.Color;
  end;
end;

procedure TcGrafTune2.BitBtn3Click(Sender: TObject);
var
  jN: Integer;
  rcd: rcdDEPdepParam;
  pDD: TcShowDEPparam2;
begin
// Создать диалог

  pDD := TcShowDEPparam2.Create(self);
  try
    pDD.taskParam := taskParam;
    pDD.bMustSave := true;
    pDD.bTag  := True;
    pDD.bGeom := True;
    pDD.getParam;

    pDD.CreateIMG(self.FDEPgrafJob.DEPdepParam);
    pDD.ShowModal;

    rcd.DEPparNum := pDD.selectDEP;
    jN := self.FDEPgrafJob.DEPdepParam.Find(@rcd, 1);
    if jN > 0 then
    begin
      self.FnChan := rcd.DEPparNum;
      findjChnl;
      self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].sName := self.fDEPgrafJob.DEPdepParam[FjChnl].SGTparNameBig;
      TuneForms2;
    end;
  finally
    pDD.Free;
  end;
end;

procedure TcGrafTune2.TuneForms;
begin
  Edit1.Text   := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].sPodp;
  Edit2.Text   := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].sEdIzm;
  Edit3.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].diaMin));
  Edit4.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].diaMax));
  Edit5.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].xLogSize);
  Edit6.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].xLogStep);
  Edit9.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].Precision);
  Edit10.Text  := IntToStr(FnChan);
  Edit11.Text  := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].sName;
  Panel3.Color := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].Color;

  finfjDscr;
  findjChnl;
end;

procedure TcGrafTune2.setjDscr;
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

function TcGrafTune2._CheckString(const Txt, Lbl: String): Boolean;
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

function TcGrafTune2._CheckDouble(const Txt, Lbl: String; var dRes: Double): Boolean;
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

function TcGrafTune2._CheckInteger(const Txt, Lbl: String; var jRes: Integer): Boolean;
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

procedure TcGrafTune2.findjChnl;
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

procedure TcGrafTune2.finfjDscr;
var
  rcdGRF: rcdDEPlistChanGraphDescr;
begin
  rcdGRF.nChanal := FnChan;
  FjDscr := self.fDEPgrafJob.DEPGrhDescr.listGrfS.Find(@rcdGRF, 1);
end;

procedure TcGrafTune2.TuneForms2;
var
  rcd: rcdDEPlistChanGraphDescr;
  j1: integer;
begin
  rcd.nChanal := FnChan;
  j1 := self.fDEPgrafJob.DEPGrhDescr.listGrfS.Find(@rcd, 1);
  if j1 = 0 then
  begin
    Edit1.Text   := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].sPodp;
    Edit2.Text   := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].sEdIzm;
    Edit3.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].diaMin));
    Edit4.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].diaMax));
    Edit5.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].xLogSize);
    Edit6.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].xLogStep);
    Edit9.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].Precision);
    Edit10.Text  := IntToStr(FnChan);
    Edit11.Text  := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].sName;
    Panel3.Color := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.getSelectedTrack[fnPar].Color;
  end
  else
  begin
    Edit1.Text   := self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].sPodp;
    Edit2.Text   := self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].sEdIzm;
    Edit3.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].diaMin));
    Edit4.Text   := Trim(floatToStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].diaMax));
    Edit5.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].xLogSize);
    Edit6.Text   := TDEPgraphDescribe.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].xLogStep);
    Edit9.Text   := IntToStr(self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].Precision);
    Edit10.Text  := IntToStr(FnChan);
    Edit11.Text  := self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].sName;
    Panel3.Color := self.fDEPgrafJob.DEPGrhDescr.listGrfS[j1].Color;
  end;

  finfjDscr;
  findjChnl;
end;

end.
