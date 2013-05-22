unit uDBVreportQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  uCalendar1, uDBVreportQueryConst, uDEPdescript2, uDEPgrafJob2, uGrafTune2,
  uGraphPatterns1, CheckLst, uSGTlibDB1, uOreolProtocol6;

type
  TcDBVreportQuery = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    BitBtn3: TBitBtn;
    ColorDialog1: TColorDialog;
    Panel7: TPanel;
    BitBtn5: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    BitBtn4: TBitBtn;
    Edit8: TEdit;
    Edit7: TEdit;
    Edit6: TEdit;
    Edit5: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    Label34: TLabel;
    Edit24: TEdit;
    Label36: TLabel;
    Edit25: TEdit;
    TabSheet5: TTabSheet;
    Panel3: TPanel;
    BitBtn6: TBitBtn;
    Edit13: TEdit;
    Edit12: TEdit;
    Edit9: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Edit11: TEdit;
    Label11: TLabel;
    Edit10: TEdit;
    Label17: TLabel;
    Edit14: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
  private
    bMin, bHour, bYear, bMonth, bDay: Integer; bdDate, bdHour, bdMin: TDateTime;
    eMin, eHour, eYear, eMonth, eDay: Integer; edDate, edHour, edMin: TDateTime;
    sYear, sMonth, sDay: Integer; sdDate{, sdHour, sdMin}: TDateTime;

//    pageDescr:  TDEPpageDescr;
//    grapDescr:  TDEPgraphDescr;

    fDEPgrafJob:  TDEPgrafJob1;

    function  QueryReportCheck: boolean;
    procedure saveQueryParam;

    { Private declarations }
  public
    procedure CreateIMG(DEPgrafJob:  TDEPgrafJob1);
    { Public declarations }
  end;

implementation
uses uSupport;

{$R *.dfm}

procedure TcDBVreportQuery.BitBtn4Click(Sender: TObject);
var
  clndr: TcCalendar1;
  dT: TDateTime;
  Year, Month, Day: Word;
begin
  inherited;
  clndr := TcCalendar1.Create(self);
  try
    clndr.MonthCalendar1.Date := Date - 1;
    clndr.ShowModal;
    if clndr.bFinish then
    begin
      dT := clndr.MonthCalendar1.Date;
      DecodeDate(dT, Year, Month, Day);
      self.Edit5.Text := IntToStr( Day );
      self.Edit6.Text := IntToStr( Month );
      self.Edit7.Text := IntToStr( Year );
      dT := dT + 1; // Начало следующих суток
      DecodeDate(dT, Year, Month, Day);
      self.Edit4.Text := IntToStr( Day );
      self.Edit3.Text := IntToStr( Month );
      self.Edit2.Text := IntToStr( Year );
    end;
  finally
    clndr.Free;
  end;
end;

procedure TcDBVreportQuery.BitBtn5Click(Sender: TObject);
var
  clndr: TcCalendar1;
  dT: TDateTime;
  Year, Month, Day: Word;
begin
  inherited;
  clndr := TcCalendar1.Create(self);
  try
    clndr.MonthCalendar1.Date := Date - 1;
    clndr.ShowModal;
    if clndr.bFinish then
    begin
      dT := clndr.MonthCalendar1.Date;
      DecodeDate(dT, Year, Month, Day);
      self.Edit4.Text := IntToStr( Day );
      self.Edit3.Text := IntToStr( Month );
      self.Edit2.Text := IntToStr( Year );
    end;
  finally
    clndr.Free;
  end;
end;

function TcDBVreportQuery.QueryReportCheck: boolean;
begin
  result := false;

  if not uSupport.prqStrToInt(Trim(self.Edit5.Text), bDay) then
  begin
    ShowMessage(pc006_104_1101);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit6.Text), bMonth) then
  begin
    ShowMessage(pc006_104_1102);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit7.Text), bYear) then
  begin
    ShowMessage(pc006_104_1103);
    Exit;
  end;

  if not TryEncodeDate(bYear, bMonth, bDay, bdDate) then
  begin
    ShowMessage(pc006_104_1104);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit8.Text), bHour) then
  begin
    ShowMessage(pc006_104_1105);
    Exit;
  end;
  if (bHour < 0) or (bHour >= 24) then
  begin
    ShowMessage(pc006_104_1105);
    Exit;
  end;
  bdHour := bHour; bdHour := bdHour / 24;

  if not uSupport.prqStrToInt(Trim(self.Edit24.Text), bMin) then
  begin
    ShowMessage(pc006_104_1106);
    Exit;
  end;
  if (bMin < 0) or (bMin >= 60) then
  begin
    ShowMessage(pc006_104_1106);
    Exit;
  end;
  bdMin := bMin; bdMin := bdMin / (24 * 60);

  if not uSupport.prqStrToInt(Trim(self.Edit4.Text), eDay) then
  begin
    ShowMessage(pc006_104_1111);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit3.Text), eMonth) then
  begin
    ShowMessage(pc006_104_1112);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit2.Text), eYear) then
  begin
    ShowMessage(pc006_104_1113);
    Exit;
  end;

  if not TryEncodeDate(eYear, eMonth, eDay, edDate) then
  begin
    ShowMessage(pc006_104_1114);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit1.Text), eHour) then
  begin
    ShowMessage(pc006_104_1115);
    Exit;
  end;
  if (eHour < 0) or (eHour > 24) then
  begin
    ShowMessage(pc006_104_1115);
    Exit;
  end;
  edHour := eHour; edHour := edHour / 24;

  if not uSupport.prqStrToInt(Trim(self.Edit25.Text), eMin) then
  begin
    ShowMessage(pc006_104_1118);
    Exit;
  end;
  if (eHour < 0) or (eHour > 60) then
  begin
    ShowMessage(pc006_104_1118);
    Exit;
  end;
  edMin := eMin; edMin := edMin / (24 * 60);

  if (edDate + edHour + edMin) <= (bdDate + bdHour + bdMin) then
  begin
    ShowMessage(pc006_104_1116);
    Exit;
  end;
  if ((edDate + edHour + edMin) - (bdDate + bdHour + bdMin)) > 1 then
  begin
    ShowMessage(pc006_104_1117);
    Exit;
  end;


  if not uSupport.prqStrToInt(Trim(self.Edit9.Text), sDay) then
  begin
    ShowMessage(pc006_104_1107);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit12.Text), sMonth) then
  begin
    ShowMessage(pc006_104_1108);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit13.Text), sYear) then
  begin
    ShowMessage(pc006_104_1109);
    Exit;
  end;

  if not TryEncodeDate(sYear, sMonth, sDay, sdDate) then
  begin
    ShowMessage(pc006_104_1120);
    Exit;
  end;
  if (edDate + edHour + edMin) <= sdDate then
  begin
    ShowMessage(pc006_104_1124);
    Exit;
  end;

  result := true;
end;

procedure TcDBVreportQuery.BitBtn3Click(Sender: TObject);
begin
  inherited;
  if not QueryReportCheck() then
  begin
    Exit;
  end;

// Сохранить настройки
  saveQueryParam;

  fDEPgrafJob.DOit := false;
  Close;
end;

procedure TcDBVreportQuery.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if not QueryReportCheck then
  begin
    Exit;
  end;

// Сохранить настройки
  saveQueryParam;

  fDEPgrafJob.DOit := true;
  Close;
end;

procedure TcDBVreportQuery.CreateIMG(DEPgrafJob:  TDEPgrafJob1);
begin
  self.fDEPgrafJob := DEPgrafJob;
  self.fDEPgrafJob.DOit := false;
end;

procedure TcDBVreportQuery.saveQueryParam;
begin
  self.fDEPgrafJob.DEPqueParam.dBeg := self.bdDate + self.bdHour + self.bdMin;
  self.fDEPgrafJob.DEPqueParam.dEnd := self.edDate + self.edHour + self.edMin;
  self.fDEPgrafJob.DEPqueParam.dStart := self.sdDate;
  self.fDEPgrafJob.DEPqueParam.Zakaz := Trim(self.Edit10.Text);
  self.fDEPgrafJob.DEPqueParam.Podrjad := Trim(self.Edit11.Text);
  self.fDEPgrafJob.DEPqueParam.Station := Trim(self.Edit14.Text);

  self.fDEPgrafJob.Modify := true;

//  self.fDEPgrafJob.DEPGrhDescr.Graphiks.Clone(self.grapDescr);
//  self.fDEPgrafJob.DEPGrhDescr.Pages.Clone(self.pageDescr);
end;

procedure TcDBVreportQuery.FormCreate(Sender: TObject);
begin
  inherited;
  jUniType   := pc006_104_jMain;
  Caption    := pc006_104_Caption;
//  pageDescr  := TDEPpageDescr.Create;
//  grapDescr  := TDEPgraphDescr.Create;
end;

procedure TcDBVreportQuery.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  pageDescr.Free;
//  grapDescr.Free;
end;

procedure TcDBVreportQuery.BitBtn6Click(Sender: TObject);
var
  clndr: TcCalendar1;
  dT: TDateTime;
  Year, Month, Day: Word;
begin
  inherited;
  clndr := TcCalendar1.Create(self);
  try
    clndr.MonthCalendar1.Date := Date();
    clndr.ShowModal;
    if clndr.bFinish then
    begin
      dT := clndr.MonthCalendar1.Date;
      DecodeDate(dT, Year, Month, Day);
      self.Edit9.Text := IntToStr( Day );
      self.Edit12.Text := IntToStr( Month );
      self.Edit13.Text := IntToStr( Year );
    end;
  finally
    clndr.Free;
  end;
end;

end.
