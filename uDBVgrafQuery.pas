unit uDBVgrafQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  uCalendar1, uDBVgrafQueryConst, uDEPdescript2, uDEPgrafJob2, uGrafTune2,
  uGraphPatterns1, CheckLst, uSGTlibDB1, uOreolProtocol6;

type
  TcDBVgrafQuery = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    BitBtn3: TBitBtn;
    Panel9: TPanel;
    CheckBox9: TCheckBox;
    BitBtn14: TBitBtn;
    CheckBox10: TCheckBox;
    BitBtn15: TBitBtn;
    CheckBox11: TCheckBox;
    BitBtn16: TBitBtn;
    CheckBox12: TCheckBox;
    BitBtn17: TBitBtn;
    CheckBox13: TCheckBox;
    BitBtn18: TBitBtn;
    TabSheet3: TTabSheet;
    Panel12: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label35: TLabel;
    Panel13: TPanel;
    Panel10: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Panel11: TPanel;
    Edit11: TEdit;
    TabSheet4: TTabSheet;
    Panel5: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label37: TLabel;
    Panel6: TPanel;
    Edit9: TEdit;
    Edit20: TEdit;
    Panel4: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Edit10: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit19: TEdit;
    Edit21: TEdit;
    ColorDialog1: TColorDialog;
    Label29: TLabel;
    Edit22: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit18: TEdit;
    Panel3: TPanel;
    Label30: TLabel;
    ComboBox1: TComboBox;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    TabControl1: TTabControl;
    CheckBox1: TCheckBox;
    Shape1: TShape;
    CheckBox2: TCheckBox;
    Label31: TLabel;
    Edit23: TEdit;
    Label32: TLabel;
    CheckBox3: TCheckBox;
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
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
    procedure Panel11Click(Sender: TObject);
    procedure Panel13Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabControl1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
  private
    bMin, bHour, bYear, bMonth, bDay: Integer; bdDate, bdHour, bdMin: TDateTime;
    eMin, eHour, eYear, eMonth, eDay: Integer; edDate, edHour, edMin: TDateTime;

    pageDescr:  TDEPpageDescr;
    grapDescr:  TDEPgraphDescr;

    fDEPgrafJob:  TDEPgrafJob1;

    FcSelectList: TGraphListPattern; // Шаблон, выбранный для исполнения
    FcSelectTrac: TTrackPattern; // Трек шаблона, выбранный для показа

    function  QueryReportCheck: boolean;
    procedure saveQueryParam();
    procedure setChoiseParam(Chanal: Integer);
    function  getCheckBox(Chanal: Integer): TCheckBox;
    function  getBitBtn(Chanal: Integer): TBitBtn;

    procedure clearList(chl: TCheckListBox);
    procedure setList(chl: TCheckListBox);

    { Private declarations }
  public
    procedure CreateIMG(DEPgrafJob:  TDEPgrafJob1);
    procedure tuningGraf(numGraf: integer);
    { Public declarations }
  end;

implementation
uses uSupport;

{$R *.dfm}

procedure TcDBVgrafQuery.BitBtn4Click(Sender: TObject);
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
      self.Edit5.Text := IntToStr( Day );
      self.Edit6.Text := IntToStr( Month );
      self.Edit7.Text := IntToStr( Year );
    end;
  finally
    clndr.Free;
  end;
end;

procedure TcDBVgrafQuery.BitBtn5Click(Sender: TObject);
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
      self.Edit4.Text := IntToStr( Day );
      self.Edit3.Text := IntToStr( Month );
      self.Edit2.Text := IntToStr( Year );
    end;
  finally
    clndr.Free;
  end;
end;

function TcDBVgrafQuery.QueryReportCheck: boolean;
var
  dRes: Double;
begin
  result := false;

  if not uSupport.prqStrToInt(Trim(self.Edit5.Text), bDay) then
  begin
    ShowMessage(pc006_101_1101);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit6.Text), bMonth) then
  begin
    ShowMessage(pc006_101_1102);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit7.Text), bYear) then
  begin
    ShowMessage(pc006_101_1103);
    Exit;
  end;

  if not TryEncodeDate(bYear, bMonth, bDay, bdDate) then
  begin
    ShowMessage(pc006_101_1104);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit8.Text), bHour) then
  begin
    ShowMessage(pc006_101_1105);
    Exit;
  end;
  if (bHour < 0) or (bHour >= 24) then
  begin
    ShowMessage(pc006_101_1105);
    Exit;
  end;
  bdHour := bHour; bdHour := bdHour / 24;

  if not uSupport.prqStrToInt(Trim(self.Edit24.Text), bMin) then
  begin
    ShowMessage(pc006_101_1106);
    Exit;
  end;
  if (bMin < 0) or (bMin >= 60) then
  begin
    ShowMessage(pc006_101_1106);
    Exit;
  end;
  bdMin := bMin; bdMin := bdMin / (24 * 60);

  if not uSupport.prqStrToInt(Trim(self.Edit4.Text), eDay) then
  begin
    ShowMessage(pc006_101_1111);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit3.Text), eMonth) then
  begin
    ShowMessage(pc006_101_1112);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit2.Text), eYear) then
  begin
    ShowMessage(pc006_101_1113);
    Exit;
  end;

  if not TryEncodeDate(eYear, eMonth, eDay, edDate) then
  begin
    ShowMessage(pc006_101_1114);
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit1.Text), eHour) then
  begin
    ShowMessage(pc006_101_1115);
    Exit;
  end;
  if (eHour < 0) or (eHour > 24) then
  begin
    ShowMessage(pc006_101_1115);
    Exit;
  end;
  edHour := eHour; edHour := edHour / 24;

  if not uSupport.prqStrToInt(Trim(self.Edit25.Text), eMin) then
  begin
    ShowMessage(pc006_101_1118);
    Exit;
  end;
  if (eHour < 0) or (eHour > 60) then
  begin
    ShowMessage(pc006_101_1118);
    Exit;
  end;
  edMin := eMin; edMin := edMin / (24 * 60);

  if (edDate + edHour + edMin) <= (bdDate + bdHour + bdMin) then
  begin
    ShowMessage(pc006_101_1116);
    Exit;
  end;
  if ((edDate + edHour + edMin) - (bdDate + bdHour + bdMin)) > 2 then
  begin
    ShowMessage(pc006_101_1117);
    Exit;
  end;


  if not TDEPgrafJob1._CheckDouble(Trim(self.Edit10.Text), dRes) then
  begin
    ShowMessage(format(pc006_101_1110, [Label15.Caption]));
    Exit;
  end;
  pageDescr.Height := Round(dRes * 10);

  if not TDEPgrafJob1._CheckDouble(Trim(self.Edit15.Text), dRes) then
  begin
    ShowMessage(format(pc006_101_1110, [Label16.Caption]));
    Exit;
  end;
  pageDescr.Width := Round(dRes * 10);

  if not TDEPgrafJob1._CheckDouble(Trim(self.Edit16.Text), dRes) then
  begin
    ShowMessage(format(pc006_101_1110, [Label25.Caption]));
    Exit;
  end;
  pageDescr.shiftLeft := Round(dRes * 10);

  if not TDEPgrafJob1._CheckDouble(Trim(self.Edit17.Text), dRes) then
  begin
    ShowMessage(format(pc006_101_1110, [Label26.Caption]));
    Exit;
  end;
  pageDescr.shiftRight := Round(dRes * 10);

  if not TDEPgrafJob1._CheckDouble(Trim(self.Edit19.Text), dRes) then
  begin
    ShowMessage(format(pc006_101_1110, [Label27.Caption]));
    Exit;
  end;
  pageDescr.shiftTop := Round(dRes * 10);

  if not TDEPgrafJob1._CheckDouble(Trim(self.Edit21.Text), dRes) then
  begin
    ShowMessage(format(pc006_101_1110, [Label28.Caption]));
    Exit;
  end;
  pageDescr.shiftBottom := Round(dRes * 10);

  pageDescr.ramColor := self.Panel6.Color;

  if not TDEPgrafJob1._CheckDouble(Trim(self.Edit9.Text), dRes) then
  begin
    ShowMessage(format(pc006_101_1110, [Label13.Caption]));
    Exit;
  end;
  pageDescr.ramWidth := Round(dRes * 10);

  if not uSupport.prqStrToInt(Trim(self.Edit20.Text), pageDescr.sizeZGL) then
  begin
    ShowMessage(format(pc006_101_1110, [Label37.Caption]));
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit22.Text), pageDescr.sizeTOUT) then
  begin
    ShowMessage(format(pc006_101_1110, [Label29.Caption]));
    Exit;
  end;

  grapDescr.ramColor := self.Panel11.Color;

  if not TDEPgrafJob1._CheckDouble(Trim(self.Edit11.Text), dRes) then
  begin
    ShowMessage(format(pc006_101_1110, [Label19.Caption]));
    Exit;
  end;
  grapDescr.ramWidth := Round(dRes * 10);

  if not uSupport.prqStrToInt(Trim(self.Edit23.Text), grapDescr.fnSize) then
  begin
    ShowMessage(format(pc006_101_1110, [Label32.Caption]));
    Exit;
  end;

  grapDescr.bSignScaleVal := self.CheckBox3.Checked;

  grapDescr.netColor := self.Panel13.Color;

  if not TDEPgrafJob1._CheckDouble(Trim(self.Edit12.Text), dRes) then
  begin
    ShowMessage(format(pc006_101_1110, [Label22.Caption]));
    Exit;
  end;
  grapDescr.netWidth := Round(dRes * 10);

  if not TDEPgrafJob1._CheckDouble(Trim(self.Edit13.Text), dRes) then
  begin
    ShowMessage(format(pc006_101_1110, [Label23.Caption]));
    Exit;
  end;
  grapDescr.netYStep := Round(dRes * 10);

  if not uSupport.prqStrToInt(Trim(self.Edit14.Text), grapDescr.cntXStep) then
  begin
    ShowMessage(format(pc006_101_1110, [Label24.Caption]));
    Exit;
  end;

  if not uSupport.prqStrToInt(Trim(self.Edit18.Text), grapDescr.TSclSize) then
  begin
    ShowMessage(format(pc006_101_1110, [Label35.Caption]));
    Exit;
  end;

  result := true;
end;

procedure TcDBVgrafQuery.BitBtn3Click(Sender: TObject);
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

procedure TcDBVgrafQuery.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if not QueryReportCheck then
  begin
    Exit;
  end;

// Сохранить настройки
  saveQueryParam;

// указать признак запроса
  if not self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.isActiveGraph then
  begin
    ShowMessage(pc006_101_1121);
    Exit;
  end;

  fDEPgrafJob.DOit := true;
  Close;
end;

procedure TcDBVgrafQuery.CreateIMG(DEPgrafJob:  TDEPgrafJob1);
var
  jN, jC1: integer;
  c1: TGraphListPattern;
begin
  self.fDEPgrafJob := DEPgrafJob;
  self.fDEPgrafJob.DOit := false;
// Заполнение формы значениями

// Страница
  self.Edit10.Text   := self.fDEPgrafJob.DEPGrhDescr.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Pages.Height);
  self.Edit15.Text   := self.fDEPgrafJob.DEPGrhDescr.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Pages.Width);
  self.Edit16.Text   := self.fDEPgrafJob.DEPGrhDescr.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Pages.shiftLeft);
  self.Edit17.Text   := self.fDEPgrafJob.DEPGrhDescr.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Pages.shiftRight);
  self.Edit19.Text   := self.fDEPgrafJob.DEPGrhDescr.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Pages.shiftTop);
  self.Edit21.Text   := self.fDEPgrafJob.DEPGrhDescr.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Pages.shiftBottom);
   self.Edit9.Text   := self.fDEPgrafJob.DEPGrhDescr.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Pages.ramWidth);
  self.Edit20.Text   :=                                  IntToStr(self.fDEPgrafJob.DEPGrhDescr.Pages.sizeZGL);
  self.Edit22.Text   :=                                  IntToStr(self.fDEPgrafJob.DEPGrhDescr.Pages.sizeTOUT);
  self.Panel6.Color  :=                                           self.fDEPgrafJob.DEPGrhDescr.Pages.ramColor;

// Область графики
  self.Panel13.Color :=                                           self.fDEPgrafJob.DEPGrhDescr.Graphiks.netColor;
  self.Panel11.Color :=                                           self.fDEPgrafJob.DEPGrhDescr.Graphiks.ramColor;
  self.Edit12.Text   := self.fDEPgrafJob.DEPGrhDescr.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Graphiks.netWidth);
  self.Edit13.Text   := self.fDEPgrafJob.DEPGrhDescr.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Graphiks.netYStep);
  self.Edit14.Text   :=                                  IntToStr(self.fDEPgrafJob.DEPGrhDescr.Graphiks.cntXStep);
  self.Edit11.Text   := self.fDEPgrafJob.DEPGrhDescr.jValueToDStr(self.fDEPgrafJob.DEPGrhDescr.Graphiks.ramWidth);
  self.Edit18.Text   :=                                  IntToStr(self.fDEPgrafJob.DEPGrhDescr.Graphiks.TSclSize);
  self.Edit23.Text   :=                                  IntToStr(self.fDEPgrafJob.DEPGrhDescr.Graphiks.fnSize);
  self.CheckBox3.Checked := self.fDEPgrafJob.DEPGrhDescr.Graphiks.bSignScaleVal;

// список шаблонов
  self.ComboBox1.Clear;

  if self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.Count = 0 then
  begin
     jN := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.addEmptyPattern;
     c1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.GetObjPnt(jN);
     c1.active := true;
  end;

  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern := 0;
  for jC1 := 1 to self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.Count do
  begin
    c1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.GetObjPnt(jC1);
    if c1 = nil then continue;
    c1.SelectedTrack := 1;
    self.ComboBox1.Items.Add(c1.name);
    if c1.active then
    begin
      self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern := jC1;
    end;
  end;

  if self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern = 0 then
  begin
    self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern := 1;
    c1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.GetObjPnt(1);
    c1.active := true;
  end;

  self.ComboBox1.ItemIndex := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern - 1;
  self.TabControl1.TabIndex := 0;

  c1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.GetObjPnt(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern);
  self.FcSelectList := c1;
  self.FcSelectTrac := c1[c1.SelectedTrack].ukz as TTrackPattern;
  self.FcSelectTrac.Select := true;

  self.CheckBox1.Checked := self.FcSelectTrac.active;

// Список параметров
  setChoiseParam(1);
  setChoiseParam(2);
  setChoiseParam(3);
  setChoiseParam(4);
  setChoiseParam(5);
end;

procedure TcDBVgrafQuery.saveQueryParam;
begin
  self.fDEPgrafJob.DEPqueParam.dBeg := bdDate + bdHour + bdMin;
  self.fDEPgrafJob.DEPqueParam.dEnd := edDate + edHour + edMin;
  self.fDEPgrafJob.Modify := true;
  self.FcSelectTrac[1].active := self.CheckBox9.Checked;
  self.FcSelectTrac[2].active := self.CheckBox10.Checked;
  self.FcSelectTrac[3].active := self.CheckBox11.Checked;
  self.FcSelectTrac[4].active := self.CheckBox12.Checked;
  self.FcSelectTrac[5].active := self.CheckBox13.Checked;

  self.FcSelectTrac.active := self.CheckBox1.Checked;

  self.fDEPgrafJob.DEPGrhDescr.Graphiks.Clone(self.grapDescr);
  self.fDEPgrafJob.DEPGrhDescr.Pages.Clone(self.pageDescr);
end;

procedure TcDBVgrafQuery.BitBtn14Click(Sender: TObject);
begin
  inherited;
  self.FcSelectTrac[1].active := self.CheckBox9.Checked;
  tuningGraf(1);
end;

procedure TcDBVgrafQuery.BitBtn15Click(Sender: TObject);
begin
  inherited;
  self.FcSelectTrac[2].active := self.CheckBox10.Checked;
  tuningGraf(2);
end;

procedure TcDBVgrafQuery.BitBtn16Click(Sender: TObject);
begin
  inherited;
  self.FcSelectTrac[3].active := self.CheckBox11.Checked;
  tuningGraf(3);
end;

procedure TcDBVgrafQuery.BitBtn17Click(Sender: TObject);
begin
  inherited;
  self.FcSelectTrac[4].active := self.CheckBox12.Checked;
  tuningGraf(4);
end;

procedure TcDBVgrafQuery.BitBtn18Click(Sender: TObject);
begin
  inherited;
  self.FcSelectTrac[5].active := self.CheckBox13.Checked;
  tuningGraf(5);
end;

procedure TcDBVgrafQuery.tuningGraf(numGraf: integer);
var
  pDD: TcGrafTune2;
begin
// Создать диалог

  pDD := TcGrafTune2.Create(self);
  try
    pDD.taskParam := self.taskParam;
    pDD.bMustSave := true;
    pDD.bTag  := True;
    pDD.bGeom := True;
    pDD.getParam;

    pDD.TuneForms(fDEPgrafJob, self.fDEPgrafJob.AddQueParam(numGraf, self.FcSelectTrac) );
    pDD.ShowModal;

    if not pDD.bUpdate then Exit;

    setChoiseParam(numGraf);

  finally
    pDD.Free;
  end;
end;

procedure TcDBVgrafQuery.Panel6Click(Sender: TObject);
begin
  inherited;
  if self.ColorDialog1.Execute then self.Panel6.Color := self.ColorDialog1.Color;
end;

procedure TcDBVgrafQuery.Panel11Click(Sender: TObject);
begin
  inherited;
  if self.ColorDialog1.Execute then self.Panel11.Color := self.ColorDialog1.Color;
end;

procedure TcDBVgrafQuery.Panel13Click(Sender: TObject);
begin
  inherited;
  if self.ColorDialog1.Execute then self.Panel13.Color := self.ColorDialog1.Color;
end;

procedure TcDBVgrafQuery.setChoiseParam(Chanal: Integer);
var
  rcdGRF: rcdTrackPattern;
  j1: integer;
  CheckBox: TCheckBox; BitButton: TBitBtn;
begin
// Выбранный шаблон в self.FcSelectList
// Выбранный трек в self.TabControl1.TabIndex

  CheckBox := self.getCheckBox(Chanal);
  BitButton := self.getBitBtn(Chanal);

  j1 := self.fDEPgrafJob.AddQueParam(Chanal, self.FcSelectTrac);

  rcdGRF.nChanal := self.FcSelectTrac[j1].nChanal;
  if rcdGRF.nChanal < 0 then
  begin
    CheckBox.Checked := false;
    CheckBox.Enabled := false;
    CheckBox.Caption     := format(pc006_101_1202, [Chanal]);
    self.FcSelectTrac[j1].active := false;
    Exit;
  end;

  CheckBox.Checked := true;
  CheckBox.Enabled := true;

  CheckBox.Font.Color  := self.FcSelectTrac[j1].Color;
  CheckBox.Caption     := format(pc006_101_1201,
                           [self.FcSelectTrac[j1].sPodp,
                            self.FcSelectTrac[j1].nChanal]);
  BitButton.Font.Color := self.FcSelectTrac[j1].Color;
  CheckBox.Checked := self.FcSelectTrac[j1].active;
end;

procedure TcDBVgrafQuery.FormCreate(Sender: TObject);
begin
  inherited;
  jUniType   := pc006_101_jMain;
  Caption    := pc006_101_Caption;
  pageDescr  := TDEPpageDescr.Create;
  grapDescr  := TDEPgraphDescr.Create;
end;

function TcDBVgrafQuery.getBitBtn(Chanal: Integer): TBitBtn;
begin
  case Chanal of
    1: result := BitBtn14;
    2: result := BitBtn15;
    3: result := BitBtn16;
    4: result := BitBtn17;
    5: result := BitBtn18;
    else result := nil;
  end;
end;

function TcDBVgrafQuery.getCheckBox(Chanal: Integer): TCheckBox;
begin
  case Chanal of
    1: result :=  CheckBox9;
    2: result := CheckBox10;
    3: result := CheckBox11;
    4: result := CheckBox12;
    5: result := CheckBox13;
    else result := nil;
  end;
end;

procedure TcDBVgrafQuery.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pageDescr.Free;
  grapDescr.Free;
end;

procedure TcDBVgrafQuery.TabControl1Change(Sender: TObject);
begin
  inherited;

  // Сохранить настройки
  self.FcSelectTrac.Select := false;
  self.saveQueryParam;

  // Переключить страницу
  //  ShowMessage( IntToStr( self.TabControl1.TabIndex ) );

  self.FcSelectList.SelectedTrack := self.TabControl1.TabIndex + 1;
  self.FcSelectTrac := self.FcSelectList[self.FcSelectList.SelectedTrack].ukz as TTrackPattern;
  self.FcSelectTrac.Select := true;

  self.CheckBox1.Checked := self.FcSelectTrac.active;

// Список параметров
  setChoiseParam(1);
  setChoiseParam(2);
  setChoiseParam(3);
  setChoiseParam(4);
  setChoiseParam(5);

end;

procedure TcDBVgrafQuery.ComboBox1Change(Sender: TObject);
var
  jT, jN: integer;
  c1: TGraphListPattern;
begin
  inherited;
//  выбрать шаблон
// Сохранить настройки
  if not QueryReportCheck() then
  begin
    Exit;
  end;

  saveQueryParam;
  self.FcSelectList.active := false;
  jT := self.FcSelectList.SelectedTrack;

//  добавить шаблон
  jN := self.ComboBox1.ItemIndex + 1;

  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern := jN;

  c1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.GetObjPnt(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern);
  self.FcSelectList := c1;
  c1.SelectedTrack := jT;
  self.FcSelectTrac := c1[c1.SelectedTrack].ukz as TTrackPattern;
  self.FcSelectTrac.Select := true;
  c1.active := true;

  self.CheckBox1.Checked := self.FcSelectTrac.active;
  self.TabControl1.TabIndex := jT-1;

// Список параметров
  setChoiseParam(1);
  setChoiseParam(2);
  setChoiseParam(3);
  setChoiseParam(4);
  setChoiseParam(5);
end;

procedure TcDBVgrafQuery.BitBtn6Click(Sender: TObject);
var
  jN: integer;
  c1: TGraphListPattern;
begin
  inherited;
// Сохранить настройки
  if not QueryReportCheck() then
  begin
    Exit;
  end;

  saveQueryParam;
  self.FcSelectList.active := false;

//  добавить шаблон
  jN := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.addEmptyPattern;
  c1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.GetObjPnt(jN);
  if self.CheckBox2.Checked then
  begin
    c1.Clone(self.FcSelectList);
  end
  else
  begin
    c1.SelectedTrack := 1;
  end;

  c1.active := true;
  self.ComboBox1.Items.Add(c1.name);
  c1.name := format(pc006_101_1203, [jN]);

  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern := jN;
  self.ComboBox1.ItemIndex := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern - 1;

  c1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.GetObjPnt(self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern);
  self.FcSelectList := c1;
  self.FcSelectTrac := c1.GetObjPnt(c1.SelectedTrack);
  self.FcSelectTrac.Select := true;

  self.CheckBox1.Checked := self.FcSelectTrac.active;
  self.TabControl1.TabIndex := c1.SelectedTrack - 1;

// Список параметров
  setChoiseParam(1);
  setChoiseParam(2);
  setChoiseParam(3);
  setChoiseParam(4);
  setChoiseParam(5);
end;

procedure TcDBVgrafQuery.BitBtn7Click(Sender: TObject);
var
  InputString: string;
  jC1, j1: integer;
  c1: TGraphListPattern;
begin
  inherited;
//  переименовать шаблон
  InputString := Trim(InputBox(self.Caption, 'Укажите новое имя шаблона', self.FcSelectList.name));

  if self.FcSelectList.name <> InputString then
  begin
    self.FcSelectList.name := InputString;
    j1 := self.ComboBox1.ItemIndex;
    self.ComboBox1.Clear;
    for jC1 := 1 to self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.Count do
    begin
      c1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.GetObjPnt(jC1);
      if c1 = nil then continue;
      self.ComboBox1.Items.Add(c1.name);
    end;
    self.ComboBox1.ItemIndex := j1;
  end;
end;

procedure TcDBVgrafQuery.BitBtn8Click(Sender: TObject);
var
  s1: string;
  jC1, j1: integer;
  c1: TGraphListPattern;
begin
// удалить шаблон

  inherited;

  if self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.Count = 1 then
  begin
    ShowMessage(pc006_101_1123);
    Exit;
  end;

  s1 := format(pc006_101_1122, [self.FcSelectList.name]);

  if MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
    Exit;
  end;

  j1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.SelectedPattern;
  self.ComboBox1.Clear;

  self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.Delete(j1);
  for jC1 := 1 to self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.Count do
  begin
    c1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.GetObjPnt(jC1);
    if c1 = nil then continue;
    self.ComboBox1.Items.Add(c1.name);
  end;

  if j1 > self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.Count then
  begin
    j1 := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.Count;
  end;

  self.ComboBox1.ItemIndex := j1 - 1;
  self.FcSelectList := self.fDEPgrafJob.DEPGrhDescr.GraphListPatterns.GetObjPnt(j1);
  self.FcSelectList.SelectedTrack := 1;
  self.FcSelectTrac := self.FcSelectList.GetObjPnt(self.FcSelectList.SelectedTrack);

  self.CheckBox1.Checked := self.FcSelectTrac.active;
  self.TabControl1.TabIndex := self.FcSelectList.SelectedTrack - 1;

// Список параметров
  setChoiseParam(1);
  setChoiseParam(2);
  setChoiseParam(3);
  setChoiseParam(4);
  setChoiseParam(5);
end;

procedure TcDBVgrafQuery.clearList(chl: TCheckListBox);
var
  jC1: integer;
begin
  for jC1 := 1 to chl.Count do
  begin
    chl.Checked[jC1-1] := false;
  end;
end;

procedure TcDBVgrafQuery.setList(chl: TCheckListBox);
var
  jC1: integer;
begin
  for jC1 := 1 to chl.Count do
  begin
    chl.Checked[jC1-1] := true;
  end;
end;

procedure TcDBVgrafQuery.CheckBox9Click(Sender: TObject);
begin
  inherited;
//  self.FcSelectTrac[1].active := self.CheckBox9.Checked;
end;

procedure TcDBVgrafQuery.CheckBox10Click(Sender: TObject);
begin
  inherited;
//  self.FcSelectTrac[2].active := self.CheckBox10.Checked;
end;

procedure TcDBVgrafQuery.CheckBox11Click(Sender: TObject);
begin
  inherited;
//  self.FcSelectTrac[3].active := self.CheckBox11.Checked;
end;

procedure TcDBVgrafQuery.CheckBox12Click(Sender: TObject);
begin
  inherited;
//  self.FcSelectTrac[4].active := self.CheckBox12.Checked;
end;

procedure TcDBVgrafQuery.CheckBox13Click(Sender: TObject);
begin
  inherited;
//  self.FcSelectTrac[5].active := self.CheckBox13.Checked;
end;

end.
