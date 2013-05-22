unit uShowImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, upf2, uShowImageConst,
  uDepGrafList1, ComCtrls, uAbstrGeometry, uAbstrArray, Math, uMsgDial, uEditParam2,
  Grids, uEditParamConst, uDEPdescript, uDEPgrafJob1, uDEPgrafQuery1, Printers;

type
  TdepImgParam = class
    crntStep: double; // выбранный шаг сетки
    crntShft: integer; // текущий сдвиг (пока в шагах сетки)
    crntStepIndx: integer; // текущий индех шага сетки
  end;

  rcdTimgsArr = packed record
    numCombo: Integer;
    numWindow: Integer;
    img: TImage;
    gWd: TprqRptGrafWindow;
//    gWdCopy: TprqRptGrafWindow;
  end;
  PrcdTimgsArr = ^rcdTimgsArr;

  prqTimgsArr = class(prqTabstract1)
  private
    function    GetPntDyn(j: Integer): PrcdTimgsArr;
  protected
    procedure   SetSize(size: Integer); override;
    function  Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
  public
    property    pntDyn[j:Integer]: PrcdTimgsArr read GetPntDyn; default;
    procedure   Delete(jnd1: Integer);

    function findComboList(j: Integer): Integer;
    function findWindowList(j: Integer): Integer;

    constructor Create;
    destructor  Destroy; override;
  end;

  TDescriptMouse = class
  public
    pntImg: TPoint;            // Координаты мыши в пространстве изображения
    pntLog: TPoint;            // Координаты мыши логические в пространстве листа с учётом сдвига
    dTime: Double;             // Время, соответствующее лог коорд
    pntShift: TShiftState;     // Состояние кнопок
    pntBGraf: Boolean;         // Мышка в окне
    eNum: Integer;             // Номер этапа
    bBeg: Boolean;             // Выделено начало этапа (или конец :-))

// в момент нажатия
    eNumDown: Integer;         // Номер этапа
    pntShiftDown: TShiftState; // Состояние кнопок
    pntImgDown: TPoint;        // Координаты мыши в пространстве изображения
    pntLogDown: TPoint;        // Координаты мыши логические в пространстве листа с учётом сдвига
    bBegDown: Boolean;         // Выделено начало этапа (или конец :-))

// в момент отпуска
    eNumUp: Integer;           // Номер этапа
    pntShiftUp: TShiftState;   // Состояние кнопок
    pntImgUp: TPoint;          // Координаты мыши в пространстве изображения
    pntLogUp: TPoint;          // Координаты мыши логические в пространстве листа с учётом сдвига
    bBegUp: Boolean;           // Выделено начало этапа (или конец :-))

    constructor Create;
  end;

  TcShowImage = class(Tpf2)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Panel3: TPanel;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel4: TPanel;
    Label11: TLabel;
    Edit10: TEdit;
    CheckBox1: TCheckBox;
    StringGrid1: TStringGrid;
    Panel5: TPanel;
    BitBtn9: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn4: TBitBtn;
    Panel6: TPanel;
    BitBtn1: TBitBtn;
    BitBtn8: TBitBtn;
    ScrollBar1: TScrollBar;
    BitBtn10: TBitBtn;
    PrintDialog1: TPrintDialog;
    BitBtn11: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
  private
    { Private declarations }
//    fjobParam{, fjobParamArch}: TRaport8v4param;
    fjob: TDEPgrafJob1; // Задание на работу

    fSaveMode: boolean; // true = закрываем по команде сохранения

    cArchiv: TArrScreenShot1;
    bFirst: Boolean;
    fMashtab: Double;
    fEtapEditMode: Integer;
    fMode: Integer;
    fImage1: prqTimgsArr; //TImage;
    fSource: TRect;
    yShift: Integer;
    deltaY: Integer; // Шаг сдвига по Y
    bigStep: Boolean;
    numList: Integer;

    FdepImgParam: TdepImgParam;

//    crntStep: double; // выбранный шаг сетки
//    crntShft: integer; // текущий сдвиг (пока в шагах сетки)
//    crntStepIndx: integer; // текущий индех шага сетки
    dtCrntBeg, dtCrntEnd: double; // Начала и конец окна по времени
    outCrntBeg, outCrntEnd: double; // Начала и конец окна по времени (возвращает процедура отрисовки)

    DescriptMouse: TDescriptMouse;
//    EtapNew: prqTRptGrfEtap1; // Список этапов новый

    Intervals: prqTGrafInterval; // Список интервалов The list of intervals

    bScroll: Boolean;

    procedure setMaxScrollBar;
    procedure SetScrollBar;
    function getStepDate(jNum: integer): double;
    procedure setDelta;
    procedure picUp;
    procedure picDown;
    procedure LineRepaint(const pnt: TPoint; Width: Integer; Color: TColor);              overload;
    procedure LineRepaint(const pnt: TPoint; Width: Integer; Color: TColor;
                          fgWind: TprqRptGrafWindow; img: TImage);                        overload;
    procedure intervalLineRepaint(const pnt: TPoint);                                     overload;
    procedure intervalLineRepaint(const dTime: Double);                                   overload;

    procedure IntervalRepaint;

    procedure StateMouseDefine(Shift: TShiftState; X,Y: Integer);
    procedure StateMouseShow;
    function  isBegOfStage(eNum: Integer; dTime: Double): Boolean;
    function  isBegOfIntrval(dTime, jobBeg, jobEnd: Double): Boolean;

// Указать интервал
    procedure _NewInterval_D;
    procedure _NewInterval_M;
    procedure _NewInterval_U;

    function  _CreateImage(pctWidth, pctHeight: integer): TImage; // Создать заготовку БИТмэпа
    procedure _ClearCanvas(canva: TCanvas; pctWidth, pctHeight: integer);

  public
    { Public declarations }
    procedure unknowDialogMessage(var Msg: TMessage; kode: Integer); override;

    procedure StringSign;
    procedure StringParShow;

    procedure AddCurrentState;
    procedure Init(jobParam: TDEPgrafJob1; depImgParam: TdepImgParam;
valArchiv: TArrScreenShot1); // Задание на работу);
    procedure Init1;

    procedure CreateAllImage;
    function  getImagePageCount(var sErr: string): integer;
    procedure printImagePage(jMode, n1, n2, maxPage: integer);
// Печать документа
// jMode == 0 - весь документ (prAllPages: j1 := 0;)
//       == 1 - страницы с n1 по n2 (prPageNums: j1 := 1;)
//       == 2 - выделенную страницы (prSelection:j1 := 2;)
    procedure ImageTransfer(num: Integer);
    procedure RepaintImage(Sender: TObject);
    procedure RepaintImage2(Sender: TObject);

class function  isValideList(gList: TprqRptGrafList1): Boolean;
  end;

implementation
uses
  uSupport;
{$R *.dfm}

procedure TcShowImage.FormCreate(Sender: TObject);
begin
  inherited;
  self.jUniType     := pc005_110_jMain;
  self.Caption      := pc005_110_Caption;
  self.bFirst       := True;
  self.fSaveMode    := false;
  self.fMashtab     := 1;
  self.bScroll := false;

  fImage1       := prqTimgsArr.Create;

  deltaY        := 1;
  bigStep       := False;
  fEtapEditMode := -1;

//  EtapNew       := prqTRptGrfEtap1.Create;
  DescriptMouse := TDescriptMouse.Create;
  Intervals     := prqTGrafInterval.Create;

//  fgListArch    := TprqRptGrafList4.Create;
//  fjobParamArch := TRaport8v4param.Create;
  cArchiv := nil;
{
  self.ComboBox1.Items.Add(pc005_110_CB01_00);
  self.ComboBox1.Items.Add(pc005_110_CB01_05);
}
end;

procedure TcShowImage.Init(jobParam: TDEPgrafJob1; depImgParam: TdepImgParam;
valArchiv: TArrScreenShot1);
begin
  fJob := jobParam;
  self.FdepImgParam := depImgParam;

{
  if self.FdepImgParam.crntStepIndx < 0 then
  begin
    self.FdepImgParam.crntStepIndx := 10;
  end;

  self.crntShft := 0;
  self.crntStepIndx := 10;
}
  self.setMaxScrollBar;
  self.SetScrollBar;

  self.cArchiv := valArchiv;
  if self.cArchiv.Count = 0 then
  begin
    AddCurrentState;
  end;

  Init1;
end;

procedure TcShowImage.FormShow(Sender: TObject);
begin
  inherited;
  if self.bFirst then
  begin
    self.bFirst := False;
    CreateAllImage;
    fSource := Image1.ClientRect;
    yShift := 0;
    fEtapEditMode := 1; //self.ComboBox1.ItemIndex;
    ImageTransfer(self.numList);
    IntervalRepaint;
  end;
end;

procedure TcShowImage.Panel1Resize(Sender: TObject);
begin
  inherited;
  if not self.bFirst then
  begin
    self.setMaxScrollBar;
    self.SetScrollBar;
    RepaintImage(Sender);
  end;
end;

procedure TcShowImage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  fImage1.Free;
  Intervals.Free;

  DescriptMouse.Free;
end;

procedure TcShowImage.picDown;
var
  dtEnd: double;
begin
  inherited;

  self.FdepImgParam.crntStep := getStepDate(self.FdepImgParam.crntStepIndx);

  if self.CheckBox1.Checked then
  begin
    Inc(self.FdepImgParam.crntShft, 4);
  end
  else
  begin
    Inc(self.FdepImgParam.crntShft);
  end;

  repeat
    dtEnd := self.fjob.gList.dtJobBeg + (self.FdepImgParam.crntStep * (self.FdepImgParam.crntShft + 1));
    if dtEnd < self.fjob.gList.dtJobEnd then
    begin
      break;
    end;
    Dec(self.FdepImgParam.crntShft);
  until self.FdepImgParam.crntShft = 0;

  self.SetScrollBar;
  self.RepaintImage2(Self);
end;

procedure TcShowImage.BitBtn2Click(Sender: TObject);
begin
  inherited;
  self.bigStep := self.CheckBox1.Checked;
  picUp;
end;

procedure TcShowImage.picUp;
begin
  inherited;

  if self.CheckBox1.Checked then
  begin
    Dec(self.FdepImgParam.crntShft, 4);
  end
  else
  begin
    Dec(self.FdepImgParam.crntShft);
  end;
  if self.FdepImgParam.crntShft < 0 then
  begin
    self.FdepImgParam.crntShft := 0;
  end;

  self.SetScrollBar;
  self.RepaintImage2(Self);
end;

procedure TcShowImage.BitBtn3Click(Sender: TObject);
begin
  inherited;
  self.bigStep := self.CheckBox1.Checked;
  picDown;
end;

procedure TcShowImage.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;

  self.StateMouseDefine(Shift, X,Y);
  self.StateMouseShow;

  if not self.DescriptMouse.pntBGraf then Exit;

  if self.fEtapEditMode = pc005_110_CB01_05val then
  begin
    _NewInterval_M;
  end;
end;

procedure TcShowImage.setDelta;
begin
  if self.bigStep then
  begin
    deltaY := (Image1.ClientRect.Bottom - Image1.ClientRect.Top) div 8;
  end
  else
  begin
    deltaY := 1;
  end;
end;

procedure TcShowImage.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Step: Boolean;
begin
  Step := self.bigStep;
  self.bigStep := (ssCtrl in Shift) AND (ssShift in Shift);

  case Key of
    VK_PRIOR, Ord('U'):
    begin
      Key := 0;
      picUp;
    end;

    VK_NEXT, Ord('D'):
    begin
      Key := 0;
      picDown;
    end;
  end;
  self.bigStep := Step;
end;

procedure TcShowImage.StateMouseDefine(Shift: TShiftState; X, Y: Integer);
var
  pnt1: TPoint;
  wnd: TRect;
  fgWind: TprqRptGrafWindow;
begin
  inherited;

  self.DescriptMouse.pntBGraf := False;
  self.DescriptMouse.pntImg.X := X;      // Сохранили текущее состояние
  self.DescriptMouse.pntImg.Y := Y;
  self.DescriptMouse.pntShift := Shift;


  pnt1.X  := X;
  pnt1.Y  := Y;// + 64;

  fgWind := self.fImage1[self.fImage1.findWindowList(self.numList)].gWd;

//  wnd.Left   := fJob.gList.logToPointX(fgWind.wnd_Graf.Left);
//  wnd.Right  := fJob.gList.logToPointX(fgWind.wnd_Graf.Right);

//            pw.wnd_all.Left   := LogOtsLeft + pc003_127_App_Shift1;
//            pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + pc003_127_App_Shift2;
//            pw.wnd_Scale.Right    := pw.wnd_Scale.Left + pc003_127_App_Shift5;

  wnd.Left   := fJob.gList.logToPointX(fJob.gList.LogOtsLeft + pc003_127_App_Shift1 + pc003_127_App_Shift2 + pc003_127_App_Shift5);
  wnd.Right  := fJob.gList.logToPointX(fJob.gList.LogWidth - fJob.gList.LogOtsRight - pc003_127_App_Shift1);


  wnd.Top    := fJob.gList.logToPointY(fgWind.wnd_Graf.Top) - yShift;
  if wnd.Top < 0 then wnd.Top := 0;
  wnd.Bottom := fJob.gList.logToPointY(fgWind.wnd_Graf.Bottom) - yShift;
  if wnd.Bottom > Image1.Height then wnd.Bottom := Image1.Height;


  if not TprqAGallfunc.isInternalPoint(pnt1, wnd, False) then Exit;

//  Edit11.Text := IntToStr(fJob.gList.PointYTOlog(Y));

  self.DescriptMouse.pntLog.X := fJob.gList.PointXTOlog(pnt1.X);
  self.DescriptMouse.pntLog.Y := fJob.gList.PointYTOlog(pnt1.Y + yShift);
  self.DescriptMouse.pntBGraf := True;
  self.DescriptMouse.dTime    := fgWind.dTimeScale.getTimefromY(self.DescriptMouse.pntLog.Y);
  self.DescriptMouse.eNum     := self.fJob.gList.Etaps.findEtapLine(self.DescriptMouse.dTime);
  self.DescriptMouse.bBeg     := isBegOfStage(self.DescriptMouse.eNum, self.DescriptMouse.dTime);
end;

procedure TcShowImage.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  self.StateMouseDefine(Shift, X,Y);

  self.DescriptMouse.pntImgDown   := self.DescriptMouse.pntImg;
  self.DescriptMouse.pntLogDown   := self.DescriptMouse.pntLog;
  self.DescriptMouse.pntShiftDown := self.DescriptMouse.pntShift;
  self.DescriptMouse.bBegDown     := self.DescriptMouse.bBeg;

  if self.DescriptMouse.pntBGraf then
  begin
    self.DescriptMouse.eNumDown := self.DescriptMouse.eNum;
  end
  else
  begin
    self.DescriptMouse.eNumDown := 0;
    self.Intervals.intMod       := 0;
  end;

  self.StateMouseShow;

  if not self.DescriptMouse.pntBGraf then Exit;

  // Указать интервал
  if self.fEtapEditMode = pc005_110_CB01_05val then
  begin
    _NewInterval_D;
  end;
end;

procedure TcShowImage.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  self.StateMouseDefine(Shift, X,Y);
  self.StateMouseShow;

  self.DescriptMouse.pntImgUp   := self.DescriptMouse.pntImg;
  self.DescriptMouse.pntLogUp   := self.DescriptMouse.pntLog;
  self.DescriptMouse.pntShiftUp := self.DescriptMouse.pntShift;
  self.DescriptMouse.eNumUp     := self.DescriptMouse.eNum;
  self.DescriptMouse.bBegUp     := self.DescriptMouse.bBeg;

  if self.fEtapEditMode = pc005_110_CB01_05val then // Начало интервала
  begin
    _NewInterval_U;
  end;
end;

procedure TcShowImage.StateMouseShow;
begin
{
  Edit1.Text := IntToStr(self.DescriptMouse.pntImg.X);
  Edit2.Text := IntToStr(self.DescriptMouse.pntImg.Y);

  if ssShift  in self.DescriptMouse.pntShift then Edit3.text := '+' else Edit3.text := '';
  if ssAlt    in self.DescriptMouse.pntShift then Edit4.text := '+' else Edit4.text := '';
  if ssCtrl   in self.DescriptMouse.pntShift then Edit5.text := '+' else Edit5.text := '';
  if ssLeft   in self.DescriptMouse.pntShift then Edit6.text := '+' else Edit6.text := '';
  if ssRight  in self.DescriptMouse.pntShift then Edit7.text := '+' else Edit7.text := '';
  if ssMiddle in self.DescriptMouse.pntShift then Edit8.text := '+' else Edit8.text := '';
  if ssDouble in self.DescriptMouse.pntShift then Edit9.text := '+' else Edit9.text := '';
}
  StringParShow;

  if self.DescriptMouse.pntBGraf then
  begin
    Edit10.Text := FormatDateTime('dd:mm:yy hh:nn:ss', self.DescriptMouse.dTime);
  end;
end;

{ TDescriptMouse }

constructor TDescriptMouse.Create;
begin
  pntImg.X := 0;
  pntImg.Y := 0;
  pntLog.X := 0;
  pntLog.Y := 0;
  dTime    := 0;
  eNum     := 0;
  pntShift := [];
  pntBGraf := False;
  pntImgDown := pntImg;
  pntLogDown := pntImg;
  pntImgUp   := pntImg;
  pntLogUp   := pntImg;
  pntShiftDown := [];
  pntShiftUp   := [];
end;

procedure TcShowImage.ComboBox1Change(Sender: TObject);
begin
  inherited;
  self.fEtapEditMode := 1; //self.ComboBox1.ItemIndex;
end;

class function TcShowImage.isValideList(gList: TprqRptGrafList1): Boolean;
var
  jC1: Integer;
begin
  result := true;
  for jC1 := 1 to gList.GrafWindows.Count do
  begin
    if gList.isDrawWnd(jC1) then Exit;
  end;

  result := false;
end;

procedure TcShowImage.ComboBox2Change(Sender: TObject);
var
  jNom, jVal: Integer;
begin
  inherited;
  jNom := 1; // self.fImage1.findComboList(self.ComboBox2.ItemIndex + 1);
  jVal := self.fImage1[jNom].numWindow;
  if jVal <> self.numList then
  begin
    self.numList := jVal;

    ImageTransfer(self.numList);

    IntervalRepaint;
    StringSign;
  end;
end;

{ prqTimgsArr }

function prqTimgsArr.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign(PrcdTimgsArr(ukz1).numCombo - PrcdTimgsArr(ukz2).numCombo) + 2;
     end;
  2: begin
       result := sign(PrcdTimgsArr(ukz1).numWindow - PrcdTimgsArr(ukz2).numWindow) + 2;
     end;
  else begin result := 0; end;
  end;
end;

constructor prqTimgsArr.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTimgsArr);
end;

procedure prqTimgsArr.Delete(jnd1: Integer);
begin
  if Assigned( self[jnd1].img ) then self[jnd1].img.Free;
//  if Assigned( self[jnd1].gWdCopy ) then self[jnd1].gWdCopy.Free;
  inherited;
end;

destructor prqTimgsArr.Destroy;
var
  FCount, j1: Integer;
begin
  FCount := Count;

  if FCount > 0 then
  begin
    for j1 := 1 to FCount do
    begin
      if Assigned( self[j1].img ) then self[j1].img.Free;
//      if Assigned( self[j1].gWdCopy ) then self[j1].gWdCopy.Free;
    end;
  end;
  inherited;
end;

function prqTimgsArr.findComboList(j: Integer): Integer;
var
  rCD: rcdTimgsArr;
begin
  rCD.numCombo := j;
  result := self.Find(@rCD, 1);
end;

function prqTimgsArr.findWindowList(j: Integer): Integer;
var
  rCD: rcdTimgsArr;
begin
  rCD.numWindow := j;
  result := self.Find(@rCD, 2);
end;

function prqTimgsArr.GetPntDyn(j: Integer): PrcdTimgsArr;
begin
  result := GetPnt(j);
end;

procedure prqTimgsArr.SetSize(size: Integer);
var
  FCount, j1, jOld: Integer;
begin
  FCount := Count;

  if size = FCount then Exit;

  if size < FCount then
  begin
    for j1 := size+1 to FCount do
    begin
      if Assigned( self[j1].img ) then self[j1].img.Free;
//      if Assigned( self[j1].gWdCopy ) then self[j1].gWdCopy.Free;
    end;
  end;

  jOld := FCount;
  inherited;

  FCount := Count;
  if jOld < FCount then
  begin
    for j1 := jOld+1 to FCount do
    begin
      self[j1].numCombo  := -1;
      self[j1].numWindow := -1;
      self[j1].img       := TImage.Create(nil);
      self[j1].gWd       := nil;
//      self[j1].gWdCopy   := TprqRptGrafWindow.Create;
    end;
  end;
end;

procedure TcShowImage.BitBtn4Click(Sender: TObject);
var
//  Msg: TMessage;
  jM, j1, jNom{, jC1, jSelf, jBoss}: Integer;
  s1: String;
begin
  inherited;

  jM := self.fMode;
  try

    self.fMode := 0; // Перевод в масштаб листа
    CreateAllImage;

// Сохранение файлов
    if fJob.gList.isDrawWnd(1) then
    begin
        jNom := self.fImage1.findWindowList(1);
        s1 := fJob.bmpSgtGraphReprtName;
        self.fImage1[jNom].img.Picture.Bitmap.SaveToFile(s1);
    end;

//    cArchiv.Count := 0; // Забыть об истории сразу

// Известить, что рисунки готовы
    uSupport.SendMessageToParent(self.taskParam, self.jUniKeySelf,
                          pc005_110_AcceptMsg1, 0, 0, 0, false, j1);
    Application.ProcessMessages;
//    self.fSaveMode := true;
//    Close;
  finally
    self.fMode := jM;
    self.RepaintImage2(Sender);
  end;

end;

procedure TcShowImage.RepaintImage(Sender: TObject);
begin
  fSource := Image1.ClientRect;
  yShift := 0;
  RepaintImage2(Sender);
end;

procedure TcShowImage.LineRepaint(const pnt: TPoint; Width: Integer;
  Color: TColor);
var
  pnt1: TPoint;
//  fgWind: TprqRptGrafWindow;
begin
  Image1.Picture.Bitmap.Canvas.Pen.Mode := pmNotXor;
  Image1.Picture.Bitmap.Canvas.Pen.Style := psSolid;
  Image1.Picture.Bitmap.Canvas.Pen.Width := Width;
  Image1.Picture.Bitmap.Canvas.Pen.Color := Color;

//  fgWind := self.fImage1[self.fImage1.findWindowList(self.numList)].gWd;

  pnt1.X := fJob.gList.logToPointX(fJob.gList.LogOtsLeft + pc003_127_App_Shift1 + pc003_127_App_Shift2 + pc003_127_App_Shift5);
  pnt1.Y := pnt.Y;

  Image1.Picture.Bitmap.Canvas.MoveTo(pnt1.X,  pnt1.Y);

  pnt1.X := fJob.gList.logToPointX(fJob.gList.LogWidth - fJob.gList.LogOtsRight - pc003_127_App_Shift1);
  Image1.Picture.Bitmap.Canvas.LineTo(pnt1.X,  pnt1.Y);

{
  pnt1.X := fJob.gList.logToPointX(fgWind.wnd_Graf.Left);
  pnt1.Y := pnt.Y;

  Image1.Picture.Bitmap.Canvas.MoveTo(pnt1.X,  pnt1.Y);

  pnt1.X := fJob.gList.logToPointX(fgWind.wnd_Graf.Right);
  Image1.Picture.Bitmap.Canvas.LineTo(pnt1.X,  pnt1.Y);
}
  Image1.Picture.Bitmap.Canvas.Pen.Mode := pmCopy;
end;

procedure TcShowImage.intervalLineRepaint(const pnt: TPoint);
begin
  LineRepaint(pnt, 3, pc005_110_CB01_05cl);
end;

procedure TcShowImage._NewInterval_D;
var
j1: Integer;
begin // MouseDown...
  if not ([ssLeft] = self.DescriptMouse.pntShift) then Exit;

  j1 := self.Intervals.Count;

  case j1  of
0: // ввод 1-й точки
    begin
      self.Intervals.Count     := 1;
      self.Intervals[1].dTime  := self.DescriptMouse.dTime;
      self.Intervals[1].pntImg := self.DescriptMouse.pntImg;
      self.Intervals[1].pntLog := self.DescriptMouse.pntLog;
//      intervalLineRepaint(self.Intervals[1].pntImg);
      intervalLineRepaint(self.Intervals[1].dTime);
      self.Intervals.intMod    := 1; // Редактируем 1-ю точку
    end;

1: // ввод 2-й точки
    begin
      self.Intervals.Count     := 2;
      self.Intervals[2].dTime  := self.DescriptMouse.dTime;
      self.Intervals[2].pntImg := self.DescriptMouse.pntImg;
      self.Intervals[2].pntLog := self.DescriptMouse.pntLog;
//      intervalLineRepaint(self.Intervals[2].pntImg);
      intervalLineRepaint(self.Intervals[2].dTime);
      self.Intervals.intMod    := 2; // Редактируем 1-ю точку
    end;

2: // редактирование ближайшей точки
    begin
      self.Intervals.intMod    := self.Intervals.FindNearest(self.DescriptMouse.dTime);
      _NewInterval_M;
    end;

  end;
end;

procedure TcShowImage._NewInterval_M;
begin
  if not ([ssLeft] = self.DescriptMouse.pntShift) then Exit;
  if self.Intervals.intMod <= 0 then Exit;
  if self.Intervals.intMod > self.Intervals.Count then Exit;

//  intervalLineRepaint(self.Intervals[self.Intervals.intMod].pntImg);
  intervalLineRepaint(self.Intervals[self.Intervals.intMod].dTime);

//  intervalLineRepaint(self.DescriptMouse.pntImg);
  intervalLineRepaint(self.DescriptMouse.dTime);
  self.DescriptMouse.pntImgDown := self.DescriptMouse.pntImg;

  self.Intervals[self.Intervals.intMod].dTime  := self.DescriptMouse.dTime;
  self.Intervals[self.Intervals.intMod].pntImg := self.DescriptMouse.pntImg;
  self.Intervals[self.Intervals.intMod].pntLog := self.DescriptMouse.pntLog;
end;

procedure TcShowImage._NewInterval_U;
begin
  if not ([] = self.DescriptMouse.pntShift) then Exit;
  if self.Intervals.intMod <= 0 then Exit;
  if self.Intervals.intMod > self.Intervals.Count then Exit;

  if self.DescriptMouse.pntBGraf then
  begin
//    if self.Intervals.Count > 1 then self.Intervals.Sort(1);
    self.Intervals.intMod := 0;
  end

  else
  begin
// Отменили отрисовку
//    intervalLineRepaint(self.Intervals[self.Intervals.intMod].pntImg);
    intervalLineRepaint(self.Intervals[self.Intervals.intMod].dTime);
    self.Intervals.Delete(self.Intervals.intMod);
    self.Intervals.intMod := 0;
  end;
end;

procedure TcShowImage.IntervalRepaint;
var
  pnt1, pnt2: TPoint;
  jC1: Integer;
  fgWind: TprqRptGrafWindow;
begin
  if self.Intervals.Count = 0 then Exit;

  fgWind := self.fImage1[self.fImage1.findWindowList(self.numList)].gWd;

  for jC1 := 1 to self.Intervals.Count do
  begin
    if (self.dtCrntBeg > self.Intervals[jC1].dTime) or (self.dtCrntEnd < self.Intervals[jC1].dTime) then continue;
    pnt1.Y := fgWind.dTimeScale.getYfromTime( self.Intervals[jC1].dTime );

    pnt2.X := fJob.gList.logToPointX(fgWind.wnd_Graf.Left);
    pnt2.Y := fJob.gList.logToPointY(pnt1.Y) - yShift;

//    if not TprqAGallfunc.isInternalPoint(pnt2, Image1.ClientRect, True) then continue;
    intervalLineRepaint(pnt2);
  end;
end;

procedure TcShowImage.intervalLineRepaint(const dTime: Double);
var
  pnt1, pnt2: TPoint;
  fgWind: TprqRptGrafWindow;
begin
  fgWind := self.fImage1[self.fImage1.findWindowList(self.numList)].gWd;

  if (self.dtCrntBeg > dTime) or (self.dtCrntEnd < dTime) then Exit;

  pnt1.Y := fgWind.dTimeScale.getYfromTime( dTime );

  pnt2.X := fJob.gList.logToPointX(fgWind.wnd_Graf.Left);
  pnt2.Y := fJob.gList.logToPointY(pnt1.Y) - yShift;
//  if not TprqAGallfunc.isInternalPoint(pnt2, Image1.ClientRect, True) then Exit;

  intervalLineRepaint(pnt2);
end;

procedure TcShowImage.BitBtn5Click(Sender: TObject);
var
  uEd_Par: TcEditParam2;
  fgWind: TprqRptGrafWindow;
begin
  inherited;

  if self.Intervals.Count < 2 then
  begin
    ShowMessage(pc005_110_131);
    Exit;
  end;

  uEd_Par := TcEditParam2.Create(self);
  uEd_Par.bTag := True;
  uEd_Par.taskParam := taskParam;
  registryObj(taskParam, uEd_Par.jUniKeySelf, jUniKeySelf, uEd_Par.jUniType, uEd_Par);
  uEd_Par.bTag  := True;
  uEd_Par.bGeom := True;
  uEd_Par.getParam;

  AddCurrentState;
  
  fgWind := self.fImage1[self.fImage1.findWindowList(self.numList)].gWd;
  uEd_Par.Init(fjob, self.Intervals, fgWind);
  uEd_Par.ShowModal;
end;

procedure TcShowImage.StringSign;
var
  jC1: Integer;
  fgWind: TprqRptGrafWindow;
  pg: TprqRptGraf1;
begin
  self.StringGrid1.Cells[0,0] := pc005_110_GD1_0_0;
  self.StringGrid1.Cells[1,0] := pc005_110_GD1_1_0;
  fgWind := self.fImage1[self.fImage1.findWindowList(self.numList)].gWd;
  for jC1 := 1 to fgWind.Grafiks.Count do
  begin
    pg := fgWind.Grafiks[jC1].ukz as TprqRptGraf1;
    if pg.bActive then
    begin
      self.StringGrid1.Cells[0,jC1] := pg.sName;
    end;
  end;
end;

procedure TcShowImage.StringParShow;
var
  j1, jC1: Integer;
  fgWind: TprqRptGrafWindow;
  pg: TprqRptGraf1;
  Value: Double;
begin
  if self.DescriptMouse.pntBGraf then
  begin
    fgWind := self.fImage1[self.fImage1.findWindowList(self.numList)].gWd;
    for jC1 := 1 to fgWind.Grafiks.Count do
    begin
      pg := fgWind.Grafiks[jC1].ukz as TprqRptGraf1;
      if pg.bActive then
      begin
        if self.DescriptMouse.eNum > 0 then
        begin
          j1 := pg.FindIndexForTime(self.DescriptMouse.dTime,
                                    self.fJob.gList.Etaps[self.DescriptMouse.eNum].Number,
                                    Value,
                                    self.fjob.OtherParams);
        end
        else
        begin
          j1 := pg.FindIndexForTime(self.DescriptMouse.dTime,
                                    1,
                                    Value,
                                    self.fjob.OtherParams);
        end;

        if j1 > 0 then
        begin
          self.StringGrid1.Cells[1,jC1] := Trim(FormatFloat('#####0.0##', Value));
        end
        else
          self.StringGrid1.Cells[1,jC1] := '';
      end;
    end;
  end
  else
  begin
    uSupport.prqClearGridUserR(self.StringGrid1);
  end;
end;

procedure TcShowImage.RepaintImage2(Sender: TObject);
begin
  IntervalRepaint;

  CreateAllImage;
  ImageTransfer(self.numList);

  IntervalRepaint;
end;

procedure TcShowImage.BitBtn6Click(Sender: TObject);
var
  jC1, j1: Integer;
begin
  inherited;

  if MessageDlg(pc005_110_005,   mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    j1 := cArchiv.Count;
    self.fJob.gList.CloneClass((cArchiv[j1].ukz as TScreenShot1).fgListArch);

    self.fjob.OtherParams.Clone((cArchiv[j1].ukz as TScreenShot1).fOtherParams);
    for jC1 := 1 to self.fjob.OtherParams.Count do
    begin
      self.fjob.OtherParams[jC1].ukz := TprqRptTX.Create;
      (self.fjob.OtherParams[jC1].ukz as TprqRptTX).CloneClass((cArchiv[j1].ukz as TScreenShot1).fOtherParams[jC1].ukz as TprqRptTX);
    end;

    if j1 > 1 then
    begin
      cArchiv.Delete(j1);
    end;

{
    uSupport.SendMessageToParent(self.taskParam, self.jUniKeySelf,
                          pc003_133_AcceptMsg, 0, 0, 0, true, j1);
}
    self.Init1;

    RepaintImage2(Sender);
    ShowMessage(pc005_110_006);
  end;
end;

procedure TcShowImage.Init1;
var
  j1, jC1: Integer;
begin
//  self.ComboBox2.Items.Clear;
  numList   := 0;
  self.fImage1.Count := 0;
  self.fImage1.Count := fJob.gList.getActiveListCount;
  j1 := 0;
  for jC1 := 1 to fJob.gList.GrafWindows.Count do
  begin

    if fJob.gList.isDrawWnd(jC1) then
    begin
//      self.ComboBox2.Items.Add(pc005_110_002 + IntToStr(jC1));

      Inc(j1);
      self.fImage1[j1].numCombo  := j1;
      self.fImage1[j1].numWindow := jC1;
      self.fImage1[j1].gWd       := fJob.gList.GrafWindows[jC1].ukz as TprqRptGrafWindow;
{
      if numList = 0 then
      begin
        self.numList             := jC1;
        self.ComboBox2.ItemIndex := self.ComboBox2.Items.Count - 1;
      end;
}
    end;

  end;

  self.numList             := 1;

//  EtapNew.AppendClass(fJob.gList.Etaps);
//  fJob.gList.Etaps.Sort(2);

//  setMode;
  self.fMode := 1;
  StringSign;
end;

procedure TcShowImage.LineRepaint(const pnt: TPoint; Width: Integer;
  Color: TColor; fgWind: TprqRptGrafWindow; img: TImage);
var
  pnt1: TPoint;
begin
  img.Picture.Bitmap.Canvas.Pen.Mode := pmNotXor;
  img.Picture.Bitmap.Canvas.Pen.Style := psSolid;
  img.Picture.Bitmap.Canvas.Pen.Width := Width;
  img.Picture.Bitmap.Canvas.Pen.Color := Color;

  pnt1.X := fJob.gList.logToPointX(fJob.gList.LogOtsLeft + pc003_127_App_Shift1 + pc003_127_App_Shift2 + pc003_127_App_Shift5);
  pnt1.Y := pnt.Y;

  img.Picture.Bitmap.Canvas.MoveTo(pnt1.X,  pnt1.Y);

  pnt1.X := fJob.gList.logToPointX(fJob.gList.LogWidth - fJob.gList.LogOtsRight - pc003_127_App_Shift1);
  img.Picture.Bitmap.Canvas.LineTo(pnt1.X,  pnt1.Y);

{
  pnt1.X := fJob.gList.logToPointX(fgWind.wnd_Graf.Left);
  pnt1.Y := pnt.Y;

  img.Picture.Bitmap.Canvas.MoveTo(pnt1.X,  pnt1.Y);

  pnt1.X := fJob.gList.logToPointX(fgWind.wnd_Graf.Right);
  img.Picture.Bitmap.Canvas.LineTo(pnt1.X,  pnt1.Y);
}
  img.Picture.Bitmap.Canvas.Pen.Mode := pmCopy;
end;

procedure TcShowImage.CreateAllImage;
var
  myImage1: TImage;
  dHeight, dWidth: Double;
  jcScale, jNom, jC1: Integer;
  sCl: double;
begin
  if self.fMode = 0 then
  begin
// Экспорт графиков в Excel
    dWidth  := PixelsPerInch *  8.3;
    dHeight := PixelsPerInch * 11.7;
    sCl := 0.687;
  end
  else
  begin
// на экран
    dWidth  := Image1.Width;
    dHeight := Image1.Height;

    self.fjob.gList.LogWidth  := Round( (dWidth  * 253) / PixelsPerInch );
    self.fjob.gList.LogHeight := Round( (dHeight * 253) / PixelsPerInch );
    sCl := 0.934;
  end;

  self.fjob.pctWidth  := Round(dWidth);
  self.fjob.pctHeight := Round(dHeight);

  for jC1 := 1 to fJob.gList.GrafWindows.Count do
  begin
    if fJob.gList.isDrawWnd(jC1) then
    begin
      myImage1 := self._CreateImage(self.fjob.pctWidth, self.fjob.pctHeight);
      try

        if self.FdepImgParam.crntStepIndx < 0 then
        begin // Подгонка начального шага
{
  if self.FdepImgParam.crntStepIndx = 17 then // шаг =  30 секунд     17  2
  if self.FdepImgParam.crntStepIndx = 4 then // шаг =  4 часа             4  2
}

          self.dtCrntBeg := self.fjob.gList.dtJobBeg;
          self.dtCrntEnd := self.fjob.gList.dtJobEnd;

          for jcScale := 17 downto 4 do
          begin
            self.FdepImgParam.crntStepIndx := jcScale;
//            self._ClearCanvas(myImage1.Picture.Bitmap.Canvas, self.fjob.pctWidth, self.fjob.pctHeight);

            fJob.gList.getTimeRegion(jC1, myImage1.Canvas,
  self.FdepImgParam.crntStepIndx, sCl, self.dtCrntBeg, self.dtCrntEnd,
  self.outCrntBeg, self.outCrntEnd, 1,
  myImage1.Picture.Bitmap.Width, myImage1.Picture.Bitmap.Height);
{
            fJob.gList.imageListU2(jC1, myImage1.Picture.Bitmap,
self.fjob.OtherParams, self.FdepImgParam.crntStepIndx, sCl, self.dtCrntBeg, self.dtCrntEnd,
self.outCrntBeg, self.outCrntEnd, 1, 0, 0);
}
            if self.dtCrntEnd <= self.outCrntEnd then
            begin
              self._ClearCanvas(myImage1.Picture.Bitmap.Canvas, self.fjob.pctWidth, self.fjob.pctHeight);
              fJob.gList.imageListU2(jC1, myImage1.Picture.Bitmap,
self.fjob.OtherParams, self.FdepImgParam.crntStepIndx, sCl, self.dtCrntBeg, self.dtCrntEnd,
self.outCrntBeg, self.outCrntEnd, 1, 0, 0);
              break;
            end;
          end;
        end
        else
        begin
          self.FdepImgParam.crntStep := getStepDate(self.FdepImgParam.crntStepIndx);
          self.dtCrntBeg := self.fjob.gList.dtJobBeg + (self.FdepImgParam.crntStep * self.FdepImgParam.crntShft);
          self.dtCrntEnd := self.fjob.gList.dtJobEnd;

          fJob.gList.imageListU2(jC1, myImage1.Picture.Bitmap,
self.fjob.OtherParams, self.FdepImgParam.crntStepIndx, sCl, self.dtCrntBeg, self.dtCrntEnd,
self.outCrntBeg, self.outCrntEnd, 1, 0, 0);
        end;

        jNom := self.fImage1.findWindowList(jC1);
        self.fImage1[jNom].img.Picture.Bitmap.Assign( myImage1.Picture.Bitmap );

      finally
        myImage1.Free;
      end;

      break;
    end;
  end;
end;

procedure TcShowImage.ImageTransfer(num: Integer);
var
  jNom: Integer;
  Dest: TRect;
begin
  jNom := self.fImage1.findWindowList(num);
  if jNom > 0 then
  begin
    Image1.Picture.Bitmap.Assign(
      self.fImage1[self.fImage1.findWindowList(jNom)].img.Picture.Bitmap
      );

    Dest :=  Image1.ClientRect;
    Image1.Canvas.CopyRect(
      Dest,
      self.fImage1[self.fImage1.findWindowList(jNom)].img.Canvas,
      self.fSource);
  end;
end;

procedure TcShowImage.BitBtn2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  self.bigStep := self.CheckBox1.Checked;
  picUp;
end;

procedure TcShowImage.BitBtn3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  self.bigStep := self.CheckBox1.Checked;
  picDown;
end;

procedure TcShowImage.unknowDialogMessage(var Msg: TMessage;
  kode: Integer);
begin
  if kode = WM_User_Dialog then
  begin
    case Msg.WParamLo of // Номер процесса

pc003_132_AcceptMsg:
      begin // Обновлена таблица этапов и параметры
        RepaintImage2(Self);
        Exit;
      end;

    end;
  end;

  inherited;
end;

function TcShowImage.isBegOfStage(eNum: Integer; dTime: Double): Boolean;
var
  dBeg, dEnd: Double;
begin
  if eNum <= 0 then
  begin                    
    result := isBegOfIntrval(dTime, self.fJob.gList.dtJobBeg, self.fJob.gList.dtJobEnd);
    Exit;
  end;
  dBeg := abs(dTime - self.fJob.gList.Etaps[eNum].dataBeg);
  dEnd := abs(dTime - self.fJob.gList.Etaps[eNum].dataEnd);
  result := dBeg <= dEnd;
end;

function TcShowImage.isBegOfIntrval(dTime, jobBeg, jobEnd: Double): Boolean;
var
  dBeg, dEnd: Double;
begin
  if fJob.gList.Etaps.Count > 0 then
  begin
    if fJob.gList.Etaps[1].dataBeg > dTime then
    begin
      result := True;
    end
    else
    begin
      result := False;
    end;
  end
  else
  begin
    dBeg := abs(dTime - jobBeg);
    dEnd := abs(dTime - jobEnd);
    result := dBeg <= dEnd;
  end
end;

procedure TcShowImage.BitBtn7Click(Sender: TObject);
var
  pDD: TcDEPgrafQuery1;
  j1: Integer;
begin
  inherited;
  pDD := TcDEPgrafQuery1.Create(self);
  pDD.taskParam := taskParam;
  registryObj(taskParam, pDD.jUniKeySelf, jUniKeySelf, pDD.jUniType, pDD);
  pDD.bTag  := True;
  pDD.bGeom := True;
  pDD.getParam;
  pDD.CreateIMG(self.fjob);
  pDD.BitBtn1.Caption := pc005_110_008;
  pDD.ShowModal;

  if not self.fjob.DOit then Exit;

  if not
     uSupport.SendMessageToParent(self.taskParam, self.jUniKeySelf,
                                    pc005_110_AcceptMsg, 0, 0, 0, true, j1)
  then Exit;

  BitBtn9Click(Sender); // удалить интервал
  RepaintImage2(Sender);
end;

procedure TcShowImage.BitBtn9Click(Sender: TObject);
begin
  inherited;
  if self.Intervals.Count = 0 then Exit;
  IntervalRepaint;
  self.Intervals.Count := 0;
end;

procedure TcShowImage.AddCurrentState;
var
  jC1, j1: Integer;
begin

  j1        := cArchiv.Count + 1;
  cArchiv.Count := j1;
  cArchiv[j1].ukz := TScreenShot1.Create;

  (cArchiv[j1].ukz as TScreenShot1).fgListArch.CloneClass(self.fJob.gList);
  (cArchiv[j1].ukz as TScreenShot1).fOtherParams.Clone(self.fjob.OtherParams);
  for jC1 := 1 to self.fjob.OtherParams.Count do
  begin
    (cArchiv[j1].ukz as TScreenShot1).fOtherParams[jC1].ukz := TprqRptTX.Create;
    ((cArchiv[j1].ukz as TScreenShot1).fOtherParams[jC1].ukz as TprqRptTX).CloneClass(self.fjob.OtherParams[jC1].ukz as TprqRptTX);
  end;
end;

function TcShowImage._CreateImage(pctWidth, pctHeight: integer): TImage;
var
  r: TRect;
begin
  result := TImage.Create(nil);
  result.Width := pctWidth;
  result.Height := pctHeight;
  result.Picture.Bitmap.Width  := pctWidth;
  result.Picture.Bitmap.Height := pctHeight;
  r.Left   := 0;
  r.Top    := 0;
  r.Right  := pctWidth;
  r.Bottom := pctHeight;
  result.Canvas.Brush.Color := clWhite;
  result.Canvas.FillRect(r);
end;

procedure TcShowImage.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
{
  if not self.fSaveMode then
  begin
    if self.cArchiv.Count > 1 then
    begin
      w1 := MessageDlg(pc005_110_007,   mtConfirmation, [mbYes, mbCancel, mbNo], 0);
      if w1 = mrCancel then
      begin
        CanClose := false;
        Exit;
      end;
      if w1 <> mrYes then
      begin
        j1 := 1;
        self.fJob.gList.CloneClass((cArchiv[j1].ukz as TScreenShot1).fgListArch);
        self.fjob.OtherParams.Clone((cArchiv[j1].ukz as TScreenShot1).fOtherParams);
        for jC1 := 1 to self.fjob.OtherParams.Count do
        begin
          self.fjob.OtherParams[jC1].ukz := TprqRptTX.Create;
          (self.fjob.OtherParams[jC1].ukz as TprqRptTX).CloneClass((cArchiv[j1].ukz as TScreenShot1).fOtherParams[jC1].ukz as TprqRptTX);
        end;
      end;
    end;
  end;
}
  inherited;
end;

function TcShowImage.getStepDate(jNum: integer): double;
var
  sc: TprqTimeScale1;
begin
  sc := TprqTimeScale1.Create;
  try
    if jNum < 1 then
    begin
      jNum := 1;
    end
    else
    if jNum > sc.Count then
    begin
      jNum := sc.Count;
    end;
    result := sc[jNum]^;
  finally
    sc.Free;
  end;
end;

procedure TcShowImage.BitBtn1Click(Sender: TObject);
var
  delta: double;
begin
  inherited;
  if self.FdepImgParam.crntStepIndx = 17 then // шаг =  30 секунд     17  2
  begin
    Exit;
  end;

  self.FdepImgParam.crntStep := getStepDate(self.FdepImgParam.crntStepIndx);
  delta := self.FdepImgParam.crntStep * self.FdepImgParam.crntShft;
  Inc(self.FdepImgParam.crntStepIndx);
  self.FdepImgParam.crntStep := getStepDate(self.FdepImgParam.crntStepIndx);
  self.FdepImgParam.crntShft := Trunc(delta / self.FdepImgParam.crntStep);
  self.RepaintImage2(Self);
  self.setMaxScrollBar;
  self.SetScrollBar;
end;

procedure TcShowImage.BitBtn8Click(Sender: TObject);
var
  delta: double;
begin
  inherited;
  if self.FdepImgParam.crntStepIndx = 4 then // шаг =  4 часа             4  2
  begin
    Exit;
  end;

  self.FdepImgParam.crntStep := getStepDate(self.FdepImgParam.crntStepIndx);
  delta := self.FdepImgParam.crntStep * self.FdepImgParam.crntShft;
  Dec(self.FdepImgParam.crntStepIndx);
  self.FdepImgParam.crntStep := getStepDate(self.FdepImgParam.crntStepIndx);
  self.FdepImgParam.crntShft := Trunc(delta / self.FdepImgParam.crntStep);
  self.RepaintImage2(Self);
  self.setMaxScrollBar;
  self.SetScrollBar;
end;

procedure TcShowImage.SetScrollBar;
begin
  self.bScroll := true;
  try
    self.ScrollBar1.Position := self.FdepImgParam.crntShft;
  finally
    self.bScroll := false;
  end;
end;

procedure TcShowImage.setMaxScrollBar;
var
  delta: double;
  j1: integer;
begin
  self.bScroll := true;
  try
    self.FdepImgParam.crntStep := getStepDate(self.FdepImgParam.crntStepIndx);
    delta := self.fjob.gList.dtJobEnd - self.fjob.gList.dtJobBeg;

    j1 := Trunc(delta / self.FdepImgParam.crntStep) + 1;
    self.ScrollBar1.Max := j1;
  finally
    self.bScroll := false;
  end;
end;

procedure TcShowImage.ScrollBar1Change(Sender: TObject);
var
  dtEnd: double;
begin
  inherited;
  if self.bScroll then
  begin
    Exit;
  end;

  self.FdepImgParam.crntShft := self.ScrollBar1.Position;
  self.FdepImgParam.crntStep := getStepDate(self.FdepImgParam.crntStepIndx);
  repeat
    dtEnd := self.fjob.gList.dtJobBeg + (self.FdepImgParam.crntStep * (self.FdepImgParam.crntShft + 1));
    if dtEnd < self.fjob.gList.dtJobEnd then
    begin
      break;
    end;
    Dec(self.FdepImgParam.crntShft);
  until self.FdepImgParam.crntShft = 0;

  self.RepaintImage2(Self);

  try
    self.StringGrid1.SetFocus;
  except
  end;
end;

procedure TcShowImage.BitBtn10Click(Sender: TObject);
var
  j1, jM: integer;
  sErr: string;
begin
  inherited;
  jM := self.fMode;
  try

    self.fMode := 2;
    j1 := self.getImagePageCount(sErr);
    if j1 < 0 then
    begin
      ShowMessage( sErr );
      Exit;
    end;

    self.PrintDialog1.MaxPage := j1;
    self.PrintDialog1.FromPage := 1;
    self.PrintDialog1.ToPage := j1;

    if self.PrintDialog1.Execute then
    begin
        case self.PrintDialog1.PrintRange of
          prAllPages: j1 := 0;
          prPageNums: j1 := 1;
          prSelection:j1 := 2;
        end;

        self.printImagePage(j1, self.PrintDialog1.FromPage,
  self.PrintDialog1.ToPage, self.PrintDialog1.MaxPage);

    end;

  finally
    self.fMode := jM;
    self.RepaintImage2(Self);
  end;
end;

function TcShowImage.getImagePageCount(var sErr: string): integer;
var
  myImage1: TImage;
  dHeight, dWidth: Double;
  FpctHeight, FpctWidth, jC1: Integer;
  FdtCrntBeg, FdtCrntEnd, FdtBeg, FdtEnd, sCl: double;
  txtScale: double;
begin
  dWidth  := Printer.PageWidth;
  dHeight := Printer.PageHeight;
  sCl := 0.715625; // Настройка для PDF Complit
  txtScale := 300e0 / 96e0;
  result := 0;

  FpctWidth  := Round(dWidth);
  FpctHeight := Round(dHeight);

  for jC1 := 1 to fJob.gList.GrafWindows.Count do
  begin
    if fJob.gList.isDrawWnd(jC1) then
    begin
      myImage1 := self._CreateImage(FpctWidth, FpctHeight);
      try

        self.FdepImgParam.crntStep := getStepDate(self.FdepImgParam.crntStepIndx);
        FdtCrntBeg := self.fjob.gList.dtJobBeg;
        FdtCrntEnd := self.fjob.gList.dtJobEnd;

        try
          while FdtCrntEnd > FdtCrntBeg do
          begin
            fJob.gList.imageListU2(jC1, myImage1.Picture.Bitmap,
self.fjob.OtherParams, self.FdepImgParam.crntStepIndx, sCl,
FdtCrntBeg, FdtCrntEnd, FdtBeg, FdtEnd, txtScale, 0, 0);
            FdtCrntBeg := FdtEnd;
            Inc(result);
          end;
        except
          on E: Exception do
          begin
            result := -1;
            sErr   := E.Message;
            Exit;
          end;
        end;

      finally
        myImage1.Free;
      end;
      Exit;
    end;
  end;
end;

procedure TcShowImage.printImagePage(jMode, n1, n2, maxPage: integer);
var
  dHeight, dWidth: Double;
  jn1, jn2, jCrntPageNum, FpctHeight, FpctWidth, jC1: Integer;
  FdtCrntBeg, FdtCrntEnd, FdtBeg, FdtEnd, sCl: double;
  sErr: string;
  bFirst: boolean;
  txtScale: double;
begin
  dWidth  := Printer.PageWidth;
  dHeight := Printer.PageHeight;
  sCl := 0.715625; // Настройка для PDF Complit
  txtScale := 1; //300e0 / 96e0;
//  sCl := 0.687; // Настройка для экрана монитора
//  sCl := 0.934; // Настройка для экспорта в Excell
//  sCl := 1;
  jCrntPageNum := 0;
  bFirst := true;

  FpctWidth  := Round(dWidth);
  FpctHeight := Round(dHeight);

  Printer.Title := pc005_110_PrinterTitle;
  Printer.BeginDoc;
  try

    for jC1 := 1 to fJob.gList.GrafWindows.Count do
    begin
      if fJob.gList.isDrawWnd(jC1) then
      begin

        self.FdepImgParam.crntStep := getStepDate(self.FdepImgParam.crntStepIndx);
        FdtCrntBeg := self.fjob.gList.dtJobBeg;
        FdtCrntEnd := self.fjob.gList.dtJobEnd;

        jn1 := 0;
        jn2 := maxPage;
        try

          while FdtCrntEnd > FdtCrntBeg do
          begin
//            myImage1 := self._CreateImage(FpctWidth, FpctHeight);
//            Source := myImage1.ClientRect;
//            Dest := myImage1.ClientRect;
//                     Printer.Canvas.CopyRect(Dest, myImage1.Canvas, Source);
//                     myImage1.Picture.SaveToFile('tst.bmp');
//                       ShowMessage(IntToStr(jCrntPageNum));

            Inc(jCrntPageNum);

            case jMode of
              0: begin
                   jn1 := jCrntPageNum;
                 end;
              1: begin
                   jn1 := jCrntPageNum;
                 end;
              2: begin
                   FdtCrntBeg := self.outCrntBeg;
                 end;
            end;

            case jMode of

              0: begin
                   if not bFirst then
                   begin
                     Printer.NewPage;
                   end;
                   fJob.gList.printListU2(jC1, Printer.Canvas,
self.fjob.OtherParams, self.FdepImgParam.crntStepIndx, sCl,
FdtCrntBeg, FdtCrntEnd, FdtBeg, FdtEnd, txtScale, jn1, jn2, FpctWidth, FpctHeight);
                   bFirst := false;
                 end;

              1: begin
                   if (jCrntPageNum >= n1) and (jCrntPageNum <= n2) then
                   begin
                     if not bFirst then
                     begin
                       Printer.NewPage;
                     end
                     else
                     begin
                       self._ClearCanvas(Printer.Canvas, FpctWidth, FpctHeight);
                     end;
                     fJob.gList.printListU2(jC1, Printer.Canvas,
self.fjob.OtherParams, self.FdepImgParam.crntStepIndx, sCl,
FdtCrntBeg, FdtCrntEnd, FdtBeg, FdtEnd, txtScale, jn1, jn2, FpctWidth, FpctHeight);
                     bFirst := false;
                   end
                   else
                   begin
                     fJob.gList.printListU2(jC1, Printer.Canvas,
self.fjob.OtherParams, self.FdepImgParam.crntStepIndx, sCl,
FdtCrntBeg, FdtCrntEnd, FdtBeg, FdtEnd, txtScale, jn1, jn2, FpctWidth, FpctHeight);
                   end;
                   if jCrntPageNum = n2 then break;
                 end;

              2: begin
// анализ FdtBeg, FdtEnd - сравнить с текущим положением окна: self.outCrntBeg, self.outCrntEnd
                   fJob.gList.printListU2(jC1, Printer.Canvas,
self.fjob.OtherParams, self.FdepImgParam.crntStepIndx, sCl,
FdtCrntBeg, FdtCrntEnd, FdtBeg, FdtEnd, txtScale, jn1, jn2, FpctWidth, FpctHeight);
                   break;
                 end;
            end;

            FdtCrntBeg := FdtEnd;
          end;

        except
          on E: Exception do
          begin
            sErr   := E.Message;
            ShowMessage(sErr);
            Exit;
          end;
        end;

        Break;
      end;
    end;

  finally
    Printer.EndDoc;
  end;

{
      s1 := 'Parameters:' + #13#10 +
            '    Collate = ' + BoolToStr(self.PrintDialog1.Collate) + #13#10 +
            '     Copies = ' + IntToStr(self.PrintDialog1.Copies) + #13#10 +
            '    MaxPage = ' + IntToStr(self.PrintDialog1.MaxPage) + #13#10 +
            '    MinPage = ' + IntToStr(self.PrintDialog1.MinPage) + #13#10 +
            ' PrintRange = ' + IntToStr(j1) + #13#10 +
            'PrintToFile = ' + BoolToStr(self.PrintDialog1.Collate) + #13#10 +
            '   FromPage = ' + IntToStr(self.PrintDialog1.FromPage) + #13#10 +
            '     ToPage = ' + IntToStr(self.PrintDialog1.ToPage);
      ShowMessage(s1);
}
end;

procedure TcShowImage.BitBtn11Click(Sender: TObject);
begin
  inherited;
  self.PrintScale := poPrintToFit; //poNone; //poProportional;//
  self.Print;
end;

procedure TcShowImage._ClearCanvas(canva: TCanvas; pctWidth, pctHeight: integer);
var
  r: TRect;
begin
  r.Left   := 0;
  r.Top    := 0;
  r.Right  := pctWidth;
  r.Bottom := pctHeight;
  canva.Brush.Style := bsSolid;
  canva.Brush.Color := clWhite;
  canva.FillRect(r);
end;

end.
