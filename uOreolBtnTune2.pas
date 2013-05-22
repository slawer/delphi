unit uOreolBtnTune2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  upf2, uMainData, uMainConst, uOreolBtnTune2const, StdCtrls, Buttons,
  uOreolButton2data,
  ExtCtrls, Grids;

type
  TOreolBtnTune2 = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    fbFirst: Boolean;

    ParamNew: prqTODButton2Par1;
    procedure ParamInit;

  public
    { Public declarations }
    Param: prqTODButton2Par1;
    bExit: Boolean;
  end;

implementation

{$R *.dfm}

procedure TOreolBtnTune2.FormCreate(Sender: TObject);
begin
  jUniType := pc003_120_jMain;
  Caption  := pc003_120_Caption;
  bNotSaveParam := True;
  fbFirst  := True;
  bExit    := False;
  ParamNew := prqTODButton2Par1.Create;
end;

procedure TOreolBtnTune2.FormActivate(Sender: TObject);
begin
  if fbFirst then
  begin
    ParamInit;
    fbFirst := False;
  end;
end;

procedure TOreolBtnTune2.BitBtn1Click(Sender: TObject);
begin
  if not ParamNew.tranStringGrid(StringGrid1) then Exit;

  Param.Count := 0;
  Param.AppendClass(ParamNew);
  bExit  := True;
  Close;
end;

procedure TOreolBtnTune2.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TOreolBtnTune2.ParamInit;
begin
  ParamNew.Count := 0;
  ParamNew.AppendClass(Param);
  ParamNew.signStringGrid(StringGrid1);
  ParamNew.fillStringGrid(StringGrid1);
end;

procedure TOreolBtnTune2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ParamNew.Free;
  inherited;
end;

end.
