unit uEditParam2v2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, uEditParam2Const, uDepGrafList1, StdCtrls,
  ExtCtrls, ComCtrls, uAbstrArray, Buttons, uDEPdescript2, uShowImageConst,
  uDEPgrafJob2;

type
  prqTGrafInterval2 = class
  private

  public
    dTime, dValue: Double;
    b_Index      : Integer;
    Empty        : Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

  prqTBorders = class(prqTobject)
  private
    numChanal:     Integer;
    phNChanal:     Integer;
    Empty:         Boolean;
    xVal, yTime: prqTDouble;

    NError:        Integer;
  public
    constructor Create;
    destructor Destroy; override;
  published

  end;


  TcEditParam2 = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    RadioGroup1: TRadioGroup;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
    RadioButton1: TRadioButton;
    Panel4: TPanel;
    Label5: TLabel;
    RadioButton3: TRadioButton;
    Panel5: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    TabSheet3: TTabSheet;
    Panel6: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Edit6: TEdit;
    Edit7: TEdit;
    Panel7: TPanel;
    Label9: TLabel;
    RadioButton6: TRadioButton;
    TabSheet4: TTabSheet;
    Panel8: TPanel;
    RadioButton8: TRadioButton;
    Panel9: TPanel;
    Label11: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    RadioButton9: TRadioButton;
    Panel11: TPanel;
    Label17: TLabel;
    Edit5: TEdit;
    CheckBox1: TCheckBox;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);

  private
    { Private declarations }
    fjobParam:    TDEPgrafJob1;
    fOtherParams: prqTobject;
    fgList:       TprqRptGrafList4;
    fIntervals:   prqTGrafInterval;
    fgWind:       TprqRptGrafWindow;
    numChanals:   prqTInteger;
    numChanal:    Integer;
    borders:      prqTBorders;
    dTimeOut:     Double;
    dTimeStep:    Double;

    procedure setChoiseValue2;
    procedure setChoiseValue3;
    procedure setInterval(bRder: prqTGrafInterval2);
    procedure findNearest(numChanal: Integer);
    function  FindGrafOnEtaps(dTime: Double; pg: TprqRptGraf1): Integer;
    function  FindFistPoint(dTime: Double): Integer;
    function  FindLastPoint(dTime: Double): Integer;

    procedure Metod1;
// Восстановить "автоматически" значения на границах
    procedure Metod1_1(const noise: Double);
    procedure _Metod1_1(const noise: Double; _xVal, _yTime: prqTDouble);
// Восстановить с учётом заданных значений на границах:
    procedure Metod1_2(const noise, par1, par2: Double; b1, b2: Boolean);
    procedure _Metod1_2(const noise, par1, par2: Double; b1, b2: Boolean; _xVal, _yTime: prqTDouble);
// Служебная, дописывает значеия в Таймауте
    procedure RestoreParam1(dxVal, dTime: prqTDouble; const noise: Double;
                            var ParCrnt, TmrCrnt: Double;
                            const goalParCrnt, goalTmrCrnt: Double);

    procedure Metod2;
// Восстановить "автоматически" значения на границах
    procedure Metod2_1(const noise: Double);
    procedure _Metod2_1(const noise: Double; _xVal, _yTime: prqTDouble);
// Восстановить с учётом заданных значений на границах:
    procedure Metod2_2(const noise, par1, par2: Double; b1, b2: Boolean);
    procedure _Metod2_2(const noise, par1, par2: Double; b1, b2: Boolean; _xVal, _yTime: prqTDouble);

    procedure Metod3;
// Нормализация объёма
    procedure Metod3_1;
    procedure _Metod3_1(_xVal, _yTime: prqTDouble);
// Сдвиг и наклон параметра
    procedure Metod3_2(const noise, par1, par2: Double);
    procedure _Metod3_2(const noise, par1, par2: Double; _xVal, _yTime: prqTDouble);
// Внесенние в данные шума (% от значения)
    procedure Metod3_3(const noise: Double);
    procedure _Metod3_3(const noise: Double; _xVal, _yTime: prqTDouble);

  public
    { Public declarations }
    procedure Init(jobParam: TDEPgrafJob1; Intervals: prqTGrafInterval; gWind: TprqRptGrafWindow);

  end;

var
  cEditParam2: TcEditParam2;

implementation
uses uSupport;

{$R *.dfm}

procedure TcEditParam2.FormCreate(Sender: TObject);
begin
  inherited;
  self.jUniType := pc005_111_jMain;
  self.Caption  := pc005_111_Caption;
  numChanals    := prqTInteger.Create;
  borders       := prqTBorders.Create;
end;

procedure TcEditParam2.Init(jobParam: TDEPgrafJob1; Intervals: prqTGrafInterval; gWind: TprqRptGrafWindow);
var
  pg: TprqRptGraf1;
  jC1: Integer;
begin
  fjobParam    := jobParam;
  fOtherParams := jobParam.OtherParams;
  fgList    := jobParam.gList;
  fIntervals:= Intervals;
  fgWind    := gWind;
//  fjobParam.Tag := 0;

  for jC1 := 1 to self.fgWind.Grafiks.Count do
  begin
    pg := self.fgWind.Grafiks[jC1].ukz as TprqRptGraf1;
    if pg.bActive then
    begin
      self.RadioGroup1.Items.Add(
        pg.sName + '(' + pg.sEdIzm + ')'
        );
      self.numChanals.Append(@jC1);
    end;
  end;
  self.RadioGroup1.Height := (self.RadioGroup1.Items.Count * pc005_111_001) + pc005_111_002;
  self.PageControl1.ActivePage := self.PageControl1.Pages[0];

  self.fIntervals.Sort(1);

  setChoiseValue3;
end;

procedure TcEditParam2.RadioGroup1Click(Sender: TObject);
begin
  inherited;
  setChoiseValue2;
end;

procedure TcEditParam2.setChoiseValue2;
begin
  self.borders.numChanal := 0;
  if  uSupport.prqStrToFloat(Trim(Edit1.Text), self.dTimeOut) then
  begin
    self.dTimeOut     := self.dTimeOut / 86400;
  end
  else
  begin
    ShowMessage(pc005_111_011);
    self.RadioGroup1.ItemIndex := -1;
    Exit;
  end;

  if  uSupport.prqStrToFloat(Trim(Edit2.Text), self.dTimeStep) then
  begin
    self.dTimeStep    := self.dTimeStep / 86400;
  end
  else
  begin
    ShowMessage(pc005_111_012);
    self.RadioGroup1.ItemIndex := -1;
    Exit;
  end;

  self.numChanal      := self.RadioGroup1.ItemIndex + 1;
  if (self.numChanal < 0)  OR  (self.numChanal > self.numChanals.Count) then Exit;
  findNearest(self.numChanals[self.numChanal]^);
  if self.borders.Empty then
  begin
    self.Edit6.Text   := '';
    self.Edit7.Text   := '';
  end
  else
  begin
    self.Edit6.Text   := Trim(FormatFloat('#####0.0##', (self.borders[1].ukz as prqTGrafInterval2).dValue));
    self.Edit7.Text   := Trim(FormatFloat('#####0.0##', (self.borders[2].ukz as prqTGrafInterval2).dValue));
  end;
end;

procedure TcEditParam2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  numChanals.Free;
  borders.Free;
end;

{ prqTGrafInterval2 }

constructor prqTGrafInterval2.Create;
begin
  inherited;
  dTime     := 0;
  dValue    := 0;
  b_Index   := 0;
  Empty     := true;
end;

destructor prqTGrafInterval2.Destroy;
begin
  inherited;
end;

procedure TcEditParam2.findNearest(numChanal: Integer);
var
  pg: TprqRptGraf1;
  num: Integer;
  bRder1, bRder2: prqTGrafInterval2;
  pCh: TprqRptTX;
begin
  self.borders.Count       := 0;
  self.borders.Count       := 2;

  self.borders.numChanal   := numChanal;
  pg                       := self.fgWind.Grafiks[numChanal].ukz as TprqRptGraf1;
  self.borders.phNChanal   := pg.nChanal;

  if pg.nChanal > 0 then
  begin
    num := pg.nChanal;
  end
  else
  begin
    num := FindGrafOnEtaps(self.fIntervals[1].dTime, pg);
    num := pg.FindNumChanal(num, self.fOtherParams);
    if num = 0 then
    begin
      self.borders.NError  := 1;
      Exit;
    end;
  end;

  pCh := TprqRptGrafList4.FindOtherParams(num, self.fOtherParams);
  if not Assigned(pCh) then
  begin
    self.borders.NError  := 2;
    Exit;
  end;

  self.borders.xVal  := pCh.xVal;
  self.borders.yTime := pCh.yTime;

  bRder1                   := prqTGrafInterval2.Create;
  self.borders[1].ukz      := bRder1;
  bRder1.b_Index           := FindFistPoint(self.fIntervals[1].dTime);
  setInterval(bRder1);

  bRder2                   := prqTGrafInterval2.Create;
  self.borders[2].ukz      := bRder2;
  bRder2.b_Index           := FindLastPoint(self.fIntervals[2].dTime);
  setInterval(bRder2);

  self.borders.Empty       := bRder1.Empty  and  bRder2.Empty;
end;

{ prqTBorders }

constructor prqTBorders.Create;
begin
  inherited;
  numChanal := 0;
  phNChanal := 0;
  NError    := 0;
  Empty     := true;
  xVal      := nil;
  yTime     := nil;
end;

destructor prqTBorders.Destroy;
begin
  xVal      := nil;
  yTime     := nil;
  inherited;
end;

function TcEditParam2.FindGrafOnEtaps(dTime: Double; pg: TprqRptGraf1): Integer;
var
  jC1: Integer;
  rcd: rcdTcontainer;
begin
  result := 0;
  for jC1 := 1 to self.fgList.Etaps.Count do
  begin
    if self.fgList.Etaps[jC1].dataBeg > dTime then continue;
    if self.fgList.Etaps[jC1].dataEnd < dTime then continue;

    if pg.arrChanal[jC1] <= 0 then Exit;

    rcd.key := pg.arrChanal[jC1];
    result := pg.arrXY.Find(@rcd, 1);
    Exit;
  end;
end;

function TcEditParam2.FindFistPoint(dTime: Double): Integer;
var
  jC1: Integer;
  dT: Double;
begin
  dT  := fIntervals[1].dTime;
  for jC1 := 1 to self.borders.yTime.Count do
  begin
    if self.borders.yTime[jC1]^ < dT then continue;
    result := jC1 - 1;
    Exit;
  end;
  result := self.borders.yTime.Count;
end;

function TcEditParam2.FindLastPoint(dTime: Double): Integer;
var
  jC1: Integer;
  dT: Double;
begin
  dT  := fIntervals[2].dTime;
  for jC1 := self.borders.yTime.Count downto 1 do
  begin
    if self.borders.yTime[jC1]^ > dT then continue;
    result := jC1 + 1;
    Exit;
  end;
  result := 1;
end;

procedure TcEditParam2.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TcEditParam2.BitBtn1Click(Sender: TObject);
var
  j1: Integer;
begin
  inherited;
  if self.PageControl1.ActivePageIndex = 0 then
  begin
    ShowMessage(pc005_111_013);
  end;

//  fjobParam.Tag := 1;

  case self.PageControl1.ActivePageIndex of
    1: Metod1;
    2: Metod2;
    3: Metod3;
  end;

  uSupport.SendMessageToParent(self.taskParam, self.jUniKeySelf,
                               pc005_111_AcceptMsg, 0, 0, 0, true, j1)

end;

procedure TcEditParam2.Metod1_1(const noise: Double);
var
  s1: String;
  jC1: Integer;
  p1: TprqRptTX;
begin
//  _Metod1_1(noise, self.borders.xVal, self.borders.yTime);
  for jC1 := 1 to self.fOtherParams.Count do
  begin
    if self.fOtherParams[jC1].key = self.borders.phNChanal then
    begin
      p1 := self.fOtherParams[jC1].ukz as TprqRptTX;
      _Metod1_1(noise, p1.xVal, p1.yTime);
    end;
  end;

  s1 := format(pc005_111_021, [self.borders.phNChanal, noise]);
  ShowMessage(s1);
end;

procedure TcEditParam2.Metod1_2(const noise, par1, par2: Double; b1, b2: Boolean);
var
  s1: String;
  jC1: Integer;
  p1: TprqRptTX;
begin
//  _Metod1_2(noise, par1, par2, b1, b2, self.borders.xVal, self.borders.yTime);
  for jC1 := 1 to self.fOtherParams.Count do
  begin
    if self.fOtherParams[jC1].key = self.borders.phNChanal then
    begin
      p1 := self.fOtherParams[jC1].ukz as TprqRptTX;
      _Metod1_2(noise, par1, par2, b1, b2, p1.xVal, p1.yTime);
    end;
  end;

  s1 := format(pc005_111_022, [self.borders.phNChanal, par1, par2, noise]);
  ShowMessage(s1);
end;

procedure TcEditParam2.Metod1;
var
  s5, s3, s2, s1: String;
  noise: Double;
begin
  if self.borders.numChanal = 0 then
  begin
    ShowMessage(pc005_111_014);
    Exit;
  end;

  noise := 0;

  if CheckBox1.Checked then
  begin
    s5 := Trim(Edit5.Text);
    if  not uSupport.prqStrToFloat(s5, noise) then
    begin
      ShowMessage(pc005_111_019);
      Exit;
    end;
    if noise <= 0 then
    begin
      ShowMessage(pc005_111_019);
      Exit;
    end;
  end
  else
  begin
    s5 := '';
  end;

  s3 := self.PageControl1.ActivePage.Caption;
  if self.RadioButton1.Checked then
  begin
    if self.borders.Empty  or  (self.borders.xVal.Count = 0) then
    begin
      ShowMessage(pc005_111_020);
      Exit;
    end;

    s2 := self.RadioButton1.Caption;
    s1 := format(pc005_111_015,
                [self.borders.phNChanal,
                 s3,
                 s2,
                 s5
                ]);
    if not (MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then Exit;
    Metod1_1(noise);
    self.setChoiseValue2;
  end;
end;

procedure TcEditParam2.setInterval(bRder: prqTGrafInterval2);
var
  j1: Integer;
begin
  j1 := bRder.b_Index;
  if j1 > self.borders.yTime.Count then j1 := self.borders.yTime.Count;
  if j1 > 0 then
  begin
    bRder.dTime   := self.borders.yTime[j1]^;
    bRder.dValue  := self.borders.xVal[j1]^;
    bRder.Empty   := false;
  end
  else
  begin
    bRder.dTime   := self.fIntervals[1].dTime;
    bRder.dValue  := self.borders.xVal[1]^;
    bRder.Empty   := true;
  end;
end;

procedure TcEditParam2.RestoreParam1(dxVal, dTime: prqTDouble; const noise: Double;
                                    var ParCrnt, TmrCrnt: Double;
                                    const goalParCrnt, goalTmrCrnt: Double);
var
  xn, n, x, a, b: Double;
begin
  if noise > 0 then
  begin
    Randomize;
    n := noise * 0.01;
  end
  else
    n := 0;

{
  x  = a * (t - t0) + b
  t0 = TmrCrnt
  b  = ParCrnt
  a  = (goalParCrnt-ParCrnt) / (goalTmrCrnt-TmrCrnt)
}

  b  := ParCrnt;
  a  := (goalParCrnt-ParCrnt) / (goalTmrCrnt-TmrCrnt);

  TmrCrnt := TmrCrnt + self.dTimeStep;
  x       := b;
  a       := self.dTimeStep * a;
  while TmrCrnt <= goalTmrCrnt do
  begin
    x := x + a;

    if noise > 0 then
    begin
      xn := x * (1 + (2 * Random - 1) * n);
      dxVal.Append(@xn);
    end
    else
      dxVal.Append(@x);
    dTime.Append(@TmrCrnt);
    TmrCrnt := TmrCrnt + self.dTimeStep;
  end;
  TmrCrnt := TmrCrnt - self.dTimeStep;
end;

procedure TcEditParam2.RadioButton4Click(Sender: TObject);
begin
  inherited;
  setChoiseValue3;
end;

procedure TcEditParam2.setChoiseValue3;
begin
  if self.RadioButton4.Checked then
  begin
    self.Edit6.Enabled := false;
    self.Edit7.Enabled := false;
  end
  else
  begin
    self.Edit6.Enabled := true;
    self.Edit7.Enabled := true;
  end;
end;

procedure TcEditParam2.RadioButton5Click(Sender: TObject);
begin
  inherited;
  setChoiseValue3;
end;

procedure TcEditParam2.Metod2;
var
  s5, s4, s3, s2, s1: String;
  noise, par1, par2: Double;
  b1, b2: Boolean;
begin
  if self.borders.numChanal = 0 then
  begin
    ShowMessage(pc005_111_014);
    Exit;
  end;

  noise := 0;

  if CheckBox1.Checked then
  begin
    s5 := Trim(Edit5.Text);
    if  not uSupport.prqStrToFloat(s5, noise) then
    begin
      ShowMessage(pc005_111_019);
      Exit;
    end;
    if noise <= 0 then
    begin
      ShowMessage(pc005_111_019);
      Exit;
    end;
  end
  else
  begin
    s5 := '';
  end;

  s3 := self.PageControl1.ActivePage.Caption;
  if self.RadioButton4.Checked then
  begin
    if self.borders.Empty  or  (self.borders.xVal.Count = 0) then
    begin
      ShowMessage(pc005_111_020);
      Exit;
    end;

    s2 := self.RadioButton4.Caption;
    s1 := format(pc005_111_015,
                [self.borders.phNChanal,
                 s3,
                 s2,
                 s5
                ]);
    if not (MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then Exit;
    Metod2_1(noise);
    self.setChoiseValue2;
  end
  else
  begin
    try
      s4 := Trim(Edit6.Text);
      if Length(s4) = 0 then
      begin
        b1 := false;
        par1 := 0;
      end
      else
      begin
        b1 := true;
        prqStrToFloat(s4, par1);
      end;
    except
      ShowMessage(pc005_111_017);
      Exit;
    end;

    try
      s4 := Trim(Edit7.Text);
      if Length(s4) = 0 then
      begin
        b2 := false;
        par2 := 0;
      end
      else
      begin
        b2 := true;
        prqStrToFloat(s4, par2);
      end;
    except
      ShowMessage(pc005_111_018);
      Exit;
    end;

    s2 := self.RadioButton5.Caption;
    s1 := format(pc005_111_016,
                [self.borders.phNChanal,
                 s3,
                 s2,
                 Edit6.Text,
                 Edit7.Text,
                 s5
                ]);
    if not (MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then Exit;
    Metod2_2(noise, par1, par2, b1, b2);
    self.setChoiseValue2;
  end;
end;

procedure TcEditParam2.Metod2_1(const noise: Double);
var
  s1: String;
  jC1: Integer;
  p1: TprqRptTX;
begin
//  _Metod2_1(noise, self.borders.xVal, self.borders.yTime);
  for jC1 := 1 to self.fOtherParams.Count do
  begin
    if self.fOtherParams[jC1].key = self.borders.phNChanal then
    begin
      p1 := self.fOtherParams[jC1].ukz as TprqRptTX;
      _Metod2_1(noise, p1.xVal, p1.yTime);
    end;
  end;

  s1 := format(pc005_111_021, [self.borders.phNChanal, noise]);
  ShowMessage(s1);
end;

procedure TcEditParam2.Metod2_2(const noise, par1, par2: Double; b1,
  b2: Boolean);
var
  s1: String;
  jC1: Integer;
  p1: TprqRptTX;
begin
//  _Metod2_2(noise, par1, par2, b1, b2, self.borders.xVal, self.borders.yTime);
  for jC1 := 1 to self.fOtherParams.Count do
  begin
    if self.fOtherParams[jC1].key = self.borders.phNChanal then
    begin
      p1 := self.fOtherParams[jC1].ukz as TprqRptTX;
      _Metod2_2(noise, par1, par2, b1, b2, p1.xVal, p1.yTime);
    end;
  end;

  s1 := format(pc005_111_022, [self.borders.phNChanal, par1, par2, noise]);
  ShowMessage(s1);
end;

procedure TcEditParam2.Metod3;
var
  s5, s4, s3, s2, s1: String;
  noise, par1, par2: Double;
begin
  if self.borders.numChanal = 0 then
  begin
    ShowMessage(pc005_111_014);
    Exit;
  end;

  noise := 0;

  s3 := self.PageControl1.ActivePage.Caption;
{
  if self.RadioButton7.Checked then
  begin
    if self.borders.Empty  or  (self.borders.xVal.Count = 0) then
    begin
      ShowMessage(pc005_111_020);
      Exit;
    end;
    s2 := self.RadioButton7.Caption;
    s1 := format(pc005_111_023,
                [self.borders.phNChanal,
                 s3,
                 s2
                ]);
    if not (MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then Exit;
    Metod3_1();
  end

  else
}
  if self.RadioButton8.Checked then
  begin
    try
      s4   := Trim(Edit9.Text);
      if Length(s4) = 0 then
      begin
        par1 := 0;
      end
      else
      begin
        prqStrToFloat(s4, par1);
      end;
    except
      ShowMessage(pc005_111_024);
      Exit;
    end;

    try
      s4   := Trim(Edit10.Text);
      if Length(s4) = 0 then
      begin
        par2 := 1;
      end
      else
      begin
        prqStrToFloat(s4, par2);
      end;
    except
      ShowMessage(pc005_111_025);
      Exit;
    end;

    s2 := self.RadioButton8.Caption;
    s1 := format(pc005_111_028,
                [self.borders.phNChanal,
                 s3,
                 s2,
                 Edit9.Text,
                 Edit10.Text
                ]);
    if not (MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then Exit;
    Metod3_2(noise, par1, par2);
  end

  else
  begin
    s5 := Trim(Edit5.Text);
    if  not uSupport.prqStrToFloat(s5, noise) then
    begin
      ShowMessage(pc005_111_019);
      Exit;
    end;
    if noise <= 0 then
    begin
      ShowMessage(pc005_111_019);
      Exit;
    end;
    s2 := self.RadioButton9.Caption;
    s1 := format(pc005_111_029,
                [self.borders.phNChanal,
                 s3,
                 s2,
                 s5
                ]);
    if not (MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then Exit;
    Metod3_3(noise);
  end;
end;

procedure TcEditParam2.Metod3_1;
var
  s1: String;
  jC1: Integer;
  p1: TprqRptTX;
begin
//  _Metod3_1(self.borders.xVal, self.borders.yTime);
  for jC1 := 1 to self.fOtherParams.Count do
  begin
    if self.fOtherParams[jC1].key = self.borders.phNChanal then
    begin
      p1 := self.fOtherParams[jC1].ukz as TprqRptTX;
      _Metod3_1(p1.xVal, p1.yTime);
    end;
  end;

  s1 := format(pc005_111_031, [self.borders.phNChanal]);
  ShowMessage(s1);
end;

procedure TcEditParam2.Metod3_2(const noise, par1, par2: Double);
var
  s1: String;
  jC1: Integer;
  p1: TprqRptTX;
begin
//  _Metod3_2(noise, par1, par2, self.borders.xVal, self.borders.yTime);
  for jC1 := 1 to self.fOtherParams.Count do
  begin
    if self.fOtherParams[jC1].key = self.borders.phNChanal then
    begin
      p1 := self.fOtherParams[jC1].ukz as TprqRptTX;
      _Metod3_2(noise, par1, par2, p1.xVal, p1.yTime);
    end;
  end;

  s1 := format(pc005_111_030, [self.borders.phNChanal, par1, par2]);
  ShowMessage(s1);
end;

procedure TcEditParam2.Metod3_3(const noise: Double);
var
  s1: String;
  jC1: Integer;
  p1: TprqRptTX;
begin
//  _Metod3_3(noise, self.borders.xVal, self.borders.yTime);
  for jC1 := 1 to self.fOtherParams.Count do
  begin
    if self.fOtherParams[jC1].key = self.borders.phNChanal then
    begin
      p1 := self.fOtherParams[jC1].ukz as TprqRptTX;
      _Metod3_3(noise, p1.xVal, p1.yTime);
    end;
  end;

  s1 := format(pc005_111_021, [self.borders.phNChanal, noise]);
  ShowMessage(s1);
end;

procedure TcEditParam2._Metod1_2(const noise, par1, par2: Double; b1,
  b2: Boolean; _xVal, _yTime: prqTDouble);
var
  dxVal, dTime: prqTDouble;
  lastIndex, jC1: Integer;
  brd1, brd2: prqTGrafInterval2;
  ParCrnt: Double;
  TmrCrnt: Double;
begin
//1. Создать класс приёмник, скопировать туда начальный отрезок данных
  dxVal := prqTDouble.Create;
  dTime := prqTDouble.Create;
  try
    brd1  := self.borders[1].ukz as prqTGrafInterval2;
    brd2  := self.borders[2].ukz as prqTGrafInterval2;
    for jC1 := 1 to brd1.b_Index do
    begin
      dxVal.Append(_xVal[jC1]);
      dTime.Append(_yTime[jC1]);
    end;

  //2. устанавливаем начальное значение переменных
    if brd1.b_Index > 0 then
    begin
      if b1 then
      begin
        ParCrnt := par1;
      end
      else
      begin
        ParCrnt := _xVal[1]^;
      end;
      lastIndex := brd1.b_Index + 1;
      TmrCrnt   := self.fIntervals[1].dTime;
    end
    else
    begin
      if b1 then
      begin
        ParCrnt := par1;
      end
      else
      begin
        ParCrnt := _xVal[1]^;
      end;
      TmrCrnt   := self.fIntervals[1].dTime;
      dxVal.Append(@ParCrnt);
      dTime.Append(@TmrCrnt);
      lastIndex := 1;
    end;

  //3. В цикле просмотреть до второй границы интервала и восстановить пробелы
    while TmrCrnt < self.fIntervals[2].dTime do
    begin
      if lastIndex < brd2.b_Index then
      begin
        if _yTime[lastIndex]^ < self.fIntervals[1].dTime then
        begin
          Inc(lastIndex);
          continue;
        end;

        if _yTime[lastIndex]^ <= TmrCrnt then
        begin
          Inc(lastIndex);
          continue;
        end;

        if (_yTime[lastIndex]^ - TmrCrnt) < self.dTimeOut then
        begin
          dxVal.Append(_xVal[lastIndex]);
          dTime.Append(_yTime[lastIndex]);
          ParCrnt   := _xVal[lastIndex]^;
          TmrCrnt   := _yTime[lastIndex]^;
          Inc(lastIndex);
          continue;
        end
        else
        begin
          RestoreParam1(dxVal, dTime, noise,
                        ParCrnt, TmrCrnt,
                        _xVal[lastIndex]^, _yTime[lastIndex]^);
        end;
      end
      else
      begin
        if b2 then
        begin
          RestoreParam1(dxVal, dTime, noise,
                        ParCrnt, TmrCrnt,
                        par2, self.fIntervals[2].dTime);
        end
        else
        begin
          RestoreParam1(dxVal, dTime, noise,
                        ParCrnt, TmrCrnt,
                        brd2.dValue, self.fIntervals[2].dTime);
        end;
        break;
      end;
    end;

  //4. Дополнить реставрированное значение остатками параметра
    for jC1 := brd2.b_Index to _yTime.Count do
    begin
      if _yTime[jC1]^ <= TmrCrnt then
      begin
        continue;
      end;
      dxVal.Append(_xVal[jC1]);
      dTime.Append(_yTime[jC1]);
    end;

  //5. Перенести реставрированный параметр на место исходного
    _xVal.Count := 0; _xVal.AppendClass(dxVal);
    _yTime.Count := 0; _yTime.AppendClass(dTime);

  finally
    dxVal.Free;
    dTime.Free;
  end;
end;

procedure TcEditParam2._Metod1_1(const noise: Double; _xVal,
  _yTime: prqTDouble);
var
  dxVal, dTime: prqTDouble;
  lastIndex, jC1: Integer;
  brd1, brd2: prqTGrafInterval2;
  ParCrnt: Double;
  TmrCrnt: Double;
begin
//1. Создать класс приёмник, скопировать туда начальный отрезок данных
  dxVal := prqTDouble.Create;
  dTime := prqTDouble.Create;
  try
    brd1  := self.borders[1].ukz as prqTGrafInterval2;
    brd2  := self.borders[2].ukz as prqTGrafInterval2;
    for jC1 := 1 to brd1.b_Index do
    begin
      dxVal.Append(_xVal[jC1]);
      dTime.Append(_yTime[jC1]);
    end;

  //2. устанавливаем начальное значение переменных
    if brd1.b_Index > 0 then
    begin
      lastIndex := brd1.b_Index;
      ParCrnt   := _xVal[lastIndex]^;
      TmrCrnt   := _yTime[lastIndex]^;
      Inc(lastIndex);
    end
    else
    begin
      ParCrnt   := _xVal[1]^;
      TmrCrnt   := self.fIntervals[1].dTime;
      dxVal.Append(@ParCrnt);
      dTime.Append(@TmrCrnt);
      lastIndex := 1;
    end;

  //3. В цикле просмотреть до второй границы интервала и восстановить пробелы
    while TmrCrnt < self.fIntervals[2].dTime do
    begin
      if lastIndex < brd2.b_Index then
      begin
        if _yTime[lastIndex]^ <= TmrCrnt then
        begin
          Inc(lastIndex);
          continue;
        end;

        if (_yTime[lastIndex]^ - TmrCrnt) < self.dTimeOut then
        begin
          dxVal.Append(_xVal[lastIndex]);
          dTime.Append(_yTime[lastIndex]);
          ParCrnt   := _xVal[lastIndex]^;
          TmrCrnt   := _yTime[lastIndex]^;
          Inc(lastIndex);
          continue;
        end
        else
        begin
          RestoreParam1(dxVal, dTime, noise,
                        ParCrnt, TmrCrnt,
                        _xVal[lastIndex]^, _yTime[lastIndex]^);
        end;
      end
      else
      begin
        RestoreParam1(dxVal, dTime, noise,
                      ParCrnt, TmrCrnt,
                      brd2.dValue, self.fIntervals[2].dTime);
        break;
      end;
    end;

  //4. Дополнить реставрированное значение остатками параметра
    for jC1 := brd2.b_Index to _yTime.Count do
    begin
      if _yTime[jC1]^ <= TmrCrnt then
      begin
        continue;
      end;
      dxVal.Append(_xVal[jC1]);
      dTime.Append(_yTime[jC1]);
    end;

  //5. Перенести реставрированный параметр на место исходного
    _xVal.Count := 0; _xVal.AppendClass(dxVal);
    _yTime.Count := 0; _yTime.AppendClass(dTime);

  finally
    dxVal.Free;
    dTime.Free;
  end;
end;

procedure TcEditParam2._Metod2_1(const noise: Double; _xVal,
  _yTime: prqTDouble);
var
  dxVal, dTime: prqTDouble;
  lastIndex, jC1: Integer;
  brd1, brd2: prqTGrafInterval2;
  ParCrnt: Double;
  TmrCrnt: Double;
begin
//1. Создать класс приёмник, скопировать туда начальный отрезок данных
  dxVal := prqTDouble.Create;
  dTime := prqTDouble.Create;
  try
    brd1  := self.borders[1].ukz as prqTGrafInterval2;
    brd2  := self.borders[2].ukz as prqTGrafInterval2;
    for jC1 := 1 to brd1.b_Index do
    begin
      dxVal.Append(_xVal[jC1]);
      dTime.Append(_yTime[jC1]);
    end;

  //2. устанавливаем начальное значение переменных
    if brd1.b_Index > 0 then
    begin
      lastIndex := brd1.b_Index;
      ParCrnt   := _xVal[lastIndex]^;
      TmrCrnt   := _yTime[lastIndex]^;
//      Inc(lastIndex);
    end
    else
    begin
      ParCrnt   := _xVal[1]^;
      TmrCrnt   := self.fIntervals[1].dTime;
      dxVal.Append(@ParCrnt);
      dTime.Append(@TmrCrnt);
//      lastIndex := 1;
    end;

  //3. Реставрация
    RestoreParam1(dxVal, dTime, noise,
                  ParCrnt, TmrCrnt,
                  brd2.dValue, self.fIntervals[2].dTime);


  //4. Дополнить реставрированное значение остатками параметра
    for jC1 := brd2.b_Index to _yTime.Count do
    begin
      if _yTime[jC1]^ <= TmrCrnt then
      begin
        continue;
      end;
      dxVal.Append(_xVal[jC1]);
      dTime.Append(_yTime[jC1]);
    end;

  //5. Перенести реставрированный параметр на место исходного
    _xVal.Count := 0; _xVal.AppendClass(dxVal);
    _yTime.Count := 0; _yTime.AppendClass(dTime);

  finally
    dxVal.Free;
    dTime.Free;
  end;
end;

procedure TcEditParam2._Metod2_2(const noise, par1, par2: Double; b1,
  b2: Boolean; _xVal, _yTime: prqTDouble);
var
  dxVal, dTime: prqTDouble;
  jC1: Integer;
  brd1, brd2: prqTGrafInterval2;
  ParCrnt: Double;
  TmrCrnt: Double;
begin
//1. Создать класс приёмник, скопировать туда начальный отрезок данных
  dxVal := prqTDouble.Create;
  dTime := prqTDouble.Create;
  try
    brd1  := self.borders[1].ukz as prqTGrafInterval2;
    brd2  := self.borders[2].ukz as prqTGrafInterval2;
    for jC1 := 1 to brd1.b_Index do
    begin
      dxVal.Append(_xVal[jC1]);
      dTime.Append(_yTime[jC1]);
    end;

  //2. устанавливаем начальное значение переменных
    if b1 then
    begin
      ParCrnt := par1;
    end
    else
    begin
      ParCrnt := _xVal[1]^;
    end;
    TmrCrnt   := self.fIntervals[1].dTime;

    if brd1.b_Index = 0 then
    begin
      dxVal.Append(@ParCrnt);
      dTime.Append(@TmrCrnt);
    end;

  //3. В цикле просмотреть до второй границы интервала и восстановить пробелы
    if b2 then
    begin
      RestoreParam1(dxVal, dTime, noise,
                    ParCrnt, TmrCrnt,
                    par2, self.fIntervals[2].dTime);
    end
    else
    begin
      RestoreParam1(dxVal, dTime, noise,
                    ParCrnt, TmrCrnt,
                    brd2.dValue, self.fIntervals[2].dTime);
    end;

  //4. Дополнить реставрированное значение остатками параметра
    for jC1 := brd2.b_Index to _yTime.Count do
    begin
      if _yTime[jC1]^ <= TmrCrnt then
      begin
        continue;
      end;
      dxVal.Append(_xVal[jC1]);
      dTime.Append(_yTime[jC1]);
    end;

  //5. Перенести реставрированный параметр на место исходного
    _xVal.Count := 0; _xVal.AppendClass(dxVal);
    _yTime.Count := 0; _yTime.AppendClass(dTime);

  finally
    dxVal.Free;
    dTime.Free;
  end;
end;

procedure TcEditParam2._Metod3_1(_xVal, _yTime: prqTDouble);
var
  dxVal2, dxVal, dTime: prqTDouble;
  jC1: Integer;
  brd1, brd2: prqTGrafInterval2;
begin
//1. Создать класс приёмник, скопировать туда начальный отрезок данных
  dxVal := prqTDouble.Create;
  dxVal2:= prqTDouble.Create;
  dTime := prqTDouble.Create;
  try
    brd1  := self.borders[1].ukz as prqTGrafInterval2;
    brd2  := self.borders[2].ukz as prqTGrafInterval2;
    for jC1 := 1 to brd1.b_Index do
    begin
      dxVal.Append(_xVal[jC1]);
      dTime.Append(_yTime[jC1]);
    end;

//3. Нормализация
    for jC1 := brd1.b_Index + 1 to brd2.b_Index - 1 do
    begin
      dxVal2.Append(_xVal[jC1]);
    end;

//    TkrsFunction.NormalizeVolume(dxVal2);

    for jC1 := 1 to dxVal2.Count do
    begin
      dxVal.Append(dxVal2[jC1]);
      dTime.Append(_yTime[jC1 + brd1.b_Index]);
    end;

//4. Дополнить Нормализованное значение остатками параметра
    for jC1 := brd2.b_Index to _yTime.Count do
    begin
      dxVal.Append(_xVal[jC1]);
      dTime.Append(_yTime[jC1]);
    end;

  //5. Перенести реставрированный параметр на место исходного
    _xVal.Count := 0; _xVal.AppendClass(dxVal);
    _yTime.Count := 0; _yTime.AppendClass(dTime);

  finally
    dxVal.Free;
    dxVal2.Free;
    dTime.Free;
  end;
end;

procedure TcEditParam2._Metod3_2(const noise, par1, par2: Double; _xVal,
  _yTime: prqTDouble);
var
  jL1, jL2, jC1: Integer;
  brd1, brd2: prqTGrafInterval2;
begin
//1. Создать класс приёмник, скопировать туда начальный отрезок данных
  brd1  := self.borders[1].ukz as prqTGrafInterval2;
  brd2  := self.borders[2].ukz as prqTGrafInterval2;

  if brd1.b_Index = 0 then jL1 := 1 else jL1 := brd1.b_Index;
  if brd2.b_Index > _yTime.Count then
    jL2 := _yTime.Count else jL2 := brd2.b_Index;

  for jC1 := jL1 to jL2 do
  begin
    _xVal[jC1]^ := _xVal[jC1]^ * par2 + par1;
  end;
end;

procedure TcEditParam2._Metod3_3(const noise: Double; _xVal,
  _yTime: prqTDouble);
var
  jL1, jL2, jC1: Integer;
  brd1, brd2: prqTGrafInterval2;
  n: Double;
begin
//1. Создать класс приёмник, скопировать туда начальный отрезок данных
  brd1  := self.borders[1].ukz as prqTGrafInterval2;
  brd2  := self.borders[2].ukz as prqTGrafInterval2;

  if brd1.b_Index = 0 then jL1 := 1 else jL1 := brd1.b_Index;
  if brd2.b_Index > _yTime.Count then
    jL2 := _yTime.Count else jL2 := brd2.b_Index;

  if noise = 0 then Exit;
  Randomize;
  n := noise * 0.01;

  for jC1 := jL1 to jL2 do
  begin
    _xVal[jC1]^ := _xVal[jC1]^ * (1 + (2 * Random - 1) * n);
  end;
end;

end.
