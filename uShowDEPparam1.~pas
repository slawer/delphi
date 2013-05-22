unit uShowDEPparam1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  uPf2, uShowDEPparam1const, uDEPdescript2,
  Grids, ExtCtrls, StdCtrls, Buttons;

type
  TcShowDEPparam1 = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    StringGrid1: TStringGrid;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    bLast: Boolean;
    fjob: TDEPdepParam; // Задание на работу
  public
    { Public declarations }
    procedure CreateIMG(job: TDEPdepParam);
  end;

implementation
uses
  uSupport;

{$R *.dfm}

{ TOreolShowTabParam1 }

procedure TcShowDEPparam1.CreateIMG(job: TDEPdepParam);
var
  jCrow: Integer;
begin
// Настроить таблицу
  prqClearGrid(StringGrid1);
  prqSubscribeGridCol(StringGrid1, [pc005_103_01, pc005_103_02, pc005_103_03]);

  fjob := job;

  if fjob.Count = 0 then Exit;

  StringGrid1.RowCount := fjob.Count + 1;
  for jCrow := 1 to fjob.Count do
  begin
    if fjob[jCrow].bSaveDB then
    begin
      StringGrid1.Cells[0, jCrow] := IntToStr(fjob[jCrow].DEPparNum);
      StringGrid1.Cells[1, jCrow] := fjob[jCrow].SGTparNameBig;
      StringGrid1.Cells[2, jCrow] := fjob[jCrow].SGTparNameType;
    end
    else
    begin
      StringGrid1.Cells[0, jCrow] := IntToStr(fjob[jCrow].DEPparNum);
      StringGrid1.Cells[1, jCrow] := fjob[jCrow].SGTparNameBig;
      StringGrid1.Cells[2, jCrow] := pc005_103_04;
    end;
  end;
  setALlGridColWidth(StringGrid1, pc005_103_eps);
end;

procedure TcShowDEPparam1.FormCreate(Sender: TObject);
begin
  jUniType   := pc005_103_jMain;
  Caption    := pc005_103_Caption;
end;

procedure TcShowDEPparam1.Panel1Resize(Sender: TObject);
begin
  Exit;
  StringGrid1.ColWidths[1] := StringGrid1.ClientWidth - StringGrid1.ColWidths[0] -
                              StringGrid1.ColWidths[2] - 4;
end;

procedure TcShowDEPparam1.FormShow(Sender: TObject);
begin
  if bLast then Exit;
  bLast := True;
  Panel1Resize(Self);
end;

procedure TcShowDEPparam1.BitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
