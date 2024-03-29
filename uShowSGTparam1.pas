unit uShowSGTparam1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  uPf2, uShowSGTparam1const, uDEPdescript2, uEdtSGTparam1, uMainData,
  Grids, ExtCtrls, StdCtrls, Buttons;

type
  TcShowSGTparam1 = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    StringGrid1: TStringGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    bLast: Boolean;
    fBlockWorking:   prqTBlockRsrc;
    fjobDEP: TDEPdepParam; // ������� �� ������
    fjobSGT: TDEPsgtParam; // ������� �� ������
    fEdtRow: Integer;
    bitCaption: string; // ��������� ����� ������ ��������������
  public
    { Public declarations }
    procedure CreateIMG(jobDep: TDEPdepParam; jobSGT: TDEPsgtParam; BlockWorking: prqTBlockRsrc);
    function  findSGTParam(jRow: Integer): Integer;
    procedure showSGTRowIMG(jRow, jParSGT: Integer);
    function showSGTRowTXT(jParSGT: Integer): string;
    function showDEPRowTXT(jParSGT: Integer): string;
  end;

implementation
uses
  uSupport;

{$R *.dfm}

{ TOreolShowTabParam1 }

procedure TcShowSGTparam1.CreateIMG(jobDep: TDEPdepParam; jobSGT: TDEPsgtParam; BlockWorking: prqTBlockRsrc);
var
  jCrow: Integer;
begin
// ��������� �������
  prqClearGrid(StringGrid1);
  prqSubscribeGridCol(StringGrid1, [pc005_104_01, pc005_104_02, pc005_104_03, pc005_104_04, pc005_104_05]);

  fBlockWorking := BlockWorking;
  fjobDEP := jobDEP;
  fjobSGT := jobSGT;

  if fjobSGT.Count = 0 then Exit;

  StringGrid1.RowCount := fjobSGT.Count + 1;
  for jCrow := 1 to fjobSGT.Count do
  begin
    showSGTRowIMG(jCrow, jCrow);
  end;
  setALlGridColWidth(StringGrid1, pc005_104_eps);
end;

procedure TcShowSGTparam1.FormCreate(Sender: TObject);
begin
  inherited;
  jUniType   := pc005_104_jMain;
  Caption    := pc005_104_Caption;
  fEdtRow    := 0;
  bitCaption := Trim(self.BitBtn2.Caption) + ' ';
end;

procedure TcShowSGTparam1.Panel1Resize(Sender: TObject);
begin
  Exit;
  StringGrid1.ColWidths[1] := StringGrid1.ClientWidth - StringGrid1.ColWidths[0] -
                              StringGrid1.ColWidths[2] - 4;
end;

procedure TcShowSGTparam1.FormShow(Sender: TObject);
begin
  if bLast then Exit;
  bLast := True;
  Panel1Resize(Self);
end;

procedure TcShowSGTparam1.BitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TcShowSGTparam1.BitBtn2Click(Sender: TObject);
var
  pDF: TcEdtSGTparam1;
begin
  inherited;
  if fBlockWorking.isBlockRsrc then
  begin
    ShowMessage(pc005_104_005);
    Exit;
  end;

  try
    fEdtRow := findSGTParam(self.StringGrid1.Selection.Top);
    if fEdtRow <= 0 then
    begin
      ShowMessage(pc005_104_001);
      Exit;
    end;

    pDF := TcEdtSGTparam1.Create(nil);
    try
      pDF.taskParam := taskParam;
      registryObj(taskParam, pDF.jUniKeySelf, jUniKeySelf, pDF.jUniType, pDF);
      pDF.bTag  := True;
      pDF.bGeom := True;
      pDF.getParam;

      pDF.RowNumber := self.fEdtRow;
      pDF.jobDEP    := self.fjobDEP;
      pDF.jobSGT    := self.fjobSGT;
      pDF.ShowDEPRow;
      pDF.ShowModal;
      self.showSGTRowIMG(self.StringGrid1.Selection.Top, fEdtRow);
      setALlGridColWidth(StringGrid1, pc005_104_eps);
    finally
      pDF.Free;
    end;
  finally
    fBlockWorking.bBlockRsrc := false;
  end;
end;

procedure TcShowSGTparam1.StringGrid1Click(Sender: TObject);
begin
  inherited;
  fEdtRow := findSGTParam(self.StringGrid1.Selection.Top);
  if fEdtRow > 0 then
  begin
    self.BitBtn2.Caption := bitCaption + IntToStr( fEdtRow );
  end
  else
  begin
    self.BitBtn2.Caption := bitCaption;
  end;
end;

function TcShowSGTparam1.findSGTParam(jRow: Integer): Integer;
begin
  result := 0;
  if (jRow < 1)  or  (jRow > self.fjobSGT.Count) then Exit;
  result := StrToInt(self.StringGrid1.Cells[0, jRow]);
end;

procedure TcShowSGTparam1.showSGTRowIMG(jRow, jParSGT: Integer);
var
  jN: Integer;
  rcd: rcdDEPdepParam;
begin
  StringGrid1.Cells[0, jRow] := IntToStr(fjobSGT[jParSGT].SGTparNum);
  StringGrid1.Cells[1, jRow] := fjobSGT[jParSGT].SGTparNameBig;
  StringGrid1.Cells[2, jRow] := fjobSGT[jParSGT].SGTparNameShrt;
  StringGrid1.Cells[3, jRow] := IntToStr(fjobSGT[jParSGT].DEPparNum);
  rcd.DEPparNum := fjobSGT[jParSGT].DEPparNum;
  jN := fjobDEP.Find(@rcd, 1);
  if jN > 0 then
  begin
    StringGrid1.Cells[4, jRow] := fjobDEP[jN].SGTparNameBig;
  end
  else
  begin
    StringGrid1.Cells[4, jRow] := '';
  end;
end;

procedure TcShowSGTparam1.FormActivate(Sender: TObject);
begin
  inherited;
  StringGrid1Click(Sender);
end;

function TcShowSGTparam1.showSGTRowTXT(jParSGT: Integer): string;
begin
  result := format(pc005_104_004, [fjobSGT[jParSGT].SGTparNum, fjobSGT[jParSGT].SGTparNameBig]);
end;

function TcShowSGTparam1.showDEPRowTXT(jParSGT: Integer): string;
var
  jN: Integer;
  rcd: rcdDEPdepParam;
begin
  result := format(pc005_104_002, [fjobSGT[jParSGT].SGTparNum]);
  rcd.DEPparNum := fjobSGT[jParSGT].DEPparNum;
  jN := fjobDEP.Find(@rcd, 1);
  if jN > 0 then
  begin
    result := result + ' ' + fjobDEP[jN].SGTparNameBig;
  end
  else
  begin
    result := result + ' ' + pc005_104_003;
  end;
end;

end.
