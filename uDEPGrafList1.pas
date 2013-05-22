unit uDEPGrafList1;
//pc003_127_... // uRptGrafList1 �������� ������������ ����� ������ � Raport...

interface
uses
  Windows, Classes, SysUtils, Math, Dialogs, uMainData, uAbstrArray, Graphics,
  Printers, uAbstrGeometry, ExtCtrls, uGraphPatterns1const;

const
  pc005_505_jMain       = 5505;

  pc005_505_SHB_NamPar_1      = '����';
  pc005_505_SHB_NamPar_2      = '�������������';
  pc005_505_SHB_NamPar_3      = '����';
  pc005_505_SHB_NamPar_4      = '��������';
  pc005_505_SHB_NamPar_5      = '��������';
  pc005_505_SHB_NamPar_6      = '���������';
  pc005_505_SHB_NamPar_7      = '��� �����/�������';
  pc005_505_SHB_NamPar_8      = '������������� ����: ';

  pc005_505_SHB_NamPar_14     = '��������� �����';
  pc005_505_SHB_NamPar_16     = '��������� �����';

  pc005_505_Serif             = 'MS Sans Serif';
  pc005_505_Times             = 'Times New Roman';
  pc005_505_Courier           = 'Courier New';
  pc005_505_Arial             = 'Arial';
  pc005_505_CharSet           = RUSSIAN_CHARSET;
  pc005_505_HeigtShab         = '0123456789ABCDEWXYZ';

//  pc005_505_01 = '������ "%s" �� ����� ���� ��������� - ������� ���� �����';
//  pc005_505_02 = '������ "%s" �� ����� ���� ��������� - �������� ��������� ������';
  pc005_505_03 = '%s<%s>';
  pc005_505_04 = '%s';

  pc005_505_App_Shift1        =  20; // ����� ����� ������� ������������ ����� �����
  pc005_505_App_Shift2        =  10;
  pc005_505_App_Shift3        =  10; // ����� �������� ������� ������������ ����� �����
  pc005_505_App_Shift3a       =  15; // ����� ����� ��� �������� ��������
  pc005_505_App_Shift4        =  10; // ����� ������� ����� � ���������� �����
  pc005_505_App_Shift5        = 150; // ������ ��� ������� ����� � ���������� �����
  pc005_505_App_Shift6        =  15; // ����� ����� ������� ����� � ���������� �����
  pc005_505_App_Shift7        =  10; // ������ ������ ������� ����� � ���������� �����
  pc005_505_App_Shift8        =  20; // ����� ����� �������� ������������ ���������� �� �������

  pc005_505_LogInch           = 253; // ������ ����� � �������� �� 0.1 ��
type
  TprqListFormat = (cprqListFormat_A4);

  rcdTRptGrfEtap1 = packed record
    Number             // ����� �����
      : Integer;
    dataBeg,           // ������ �����
    dataEnd            // ����� �����
      : Double;
    Name
      : String[63];    // ��� �����
  end;
  PrcdTRptGrfEtap1 = ^rcdTRptGrfEtap1;
  prqTRptGrfEtap1 = class(prqTAbstract1)
  private
    function    GetPntDyn(j: Integer): PrcdTRptGrfEtap1;
  public
    property    pntDyn[j:Integer]: PrcdTRptGrfEtap1 read GetPntDyn; default;

    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
//      1 - �������� �� Number
//      2 = �������� dataBeg:  Double;

    function    findEtapLine(dT: Double): Integer;

    procedure CloneClass(Source: prqTRptGrfEtap1);

    constructor Create;
    destructor  Destroy; override;
  end;


  TprqRptTX = class
  public
    yTime, xVal:    prqTDouble;  // ��� X, Y

    procedure CloneClass(Source: TprqRptTX);

    constructor Create;
    destructor Destroy; override;
  end;

  TprqRptGraf1 = class(TObject)
  private
//    xSize:   Integer;  // ������� ����� (��� � �� �� 0.1 �� � � ������)
//    xStep: Integer;    // ��� ��������� �� ��� X (��� � �� �� 0.1 �� � � ������)
  protected
  public
    yTime, xVal:    prqTDouble;  // ��� X, Y
    nChanal:           Integer;  // ����� ������ � ��
    arrChanal: array[1..100] of Integer;  // ������ ������� � �� � ������ ������ �� ����������
    arrXY: prqTobject;
    yNormalVol: Boolean;

    xLogSize:   Integer;  // ������� ����� (��� � �� �� 0.1 �� � � ������)
    xLogStep: Integer;    // ��� ��������� �� ��� X (��� � �� �� 0.1 �� � � ������)

    Color: TColor;        // ���� �������
    sName: String;        // �������
    sEdIzm: String;       // ������� ���������
    fnSize: Integer;      // ������ ������ ��������

    RoundMode: Integer;   // ������ ���������� - ���� �� ����������

    diaMin, diaMax: Double; // �������� ���������� (����� �������)
    sFormat: String;        // ������ ��������� �����
    dTOut: Double;          // ����-��� �������, ���� 0, �� �������� �������� ���

    bActive: Boolean;       // ���� ��������� false - �������� �� ����

    function FindIndexForTime(dt: TDateTime; num: Integer; var Value: Double): Integer; overload;
    function FindIndexForTime(dt: TDateTime; num: Integer; var Value: Double;
                              OtherParams: prqTobject): Integer; overload;
    function FindIndexForTime(dt: TDateTime; num: Integer; var Value: Double;
                              var DTime: TDateTime; OtherParams: prqTobject): Integer; overload;
    function FindNumChanal(num: Integer; OtherParams: prqTobject): Integer;

    procedure CloneClass(Source: TprqRptGraf1);

    constructor Create;
    destructor Destroy; override;
  published
  end;

  TprqTimeScale1 = class;
  TprqRptGrafList1 = class;
  TprqRptGrafList4 = class;
  TprqRptGrafWindow = class(TObject)
  private
  protected
  public
    wnd_all:     TRect; // ��������� ���� "� �����"
    wnd_Nadpisi: TRect; // ��������� ���� � ��������� - ��������� ��������
    wnd_Graf:    TRect; // ��������� ���� � ���������
    wnd_Scale:   TRect; // ��������� ���� �� ������

    dTimeScale: TprqTimeScale1; // ����� �������
    yNet: prqTInteger;                 // ���������� Y ���� ����� (���)

    Grafiks:  prqTobject;
    cntGrPodp: Integer;   // ����� ����� ��� �������� ��������
    cntXStep: Integer; // ����� ����������, �� ������� ������� ��� X

    netColor: TColor;  // ���� �����
    ramColor: TColor;  // ���� �����
    ramWidth: Integer; // ������ ����� ����� (���)
    netWidth: Integer; // ������ ����� ����� (���)
    TSclSize: Integer; // ������ ������ ����� ������� (� �������)
    bSignScaleVal: boolean; // ��������� ����� �� ����� ��������

    netYlWidth: Integer; // ������ ����� �� ����� ������� (���)
    netYscShft: Integer; // ����� ������� ������� ������������ ����� �� ����� ������� (���)
    netYStep:   Integer; // ��������� ��� ����� ����� �� Y (���)

    jDraw:    Integer; // ���� �������� (= 1)

    function isActiveGraph: boolean;

    procedure risGraf(gList: TprqRptGrafList1; graf: TprqRptGraf1; dataBeg, dataEnd: Double);

// ========================
// ��������� ��������� �������� ��� ����, ����� �� ������������ ��, ��� ������ �� ����� �����
// ���������� ��������
    procedure risGrafTOut1(gList: TprqRptGrafList1; graf: TprqRptGraf1; xVal, yTime: prqTDouble;
                           dataBeg, dataEnd: Double);
// ========================

    procedure risGrafTOutU1(gList: TprqRptGrafList1; graf: TprqRptGraf1; xVal, yTime: prqTDouble;
                           dataBeg, dataEnd: Double);
class function check(xVal, yTime: prqTDouble): Boolean;
    procedure PrintGraf(gList: TprqRptGrafList1; graf: TprqRptGraf1);
    procedure PrintEtapsLine(gList: TprqRptGrafList1);
    procedure PrintEtapsLine2(gList: TprqRptGrafList1);
    procedure PrintEtapsName(gList: TprqRptGrafList1);
    procedure PrintEtapsName2(gList: TprqRptGrafList1);
    procedure PrintScale(gList: TprqRptGrafList1); overload;

    procedure PrintScale(gList: TprqRptGrafList1; jNumScale: Integer;
dtBeg,dtEnd: double; var tBeg, tEnd: double; txtScale: double); overload;
    procedure PrintScale(gList: TprqRptGrafList4; jNumScale: Integer;
dtBeg,dtEnd: double; var tBeg, tEnd: double); overload;

    procedure PrintNetXY(gList: TprqRptGrafList1); // ������� �������������� PrintScale
    procedure PrintAllGraf(gList: TprqRptGrafList1);
    procedure PrintEtapsBorder(gList: TprqRptGrafList1);
class function getColor(num: Integer): TColor;

    procedure PrintAllGraf3(gList: TprqRptGrafList1);

    procedure signGrafList3(gList: TprqRptGrafList1);  overload; // ��������� �������� � ��������
    procedure signGrafList3(gList: TprqRptGrafList1; nGraf: integer); overload;
    procedure signGrafList3(gList: TprqRptGrafList1; nGraf: integer; txtScale: double); overload;

    procedure signGrafList3M(gList: TprqRptGrafList1; txtScale: double; pw: TprqRptGrafWindow);  overload; // ��������� �������� � ��������
    procedure signGrafList3M(gList: TprqRptGrafList4; pw: TprqRptGrafWindow);  overload; // ��������� �������� � ��������
    procedure signGrafList3MPrint(gList: TprqRptGrafList1; txtScale: double; pw: TprqRptGrafWindow);  overload; // ��������� �������� � ��������

    function getHeightsignGrafList3(gList: TprqRptGrafList1; nGraf: integer): integer; overload;
    function getHeightsignGrafList3(gList: TprqRptGrafList1; nGraf: integer;
txtScale: double): integer; overload;

    procedure PrintEtapsLine3(gList: TprqRptGrafList1);
    procedure PrintEtapsName3(gList: TprqRptGrafList1);

    procedure CloneClass(Source: TprqRptGrafWindow);

    constructor Create;
    destructor Destroy; override;
  published
  end;

  TprqTimeScale1 = class(prqTDouble)
  private
    fdMin, fdMax: Extended; //Double; // �������� ������ �����
    fyMin, fyMax, fyNetStep: Integer; // �������� ��������� � ��� �����

    dtYtoTimeStep, dtTimeToYStep, dtNetStep1: Extended; //Double; // ������ � ����������� ���� ����� �� �������
    divideYstep: Integer;   // ���������� �������� (2 ��� 3) �� ������� ������� �������� ������ �����
    dtFirstNetTime: Double; // ����� 1-� ����� ����� �� �������
    sFrm: String;
  public
    property crtNetStep: Extended read dtNetStep1;

// ������� ���������, ����������� ����������������
    procedure crtScale(dMin, dMax: Double; yMin, yMax, yNetStep: Integer); overload;
    procedure crtScale(dMin, dMax: Double; yMin, yMax, yNetStep: Integer;
jNumScale: Integer; var tBeg, tEnd: double); overload;
    function FindNearestMax(d1: Double): Double;
    procedure setScaleFormat(jNumScale: Integer);
    function getYfromTime(d1: Double): Integer;
    function getTimefromY(jY: Integer): Double;
    function getYNetTime(jN: Integer; var sT: string): Integer;

    procedure CloneClass(Source: TprqTimeScale1);

    constructor Create;
    destructor Destroy; override;
  end;

  TprqRptGrafList1 = class(TObject)
  private
    FOnlyEtapDrow: Boolean;

    fFontName:         String;
    fFontSize:        Integer;
    fFontStyle:   TFontStyles;

    procedure SetOnlyEtapDrow(const Value: Boolean);

  protected
  public
    Canvas: TCanvas;

    fntDefault: TFont;
    penDefault: TPen;
    BrushDefault: TBrush;
    sz12, sz10, sz08: Integer;

    LogHeight, // ���������� ������ � ������ ����� (� �� �� 0.1 ��)
    LogWidth,
    Height,    // ������ � ������ ����� (� ������)
    Width:
               Integer;

    ramWidth:  Integer;                // ������ ����� �������� ����� (���)
    ramColor:  TColor;                 // ���� �������� �����
    HeadFSize: Integer;                // ������ ������ ��������� (� �������)
    ScalFSize: Integer;                // ������ ������ ����� ������� (� �������)
    TimeFSize: Integer;                // ������ ������ ����� ������� (� �������)

    etpWidth:   Integer;               // ������ ����� ����� (���)
    etpColor, etpColorEnd:    TColor;  // ���� ����� �����
    etpFntSize: Integer;               // ������ ������ �������
    etpDTime:   Integer;               // ������ ������� (��������) ���� �� ������ ����� (���� ���)
    etpSign:    Boolean;               // ������� �� ������ ����������� �����

    jTOut:      Integer;               // ����-��� �������, ���� 0, �� �������� �������� ��� (� mSek)

    LogOtsLeft, LogOtsRight, LogOtsTop, LogOtsBottom: Integer; // ������ �� �����
    LogHeadLineHeight: Integer;        // ������ ���������


    WorkData, AllTime, AllVolume, Mestorogd, Kust, Rabota, Skvagina, MainPersons: String;

    dtJobBeg, dtJobEnd: Double;

    GrafWindows:  prqTobject;
    Etaps: prqTRptGrfEtap1;

    property OnlyEtapDrow: Boolean read FOnlyEtapDrow write SetOnlyEtapDrow;

    function getActiveListCount: Integer;

    function logFontSize(Z: Integer): Integer;
    function logToPointX(X: Integer): Integer;
    function logToPointY(Y: Integer): Integer;
    function PointXTOlog(X: Integer): Integer;
    function PointYTOlog(Y: Integer): Integer;

    function logToPointXY(const r: TRect): TRect;

    procedure Contur(const r: TRect);
    procedure logContur(const r: TRect; size: Integer);
    procedure logMoveTo(jX, jY: Integer);
    procedure logLineTo(jX, jY, size: Integer);

    procedure PrintRamka;
    procedure BlockRamka(const r: TRect; const NamPar, WorkData: String);
    procedure PrintRamka3; overload;
    procedure PrintRamka3(fF: double); overload;
    procedure PrintRamka3(fF: double; txtScale: double; n1, n2: integer); overload;
    procedure PrintHeadLine(var r: TRect; const sHeadLine: String); overload;
    procedure PrintHeadLine(var r: TRect; const sHeadLine: String; fF: double); overload;
    procedure PrintHeadLine(var r: TRect; const sHeadLine: String; fF: double;
txtScale: double); overload;
    procedure PrintBottomLine; overload;
    procedure PrintBottomLine(txtScale: double; n1, n2: integer); overload;

    function isDrawWnd(jNum: Integer): Boolean;  // ��������� ���� ��������� ���� � N

    procedure PrintList; overload;
    procedure PrintList(jNumGrf: Integer); overload;
    procedure setDefFont; overload;

    procedure imageList(map: TBitMap); overload;
    procedure imageList(jNumGrf: Integer; map: TBitMap); overload;

    procedure setDefFont(map: TBitMap); overload;
//    procedure PenSave;
//    procedure PenRestory;

    procedure imageList3(jNumGrf: Integer; map: TBitMap); overload;
    procedure imageList3printGraf(pw: TprqRptGrafWindow; map: TBitMap); virtual;
    procedure setDefFont3(map: TBitMap); overload;
    procedure setDefFont3(canva: TCanvas); overload;

    procedure CloneClass(Source: TprqRptGrafList1);

    constructor Create;
    destructor Destroy; override;
  published
  end;

  TprqRptGrafList4 = class(TprqRptGrafList1)
  private
    // ������� ����������
    FdScales: prqTdouble;
    FjScales: prqTinteger;

  public
    sizeHead: integer; // ����� �������� �������
    sizeScale: integer; // ����� ����� ��������
    sizeTimes: integer; // ����� ����� �������

class function  FindOtherParams(num: Integer; OtherParams: prqTobject): TprqRptTX;

    procedure imageListU1(jNumGrf: Integer; map: TBitMap; OtherParams: prqTobject);
    procedure imageListU1printGraf(pw: TprqRptGrafWindow; map: TBitMap;
                                  OtherParams: prqTobject);

// ���������� ������� �������
    procedure PrintRamkaU(n1, n2: integer); overload;
    procedure PrintHeadLineU(var r: TRect; const sHeadLine: String);
    procedure PrintBottomLineU(n1, n2: integer);

// ======================================
// ���������, ����������� ����������� � ��������� ������ �� ������ �������
    procedure imageListU2(jNumGrf: Integer; map: TBitMap; OtherParams: prqTobject); overload;
    procedure imageListU2(jNumGrf: Integer; map: TBitMap; OtherParams: prqTobject;
jNumScale: integer; sCl: double; dtBeg,dtEnd: double; var tBeg, tEnd: double;
txtScale: double; n1, n2: integer); overload;
    procedure printListU2(jNumGrf: Integer; canva: TCanvas; OtherParams: prqTobject;
jNumScale: integer; sCl: double; dtBeg,dtEnd: double; var tBeg, tEnd: double;
txtScale: double; n1, n2: integer; valWidth, valHeight: integer);
    function getTimeRegion(jNumGrf: Integer; canva: TCanvas;
jNumScale: integer; sCl: double; dtBeg,dtEnd: double; var tBeg, tEnd: double;
txtScale: double; valWidth, valHeight: integer): boolean;


// ======================================
// ���������, ����������� ����������� � ��������� ������ ��������� ��������

// ��������� ������� ������� �� ����� � ������� ��������
    function getTimeRegionM(canva: TCanvas;
jNumScale, PixPerInch: integer; dtBeg,dtEnd: double; var tBeg, tEnd: double;
valWidth, valHeight: integer): boolean;

// ���������� �������
    procedure imageListU2M(map: TBitMap; OtherParams: prqTobject;
jNumScale, PixPerInch: integer; dtBeg,dtEnd: double; var tBeg, tEnd: double;
n1, n2: integer); overload;

// ������ �������� �� �������
    procedure printListU2M(canva: TCanvas; OtherParams: prqTobject;
jNumScale, PixPerInch: integer; dtBeg,dtEnd: double; var tBeg, tEnd: double;
n1, n2: integer; valWidth, valHeight: integer);

// ������ ������ �������� � ��������
    function getHeightsignGrafListMprint: integer; overload;
    function getHeightsignGrafListMprint(pw: TprqRptGrafWindow): integer; overload;

    function getHeightsignGrafListM(txtScale: double): integer; overload;
    function getHeightsignGrafListM(pw: TprqRptGrafWindow; txtScale: double): integer; overload;
    function getHeightsignGrafListM: integer; overload;
    function getHeightsignGrafListM(pw: TprqRptGrafWindow): integer; overload;

    // ���������� ������� ������ �� ��� ����������� �������
    // fCanvas: TCanvas - �����
    // heightStr: integer - ��������� ������ ������
    // ���������: integer - �������� Font.Size
    function getSizeFont(fCanvas: TCanvas; PixPerInch, heightStr: integer): integer;

    // ����������� ���������� ��������
    function getPrinterResolution(fCanvas: TCanvas; PgHeight, lsHeight: integer): integer;

    constructor Create;
    destructor Destroy; override;
  end;



implementation

{ TprqRptGrafList1 }

procedure TprqRptGrafList1.SetOnlyEtapDrow(const Value: Boolean);
begin
  FOnlyEtapDrow := Value;
end;

constructor TprqRptGrafList1.Create;
var
  rcd: rcdTcontainer;
  jC1: Integer;
begin
  inherited;

  self.fFontName    := pc005_505_Courier;
  self.fFontSize    := 10;
  self.HeadFSize    := 12;
  self.fFontStyle   := [];

//  fPen := TPen.Create;

  self.etpDTime     := 0;
  self.jTOut        := 0;
  self.etpSign      := True;
  self.ramColor     := clGreen;
  self.etpColor     := clLime;
  self.etpColorEnd  := clFuchsia;

  GrafWindows       := prqTobject.Create;

  self.Etaps        := prqTRptGrfEtap1.Create;

  FOnlyEtapDrow := True;

  for jC1 := 1 to pc003_157_002 do
  begin
    rcd.key := jC1;
    rcd.ukz := TprqRptGrafWindow.Create;
    GrafWindows.Append(@rcd);
  end;

end;

destructor TprqRptGrafList1.Destroy;
begin
  GrafWindows.Free;
  Etaps.Free;
//  fPen.Free;

  inherited;
end;

procedure TprqRptGrafList1.Contur(const r: TRect);
var
  rect: array[0..4] of TPoint;
begin
    rect[0].x := r.Left;  rect[0].y := r.Top;
    rect[1].x := r.Left;  rect[1].y := r.Bottom;
    rect[2].x := r.Right; rect[2].y := r.Bottom;
    rect[3].x := r.Right; rect[3].y := r.Top;
    rect[4].x := r.Left;  rect[4].y := r.Top;
    Canvas.Polyline(rect);
end;

function TprqRptGrafList1.logToPointX(X: Integer): Integer;
begin
  result := (X * Width) div LogWidth;
end;

function TprqRptGrafList1.logToPointY(Y: Integer): Integer;
begin
  result := (Y * Height) div LogHeight;
end;

procedure TprqRptGrafList1.PrintList;
var
  pw, pw2: TprqRptGrafWindow;
begin
// ��������� ��������� �������
// ����� ��������
  Printer.Orientation := poPortrait;
  Height      := Printer.PageHeight;
  Width       := Printer.PageWidth;

// ��������� ���� ����
// 1
  pw := GrafWindows[1].ukz as TprqRptGrafWindow;
  pw.wnd_all.Left   := LogOtsLeft + 20;
  pw.wnd_all.Top    := LogOtsTop  + 100;
  pw.wnd_all.Right  := LogOtsLeft + ((LogWidth - LogOtsLeft - LogOtsRight) div 2);
  pw.wnd_all.Bottom := LogHeight - LogOtsBottom - 20;

  pw.wnd_Nadpisi    := pw.wnd_all;
  pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + 10;
  pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + 10;
  pw.wnd_Nadpisi.Bottom := pw.wnd_Nadpisi.Top + 280;

  pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
  pw.wnd_Scale.Right    := pw.wnd_Scale.Left + 140;
  pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;
  pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;

  pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
  pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
  pw.wnd_Graf.Right     := pw.wnd_all.Right;
  pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;

// 2
  pw2 := GrafWindows[2].ukz as TprqRptGrafWindow;
  pw2.wnd_all.Left   := pw.wnd_all.Right;
  pw2.wnd_all.Top    := pw.wnd_all.Top;
  pw2.wnd_all.Right  := LogWidth - LogOtsRight - 20;
  pw2.wnd_all.Bottom := pw.wnd_all.Bottom;

  pw2.wnd_Nadpisi    := pw2.wnd_all;
  pw2.wnd_Nadpisi.Left   := pw2.wnd_Nadpisi.Left + 10;
  pw2.wnd_Nadpisi.Top    := pw2.wnd_Nadpisi.Top + 10;
  pw2.wnd_Nadpisi.Bottom := pw2.wnd_Nadpisi.Top + 280;

  pw2.wnd_Scale.Left     := pw2.wnd_Nadpisi.Left;
  pw2.wnd_Scale.Right    := pw2.wnd_Scale.Left + 140;
  pw2.wnd_Scale.Bottom   := pw2.wnd_all.Bottom;
  pw2.wnd_Scale.Top      := pw2.wnd_Nadpisi.Bottom + 13;

  pw2.wnd_Graf.Left      := pw2.wnd_Scale.Right;
  pw2.wnd_Graf.Top       := pw2.wnd_Scale.Top;
  pw2.wnd_Graf.Right     := pw2.wnd_all.Right;
  pw2.wnd_Graf.Bottom    := pw2.wnd_all.Bottom;

// ������� ��������
  try
    Printer.BeginDoc;
    try
      setDefFont;

  // ������ ����� ������
      PrintRamka;

  // ������ ��������
      setDefFont;
      (GrafWindows[1].ukz as TprqRptGrafWindow).PrintAllGraf(self);

      setDefFont;
      (GrafWindows[2].ukz as TprqRptGrafWindow).PrintAllGraf(self);

  // ������ ��� ������
      setDefFont;
      pw.PrintEtapsName(self);
  {
      setDefFont;
      pw2.PrintEtapsName(self);
  }
  // ��������� ������
    finally
      Printer.EndDoc;
    end;
  except
    Printer.Abort;
  end;
end;

procedure TprqRptGrafList1.logContur(const r: TRect; size: Integer);
var
  rP: TRect;
  jS: Integer;
begin
  rP := logToPointXY(r);
  jS := logToPointX(size); if jS = 0 then jS := 1;

  Canvas.Pen.Width := jS;
  Contur(rP);
end;

function TprqRptGrafList1.logToPointXY(const r: TRect): TRect;
begin
  result.Left   := logToPointX(r.Left);
  result.Right  := logToPointX(r.Right);
  result.Top    := logToPointY(r.Top);
  result.Bottom := logToPointY(r.Bottom);
end;

procedure TprqRptGrafList1.PrintRamka;
Var
  r: TRect;
  jWi, jX, jY: Integer;
  s1: String;
begin
// ����� ������, ���� ������, ������� 0.5 ��
  r.Left   := LogOtsLeft;
  r.Top    := LogOtsTop;
  r.Right  := LogWidth - LogOtsRight;
  r.Bottom := LogHeight - LogOtsBottom;
  Canvas.Pen.Color := ramColor;

  LogContur(r, ramWidth);

// �������� ���������
{
  ���� = 20 ��, ������-� = 45 ��, ���� = 30 ��, �������� = 30 ��, ������� = 65 ��
������ = 10 ��
}
  r.Bottom := r.Top + 100;
  r.Right  := r.Left + 200;
  BlockRamka(r, pc005_505_SHB_NamPar_1, WorkData);

  r.Left   := r.Left + 200;
  r.Right  := r.Left + 450;
  BlockRamka(r, pc005_505_SHB_NamPar_2, Mestorogd);

  r.Left   := r.Left + 450;
  r.Right  := r.Left + 300;
  BlockRamka(r, pc005_505_SHB_NamPar_3, Kust);

  r.Left   := r.Left + 300;
  r.Right  := r.Left + 300;
  BlockRamka(r, pc005_505_SHB_NamPar_4, Skvagina);

  r.Left   := r.Left + 300;
  r.Right  := LogWidth - LogOtsRight;
  BlockRamka(r, pc005_505_SHB_NamPar_7, Rabota);

// ��������� �����
  jX := logToPointX(LogOtsLeft + 10);
  jY := logToPointY(LogHeight - LogOtsBottom + 12);
//  Canvas.Font.Size  := 12;
  Canvas.Font.Size  := sz12;
  Canvas.TextOut(jX, jY, pc005_505_SHB_NamPar_16 + ' = ' + AllTime);

// ��������� �����
  s1 := pc005_505_SHB_NamPar_14 + ' = ' + AllVolume;
  jWi := Canvas.TextWidth(s1);
  jX := logToPointX(LogWidth  - LogOtsRight  - 10) - jWi;
  jY := logToPointY(LogHeight - LogOtsBottom + 12);
  Canvas.TextOut(jX, jY, s1);
end;

procedure TprqRptGrafList1.BlockRamka(const r: TRect; const NamPar,
  WorkData: String);
Var
  rTxt: TRect;
  jX, jY: Integer;
begin
  if Length(WorkData) > 0 then
  begin
    jX := logToPointX(r.Left + 10);
    jY := logToPointY(r.Top  + 50);
//    Canvas.Font.Size  := 10;
    Canvas.Font.Size  := sz10;
    rTxt := logToPointXY(r);
    Canvas.TextRect(rTxt, jX, jY, WorkData);
  end;
  jX := logToPointX(r.Left + 10);
  jY := logToPointY(r.Top  + 10);
//  Canvas.Font.Size  := 8;
  Canvas.Font.Size  := sz08;
  Canvas.TextOut(jX, jY, NamPar);
  LogContur(r, ramWidth);
end;

procedure TprqRptGrafList1.logLineTo(jX, jY, size: Integer);
var
  jX1, jY1, jS: Integer;
begin
  jX1 := logToPointX(jX);
  jY1 := logToPointY(jY);
  jS := logToPointX(size); if jS = 0 then jS := 1;
  Canvas.Pen.Width := jS;
  Canvas.LineTo(jX1, jY1);
end;

procedure TprqRptGrafList1.logMoveTo(jX, jY: Integer);
var
  jX1, jY1: Integer;
begin
  jX1 := logToPointX(jX);
  jY1 := logToPointY(jY);
  Canvas.MoveTo(jX1, jY1);
end;

procedure TprqRptGrafList1.setDefFont;
begin
  Printer.Refresh;
  Canvas   := Printer.Canvas;
  Canvas.Font := fntDefault;
  Canvas.Font.Name := pc005_505_Times;
  Canvas.Font.Color := clBlack;
  Canvas.Pen := penDefault;
  Canvas.Pen.Style := psSolid;
end;

procedure TprqRptGrafList1.PrintList(jNumGrf: Integer);
var
  pw: TprqRptGrafWindow;
begin
// ��������� ��������� �������
// ����� ��������
  Printer.Orientation := poPortrait;
  Height      := Printer.PageHeight;
  Width       := Printer.PageWidth;

// ��������� ���� ����
// 1
  pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
  pw.wnd_all.Left   := LogOtsLeft + 20;
  pw.wnd_all.Top    := LogOtsTop  + 100;
  pw.wnd_all.Right  := LogWidth - LogOtsRight - 20;
  pw.wnd_all.Bottom := LogHeight - LogOtsBottom - 20;

  pw.wnd_Nadpisi    := pw.wnd_all;
  pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + 10;
  pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + 10;
  pw.wnd_Nadpisi.Bottom := pw.wnd_Nadpisi.Top + 280;

  pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
  pw.wnd_Scale.Right    := pw.wnd_Scale.Left + 140;
  pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;
  pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;

  pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
  pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
  pw.wnd_Graf.Right     := pw.wnd_all.Right;
  pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;

// ������� ��������
  try
    Printer.Refresh;
    Printer.BeginDoc;
    try
      setDefFont;

  // ������ ����� ������
      PrintRamka;

  // ������ ��������
      setDefFont;
      pw.PrintAllGraf(self);

  // ������ ��� ������
      setDefFont;
      pw.PrintEtapsName(self);

  // ��������� ������
    finally
      Printer.EndDoc;
    end;
  except
    Printer.Abort;
  end;
end;

procedure TprqRptGrafList1.imageList(jNumGrf: Integer; map: TBitMap);
var
  pw: TprqRptGrafWindow;
begin
// ��������� ��������� �������
// ����� ��������
  Height      := map.Height;
  Width       := map.Width;

// ��������� ���� ����
// 1
  pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
  pw.wnd_all.Left   := LogOtsLeft + 20;
  pw.wnd_all.Top    := LogOtsTop  + 100;
  pw.wnd_all.Right  := LogWidth - LogOtsRight - 20;
  pw.wnd_all.Bottom := LogHeight - LogOtsBottom - 20;

  pw.wnd_Nadpisi    := pw.wnd_all;
  pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + 10;
  pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + 10;
  pw.wnd_Nadpisi.Bottom := pw.wnd_Nadpisi.Top + 280;

  pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
  pw.wnd_Scale.Right    := pw.wnd_Scale.Left + 140;
  pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;
  pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;

  pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
  pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
  pw.wnd_Graf.Right     := pw.wnd_all.Right;
  pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;

// ������� ��������
  try
    setDefFont(map);
      sz12 := logFontSize(60);
      sz10 := logFontSize(44);
      sz08 := logFontSize(40);
//      etpFntSize  := logFontSize(50);

// ������ ����� ������
    PrintRamka;

// ������ ��������
    setDefFont(map);
    pw.PrintAllGraf(self);

// ������ ��� ������
    setDefFont(map);
    pw.PrintEtapsName(self);

// ��������� ������
  except
  end;
end;

procedure TprqRptGrafList1.setDefFont(map: TBitMap);
begin
  Canvas   := map.Canvas;
  Canvas.Refresh;
  Canvas.Font := fntDefault;
  Canvas.Font.Name := pc005_505_Times;
  Canvas.Font.Color := clBlack;
  Canvas.Pen := penDefault;
  Canvas.Pen.Style := psSolid;
  Canvas.Brush := BrushDefault;
  Canvas.Brush.Color := clWhite;
end;

function TprqRptGrafList1.logFontSize(Z: Integer): Integer;
Var
  jWi: Integer;
  s1: String;
begin
  s1 := pc005_505_HeigtShab;
  Z := (Z * Height) div LogHeight;
  for result := 1 to 1023 do
  begin
    Canvas.Font.Size  := result;
    jWi := Canvas.TextHeight(s1);
    if jWi >= Z then Exit;
  end;
  result := 1024;
end;

procedure TprqRptGrafList1.imageList(map: TBitMap);
var
  pw, pw2: TprqRptGrafWindow;
begin
// ��������� ��������� �������
// ����� ��������
  Height      := map.Height;
  Width       := map.Width;

// ��������� ���� ����
// 1
  pw := GrafWindows[1].ukz as TprqRptGrafWindow;
  pw.wnd_all.Left   := LogOtsLeft + 20;
  pw.wnd_all.Top    := LogOtsTop  + 100;
  pw.wnd_all.Right  := LogOtsLeft + ((LogWidth - LogOtsLeft - LogOtsRight) div 2);
  pw.wnd_all.Bottom := LogHeight - LogOtsBottom - 20;

  pw.wnd_Nadpisi    := pw.wnd_all;
  pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + 10;
  pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + 10;
  pw.wnd_Nadpisi.Bottom := pw.wnd_Nadpisi.Top + 280;

  pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
  pw.wnd_Scale.Right    := pw.wnd_Scale.Left + 140;
  pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;
  pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;

  pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
  pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
  pw.wnd_Graf.Right     := pw.wnd_all.Right;
  pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;

// 2
  pw2 := GrafWindows[2].ukz as TprqRptGrafWindow;
  pw2.wnd_all.Left   := pw.wnd_all.Right;
  pw2.wnd_all.Top    := pw.wnd_all.Top;
  pw2.wnd_all.Right  := LogWidth - LogOtsRight - 20;
  pw2.wnd_all.Bottom := pw.wnd_all.Bottom;

  pw2.wnd_Nadpisi    := pw2.wnd_all;
  pw2.wnd_Nadpisi.Left   := pw2.wnd_Nadpisi.Left + 10;
  pw2.wnd_Nadpisi.Top    := pw2.wnd_Nadpisi.Top + 10;
  pw2.wnd_Nadpisi.Bottom := pw2.wnd_Nadpisi.Top + 280;

  pw2.wnd_Scale.Left     := pw2.wnd_Nadpisi.Left;
  pw2.wnd_Scale.Right    := pw2.wnd_Scale.Left + 140;
  pw2.wnd_Scale.Bottom   := pw2.wnd_all.Bottom;
  pw2.wnd_Scale.Top      := pw2.wnd_Nadpisi.Bottom + 13;

  pw2.wnd_Graf.Left      := pw2.wnd_Scale.Right;
  pw2.wnd_Graf.Top       := pw2.wnd_Scale.Top;
  pw2.wnd_Graf.Right     := pw2.wnd_all.Right;
  pw2.wnd_Graf.Bottom    := pw2.wnd_all.Bottom;

// ������� ��������
  try
    setDefFont(map);
      sz12 := logFontSize(60);
      sz10 := logFontSize(44);
      sz08 := logFontSize(40);
      etpFntSize  := logFontSize(50);

  // ������ ����� ������
      PrintRamka;

  // ������ ��������
    setDefFont(map);
      (GrafWindows[1].ukz as TprqRptGrafWindow).PrintAllGraf(self);

    setDefFont(map);
      (GrafWindows[2].ukz as TprqRptGrafWindow).PrintAllGraf(self);

  // ������ ��� ������
    setDefFont(map);
      pw.PrintEtapsName(self);
  {
    setDefFont(map);
      pw2.PrintEtapsName(self);
  }
  // ��������� ������
  except
  end;
end;

function TprqRptGrafList1.isDrawWnd(jNum: Integer): Boolean;
begin
  result := False;
  if (jNum < 1)  or  (jNum > GrafWindows.Count) then Exit;
  result := (GrafWindows[jNum].ukz as TprqRptGrafWindow).jDraw = 1;
end;

procedure TprqRptGrafList1.imageList3(jNumGrf: Integer; map: TBitMap);
var
  pw: TprqRptGrafWindow;
begin
// ��������� ��������� �������
// ����� ��������
  Height      := map.Height;
  Width       := map.Width;

  try
// ������ ����� ������
    setDefFont3(map);
    PrintRamka3;

// ��������� ���� ����
    pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
    pw.wnd_all.Left   := LogOtsLeft + pc005_505_App_Shift1;
    pw.wnd_all.Top    := LogHeadLineHeight;                    // ����������� � �����
    pw.wnd_all.Right  := LogWidth - LogOtsRight - pc005_505_App_Shift1;
    pw.wnd_all.Bottom := LogHeight - LogOtsBottom - pc005_505_App_Shift1;

    pw.wnd_Nadpisi    := pw.wnd_all;
    pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
    pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
    LogHeadLineHeight := pw.wnd_Nadpisi.Top;

    pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
    pw.wnd_Scale.Right    := pw.wnd_Scale.Left + pc005_505_App_Shift5;
    pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;

    pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
    pw.wnd_Graf.Right     := pw.wnd_all.Right;
    pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;

// ������� ������� ��������!
    pw.signGrafList3(self);
    pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;
    pw.wnd_Graf.Top       := pw.wnd_Scale.Top;

// ������ ����� �������, ����� ���������
    pw.PrintScale(self);
    pw.PrintNetXY(self);

// ������ ��������
    imageList3printGraf(pw, map);

// ������ ����� ������ � ��� ������ to print stages net
    setDefFont3(map);
    pw.PrintEtapsLine(self);
    pw.PrintEtapsName(self);

// ��������� ������
  except
  end;
end;

procedure TprqRptGrafList1.PrintRamka3;
Var
  rLine, r: TRect;
  s1: String;
begin
// ����� ������
  r.Left   := LogOtsLeft;
  r.Top    := LogOtsTop;
  r.Right  := LogWidth - LogOtsRight;
  r.Bottom := LogHeight - LogOtsBottom;
  Canvas.Pen.Color := ramColor;
  LogContur(r, ramWidth);

// �������� ���������
// ������ ������ �������
  s1 := WorkData + ': ' + Mestorogd + ' \ ' + Kust + ' \ ' + Skvagina + ' \ ' + Rabota;
  rLine := r;
  PrintHeadLine(rLine, s1);

// ������ ������ �������
  s1 := pc005_505_SHB_NamPar_8 + MainPersons;
  rLine.Top := rLine.Bottom;
  PrintHeadLine(rLine, s1);

  LogHeadLineHeight := rLine.Bottom;

// ��������� ����� ��������� �����
  PrintBottomLine;
end;

procedure TprqRptGrafList1.PrintHeadLine(var r: TRect; const sHeadLine: String);
var
  rTxt, rLine: TRect;
  jY, jX, jWi:   Integer;
  fs: TFont;
begin
// ��������� �������� ������
  rLine.Left  := r.Left  + pc005_505_App_Shift3;
  rLine.Top   := r.Top   + pc005_505_App_Shift3;
  rLine.Right := r.Right - pc005_505_App_Shift3;

  fs := Canvas.Font;
  try
//    Canvas.Font.Style  := fs.Style + [fsBold];
    Canvas.Font.Name := pc005_505_Serif; //pc005_505_Arial;
    Canvas.Font.Size := self.HeadFSize;
                 jWi := Canvas.TextHeight(sHeadLine);
        rLine.Bottom := rLine.Top + PointXTOlog(jWi) + pc005_505_App_Shift3a;
            r.Bottom := rLine.Bottom;

                  jX := logToPointX(rLine.Left);
                  jY := logToPointY(rLine.Top);
                rTxt := logToPointXY(rLine);
    Canvas.TextRect(rTxt, jX, jY, sHeadLine);

    logMoveTo(r.Left, r.Bottom);
    logLineTo(r.Right, r.Bottom, ramWidth);
  finally
    Canvas.Font  := fs;
  end;
end;

function TprqRptGrafList1.PointXTOlog(X: Integer): Integer;
begin
  result := (X * LogWidth) div Width;
end;

procedure TprqRptGrafList1.PrintBottomLine;
var
  jY, jX, jWi:   Integer;
  fs: TFont;
  s1: String;
begin
  Exit;
  fs := Canvas.Font;
  try
//    Canvas.Font.Style  := fs.Style + [fsBold];
    Canvas.Font.Name   := pc005_505_Serif; //pc005_505_Arial;
    Canvas.Font.Size := self.HeadFSize;

// ��������� �����
    jX := logToPointX(LogOtsLeft + 10);
    jY := logToPointY(LogHeight - LogOtsBottom + 12);
    Canvas.TextOut(jX, jY, pc005_505_SHB_NamPar_16 + ' = ' + AllTime);

// ��������� �����
    s1 := pc005_505_SHB_NamPar_14 + ' = ' + AllVolume;
    jWi := Canvas.TextWidth(s1);
    jX := logToPointX(LogWidth  - LogOtsRight  - 10) - jWi;
    jY := logToPointY(LogHeight - LogOtsBottom + 12);
    Canvas.TextOut(jX, jY, s1);

  finally
    Canvas.Font  := fs;
  end;
end;

function TprqRptGrafList1.PointYTOlog(Y: Integer): Integer;
begin
  result := (Y * LogHeight) div Height;
end;
{
procedure TprqRptGrafList1.PenRestory;
begin
  self.Canvas.Assign( self.fPen );
end;

procedure TprqRptGrafList1.PenSave;
begin
  self.fPen.Assign( self.Canvas.Pen );
end;
}

procedure TprqRptGrafList1.imageList3printGraf(pw: TprqRptGrafWindow; map: TBitMap);
begin
  setDefFont(map);
  pw.PrintAllGraf3(self);
end;

procedure TprqRptGrafList1.CloneClass(Source: TprqRptGrafList1);
var
  jC1: Integer;
begin
  if not Assigned(Source) then Exit;

  fFontName             := Source.fFontName;
  fFontSize             := Source.fFontSize;
  fFontStyle            := Source.fFontStyle;
  FOnlyEtapDrow         := Source.FOnlyEtapDrow;

  Canvas                := Source.Canvas;

  fntDefault            := Source.fntDefault;
  penDefault            := Source.penDefault;
  BrushDefault          := Source.BrushDefault;
  sz12                  := Source.sz12;
  sz10                  := Source.sz10;
  sz08                  := Source.sz08;
  LogHeight             := Source.LogHeight;
  LogWidth              := Source.LogWidth;
  Height                := Source.Height;
  Width                 := Source.Width;
  ramWidth              := Source.ramWidth;
  ramColor              := Source.ramColor;
  HeadFSize             := Source.HeadFSize;
  etpWidth              := Source.etpWidth;
  etpColor              := Source.etpColor;
  etpColorEnd           := Source.etpColorEnd;
  etpFntSize            := Source.etpFntSize;
  etpDTime              := Source.etpDTime;
  jTOut                 := Source.jTOut;
  etpSign               := Source.etpSign;

  LogOtsLeft            := Source.LogOtsLeft;
  LogOtsRight           := Source.LogOtsRight;
  LogOtsTop             := Source.LogOtsTop;
  LogOtsBottom          := Source.LogOtsBottom;
  LogHeadLineHeight     := Source.LogHeadLineHeight;
  WorkData              := Source.WorkData;
  AllTime               := Source.AllTime;
  AllVolume             := Source.AllVolume;
  Mestorogd             := Source.Mestorogd;
  Kust                  := Source.Kust;
  Rabota                := Source.Rabota;
  Skvagina              := Source.Skvagina;
  MainPersons           := Source.MainPersons;
  dtJobBeg              := Source.dtJobBeg;
  dtJobEnd              := Source.dtJobEnd;

  GrafWindows.Count     := 0;
  GrafWindows.Count     := Source.GrafWindows.Count;
  for jC1 := 1 to Source.GrafWindows.Count do
  begin
    GrafWindows[jC1].ukz := TprqRptGrafWindow.Create;
    (GrafWindows[jC1].ukz as TprqRptGrafWindow).CloneClass(Source.GrafWindows[jC1].ukz as TprqRptGrafWindow);
    GrafWindows[jC1].key := Source.GrafWindows[jC1].key;
  end;

  Etaps.CloneClass(Source.Etaps);
end;

function TprqRptGrafList1.getActiveListCount: Integer;
var
  jC1: Integer;
begin
  result := 0;
  for jC1 := 1 to GrafWindows.Count do
  begin

    if self.isDrawWnd(jC1) then Inc(result);

  end;
end;

procedure TprqRptGrafList1.setDefFont3(map: TBitMap);
begin
  Canvas             := map.Canvas;
  Canvas.Refresh;

  Canvas.Font        := fntDefault;
  Canvas.Font.Name   := pc005_505_Times;
  Canvas.Font.Color  := clBlack;

  Canvas.Pen         := penDefault;
  Canvas.Pen.Style   := psSolid;
  Canvas.Pen.Mode    := pmCopy;

  Canvas.Brush       := BrushDefault;
  Canvas.Brush.Color := clWhite;
end;

procedure TprqRptGrafList1.PrintRamka3(fF: double);
var
  rLine, r: TRect;
  s1: String;
begin
// ����� ������
  r.Left   := LogOtsLeft;
  r.Top    := LogOtsTop;
  r.Right  := LogWidth - LogOtsRight;
  r.Bottom := LogHeight - LogOtsBottom;
  Canvas.Pen.Color := ramColor;
  LogContur(r, ramWidth);

// �������� ���������
// ������ ������ �������
  s1 := WorkData + ': ' + Mestorogd + ' \ ' + Kust + ' \ ' + Skvagina + ' \ ' + Rabota;
  rLine := r;
  PrintHeadLine(rLine, s1, fF);

// ������ ������ �������
  s1 := pc005_505_SHB_NamPar_8 + MainPersons;
  rLine.Top := rLine.Bottom;
  PrintHeadLine(rLine, s1, fF);

  LogHeadLineHeight := rLine.Bottom;
  PrintBottomLine;
end;

procedure TprqRptGrafList1.PrintHeadLine(var r: TRect;
  const sHeadLine: String; fF: double);
var
  rTxt, rLine: TRect;
  jY, jX, jWi:   Integer;
  fs: TFont;
begin
// ��������� �������� ������
  rLine.Left  := r.Left  + pc005_505_App_Shift3;
  rLine.Top   := r.Top   + pc005_505_App_Shift3;
  rLine.Right := r.Right - pc005_505_App_Shift3;

  fs := Canvas.Font;
  try
//    Canvas.Font.Style  := fs.Style + [fsBold];
    Canvas.Font.Name := pc005_505_Serif; //pc005_505_Arial;
    Canvas.Font.Size := self.HeadFSize;
                 jWi := Trunc(Canvas.TextHeight(sHeadLine) * fF);
        rLine.Bottom := rLine.Top + PointXTOlog(jWi) + pc005_505_App_Shift3a;
            r.Bottom := rLine.Bottom;

                  jX := logToPointX(rLine.Left);
                  jY := logToPointY(rLine.Top);
                rTxt := logToPointXY(rLine);
    Canvas.TextRect(rTxt, jX, jY, sHeadLine);

    logMoveTo(r.Left, r.Bottom);
    logLineTo(r.Right, r.Bottom, ramWidth);
  finally
    Canvas.Font  := fs;
  end;
end;

procedure TprqRptGrafList1.PrintRamka3(fF, txtScale: double; n1, n2: integer);
var
  rLine, r: TRect;
  s1: String;
begin
// ����� ������
  r.Left   := LogOtsLeft;
  r.Top    := LogOtsTop;
  r.Right  := LogWidth - LogOtsRight;
  r.Bottom := LogHeight - LogOtsBottom;
  Canvas.Pen.Color := ramColor;
  LogContur(r, ramWidth);

// �������� ���������
// ������ ������ �������
  s1 := WorkData + ': ' + Mestorogd + ' \ ' + Kust + ' \ ' + Skvagina + ' \ ' + Rabota;
  rLine := r;
  PrintHeadLine(rLine, s1, fF, txtScale);

// ������ ������ �������
  s1 := pc005_505_SHB_NamPar_8 + MainPersons;
  rLine.Top := rLine.Bottom;
  PrintHeadLine(rLine, s1, fF, txtScale);

  LogHeadLineHeight := rLine.Bottom;
  PrintBottomLine(txtScale, n1, n2);
end;

procedure TprqRptGrafList1.PrintHeadLine(var r: TRect;
  const sHeadLine: String; fF, txtScale: double);
var
  rTxt, rLine: TRect;
  jY, jX, jWi:   Integer;
  fs: TFont;
begin
// ��������� �������� ������
  rLine.Left  := r.Left  + pc005_505_App_Shift3;
  rLine.Top   := r.Top   + pc005_505_App_Shift3;
  rLine.Right := r.Right - pc005_505_App_Shift3;

  fs := Canvas.Font;
  try
//    Canvas.Font.Style  := fs.Style + [fsBold];
    Canvas.Font.Name := pc005_505_Serif; //pc005_505_Arial;
    Canvas.Font.Size := Trunc(self.HeadFSize * txtScale);
                 jWi := Trunc(Canvas.TextHeight(sHeadLine) * fF);
        rLine.Bottom := rLine.Top + PointXTOlog(jWi) + pc005_505_App_Shift3a;
            r.Bottom := rLine.Bottom;

                  jX := logToPointX(rLine.Left);
                  jY := logToPointY(rLine.Top);
                rTxt := logToPointXY(rLine);
    Canvas.TextRect(rTxt, jX, jY, sHeadLine);

    logMoveTo(r.Left, r.Bottom);
    logLineTo(r.Right, r.Bottom, ramWidth);
  finally
    Canvas.Font  := fs;
  end;
end;

procedure TprqRptGrafList1.PrintBottomLine(txtScale: double; n1, n2: integer);
var
  jY, jX, jWi:   Integer;
  fs: TFont;
  s1: String;
begin
  fs := Canvas.Font;
  if n1 < 1 then
  begin
    Exit;
  end;

  try
    Canvas.Font.Name   := pc005_505_Serif; //pc005_505_Arial;
    Canvas.Font.Size  := Trunc((self.HeadFSize * txtScale) * 0.75);

// ����� ��������
    s1 := IntToStr(n1) + ' / ' + IntToStr(n2);
    jWi := Canvas.TextWidth(s1);
    jX := (logToPointX(LogWidth) - jWi) div 2;
    jY := logToPointY(LogHeight - LogOtsBottom + 12);
    Canvas.TextOut(jX, jY, s1);

  finally
    Canvas.Font  := fs;
  end;
end;

procedure TprqRptGrafList1.setDefFont3(canva: TCanvas);
begin
  Canvas             := canva;
  Canvas.Refresh;

  Canvas.Font        := fntDefault;
  Canvas.Font.Name   := pc005_505_Times;
  Canvas.Font.Color  := clBlack;

  Canvas.Pen         := penDefault;
  Canvas.Pen.Style   := psSolid;
  Canvas.Pen.Mode    := pmCopy;

  Canvas.Brush       := BrushDefault;
  Canvas.Brush.Color := clWhite;
end;

{ TprqRptGraf1 }

constructor TprqRptGraf1.Create;
var
  jC1: Integer;
begin
  self.yTime      := prqTDouble.Create;
  self.xVal       := prqTDouble.Create;
  self.arrXY      := prqTobject.Create;
  self.Color      := clBlack;
  self.yNormalVol := False;
  self.dTOut      := 0;
  for jC1 := Low(arrChanal) to High(arrChanal) do
  begin
    self.arrChanal[jC1] := 0;
  end;
end;

destructor TprqRptGraf1.Destroy;
begin
  yTime.Free;
  xVal.Free;
  arrXY.Free;
  inherited;
end;

function TprqRptGraf1.FindIndexForTime(dt: TDateTime; num: Integer; var Value: Double): Integer;
var
  _xVal, _yTime: prqTDouble;
  jC1: Integer;
begin
  result := 0;
  if self.nChanal > 0 then
  begin
    _yTime     := self.yTime;
    _xVal      := self.xVal;
  end
  else
  begin
    if (num < 1)  or  (num > arrXY.Count) then Exit;
    _yTime     := (self.arrXY[num].ukz as TprqRptTX).yTime;
    _xVal      := (self.arrXY[num].ukz as TprqRptTX).xVal;
  end;

  if not Assigned(_yTime) then Exit;
  if _yTime.Count = 0 then Exit;
  if not Assigned(_xVal) then Exit;
  if _xVal.Count = 0 then Exit;

  for jC1 := 1 to _yTime.Count do
  begin
    if _yTime[jC1]^ < dT then continue;
    result := jC1 - 1;
    if result = 0 then result := 1;
    Value := _xVal[result]^;
    Exit;
  end;
  result := _yTime.Count;
  Value  := _xVal[result]^;
end;

procedure TprqRptGraf1.CloneClass(Source: TprqRptGraf1);
var
  jC1: Integer;
begin
  if not Assigned(Source) then Exit;

  yTime.Count := 0; yTime.AppendClass(Source.yTime);
  xVal.Count  := 0; xVal.AppendClass(Source.xVal);

  nChanal     := Source.nChanal;

  for jC1 := Low(arrChanal) to High(arrChanal) do
  begin
    arrChanal[jC1] := Source.arrChanal[jC1];
  end;

  arrXY.Count := 0;
  arrXY.Count := Source.arrXY.Count;
  for jC1 := 1 to Source.arrXY.Count do
  begin
    (arrXY[jC1].ukz as TprqRptTX).CloneClass(Source.arrXY[jC1].ukz as TprqRptTX);
    arrXY[jC1].key := Source.arrXY[jC1].key;
  end;

  yNormalVol := Source.yNormalVol;
  xLogSize   := Source.xLogSize;
  xLogStep   := Source.xLogStep;
  Color      := Source.Color;
  sName      := Source.sName;
  sEdIzm     := Source.sEdIzm;
  fnSize     := Source.fnSize;
  RoundMode  := Source.RoundMode;
  diaMin     := Source.diaMin;
  diaMax     := Source.diaMax;
  sFormat    := Source.sFormat;
  dTOut      := Source.dTOut;
  bActive    := Source.bActive;
end;

function TprqRptGraf1.FindIndexForTime(dt: TDateTime; num: Integer;
  var Value: Double; OtherParams: prqTobject): Integer;
var
  _xVal, _yTime: prqTDouble;
  j1, jC1: Integer;
  pCh: TprqRptTX;
begin
  result := 0;
  if self.nChanal > 0 then
  begin
    j1 := self.nChanal;
  end
  else
  begin
    if (num < 1)  or  (num > High(arrChanal)) then Exit;
    if arrChanal[num] <= 0 then Exit;
    j1 := arrChanal[num];
  end;
  pCh := TprqRptGrafList4.FindOtherParams(j1, OtherParams);
  if not Assigned(pCh) then Exit;

  _yTime := pCh.yTime;
  _xVal  := pCh.xVal;

  if not Assigned(_yTime) then Exit;
  if _yTime.Count = 0 then Exit;
  if not Assigned(_xVal) then Exit;
  if _xVal.Count = 0 then Exit;

  for jC1 := 1 to _yTime.Count do
  begin
    if _yTime[jC1]^ < dT then continue;
    result := jC1 - 1;
    if result = 0 then result := 1;
    Value := _xVal[result]^;
    Exit;
  end;
  result := _yTime.Count;
  Value  := _xVal[result]^;
end;

function TprqRptGraf1.FindNumChanal(num: Integer; OtherParams: prqTobject): Integer;
begin
  result := 0;
  if self.nChanal > 0 then
  begin
    result := self.nChanal;
  end
  else
  begin
    if (num < 1)  or  (num > High(arrChanal)) then Exit;
    if arrChanal[num] <= 0 then Exit;
    result := arrChanal[num];
  end;
end;

function TprqRptGraf1.FindIndexForTime(dt: TDateTime; num: Integer;
  var Value: Double; var DTime: TDateTime;
  OtherParams: prqTobject): Integer;
var
  _xVal, _yTime: prqTDouble;
  j1, jC1: Integer;
  pCh: TprqRptTX;
begin
  result := 0;
  if self.nChanal > 0 then
  begin
    j1 := self.nChanal;
  end
  else
  begin
    if (num < 1)  or  (num > High(arrChanal)) then Exit;
    if arrChanal[num] <= 0 then Exit;
    j1 := arrChanal[num];
  end;
  pCh := TprqRptGrafList4.FindOtherParams(j1, OtherParams);
  if not Assigned(pCh) then Exit;

  _yTime := pCh.yTime;
  _xVal  := pCh.xVal;

  if not Assigned(_yTime) then Exit;
  if _yTime.Count = 0 then Exit;
  if not Assigned(_xVal) then Exit;
  if _xVal.Count = 0 then Exit;

  for jC1 := 1 to _yTime.Count do
  begin
    if _yTime[jC1]^ < dT then continue;
    result := jC1 - 1;
    if result = 0 then result := 1;
    Value := _xVal[result]^;
    DTime := _yTime[jC1]^;
    Exit;
  end;
  result := _yTime.Count;
  Value  := _xVal[result]^;
  DTime  := _yTime[result]^;
end;

{ TprqRptGrafWindow }

constructor TprqRptGrafWindow.Create;
begin
  self.Grafiks := prqTobject.Create;
  self.netYlWidth := 20;
  self.netYscShft := 10;
  self.TSclSize   :=  8;
  self.netColor   := clBlue;  // ���� �����
  self.ramColor   := clBlue;  // ���� �����
  self.bSignScaleVal := false;

  self.dTimeScale   := TprqTimeScale1.Create; // ����� �������
  self.yNet         := prqTInteger.Create; // ���������� Y ���� ����� (���)
end;

destructor TprqRptGrafWindow.Destroy;
begin
  Grafiks.Free;
  dTimeScale.Free;
  yNet.Free;
  inherited;
end;

procedure TprqRptGrafWindow.PrintAllGraf(gList: TprqRptGrafList1);
var
  jYrs, jC2, j1, jXWi, jYWi, jX, jX1, jY1, jXStep, jC1: Integer;
  xStep: Double;
  pg: TprqRptGraf1;
  s1: string;
  pnt1, pnt2, res1, res2: TPoint;
  b1: Boolean;
begin
// ����� ���� ����
  gList.Canvas.Pen.Color := ramColor;
  gList.LogContur(wnd_Graf, ramWidth);

// ������ ����� �������
  PrintScale(gList);

// ����� �� ��� �������
  gList.Canvas.Pen.Color := netColor;
  jYrs := (yNet[2]^ - yNet[1]^) div dTimeScale.divideYstep;
  for jC1 := 1 to yNet.Count do
  begin
    gList.Canvas.Pen.Style := psDash;
    for jC2 := 1 to dTimeScale.divideYstep - 1 do
    begin
      pnt1.X := wnd_Graf.Left;  pnt1.Y := yNet[jC1]^ - (jYrs * jC2);
      pnt2.X := wnd_Graf.Right; pnt2.Y := pnt1.Y;
      if TprqAGallfunc.LineSuperPosition(pnt1, pnt2, wnd_Graf, res1, res2) then
      begin
        gList.logMoveTo(res1.X, res1.Y);
        gList.logLineTo(res2.X, res2.Y, netWidth);
      end;
    end;
    gList.Canvas.Pen.Style := psSolid;
    gList.logMoveTo(wnd_Graf.Left, yNet[jC1]^);
    gList.logLineTo(wnd_Graf.Right, yNet[jC1]^, netWidth);
  end;
  gList.Canvas.Pen.Style := psDash;
  for jC2 := 1 to dTimeScale.divideYstep - 1 do
  begin
    pnt1.X := wnd_Graf.Left;  pnt1.Y := yNet[yNet.Count]^ + (jYrs * jC2);
    pnt2.X := wnd_Graf.Right; pnt2.Y := pnt1.Y;
    if TprqAGallfunc.LineSuperPosition(pnt1, pnt2, wnd_Graf, res1, res2) then
    begin
      gList.logMoveTo(res1.X, res1.Y);
      gList.logLineTo(res2.X, res2.Y, netWidth);
    end;
  end;
  gList.Canvas.Pen.Style := psSolid;

// ����� �� ��� ��������
  xStep := wnd_Graf.Right - wnd_Graf.Left; xStep := xStep / cntXStep;
  for jC1 := 1 to cntXStep - 1 do
  begin
    jX := wnd_Graf.Left + Round(xStep * jC1);
    if jC1 = (cntXStep div 2) then j1 := 20 else j1 := 0;
    gList.logMoveTo(jX, wnd_Graf.Top - j1);
    gList.logLineTo(jX, wnd_Graf.Bottom, netWidth);
  end;

// ��������� �������� � ��������
  jXStep := (wnd_Nadpisi.Bottom - wnd_Nadpisi.Top) div cntGrPodp;
  for jC1 := 1 to Grafiks.Count do
  begin
    pg := Grafiks[jC1].ukz as TprqRptGraf1;
    b1 := pg.bActive;
    if not b1 then continue;

// �������
    gList.Canvas.Font.Size  := gList.sz08; //pg.fnSize;
    jYWi := gList.Canvas.TextHeight(pg.sName);
    jX1 := gList.logToPointX(wnd_Nadpisi.Left + 5);
    jY1 := gList.logToPointY(wnd_Nadpisi.Bottom - 10 - (jXStep * (jC1-1))) - jYWi;
    gList.Canvas.TextOut(jX1, jY1, pg.sName);

// �����
    jX1 := wnd_Graf.Left;
    jY1 := wnd_Nadpisi.Bottom - (jXStep * (jC1-1));
    gList.logMoveTo(jX1, jY1);
    jX1 := wnd_Graf.Right;
    gList.Canvas.Pen.Color := pg.Color;
    gList.logLineTo(jX1, jY1, pg.xLogSize);

// �������� Min
    s1 := Trim(Format(pg.sFormat, [pg.diaMin]));
//    jXWi := gList.Canvas.TextWidth(s1);
    jYWi := gList.Canvas.TextHeight(s1);
    jX1 := gList.logToPointX(wnd_Graf.Left);
    jY1 := gList.logToPointY(wnd_Nadpisi.Bottom - 10 - (jXStep * (jC1-1))) - jYWi;
    gList.Canvas.TextOut(jX1, jY1, s1);
// �������� Max
    s1 := Trim(Format(pg.sFormat, [pg.diaMax]));
    jXWi := gList.Canvas.TextWidth(s1);
    jYWi := gList.Canvas.TextHeight(s1);
    jX1 := gList.logToPointX(wnd_Graf.Right) - jXWi;
    jY1 := gList.logToPointY(wnd_Nadpisi.Bottom - 10 - (jXStep * (jC1-1))) - jYWi;
    gList.Canvas.TextOut(jX1, jY1, s1);

// ������� ���������
    jXWi := gList.Canvas.TextWidth(pg.sEdIzm);
    jYWi := gList.Canvas.TextHeight(pg.sEdIzm);
    jX1 := gList.logToPointX(wnd_Graf.Left + ((wnd_Graf.Right - wnd_Graf.Left) div 2)) - (jXWi div 2);
    jY1 := gList.logToPointY(wnd_Nadpisi.Bottom - 10 - (jXStep * (jC1-1))) - jYWi;
    gList.Canvas.TextOut(jX1, jY1, pg.sEdIzm);
  end;

// ������ ����� ������
  PrintEtapsLine(gList);

{
    if graf.bActive > 0 then
}
// ��������� ��������
  for jC1 := 1 to Grafiks.Count do
  begin
    pg := Grafiks[jC1].ukz as TprqRptGraf1;
    b1 := pg.bActive;
    if not b1 then continue;
      PrintGraf(gList, Grafiks[jC1].ukz as TprqRptGraf1);
  end;
end;

procedure TprqRptGrafWindow.PrintEtapsLine(gList: TprqRptGrafList1);
var
  jC1, jX1, jY1, jX2: Integer;
begin
  if not gList.etpSign then Exit;

  jX1 := wnd_Graf.Left;
  jX2 := wnd_Graf.Right;

  gList.Etaps.Sort(1);
  gList.Canvas.Pen.Color := gList.etpColor;
  gList.Canvas.Pen.Style := psDashDot;
  for jC1 := 1 to gList.Etaps.Count do
  begin

    jY1 := dTimeScale.getYfromTime(gList.Etaps[jC1].dataBeg);
    if jY1 < wnd_Graf.Top then continue;
    if jY1 >= wnd_Graf.Bottom then continue;

    gList.logMoveTo(jX1, jY1);
    gList.logLineTo(jX2, jY1, gList.etpWidth);
  end;
  gList.Canvas.Pen.Style := psSolid;
end;

procedure TprqRptGrafWindow.PrintEtapsName(gList: TprqRptGrafList1);
var
  jC1, jX1, jY1: Integer;
begin
  if not gList.etpSign then Exit;

  jX1 := gList.logToPointX(wnd_Graf.Left + 20);

  gList.Etaps.Sort(1);
  gList.Canvas.Font.Color := gList.etpColor;
  gList.Canvas.Font.Size  := gList.etpFntSize;

  for jC1 := 1 to gList.Etaps.Count do
  begin

    jY1 := dTimeScale.getYfromTime(gList.Etaps[jC1].dataBeg);
    jY1 := gList.logToPointY(jY1 + 10);

    gList.Canvas.TextOut(jX1, jY1, gList.Etaps[jC1].Name);
  end;
end;

procedure TprqRptGrafWindow.risGraf(gList: TprqRptGrafList1; graf: TprqRptGraf1; dataBeg, dataEnd: Double);
var
  jC1, jX1, jY1, jX2, jY2: Integer;
  dVal, dA, dB: Double;
  jYNewPoint, jYCurPoint: Integer;
  jBegPoint, jEndPoint: Integer;
  b1: Boolean;

procedure ris1;
var
//  ix1, ix2: Integer;
  pnt1, pnt2, res1, res2: TPoint;
begin
  dVal := dVal / (jYNewPoint - jYCurPoint + 1);
  jX2 := Round(dA * dVal + dB);

  pnt1.X := jX1; pnt1.Y := jY1; pnt2.X := jX2; pnt2.Y := jY2;
  if not TprqAGallfunc.LineSuperPosition(pnt1, pnt2, wnd_Graf, res1, res2) then Exit;
  gList.logMoveTo(res1.X, res1.Y);
  gList.logLineTo(res2.X, res2.Y, graf.xLogSize);
{
  ix1 := jX1; ix2 := jX2;
  if (ix1 < wnd_Graf.Left) and (ix2 < wnd_Graf.Left) then Exit;
  if (ix1 > wnd_Graf.Right) and (ix2 > wnd_Graf.Right) then Exit;
  if ix1 < wnd_Graf.Left  then ix1 := wnd_Graf.Left;
  if ix2 < wnd_Graf.Left  then ix2 := wnd_Graf.Left;
  if ix1 > wnd_Graf.Right then ix1 := wnd_Graf.Right;
  if ix2 > wnd_Graf.Right then ix2 := wnd_Graf.Right;
  gList.logMoveTo(ix1, jY1);
  gList.logLineTo(ix2, jY2, graf.xLogSize);
}
end;

begin
// ��������� ����������� �������
{
  wnd_Graf.Left, wnd_Graf.Top
                               wnd_Graf.Right, wnd_Graf.Bottom;

  graf.diaMin, gList.dtJobBeg
                               graf.diaMax, gList.dtJobEnd

  jY1 := (wnd_Graf.Right - wnd_Graf.Left) / (graf.diaMax - graf.diaMin) * (Val - graf.diaMin) + wnd_Graf.Left;
  jY1 := a * Val + b;
  a := (wnd_Graf.Right - wnd_Graf.Left) / (graf.diaMax - graf.diaMin);
  b := wnd_Graf.Left - graf.diaMin * a;
}
// ����� ������ ������� �� �������
  b1 := True;
  for jC1 := 1 to graf.yTime.Count do
  begin
    if graf.yTime[jC1]^ >= dataBeg then
    begin
      b1 := False;
      break;
    end;
  end;
  if b1 then Exit;
  jBegPoint := jC1;
// ����� ������� ������� �� �������
  b1 := True;
  for jC1 := graf.yTime.Count downto 1 do
  begin
    if graf.yTime[jC1]^ <= dataEnd then
    begin
      b1 := False;
      break;
    end;
  end;
  if b1 then Exit;
  jEndPoint := jC1;
  if jEndPoint < (jBegPoint+1) then Exit;

// ������������ �������� ��������������:
  dA := (wnd_Graf.Right - wnd_Graf.Left) / (graf.diaMax - graf.diaMin);
  dB := wnd_Graf.Left - graf.diaMin * dA;

  gList.Canvas.Pen.Color := graf.Color;

// ���� ���������
  jYCurPoint := jBegPoint;
  jYNewPoint := jBegPoint;
  jY1 := dTimeScale.getYfromTime(graf.yTime[jBegPoint]^);
  jX1 := Round(dA * graf.xVal[jBegPoint]^ + dB);
  dVal := graf.xVal[jBegPoint]^;
  jY2 := 0;

  while jYNewPoint < jEndPoint do
  begin
    b1 := True;
    Inc(jYNewPoint);
    dVal := dVal + graf.xVal[jYNewPoint]^;
    jY2 := dTimeScale.getYfromTime(graf.yTime[jYNewPoint]^);
    if (jY2 - jY1) >= graf.xLogStep then // ����� ����� �������
    begin
// �������� � ���������� ���� �������!
      ris1;
// ����������� ��������� ����
      jYCurPoint := jYNewPoint;
      jY1 := jY2;
      jX1 := jX2;
      b1 := False;
      dVal := graf.xVal[jYNewPoint]^;
      continue;
    end;
  end;
// �������� � ���������� ���� ��������� �������!
  if b1 then
  begin
    if jYNewPoint > jYCurPoint then
    begin
      ris1;
    end;
  end;
end;

procedure TprqRptGrafWindow.PrintGraf(gList: TprqRptGrafList1;
  graf: TprqRptGraf1);
var
  j1, jC1: Integer;
  rcd: rcdTcontainer;
begin
// ������ ����� ��������� ������
  for jC1 := 1 to gList.Etaps.Count do
  begin
    if graf.nChanal > 0 then
    begin
      if check(graf.xVal, graf.yTime) then
      begin
        risGrafTOut1(gList, graf, graf.xVal, graf.yTime,
                     gList.Etaps[jC1].dataBeg, gList.Etaps[jC1].dataEnd);
      end;
    end
    else
    begin
      if graf.arrChanal[jC1] > 0 then
      begin
        rcd.key := graf.arrChanal[jC1];
        j1 := graf.arrXY.Find(@rcd, 1);
        if j1 > 0 then
        begin
          if check((graf.arrXY[j1].ukz as TprqRptTX).xVal, (graf.arrXY[j1].ukz as TprqRptTX).yTime) then
            risGrafTOut1(gList, graf, (graf.arrXY[j1].ukz as TprqRptTX).xVal, (graf.arrXY[j1].ukz as TprqRptTX).yTime,
                         gList.Etaps[jC1].dataBeg, gList.Etaps[jC1].dataEnd);
        end;
      end;
    end;
  end;
end;

procedure TprqRptGrafWindow.PrintScale(gList: TprqRptGrafList1);
var
  jXWi, jYWi, jX2, jY2, j1, jY: Integer;
  s1: String;
  fs: TFont;
begin
  dTimeScale.crtScale(gList.dtJobBeg, gList.dtJobEnd, wnd_Scale.Top,
                            wnd_Scale.Bottom, netYStep);

// ��������� ����� �����
  gList.Canvas.Pen.Color := netColor;
  gList.Canvas.Font.Size := gList.TimeFSize;
  fs := gList.Canvas.Font;
  try
//    gList.Canvas.Font.Style  := fs.Style + [fsBold];
    gList.Canvas.Font.Name   := pc005_505_Serif; //pc005_505_Arial;
    j1 := 1;
    jY := dTimeScale.getYNetTime(j1, s1);

    yNet.Count := 0;
    while jY < wnd_Scale.Bottom do
    begin
      yNet.Append(@jY);
      gList.logMoveTo(wnd_Scale.Right, jY);
      gList.logLineTo(wnd_Scale.Right - netYlWidth, jY, netWidth);

      jXWi := gList.Canvas.TextWidth(s1);
      jYWi := gList.Canvas.TextHeight(s1);
      jX2 := gList.logToPointX(wnd_Scale.Right - netYlWidth - netYscShft) - jXWi; //;
      jY2 := gList.logToPointY(jY{ + 3}) - (jYWi div 2);
      gList.Canvas.TextOut(jX2, jY2, s1);

      Inc(j1);
      jY := dTimeScale.getYNetTime(j1, s1);
    end;

  finally
    gList.Canvas.Font := fs;
  end;
end;

procedure TprqRptGrafWindow.risGrafTOut1(gList: TprqRptGrafList1; graf: TprqRptGraf1;
xVal, yTime: prqTDouble; dataBeg, dataEnd: Double);
begin
  ShowMessage('�������������: ����� ������ ������� �� ��������');
end;

procedure TprqRptGrafWindow.signGrafList3(gList: TprqRptGrafList1);
var
  jC2, jYHi, jXWi, jYWi, jX1, jY1, jC1: Integer;
  pg: TprqRptGraf1;
  s1: string;
  d1, valStep, xStep: Double;
  fs: TFont;
begin
// ��������� �������� � ��������
  fs := gList.Canvas.Font;
  try
    gList.Canvas.Font.Style  := fs.Style + [fsBold];

    for jC1 := 1 to Grafiks.Count do
    begin
      pg := Grafiks[jC1].ukz as TprqRptGraf1;
      if not pg.bActive then continue;

  // �������
      gList.Canvas.Font.Size  := pg.fnSize; // gList.sz08; //pg.fnSize;
      jYWi  := gList.Canvas.TextHeight(pc005_505_HeigtShab);
      jYHi  := gList.PointXTOlog(jYWi) + pc005_505_App_Shift6 + pg.xLogSize;

      jX1 := gList.logToPointX(wnd_Nadpisi.Left);
      jY1 := gList.logToPointY(gList.LogHeadLineHeight + pc005_505_App_Shift4);
      s1 := format(pc005_505_03, [pg.sName, pg.sEdIzm]);
      gList.Canvas.TextOut(jX1, jY1, s1);
      Inc(gList.LogHeadLineHeight, jYHi);

  // �����
      jX1 := wnd_Graf.Left;
      jY1 := gList.LogHeadLineHeight;
      gList.logMoveTo(jX1, jY1);
      jX1 := wnd_Graf.Right;
      gList.Canvas.Pen.Color := pg.Color;
      gList.logLineTo(jX1, jY1, pg.xLogSize);

  // �������� Min
      s1 := Trim(Format(pg.sFormat, [pg.diaMin]));
      jYWi := gList.Canvas.TextHeight(s1);
      jX1 := gList.logToPointX(wnd_Graf.Left);
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // �������� Max
      s1 := Trim(Format(pg.sFormat, [pg.diaMax]));
      jXWi := gList.Canvas.TextWidth(s1);
      jX1 := gList.logToPointX(wnd_Graf.Right) - jXWi;
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // ������� ���������
  {
      jXWi := gList.Canvas.TextWidth(pg.sEdIzm);
      jYWi := gList.Canvas.TextHeight(pg.sEdIzm);
      jX1 := gList.logToPointX(wnd_Graf.Left + ((wnd_Graf.Right - wnd_Graf.Left) div 2)) - (jXWi div 2);
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, pg.sEdIzm);
  }

  // ���������� ������
      xStep := wnd_Graf.Right - wnd_Graf.Left;
      xStep := xStep / cntXStep;
      for jC2 := 0 to cntXStep do
      begin
        jX1 := wnd_Graf.Left + Round(xStep * jC2);
        gList.logMoveTo(jX1, gList.LogHeadLineHeight - pc005_505_App_Shift7);
        gList.logLineTo(jX1, gList.LogHeadLineHeight, netWidth);
      end;

  // ��������� ������
      valStep := pg.diaMax - pg.diaMin;
      valStep := valStep / cntXStep;
      d1 := pg.diaMin;
      for jC2 := 1 to cntXStep - 1 do
      begin
        d1   := d1 + valStep;
        s1   := Trim(Format(pg.sFormat, [d1]));
        jXWi := gList.Canvas.TextWidth(s1);
        jX1  := gList.logToPointX( wnd_Graf.Left + Round(xStep * jC2) )
                         - (jXWi div 2);
        jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
        gList.Canvas.TextOut(jX1, jY1, s1);
      end;

    end;
    wnd_Nadpisi.Bottom := gList.LogHeadLineHeight;

  finally
    gList.Canvas.Font  := fs;
  end;
end;

procedure TprqRptGrafWindow.PrintAllGraf3(gList: TprqRptGrafList1);
var
  jC1: Integer;
  pg: TprqRptGraf1;
begin
// ��������� ��������
  for jC1 := 1 to Grafiks.Count do
  begin
    pg := Grafiks[jC1].ukz as TprqRptGraf1;
    if pg.bActive then
      PrintGraf(gList, Grafiks[jC1].ukz as TprqRptGraf1);
  end;
end;

procedure TprqRptGrafWindow.PrintNetXY(gList: TprqRptGrafList1);
var
  jCenter, jYrs, jC2, j1, jX, jC1: Integer;
  xStep: Double;
  pnt1, pnt2, res1, res2: TPoint;
begin
// ������� �������������� PrintScale ��� ������� ��������� ����� �����

// ����� ���� ����
  gList.Canvas.Pen.Color := ramColor;
  gList.LogContur(wnd_Graf, ramWidth);

// ����� �� ��� �������
  gList.Canvas.Pen.Color := netColor;
  jYrs := (yNet[2]^ - yNet[1]^) div dTimeScale.divideYstep;
  for jC1 := 1 to yNet.Count do
  begin
    gList.Canvas.Pen.Style := psDash;
    for jC2 := 1 to dTimeScale.divideYstep - 1 do
    begin
      pnt1.X := wnd_Graf.Left;  pnt1.Y := yNet[jC1]^ - (jYrs * jC2);
      pnt2.X := wnd_Graf.Right; pnt2.Y := pnt1.Y;
      if TprqAGallfunc.LineSuperPosition(pnt1, pnt2, wnd_Graf, res1, res2) then
      begin
        gList.logMoveTo(res1.X, res1.Y);
        gList.logLineTo(res2.X, res2.Y, netWidth);
      end;
    end;
    gList.Canvas.Pen.Style := psSolid;
    gList.logMoveTo(wnd_Graf.Left, yNet[jC1]^);
    gList.logLineTo(wnd_Graf.Right, yNet[jC1]^, netWidth);
  end;
  gList.Canvas.Pen.Style := psDash;
  for jC2 := 1 to dTimeScale.divideYstep - 1 do
  begin
    pnt1.X := wnd_Graf.Left;  pnt1.Y := yNet[yNet.Count]^ + (jYrs * jC2);
    pnt2.X := wnd_Graf.Right; pnt2.Y := pnt1.Y;
    if TprqAGallfunc.LineSuperPosition(pnt1, pnt2, wnd_Graf, res1, res2) then
    begin
      gList.logMoveTo(res1.X, res1.Y);
      gList.logLineTo(res2.X, res2.Y, netWidth);
    end;
  end;
  gList.Canvas.Pen.Style := psSolid;

// ����� �� ��� ��������
  jCenter := cntXStep div 2; if (cntXStep mod 2) <> 0 then jCenter := 0;
  xStep := wnd_Graf.Right - wnd_Graf.Left; xStep := xStep / cntXStep;
  for jC1 := 1 to cntXStep - 1 do
  begin
    jX := wnd_Graf.Left + Round(xStep * jC1);
    if jC1 = jCenter then j1 := wnd_Nadpisi.Bottom else j1 := wnd_Graf.Top;
    gList.logMoveTo(jX, j1);
    gList.logLineTo(jX, wnd_Graf.Bottom, netWidth);
  end;
end;

class function TprqRptGrafWindow.check(xVal, yTime: prqTDouble): Boolean;
begin
  result := False;
  if yTime.Count <> xVal.Count then
  begin
    if  xVal.Count > yTime.Count then xVal.Count := yTime.Count;
    if yTime.Count > xVal.Count  then yTime.Count := xVal.Count;
  end;
  if xVal.Count < 2 then
  begin
    Exit;
  end;
  result := True;
end;

procedure TprqRptGrafWindow.CloneClass(Source: TprqRptGrafWindow);
var
  jC1: Integer;
begin
  if not Assigned(Source) then Exit;

  wnd_all     := Source.wnd_all;
  wnd_Nadpisi := Source.wnd_Nadpisi;
  wnd_Graf    := Source.wnd_Graf;
  wnd_Scale   := Source.wnd_Scale;
  cntGrPodp   := Source.cntGrPodp;
  cntXStep    := Source.cntXStep;
  netColor    := Source.netColor;
  ramColor    := Source.ramColor;
  ramWidth    := Source.ramWidth;
  netWidth    := Source.netWidth;
  TSclSize    := Source.TSclSize;
  netYlWidth  := Source.netYlWidth;
  netYscShft  := Source.netYscShft;
  netYStep    := Source.netYStep;
  jDraw       := Source.jDraw;

  dTimeScale.CloneClass(Source.dTimeScale);
  yNet.Count := 0; yNet.AppendClass(Source.yNet);

  Grafiks.Count := 0;
  Grafiks.Count := Source.Grafiks.Count;
  for jC1 := 1 to Source.Grafiks.Count do
  begin
    Grafiks[jC1].ukz := TprqRptGraf1.Create;
    (Grafiks[jC1].ukz as TprqRptGraf1).CloneClass(Source.Grafiks[jC1].ukz as TprqRptGraf1);
    Grafiks[jC1].key := Source.Grafiks[jC1].key;
  end;
end;

procedure TprqRptGrafWindow.PrintEtapsLine3(gList: TprqRptGrafList1);
begin
  gList.Canvas.Pen.Mode := pmNotXor;
  PrintEtapsLine(gList);
  gList.Canvas.Pen.Mode := pmCopy;
end;

procedure TprqRptGrafWindow.PrintEtapsName3(gList: TprqRptGrafList1);
begin
  gList.Canvas.Pen.Mode := pmNotXor;
  PrintEtapsLine(gList);
  gList.Canvas.Pen.Mode := pmCopy;
end;

procedure TprqRptGrafWindow.PrintEtapsLine2(gList: TprqRptGrafList1);
var
  jC1, jX1, jY1, jX2: Integer;
begin
  if not gList.etpSign then Exit;

  jX1 := wnd_Graf.Left;
  jX2 := wnd_Graf.Right;

  gList.Canvas.Pen.Style := psDashDot;
  for jC1 := 1 to gList.Etaps.Count do
  begin

    jY1 := dTimeScale.getYfromTime(gList.Etaps[jC1].dataBeg);
    if jY1 < wnd_Graf.Top then continue;
    if jY1 >= wnd_Graf.Bottom then continue;
    gList.logMoveTo(jX1, jY1);
    gList.Canvas.Pen.Color := gList.etpColor;
    gList.logLineTo(jX2, jY1, gList.etpWidth);

    jY1 := dTimeScale.getYfromTime(gList.Etaps[jC1].dataEnd);
    if jY1 < wnd_Graf.Top then continue;
    if jY1 >= wnd_Graf.Bottom then continue;
    gList.logMoveTo(jX1, jY1);
    gList.Canvas.Pen.Color := gList.etpColorEnd;
    gList.logLineTo(jX2, jY1, gList.etpWidth);

  end;
  gList.Canvas.Pen.Style := psSolid;
end;

procedure TprqRptGrafWindow.PrintEtapsBorder(gList: TprqRptGrafList1);
var
  jC1, jY2, jY1, jX2: Integer;
  Rect, logR: TRect;
begin
  if not gList.etpSign then Exit;

  jX2 := wnd_Graf.Right;
  for jC1 := 1 to gList.Etaps.Count do
  begin

    jY1 := dTimeScale.getYfromTime(gList.Etaps[jC1].dataBeg);
    if jY1 < wnd_Graf.Top then continue;
    if jY1 >= wnd_Graf.Bottom then continue;

    jY2 := dTimeScale.getYfromTime(gList.Etaps[jC1].dataEnd);
    if jY2 < wnd_Graf.Top then continue;
    if jY2 > wnd_Graf.Bottom then continue;
{
    gList.logMoveTo(jX2 + 10, jY1);
    gList.Canvas.Pen.Color := getColor(jC1);
    gList.logLineTo(jX2 + 10, jY2, 10);
}
//    gList.Canvas.Brush.Color := clWhite;

    logR.Left   := jX2 + 5;
    logR.Top    := jY1;
    logR.Right  := jX2 + 55;
    logR.Bottom := jY2;
    Rect        := gList.logToPointXY(logR);

    gList.Canvas.Brush.Style := bsSolid;
    gList.Canvas.Pen.Color   := clWhite;
    gList.Canvas.Brush.Color := clWhite;
    gList.Canvas.Rectangle(Rect);

    gList.Canvas.Brush.Style := bsDiagCross;
    gList.Canvas.Pen.Color   := getColor(jC1);
    gList.Canvas.Brush.Color := getColor(jC1); // clLime; //
    gList.Canvas.Rectangle(Rect);
//    gList.Canvas.FillRect(Rect);
  end;
end;

class function TprqRptGrafWindow.getColor(num: Integer): TColor;
begin
  num := num mod 7;
  case num of
    0: result := clAqua;
    1: result := clRed;
    2: result := clGreen;
    3: result := clBlue;
    4: result := clMaroon;
    5: result := clLime;
    6: result := clFuchsia;
{
    5: result := clOlive;
    6: result := clNavy;
    8: result := clPurple;
    9: result := clTeal;
   10: result := clYellow;
   11: result := clFuchsia;
}
  else
       result := clBlack;
  end;

end;

procedure TprqRptGrafWindow.PrintEtapsName2(gList: TprqRptGrafList1);
var
  jC1, jX1, jY1: Integer;
begin
  if not gList.etpSign then Exit;


  gList.Etaps.Sort(1);
  gList.Canvas.Font.Size  := gList.etpFntSize;

  for jC1 := 1 to gList.Etaps.Count do
  begin

    jY1 := dTimeScale.getYfromTime(gList.Etaps[jC1].dataBeg);
    jY1 := gList.logToPointY(jY1 + 10);

    jX1 := gList.logToPointX(wnd_Graf.Right - 20) - gList.Canvas.TextWidth(gList.Etaps[jC1].Name);
    gList.Canvas.Font.Color := getColor(jC1);
    gList.Canvas.TextOut(jX1, jY1, gList.Etaps[jC1].Name);
  end;
end;

procedure TprqRptGrafWindow.risGrafTOutU1(gList: TprqRptGrafList1;
  graf: TprqRptGraf1; xVal, yTime: prqTDouble; dataBeg, dataEnd: Double);
var
  jC1, jX1, jY1, jX2, jY2: Integer;
  dVal, dA, dB: Double;

//  dxVal: prqTDouble;

procedure ris1(jYNewPoint, jYCurPoint: Integer);
var
  pnt1, pnt2, res1, res2: TPoint;
begin
  dVal := dVal / (jYNewPoint - jYCurPoint + 1);
  jX2 := Round(dA * dVal + dB);

  pnt1.X := jX1; pnt1.Y := jY1; pnt2.X := jX2; pnt2.Y := jY2;
  if not TprqAGallfunc.LineSuperPosition(pnt1, pnt2, wnd_Graf, res1, res2) then Exit;
  gList.logMoveTo(res1.X, res1.Y);
  gList.logLineTo(res2.X, res2.Y, graf.xLogSize);
end;

procedure Ris2(jPoint1, jPoint2: Integer);
var
  jYNewPoint, jYCurPoint: Integer;
  b1: Boolean;
begin
  b1 := False;
  jYCurPoint := jPoint1;
  jYNewPoint := jPoint1;
  jY1 := dTimeScale.getYfromTime(yTime[jPoint1]^);
  jX1 := Round(dA * xVal[jPoint1]^ + dB);
  dVal := xVal[jPoint1]^;
  jY2 := 0;

  while jYNewPoint < jPoint2 do
  begin
    b1 := True;
    Inc(jYNewPoint);

    dVal := dVal + xVal[jYNewPoint]^;
    jY2 := dTimeScale.getYfromTime(yTime[jYNewPoint]^);
    if (jY2 - jY1) >= graf.xLogStep then // ����� ����� �������
    begin
// �������� � ���������� ���� �������!
      ris1(jYNewPoint, jYCurPoint);
// ����������� ��������� ����
      jYCurPoint := jYNewPoint;
      jY1 := jY2;
      jX1 := jX2;
      b1 := False;
      dVal := xVal[jYNewPoint]^;
      continue;
    end;
  end;

// �������� � ���������� ���� ��������� �������!
  if b1 then
  begin
    if jYNewPoint > jYCurPoint then
    begin
      ris1(jYNewPoint, jYCurPoint);
    end;
  end;
end;

var
  jYNewPoint, jYCurPoint: Integer;
  jBegPoint, jEndPoint: Integer;
  dt1, dt2: Double;
  b1: Boolean;
  dTOut: Double;          // ����-��� �������, ���� 0, �� �������� �������� ���
begin
// ��������� ����������� ������� � ������ TOut = graf.dTOut

// ����� ������ ������� �� �������
  b1 := True;
  for jC1 := 1 to yTime.Count do
  begin
    if yTime[jC1]^ >= dataBeg then
    begin
      b1 := False;
      break;
    end;
  end;
  if b1 then Exit;
  jBegPoint := jC1;
// ����� ������� ������� �� �������
  b1 := True;
  for jC1 := yTime.Count downto 1 do
  begin
    if yTime[jC1]^ <= dataEnd then
    begin
      b1 := False;
      break;
    end;
  end;
  if b1 then Exit;
  jEndPoint := jC1;
  if jEndPoint < (jBegPoint+1) then Exit;

// �������������� (������������) ����� � ������ �������������
  try
  // ������������ �������� ��������������:
    dA := (wnd_Graf.Right - wnd_Graf.Left) / (graf.diaMax - graf.diaMin);
    dB := wnd_Graf.Left - graf.diaMin * dA;

    gList.Canvas.Pen.Color := graf.Color;

  // ���� ���������
// ���������� �������
    if gList.jTOut > 0 then
    begin
      dTOut := gList.jTOut;
      dTOut := dTOut / 1000; // (������� ���� � ���)
    end
    else
    begin
      dTOut := graf.dTOut;
    end;
    if (dtOut > 0)  and  (dtOut <= 0.1) then dtOut := 3;
    dTOut := dTOut / (24*3600);

//    dTOut := 0;

//    if graf.dTOut = 0 then graf.dTOut := 10 / (24*3600);
    if {graf.}dTOut <= 0 then
    begin
      Ris2(jBegPoint, jEndPoint);
    end
    else
    begin // ����� �������� �������� � �������
  // ���� ��������� "�����������" ��������
      jYCurPoint := jBegPoint;
      jYNewPoint := jBegPoint;
      b1 := False;
      while jYNewPoint < jEndPoint do
      begin
        b1 := True;
        dt1 := yTime[jYNewPoint]^;
        Inc(jYNewPoint);
        dt2 := yTime[jYNewPoint]^;
        if (dt2 - dt1) >= {graf.}dTOut then
        begin // ��������� ������ � �������
          if jYNewPoint > (jYCurPoint + 1) then
          begin
            Ris2(jYCurPoint, jYNewPoint-1);
          end;
          jYCurPoint := jYNewPoint;
          b1 := False;
  //        break;
          continue;
        end;
      end;

      if b1 then
      begin
        if jYNewPoint > (jYCurPoint + 1) then
        begin
          Ris2(jYCurPoint, jYNewPoint-1);
        end;
      end;
    end;

  finally
  end;
end;

procedure TprqRptGrafWindow.signGrafList3(gList: TprqRptGrafList1;
  nGraf: integer);
var
  jYposNadp, jYHi, jXWi, jYWi, jX1, jX2, jX3, jY1: Integer;
  pg: TprqRptGraf1;
  s1: string;
  fs: TFont;
begin
// ��������� �������� � ��������
  fs := gList.Canvas.Font;
  try
    gList.Canvas.Font.Style  := fs.Style + [fsBold];


      pg := Grafiks[nGraf].ukz as TprqRptGraf1;
      if not pg.bActive then Exit;

  // �������
      gList.Canvas.Font.Size  := pg.fnSize; // gList.sz08; //pg.fnSize;
      jYWi := gList.Canvas.TextHeight(pc005_505_HeigtShab);
      jYHi := gList.PointXTOlog(jYWi) + pc005_505_App_Shift6 + pg.xLogSize;
      jYposNadp := gList.logToPointY(gList.LogHeadLineHeight + pc005_505_App_Shift4);

      Inc(gList.LogHeadLineHeight, jYHi);

  // �����
      jX1 := wnd_Graf.Left;
      jY1 := gList.LogHeadLineHeight;
      gList.logMoveTo(jX1, jY1);
      jX1 := wnd_Graf.Right;
      gList.Canvas.Pen.Color := pg.Color;
      gList.logLineTo(jX1, jY1, pg.xLogSize);

  // �������� Min
      s1 := Trim(Format(pg.sFormat, [pg.diaMin]));
      jYWi := gList.Canvas.TextHeight(s1);
      jX1 := gList.logToPointX(wnd_Graf.Left);
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // �������� Max
      s1 := Trim(Format(pg.sFormat, [pg.diaMax]));
      jXWi := gList.Canvas.TextWidth(s1);
      jX1 := gList.logToPointX(wnd_Graf.Right) - jXWi;
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // ���������� ������
      jX1 := wnd_Graf.Left;
      gList.logMoveTo(jX1, gList.LogHeadLineHeight - pc005_505_App_Shift7);
      gList.logLineTo(jX1, gList.LogHeadLineHeight, netWidth);
      jX2 := wnd_Graf.Right;
      gList.logMoveTo(jX2, gList.LogHeadLineHeight - pc005_505_App_Shift7);
      gList.logLineTo(jX2, gList.LogHeadLineHeight, netWidth);

// ���������� �������
      s1 := format(pc005_505_03, [pg.sName, pg.sEdIzm]);
      jXWi := gList.Canvas.TextWidth(s1);
      jX3 := gList.logToPointX((jX1 + jX2) div 2) - (jXWi div 2);
      gList.Canvas.TextOut(jX3, jYposNadp, s1);

    wnd_Nadpisi.Bottom := gList.LogHeadLineHeight;

  finally
    gList.Canvas.Font  := fs;
  end;
end;

function TprqRptGrafWindow.getHeightsignGrafList3(gList: TprqRptGrafList1;
  nGraf: integer): integer;
var
  jYHi, jYWi: Integer;
  pg: TprqRptGraf1;
  fs: TFont;
begin
// ��������� �������� � ��������
  fs := gList.Canvas.Font;
  result := 0;
  try
    gList.Canvas.Font.Style  := fs.Style + [fsBold];

      pg := Grafiks[nGraf].ukz as TprqRptGraf1;
      if not pg.bActive then Exit;

  // �������
      gList.Canvas.Font.Size  := pg.fnSize; // gList.sz08; //pg.fnSize;
      jYWi  := gList.Canvas.TextHeight(pc005_505_HeigtShab);
      jYHi  := gList.PointXTOlog(jYWi) + pc005_505_App_Shift6 + pg.xLogSize;

      result := gList.LogHeadLineHeight + jYHi;

  finally
    gList.Canvas.Font  := fs;
  end;
end;

procedure TprqRptGrafWindow.PrintScale(gList: TprqRptGrafList1;
  jNumScale: Integer; dtBeg,dtEnd: double; var tBeg, tEnd: double;
  txtScale: double);
var
  jXWi, jYWi, jX2, jY2, j1, jY: Integer;
  s1: String;
  fs: TFont;
begin
  dTimeScale.crtScale(dtBeg, dtEnd, wnd_Scale.Top,
                            wnd_Scale.Bottom, netYStep, jNumScale, tBeg, tEnd);

// ��������� ����� �����
  gList.Canvas.Pen.Color := netColor;
  gList.Canvas.Font.Size := Trunc(self.TSclSize * txtScale);
  fs := gList.Canvas.Font;
  try
//    gList.Canvas.Font.Style  := fs.Style + [fsBold];
    gList.Canvas.Font.Name   := pc005_505_Serif; //pc005_505_Arial;
    j1 := 1;
    jY := dTimeScale.getYNetTime(j1, s1);

    yNet.Count := 0;
    while jY < wnd_Scale.Bottom do
    begin
      yNet.Append(@jY);
      gList.logMoveTo(wnd_Scale.Right, jY);
      gList.logLineTo(wnd_Scale.Right - netYlWidth, jY, netWidth);

      jXWi := gList.Canvas.TextWidth(s1);
      jYWi := gList.Canvas.TextHeight(s1);
      jX2 := gList.logToPointX(wnd_Scale.Right - netYlWidth - netYscShft) - jXWi; //;
      jY2 := gList.logToPointY(jY{ + 3}) - (jYWi div 2);
      gList.Canvas.TextOut(jX2, jY2, s1);

      Inc(j1);
      jY := dTimeScale.getYNetTime(j1, s1);
    end;

  finally
    gList.Canvas.Font := fs;
  end;
end;

function TprqRptGrafWindow.getHeightsignGrafList3(gList: TprqRptGrafList1;
  nGraf: integer; txtScale: double): integer;
var
  jYHi, jYWi: Integer;
  pg: TprqRptGraf1;
  fs: TFont;
begin
// ��������� �������� � ��������
  fs := gList.Canvas.Font;
  result := 0;
  try
    gList.Canvas.Font.Style  := fs.Style + [fsBold];

      pg := Grafiks[nGraf].ukz as TprqRptGraf1;
      if not pg.bActive then Exit;

  // �������
      gList.Canvas.Font.Size  := Trunc(pg.fnSize * txtScale);
      jYWi  := gList.Canvas.TextHeight(pc005_505_HeigtShab);
      jYHi  := gList.PointXTOlog(jYWi) + pc005_505_App_Shift6 + pg.xLogSize;

      result := gList.LogHeadLineHeight + jYHi;

  finally
    gList.Canvas.Font  := fs;
  end;
end;

procedure TprqRptGrafWindow.signGrafList3(gList: TprqRptGrafList1;
  nGraf: integer; txtScale: double);
var
  jYposNadp, jYHi, jXWi, jYWi, jX1, jX2, jX3, jY1: Integer;
  pg: TprqRptGraf1;
  s1: string;
  fs: TFont;
begin
// ��������� �������� � ��������
  fs := gList.Canvas.Font;
  try
    gList.Canvas.Font.Style  := fs.Style + [fsBold];


      pg := Grafiks[nGraf].ukz as TprqRptGraf1;
      if not pg.bActive then Exit;

  // �������
      gList.Canvas.Font.Size  := Trunc(pg.fnSize * txtScale);
      jYWi := gList.Canvas.TextHeight(pc005_505_HeigtShab);
      jYHi := gList.PointXTOlog(jYWi) + pc005_505_App_Shift6 + pg.xLogSize;
      jYposNadp := gList.logToPointY(gList.LogHeadLineHeight + pc005_505_App_Shift4);

      Inc(gList.LogHeadLineHeight, jYHi);

  // �����
      jX1 := wnd_Graf.Left;
      jY1 := gList.LogHeadLineHeight;
      gList.logMoveTo(jX1, jY1);
      jX1 := wnd_Graf.Right;
      gList.Canvas.Pen.Color := pg.Color;
      gList.logLineTo(jX1, jY1, pg.xLogSize);

  // �������� Min
      s1 := Trim(Format(pg.sFormat, [pg.diaMin]));
      jYWi := gList.Canvas.TextHeight(s1);
      jX1 := gList.logToPointX(wnd_Graf.Left);
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // �������� Max
      s1 := Trim(Format(pg.sFormat, [pg.diaMax]));
      jXWi := gList.Canvas.TextWidth(s1);
      jX1 := gList.logToPointX(wnd_Graf.Right) - jXWi;
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // ���������� ������
      jX1 := wnd_Graf.Left;
      gList.logMoveTo(jX1, gList.LogHeadLineHeight - pc005_505_App_Shift7);
      gList.logLineTo(jX1, gList.LogHeadLineHeight, netWidth);
      jX2 := wnd_Graf.Right;
      gList.logMoveTo(jX2, gList.LogHeadLineHeight - pc005_505_App_Shift7);
      gList.logLineTo(jX2, gList.LogHeadLineHeight, netWidth);

// ���������� �������
      s1 := format(pc005_505_03, [pg.sName, pg.sEdIzm]);
      jXWi := gList.Canvas.TextWidth(s1);
      jX3 := gList.logToPointX((jX1 + jX2) div 2) - (jXWi div 2);
      gList.Canvas.TextOut(jX3, jYposNadp, s1);

    wnd_Nadpisi.Bottom := gList.LogHeadLineHeight;

  finally
    gList.Canvas.Font  := fs;
  end;
end;

function TprqRptGrafWindow.isActiveGraph: boolean;
var
  pg:  TprqRptGraf1;
  jC1: integer;
begin
  result := false; // ��������� ������� �������� � �������� �����
  for jC1 := 1 to self.Grafiks.Count do
  begin
    pg := self.Grafiks[jC1].ukz as TprqRptGraf1;
    if pg.bActive then
    begin
      result := true;
      Exit;
    end;
  end;
end;

procedure TprqRptGrafWindow.signGrafList3M(gList: TprqRptGrafList1;
  txtScale: double; pw: TprqRptGrafWindow);
var
  jCntr, jX3, jYposNadp, jC2, jYHi, jXWi, jYWi, jX1, jY1, jC1: Integer;
  pg: TprqRptGraf1;
  s1: string;
  d1, valStep, xStep: Double;
  fs: TFont;
begin
// ��������� �������� � ��������
  fs := gList.Canvas.Font;
  try
    gList.Canvas.Font.Style  := fs.Style + [fsBold];

    for jC1 := 1 to Grafiks.Count do
    begin
      pg := Grafiks[jC1].ukz as TprqRptGraf1;
      if not pg.bActive then continue;

  // �������
      gList.Canvas.Font.Size  := Trunc(pg.fnSize * txtScale);
      jYWi := gList.Canvas.TextHeight(pc005_505_HeigtShab);
      jYHi := gList.PointXTOlog(jYWi) + pc005_505_App_Shift6 + netWidth {pg.xLogSize};
      jYposNadp := gList.logToPointY(gList.LogHeadLineHeight + pc005_505_App_Shift4);

      Inc(gList.LogHeadLineHeight, jYHi);

  // �����
      jX1 := wnd_Graf.Left;
      jY1 := gList.LogHeadLineHeight;
      gList.logMoveTo(jX1, jY1);
      jX1 := wnd_Graf.Right;
      gList.Canvas.Pen.Color := pg.Color;
      gList.logLineTo(jX1, jY1, netWidth {pg.xLogSize});

  // �������� Min
      s1 := Trim(Format(pg.sFormat, [pg.diaMin]));
      jYWi := gList.Canvas.TextHeight(s1);
      jX1 := gList.logToPointX(wnd_Graf.Left);
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // �������� Max
      s1 := Trim(Format(pg.sFormat, [pg.diaMax]));
      jXWi := gList.Canvas.TextWidth(s1);
      jX1 := gList.logToPointX(wnd_Graf.Right) - jXWi;
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // ������� ���������
  {
      jXWi := gList.Canvas.TextWidth(pg.sEdIzm);
      jYWi := gList.Canvas.TextHeight(pg.sEdIzm);
      jX1 := gList.logToPointX(wnd_Graf.Left + ((wnd_Graf.Right - wnd_Graf.Left) div 2)) - (jXWi div 2);
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, pg.sEdIzm);
  }

  // ���������� ������
      xStep := wnd_Graf.Right - wnd_Graf.Left;
      xStep := xStep / cntXStep;
      for jC2 := 0 to cntXStep do
      begin
        jX1 := wnd_Graf.Left + Round(xStep * jC2);
        gList.logMoveTo(jX1, gList.LogHeadLineHeight - pc005_505_App_Shift7);
        gList.logLineTo(jX1, gList.LogHeadLineHeight, netWidth);
      end;

  // ��������� ������
      if pw.bSignScaleVal and (cntXStep>1) then
      begin
        valStep := pg.diaMax - pg.diaMin;
        valStep := valStep / cntXStep;
        d1 := pg.diaMin;
//        jCntr := cntXStep div 2;
//        if (jCntr * 2) <> cntXStep then
        begin
          jCntr := -1;
        end;

        for jC2 := 1 to cntXStep - 1 do
        begin
          d1   := d1 + valStep;
          if jC2 = jCntr then continue;
          s1   := Trim(Format(pg.sFormat, [d1]));
          jXWi := gList.Canvas.TextWidth(s1);
          jX1  := gList.logToPointX( wnd_Graf.Left + Round(xStep * jC2) )
                           - (jXWi div 2);
          jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
          gList.Canvas.TextOut(jX1, jY1, s1);
        end;
      end;

// ���������� �������
      if Length(pg.sEdIzm) = 0 then
      begin
        s1 := Trim(format(pc005_505_04, [pg.sName]));
      end
      else
      begin
        s1 := Trim(format(pc005_505_03, [pg.sName, pg.sEdIzm]));
      end;
      jXWi := gList.Canvas.TextWidth(s1);
//      jX2 := wnd_Graf.Right;
      jX3 := gList.logToPointX((wnd_Graf.Left + wnd_Graf.Right) div 2) - (jXWi div 2);
      gList.Canvas.TextOut(jX3, jYposNadp, s1);
    end;
    wnd_Nadpisi.Bottom := gList.LogHeadLineHeight;

  finally
    gList.Canvas.Font  := fs;
  end;
end;

procedure TprqRptGrafWindow.signGrafList3MPrint(gList: TprqRptGrafList1;
  txtScale: double; pw: TprqRptGrafWindow);
var
  jCntr, jX3, jYposNadp, jC2, jYHi, jXWi, jYWi, jX1, jY1, jC1: Integer;
  pg: TprqRptGraf1;
  s1: string;
  d1, valStep, xStep: Double;
  fs: TFont;
begin
// ��������� �������� � ��������
  fs := gList.Canvas.Font;
  try
    gList.Canvas.Font.Style  := fs.Style + [fsBold];

    for jC1 := 1 to Grafiks.Count do
    begin
      pg := Grafiks[jC1].ukz as TprqRptGraf1;
      if not pg.bActive then continue;

  // �������
      gList.Canvas.Font.Size  := Trunc(pg.fnSize * txtScale);
      jYWi := gList.Canvas.TextHeight(pc005_505_HeigtShab);
      jYHi := gList.PointXTOlog(jYWi) + pc005_505_App_Shift6 + netWidth {pg.xLogSize};
      jYposNadp := gList.logToPointY(gList.LogHeadLineHeight + pc005_505_App_Shift4);

      Inc(gList.LogHeadLineHeight, (jYHi * 8) div 11);

  // �����
      jX1 := wnd_Graf.Left;
      jY1 := gList.LogHeadLineHeight;
      gList.logMoveTo(jX1, jY1);
      jX1 := wnd_Graf.Right;
      gList.Canvas.Pen.Color := pg.Color;
      gList.logLineTo(jX1, jY1, netWidth {pg.xLogSize});

  // �������� Min
      s1 := Trim(Format(pg.sFormat, [pg.diaMin]));
      jYWi := gList.Canvas.TextHeight(s1);
      jX1 := gList.logToPointX(wnd_Graf.Left);
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // �������� Max
      s1 := Trim(Format(pg.sFormat, [pg.diaMax]));
      jXWi := gList.Canvas.TextWidth(s1);
      jX1 := gList.logToPointX(wnd_Graf.Right) - jXWi;
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // ������� ���������
  {
      jXWi := gList.Canvas.TextWidth(pg.sEdIzm);
      jYWi := gList.Canvas.TextHeight(pg.sEdIzm);
      jX1 := gList.logToPointX(wnd_Graf.Left + ((wnd_Graf.Right - wnd_Graf.Left) div 2)) - (jXWi div 2);
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, pg.sEdIzm);
  }

  // ���������� ������
      xStep := wnd_Graf.Right - wnd_Graf.Left;
      xStep := xStep / cntXStep;
      for jC2 := 0 to cntXStep do
      begin
        jX1 := wnd_Graf.Left + Round(xStep * jC2);
        gList.logMoveTo(jX1, gList.LogHeadLineHeight - pc005_505_App_Shift7);
        gList.logLineTo(jX1, gList.LogHeadLineHeight, netWidth);
      end;

  // ��������� ������
      if pw.bSignScaleVal and (cntXStep>1) then
      begin
        valStep := pg.diaMax - pg.diaMin;
        valStep := valStep / cntXStep;
        d1 := pg.diaMin;
//        jCntr := cntXStep div 2;
//        if (jCntr * 2) <> cntXStep then
        begin
          jCntr := -1;
        end;

        for jC2 := 1 to cntXStep - 1 do
        begin
          d1   := d1 + valStep;
          if jC2 = jCntr then continue;
          s1   := Trim(Format(pg.sFormat, [d1]));
          jXWi := gList.Canvas.TextWidth(s1);
          jX1  := gList.logToPointX( wnd_Graf.Left + Round(xStep * jC2) )
                           - (jXWi div 2);
          jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
          gList.Canvas.TextOut(jX1, jY1, s1);
        end;
      end;

// ���������� �������
      if Length(pg.sEdIzm) = 0 then
      begin
        s1 := Trim(format(pc005_505_04, [pg.sName]));
      end
      else
      begin
        s1 := Trim(format(pc005_505_03, [pg.sName, pg.sEdIzm]));
      end;
      jXWi := gList.Canvas.TextWidth(s1);
//      jX2 := wnd_Graf.Right;
      jX3 := gList.logToPointX((wnd_Graf.Left + wnd_Graf.Right) div 2) - (jXWi div 2);
      gList.Canvas.TextOut(jX3, jYposNadp, s1);
    end;
    wnd_Nadpisi.Bottom := gList.LogHeadLineHeight;

  finally
    gList.Canvas.Font  := fs;
  end;
end;

procedure TprqRptGrafWindow.signGrafList3M(gList: TprqRptGrafList4;
  pw: TprqRptGrafWindow);
var
  jCntr, jX3, jYposNadp, jC2, jYHi, jXWi, jYWi, jX1, jY1, jC1: Integer;
  pg: TprqRptGraf1;
  s1: string;
  d1, valStep, xStep: Double;
  fs: TFont;
begin
// ��������� �������� � ��������
  fs := gList.Canvas.Font;
  try
    gList.Canvas.Font.Style  := fs.Style + [fsBold];
//    self.Canvas.Font.Style  := fs.Style + [fsBold];
    gList.Canvas.Font.Size  := gList.ScalFSize;

    for jC1 := 1 to Grafiks.Count do
    begin
      pg := Grafiks[jC1].ukz as TprqRptGraf1;
      if not pg.bActive then continue;

  // �������
//      gList.Canvas.Font.Size  := gList.ScalFSize;
      jYWi := gList.Canvas.TextHeight(pc005_505_HeigtShab);
      jYHi := gList.PointXTOlog(jYWi) + pc005_505_App_Shift6 + netWidth {pg.xLogSize};
      jYposNadp := gList.logToPointY(gList.LogHeadLineHeight + pc005_505_App_Shift4);
// ���������� �������
      if Length(pg.sEdIzm) = 0 then
      begin
        s1 := Trim(format(pc005_505_04, [pg.sName]));
      end
      else
      begin
        s1 := Trim(format(pc005_505_03, [pg.sName, pg.sEdIzm]));
      end;
      jXWi := gList.Canvas.TextWidth(s1);
      jX3 := gList.logToPointX((wnd_Graf.Left + wnd_Graf.Right) div 2) - (jXWi div 2);
      gList.Canvas.TextOut(jX3, jYposNadp, s1);
      Inc(gList.LogHeadLineHeight, jYHi);

  // ��������� ������
      xStep := wnd_Graf.Right - wnd_Graf.Left;
      xStep := xStep / cntXStep;
      if pw.bSignScaleVal and (cntXStep>1) then
      begin
        Inc(gList.LogHeadLineHeight, jYHi - pc005_505_App_Shift4);

        valStep := pg.diaMax - pg.diaMin;
        valStep := valStep / cntXStep;
        d1 := pg.diaMin;
        begin
          jCntr := -1;
        end;
        for jC2 := 1 to cntXStep - 1 do
        begin
          d1   := d1 + valStep;
          if jC2 = jCntr then continue;
          s1   := Trim(Format(pg.sFormat, [d1]));
          jXWi := gList.Canvas.TextWidth(s1);
          jX1  := gList.logToPointX( wnd_Graf.Left + Round(xStep * jC2) )
                           - (jXWi div 2);
          jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
//          jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4);
          gList.Canvas.TextOut(jX1, jY1, s1);
        end;
      end;

  // �����
      jX1 := wnd_Graf.Left;
      jY1 := gList.LogHeadLineHeight;
      gList.logMoveTo(jX1, jY1);
      jX1 := wnd_Graf.Right;
      gList.Canvas.Pen.Color := pg.Color;
      gList.logLineTo(jX1, jY1, netWidth {pg.xLogSize});

  // �������� Min
      s1 := Trim(Format(pg.sFormat, [pg.diaMin]));
//      jYWi := gList.Canvas.TextHeight(s1);
      jX1 := gList.logToPointX(wnd_Graf.Left);
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // �������� Max
      s1 := Trim(Format(pg.sFormat, [pg.diaMax]));
      jXWi := gList.Canvas.TextWidth(s1);
      jX1 := gList.logToPointX(wnd_Graf.Right) - jXWi;
      jY1 := gList.logToPointY(gList.LogHeadLineHeight - pc005_505_App_Shift4) - jYWi;
      gList.Canvas.TextOut(jX1, jY1, s1);

  // ���������� ������
      for jC2 := 0 to cntXStep do
      begin
        jX1 := wnd_Graf.Left + Round(xStep * jC2);
        gList.logMoveTo(jX1, gList.LogHeadLineHeight - pc005_505_App_Shift7);
        gList.logLineTo(jX1, gList.LogHeadLineHeight, netWidth);
      end;
    end;
    wnd_Nadpisi.Bottom := gList.LogHeadLineHeight;

  finally
    gList.Canvas.Font  := fs;
  end;
end;

procedure TprqRptGrafWindow.PrintScale(gList: TprqRptGrafList4;
  jNumScale: Integer; dtBeg, dtEnd: double; var tBeg, tEnd: double);
var
  jXWi, jYWi, jX2, jY2, j1, jY: Integer;
  s1: String;
  fs: TFont;
begin
  dTimeScale.crtScale(dtBeg, dtEnd, wnd_Scale.Top,
                            wnd_Scale.Bottom, netYStep, jNumScale, tBeg, tEnd);

// ��������� ����� �����
  gList.Canvas.Pen.Color := netColor;
  gList.Canvas.Font.Size := gList.TimeFSize;
  fs := gList.Canvas.Font;
  try
//    gList.Canvas.Font.Style  := fs.Style + [fsBold];
    gList.Canvas.Font.Name   := pc005_505_Serif; //pc005_505_Arial;
    j1 := 1;
    jY := dTimeScale.getYNetTime(j1, s1);

    yNet.Count := 0;
    while jY < wnd_Scale.Bottom do
    begin
      yNet.Append(@jY);
      gList.logMoveTo(wnd_Scale.Right, jY);
      gList.logLineTo(wnd_Scale.Right - netYlWidth, jY, netWidth);

      jXWi := gList.Canvas.TextWidth(s1);
      jYWi := gList.Canvas.TextHeight(s1);
      jX2 := gList.logToPointX(wnd_Scale.Right - netYlWidth - netYscShft) - jXWi; //;
      jY2 := gList.logToPointY(jY{ + 3}) - (jYWi div 2);
      gList.Canvas.TextOut(jX2, jY2, s1);

      Inc(j1);
      jY := dTimeScale.getYNetTime(j1, s1);
    end;

  finally
    gList.Canvas.Font := fs;
  end;
end;

{ TprqTimeScale1 }

procedure TprqTimeScale1.CloneClass(Source: TprqTimeScale1);
begin
  if not Assigned(Source) then Exit;

  self.Count := 0;
  self.AppendClass(Source);

  fdMin          := Source.fdMin;
  fdMax          := Source.fdMax;
  fyMin          := Source.fyMin;
  fyMax          := Source.fyMax;
  fyNetStep      := Source.fyNetStep;
  dtYtoTimeStep  := Source.dtYtoTimeStep;
  dtTimeToYStep  := Source.dtTimeToYStep;
  dtNetStep1     := Source.dtNetStep1;
  divideYstep    := Source.divideYstep;
  dtFirstNetTime := Source.dtFirstNetTime;
  sFrm           := Source.sFrm;
end;

constructor TprqTimeScale1.Create;
var
  dStp, dStp1: Double;
begin
  inherited;
// ���������� ����� ����������
  dStp := 1;      Append(@dStp);     // ��� = �����           1  2
  dStp := 1 / 2;  Append(@dStp); // ��� = 12 �����            2  2
  dStp := 1 / 4;  Append(@dStp); // ��� =  6 �����            3  2
  dStp := 1 / 6;  Append(@dStp); // ��� =  4 ����             4  2
  dStp := 1 / 8;  Append(@dStp); // ��� =  3 ����             5  3
  dStp := 1 /12;  Append(@dStp); // ��� =  2 ����             6  2
  dStp := 1 /24;  Append(@dStp); // ��� =  1 ���              7  2
  dStp1:= dStp;
  dStp := dStp1 / 2;  Append(@dStp); // ��� =  30 �����       8  3
  dStp := dStp1 / 3;  Append(@dStp); // ��� =  20 �����       9  2
  dStp := dStp1 / 4;  Append(@dStp); // ��� =  15 �����      10  3
  dStp := dStp1 / 6;  Append(@dStp); // ��� =  10 �����      11  2
  dStp := dStp1 /10;  Append(@dStp); // ��� =   6 �����      12  3
// 5 min
  dStp := dStp1 /15;  Append(@dStp); // ��� =   4 ������     13  2
  dStp := dStp1 /20;  Append(@dStp); // ��� =   3 ������     14  3
  dStp := dStp1 /30;  Append(@dStp); // ��� =   2 ������     15  2
  dStp := dStp1 /60;  Append(@dStp); // ��� =   1 ������     16  2
  dStp1:= dStp;
  dStp := dStp1 / 2;  Append(@dStp); // ��� =  30 ������     17  2
  dStp := dStp1 / 3;  Append(@dStp); // ��� =  20 ������     18  2
  dStp := dStp1 / 4;  Append(@dStp); // ��� =  15 ������     19  3
  dStp := dStp1 / 6;  Append(@dStp); // ��� =  10 ������     20  2
  dStp := dStp1 /10;  Append(@dStp); // ��� =   6 ������     21  3
//  dStp := dStp1 /12;  Append(@dStp); // ��� =   5 ������     23  2
  dStp := dStp1 /15;  Append(@dStp); // ��� =   4 �������    22  2
  dStp := dStp1 /20;  Append(@dStp); // ��� =   3 �������    23  3
  dStp := dStp1 /30;  Append(@dStp); // ��� =   2 �������    24  2
  dStp := dStp1 /60;  Append(@dStp); // ��� =   1 �������    25  2
end;

procedure TprqTimeScale1.crtScale(dMin, dMax: Double; yMin, yMax, yNetStep: Integer);
var
  j64: Int64;
begin
  fdMin := dMin; fdMax := dMax;
  fyMin := yMin; fyMax := yMax; fyNetStep := yNetStep;

// ������ ���� ����� �� �������
  dtYtoTimeStep := ((fdMax - fdMin) / (fyMax - fyMin)) * fyNetStep;
  dtNetStep1 := FindNearestMax(dtYtoTimeStep);

// ������ ����������� ������������ �������������� ��������� y => t
  dtYtoTimeStep := dtYtoTimeStep / fyNetStep;

// ������ ����������� ������������ �������������� ��������� t => y
  dtTimeToYStep := (fyMax - fyMin) / (fdMax - fdMin);

// ������ ��������� ����� ����� �� �������
  j64 := Trunc(fdMin / dtNetStep1);
  dtFirstNetTime := j64 * dtNetStep1;
  if dtFirstNetTime < fdMin then dtFirstNetTime := dtFirstNetTime + dtNetStep1;
end;

procedure TprqTimeScale1.crtScale(dMin, dMax: Double; yMin, yMax, yNetStep,
  jNumScale: Integer; var tBeg, tEnd: double);
var
  j64: Int64;
  exT: extended;
begin
  self.dtNetStep1 := self[jNumScale]^;
  self.setScaleFormat(jNumScale);
  self.fyMin := yMin;
  self.fyMax := yMax;
  self.fyNetStep := yNetStep;

  exT := self.fyMax - self.fyMin; // ���������� ������ ����
  exT := exT / self.fyNetStep; // ������� ���������� ������ � ����
  exT := self.dtNetStep1 * exT; // ������ ���� �� �������
  self.fdMin := dMin;
  self.fdMax := self.fdMin + exT; // ����������� ����� ���� ����

// ������ ����������� ������������ �������������� ��������� y => t
  self.dtYtoTimeStep := exT / (self.fyMax - self.fyMin);

// ������ ����������� ������������ �������������� ��������� t => y
  self.dtTimeToYStep := (self.fyMax - self.fyMin) / exT;

// ������ ��������� ����� ����� �� �������
//  self.dtNetStep1 := self.dtNetStep1 * 2.53;
  j64 := Trunc(self.fdMin / self.dtNetStep1);
  self.dtFirstNetTime := j64 * self.dtNetStep1;
  if self.dtFirstNetTime < self.fdMin then self.dtFirstNetTime := self.dtFirstNetTime + self.dtNetStep1;

// ������� ���������
  tBeg := self.fdMin;
  tEnd := self.fdMax;
end;

destructor TprqTimeScale1.Destroy;
begin
  inherited;
end;

function TprqTimeScale1.FindNearestMax(d1: Double): Double;
var
  jUkz, jC1: Integer;
begin
  divideYstep := 2;
  for jC1 := 1 to Count do
  begin
    sFrm := 'dd';
    result := self[jC1]^;
    if result < d1 then
    begin
      if jC1 = 1 then Exit;
      jUkz := jC1 - 1;
      case jUkz of
           5, 8, 10, 12, 14, 19, 21, 23: divideYstep := 3;
      end;

      result := self[jUkz]^;
      if (jUkz) < 8 then sFrm := 'hh'
      else
      if (jUkz) <17 then sFrm := 'hh:mm'
      else
        sFrm := 'hh:mm:ss';
      Exit;
    end;
  end;
  sFrm := 'hh:mm:ss';
  result := self[Count]^;
end;

function TprqTimeScale1.getTimefromY(jY: Integer): Double;
begin
  result := ((jY - fyMin) / dtTimeToYStep) + fdMin;
end;

function TprqTimeScale1.getYfromTime(d1: Double): Integer;
begin
  result := fyMin + Round(dtTimeToYStep * (d1 - fdMin));
end;

function TprqTimeScale1.getYNetTime(jN: Integer; var sT: string): Integer;
var
  d1: Double;
begin
  d1 := dtFirstNetTime + ((jN-1) * dtNetStep1);
  result := getYfromTime(d1);
  sT := formatDateTime(sFrm, d1);
end;

procedure TprqTimeScale1.setScaleFormat(jNumScale: Integer);
begin
  divideYstep := 2;
  sFrm := 'dd';
  if jNumScale = 1 then Exit;

  case jNumScale of
5, 8, 10, 12, 14, 19, 21, 23: divideYstep := 3;
  end;
  if jNumScale < 8 then sFrm := 'hh'
  else
  if jNumScale <17 then sFrm := 'hh:mm'
  else
    sFrm := 'hh:mm:ss';
end;

{ prqTRptGrfEtap1 }

function prqTRptGrfEtap1.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
var
  j1: Integer;
begin
// mode 1 - �������� �� Number
//      2 = �������� dataBeg:  Double;
  case mode of
  1: begin
       j1 := sign(rcdTRptGrfEtap1(ukz1^).Number - rcdTRptGrfEtap1(ukz2^).Number);
     end;
  2: begin                                     
       j1 := sign(rcdTRptGrfEtap1(ukz1^).dataBeg - rcdTRptGrfEtap1(ukz2^).dataBeg);
     end;

  else begin result := 0; Exit; end;
  end;
  result := j1 + 2;
end;

procedure prqTRptGrfEtap1.CloneClass(Source: prqTRptGrfEtap1);
begin
  if not Assigned(Source) then Exit;

  self.Count := 0;
  self.AppendClass(Source);
end;

constructor prqTRptGrfEtap1.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTRptGrfEtap1);
end;

destructor prqTRptGrfEtap1.Destroy;
begin
  inherited;
end;

function prqTRptGrfEtap1.findEtapLine(dT: Double): Integer;
var
  jC1: Integer;
begin
  result := 0;
  for jC1 := 1 to self.Count do
  begin
    if self[jC1].dataBeg > dT then continue;
    if self[jC1].dataEnd < dT then continue;
    result := jC1;
    Exit;
  end;

  for jC1 := 2 to self.Count do
  begin
    if self[jC1-1].dataEnd >= dT then continue;
    if self[jC1].dataBeg   <= dT then continue;
    result := -jC1;
    Exit;
  end;
end;

function prqTRptGrfEtap1.GetPntDyn(j: Integer): PrcdTRptGrfEtap1;
begin
  result := self.GetPnt(j);
end;

{ TprqRptTX }

procedure TprqRptTX.CloneClass(Source: TprqRptTX);
begin
  if not Assigned(Source) then Exit;

  self.yTime.Count := 0; self.yTime.AppendClass(Source.yTime);
  self.xVal.Count := 0;  self.xVal.AppendClass(Source.xVal);
end;

constructor TprqRptTX.Create;
begin
  yTime := prqTDouble.Create;
  xVal  := prqTDouble.Create;
end;

destructor TprqRptTX.Destroy;
begin
  yTime.Free;
  xVal.Free;
  inherited;
end;

{ TprqRptGrafList4 }

procedure TprqRptGrafList4.imageListU1(jNumGrf: Integer; map: TBitMap;
  OtherParams: prqTobject);
var
  pw: TprqRptGrafWindow;
begin
// ��������� ��������� �������
// ����� ��������
  Height      := map.Height;
  Width       := map.Width;

  try
// ������ ����� ������
    setDefFont3(map);
    PrintRamka3;

// ��������� ���� ����
    pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
    pw.wnd_all.Left   := LogOtsLeft + pc005_505_App_Shift1;
    pw.wnd_all.Top    := LogHeadLineHeight;                    // ����������� � �����
    pw.wnd_all.Right  := LogWidth - LogOtsRight - pc005_505_App_Shift1;
    pw.wnd_all.Bottom := LogHeight - LogOtsBottom - pc005_505_App_Shift1;

    pw.wnd_Nadpisi    := pw.wnd_all;
    pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
    pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
    LogHeadLineHeight := pw.wnd_Nadpisi.Top;

    pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
    pw.wnd_Scale.Right    := pw.wnd_Scale.Left + pc005_505_App_Shift5;
    pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;

    pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
    pw.wnd_Graf.Right     := pw.wnd_all.Right;
    pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;

// ������� ������� ��������!
    pw.signGrafList3(self);
    pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;
    pw.wnd_Graf.Top       := pw.wnd_Scale.Top;

// ������ ����� �������, ����� ���������
    pw.PrintScale(self);
    pw.PrintNetXY(self);

// ������ ��������
    setDefFont(map);
    imageListU1printGraf(pw, map, OtherParams);

  except
  end;
end;

procedure TprqRptGrafList4.imageListU1printGraf(pw: TprqRptGrafWindow;
  map: TBitMap; OtherParams: prqTobject);
var
  pg:  TprqRptGraf1;
  pCh: TprqRptTX;
  jC1: Integer;
begin
  for jC1 := 1 to pw.Grafiks.Count do
  begin
    pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
    if pg.bActive then
    begin
      if pg.nChanal > 0 then
      begin
        pCh := FindOtherParams(pg.nChanal, OtherParams);
        if Assigned(pCh) then
        begin
          if TprqRptGrafWindow.check(pCh.xVal, pCh.yTime) then
          begin
            pw.risGrafTOutU1(self, pg, pCh.xVal, pCh.yTime, self.dtJobBeg, self.dtJobEnd);
          end;
        end;
      end;
    end;
  end; // End of circle for graf
end;

class function TprqRptGrafList4.FindOtherParams(num: Integer; OtherParams: prqTobject): TprqRptTX;
var
  rcd: rcdTcontainer;
  j1: Integer;
begin
  rcd.key := num;
  j1      := OtherParams.Find(@rcd, 1);
  if j1 > 0 then
    result := OtherParams[j1].ukz as TprqRptTX
  else
    result := nil;
end;

procedure TprqRptGrafList4.imageListU2(jNumGrf: Integer; map: TBitMap;
  OtherParams: prqTobject);
var
  jWidth, jC1, jWnd, jCrntWnd: integer;
  pw: TprqRptGrafWindow;
//  pwX: array[1..5] of TprqRptGrafWindow;
  pg:  TprqRptGraf1;
  pCh: TprqRptTX;
begin
  jWnd := 0;
  pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
  for jC1 := 1 to pw.Grafiks.Count do
  begin
    pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
    if pg.bActive then Inc(jWnd);
  end;

  if jWnd = 0 then Exit;


// ��������� ��������� �������
// ����� ��������
  Height      := map.Height;
  Width       := map.Width;

  try
// ������ ����� ������
    setDefFont3(map);
    PrintRamka3;

// ��������� ���� ����
    pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;

    jWidth := ((LogWidth - LogOtsLeft - LogOtsRight - pc005_505_App_Shift5 - pc005_505_App_Shift6) div jWnd);
    jCrntWnd := 0;
    for jC1 := 1 to pw.Grafiks.Count do
    begin
      pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
      if pg.bActive then
      begin
        Inc(jCrntWnd);
        if jCrntWnd = 1 then
        begin
          pw.wnd_all.Left   := LogOtsLeft + pc005_505_App_Shift1;
          pw.wnd_all.Top    := LogHeadLineHeight;                    // ����������� � �����
          pw.wnd_all.Right  := LogOtsLeft + pc005_505_App_Shift5 + jWidth;
          pw.wnd_all.Bottom := LogHeight - LogOtsBottom - pc005_505_App_Shift1;

          pw.wnd_Nadpisi    := pw.wnd_all;
          pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
          pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
          LogHeadLineHeight := pw.wnd_Nadpisi.Top;
          pw.wnd_Nadpisi.Bottom := pw.getHeightsignGrafList3(self, jC1);

          pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;
          pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
          pw.wnd_Scale.Right    := pw.wnd_Scale.Left + pc005_505_App_Shift5;
          pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;
          pw.PrintScale(self);

          pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
          pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
          pw.wnd_Graf.Right     := pw.wnd_all.Right;
          pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;
          pw.PrintNetXY(self);
        end
        else
        begin
          pw.wnd_all.Left := pw.wnd_all.Right;
          pw.wnd_all.Right := pw.wnd_all.Right + jWidth;

          pw.wnd_Nadpisi := pw.wnd_all;
          pw.wnd_Nadpisi.Left := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
          pw.wnd_Nadpisi.Top := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
          LogHeadLineHeight := pw.wnd_Nadpisi.Top;
          pw.wnd_Nadpisi.Bottom := pw.getHeightsignGrafList3(self, jC1);

          pw.wnd_Graf.Left := pw.wnd_Nadpisi.Left;
          pw.wnd_Graf.Right := pw.wnd_all.Right;
          pw.PrintNetXY(self);
        end;

// ������� ������� ��������!
        setDefFont3(map);
        pw.signGrafList3(self, jC1);

// ������ ��������
        setDefFont3(map);
        pCh := FindOtherParams(pg.nChanal, OtherParams);
        if Assigned(pCh) then
        begin
          if TprqRptGrafWindow.check(pCh.xVal, pCh.yTime) then
          begin
            pw.risGrafTOutU1(self, pg, pCh.xVal, pCh.yTime, self.dtJobBeg, self.dtJobEnd);
          end;
        end;

//        if jCrntWnd = 1 then break;
      end;
    end;

  except
  end;
end;

procedure TprqRptGrafList4.imageListU2(jNumGrf: integer; map: TBitMap;
  OtherParams: prqTobject; jNumScale: integer; sCl: double; dtBeg,dtEnd: double;
  var tBeg, tEnd: double; txtScale: double; n1, n2: integer);
var
  jCrntStep, jWidth, jC1, jWnd, jCrntWnd: integer;
  pw: TprqRptGrafWindow;
  pg:  TprqRptGraf1;
  pCh: TprqRptTX;
begin
  jWnd := 0;
  pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
  for jC1 := 1 to pw.Grafiks.Count do
  begin
    pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
    if pg.bActive then Inc(jWnd);
  end;

  if jWnd = 0 then Exit;


// ��������� ��������� �������
// ����� ��������
  Height      := map.Height;
  Width       := map.Width;

  try
// ������ ����� ������
    setDefFont3(map);
    PrintRamka3(sCl, txtScale, n1, n2);

// ��������� ���� ����
    pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
    jCrntStep := pw.netYStep;
    pw.netYStep := Trunc(jCrntStep * sCl);
    try

      jWidth := ((LogWidth - LogOtsLeft - LogOtsRight - pc005_505_App_Shift5 - pc005_505_App_Shift6) div jWnd);
      jCrntWnd := 0;
      for jC1 := 1 to pw.Grafiks.Count do
      begin
        pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
        if pg.bActive then
        begin
          Inc(jCrntWnd);
          if jCrntWnd = 1 then
          begin
            pw.wnd_all.Left   := LogOtsLeft + pc005_505_App_Shift1;
            pw.wnd_all.Top    := LogHeadLineHeight;                    // ����������� � �����
            pw.wnd_all.Right  := LogOtsLeft + pc005_505_App_Shift5 + jWidth;
            pw.wnd_all.Bottom := LogHeight - LogOtsBottom - pc005_505_App_Shift1;

            pw.wnd_Nadpisi    := pw.wnd_all;
            pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
            pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
            LogHeadLineHeight := pw.wnd_Nadpisi.Top;
            pw.wnd_Nadpisi.Bottom := pw.getHeightsignGrafList3(self, jC1, txtScale);

            pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;
            pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
            pw.wnd_Scale.Right    := pw.wnd_Scale.Left + pc005_505_App_Shift5;
            pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;

  // ��������� ��������� ���������������
            pw.PrintScale(self, jNumScale, dtBeg, dtEnd, tBeg, tEnd, txtScale);

            pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
            pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
            pw.wnd_Graf.Right     := pw.wnd_all.Right;
            pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;
          end
          else
          begin
            pw.wnd_all.Left := pw.wnd_all.Right;
            pw.wnd_all.Right := pw.wnd_all.Right + jWidth;

            pw.wnd_Nadpisi := pw.wnd_all;
            pw.wnd_Nadpisi.Left := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
            pw.wnd_Nadpisi.Top := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
            LogHeadLineHeight := pw.wnd_Nadpisi.Top;
            pw.wnd_Nadpisi.Bottom := pw.getHeightsignGrafList3(self, jC1, txtScale);

            pw.wnd_Graf.Left := pw.wnd_Nadpisi.Left;
            pw.wnd_Graf.Right := pw.wnd_all.Right;
          end;

  // �������� ����� � ������ ���������
          pw.PrintNetXY(self);

  // ������� ������� ��������!
          setDefFont3(map);
          pw.signGrafList3(self, jC1, txtScale);

  // ������ ��������
          setDefFont3(map);
          pCh := FindOtherParams(pg.nChanal, OtherParams);
          if Assigned(pCh) then
          begin
            if TprqRptGrafWindow.check(pCh.xVal, pCh.yTime) then
            begin
              pw.risGrafTOutU1(self, pg, pCh.xVal, pCh.yTime, tBeg, tEnd);
            end;
          end;

  //        if jCrntWnd = 1 then break;
        end;
      end;

    finally
      pw.netYStep := jCrntStep;
    end;

  except
  end;
end;

procedure TprqRptGrafList4.printListU2(jNumGrf: Integer; canva: TCanvas;
  OtherParams: prqTobject; jNumScale: integer; sCl, dtBeg, dtEnd: double;
  var tBeg, tEnd: double; txtScale: double; n1, n2: integer;
  valWidth, valHeight: integer);
var
  jCrntStep, jWidth, jC1, jWnd, jCrntWnd: integer;
  pw: TprqRptGrafWindow;
  pg:  TprqRptGraf1;
  pCh: TprqRptTX;
begin
  jWnd := 0;
  pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
  for jC1 := 1 to pw.Grafiks.Count do
  begin
    pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
    if pg.bActive then Inc(jWnd);
  end;

  if jWnd = 0 then Exit;


// ��������� ��������� �������
// ����� ��������
  Height      := valHeight;
  Width       := valWidth;

//  self.LogHeight :=

  try
// ������ ����� ������
    setDefFont3(canva);
    PrintRamka3(sCl, txtScale, n1, n2);

// ��������� ���� ����
    pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
    jCrntStep := pw.netYStep;
    pw.netYStep := Trunc(jCrntStep * sCl);
    try

      jWidth := ((LogWidth - LogOtsLeft - LogOtsRight - pc005_505_App_Shift5 - pc005_505_App_Shift6) div jWnd);
      jCrntWnd := 0;
      for jC1 := 1 to pw.Grafiks.Count do
      begin
        pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
        if pg.bActive then
        begin
          Inc(jCrntWnd);
          if jCrntWnd = 1 then
          begin
            pw.wnd_all.Left   := LogOtsLeft + pc005_505_App_Shift1;
            pw.wnd_all.Top    := LogHeadLineHeight;                    // ����������� � �����
            pw.wnd_all.Right  := LogOtsLeft + pc005_505_App_Shift5 + jWidth;
            pw.wnd_all.Bottom := LogHeight - LogOtsBottom - pc005_505_App_Shift1;

            pw.wnd_Nadpisi    := pw.wnd_all;
            pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
            pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
            LogHeadLineHeight := pw.wnd_Nadpisi.Top;
            pw.wnd_Nadpisi.Bottom := pw.getHeightsignGrafList3(self, jC1, txtScale);

            pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;
            pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
            pw.wnd_Scale.Right    := pw.wnd_Scale.Left + pc005_505_App_Shift5;
            pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;

  // ��������� ��������� ���������������
            pw.PrintScale(self, jNumScale, dtBeg, dtEnd, tBeg, tEnd, txtScale);

            pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
            pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
            pw.wnd_Graf.Right     := pw.wnd_all.Right;
            pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;
          end
          else
          begin
            pw.wnd_all.Left := pw.wnd_all.Right;
            pw.wnd_all.Right := pw.wnd_all.Right + jWidth;

            pw.wnd_Nadpisi := pw.wnd_all;
            pw.wnd_Nadpisi.Left := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
            pw.wnd_Nadpisi.Top := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
            LogHeadLineHeight := pw.wnd_Nadpisi.Top;
            pw.wnd_Nadpisi.Bottom := pw.getHeightsignGrafList3(self, jC1, txtScale);

            pw.wnd_Graf.Left := pw.wnd_Nadpisi.Left;
            pw.wnd_Graf.Right := pw.wnd_all.Right;
          end;

  // �������� ����� � ������ ���������
            pw.PrintNetXY(self);

  // ������� ������� ��������!
          setDefFont3(canva);
          pw.signGrafList3(self, jC1, txtScale);

  // ������ ��������
          setDefFont3(canva);
          pCh := FindOtherParams(pg.nChanal, OtherParams);
          if Assigned(pCh) then
          begin
            if TprqRptGrafWindow.check(pCh.xVal, pCh.yTime) then
            begin
              pw.risGrafTOutU1(self, pg, pCh.xVal, pCh.yTime, tBeg, tEnd);
            end;
          end;

  //        if jCrntWnd = 1 then break;
        end;
      end;

    finally
      pw.netYStep := jCrntStep;
    end;

  except
  end;
end;

function TprqRptGrafList4.getTimeRegion(jNumGrf: Integer; canva: TCanvas;
  jNumScale: integer; sCl: double; dtBeg, dtEnd: double; var tBeg, tEnd: double;
  txtScale: double; valWidth, valHeight: integer): boolean;
var
  jCrntStep, jWidth, jC1, jWnd: integer;
  pw: TprqRptGrafWindow;
  pg:  TprqRptGraf1;
begin
  result := false;
  jWnd := 0;
  pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
  for jC1 := 1 to pw.Grafiks.Count do
  begin
    pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
    if pg.bActive then Inc(jWnd);
  end;

  if jWnd = 0 then Exit;

  result := true;

// ��������� ��������� �������
// ����� ��������
  Height      := valHeight;
  Width       := valWidth;

  try
// ������ ����� ������
    setDefFont3(canva);
    PrintRamka3(sCl, txtScale, 1, 1);

// ��������� ���� ����
    pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
    jCrntStep := pw.netYStep;
    pw.netYStep := Trunc(jCrntStep * sCl);
    try

      jWidth := ((LogWidth - LogOtsLeft - LogOtsRight - pc005_505_App_Shift5 - pc005_505_App_Shift6) div jWnd);
      for jC1 := 1 to pw.Grafiks.Count do
      begin
        pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
        if pg.bActive then
        begin
          pw.wnd_all.Left   := LogOtsLeft + pc005_505_App_Shift1;
          pw.wnd_all.Top    := LogHeadLineHeight;                    // ����������� � �����
          pw.wnd_all.Right  := LogOtsLeft + pc005_505_App_Shift5 + jWidth;
          pw.wnd_all.Bottom := LogHeight - LogOtsBottom - pc005_505_App_Shift1;

          pw.wnd_Nadpisi    := pw.wnd_all;
          pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
          pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
          LogHeadLineHeight := pw.wnd_Nadpisi.Top;
          pw.wnd_Nadpisi.Bottom := pw.getHeightsignGrafList3(self, jC1, txtScale);

          pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;
          pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
          pw.wnd_Scale.Right    := pw.wnd_Scale.Left + pc005_505_App_Shift5;
          pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;

  // ��������� ��������� ���������������
          pw.PrintScale(self, jNumScale, dtBeg, dtEnd, tBeg, tEnd, txtScale);
          Exit;
        end;
      end;

    finally
      pw.netYStep := jCrntStep;
    end;

  except
  end;
end;

function TprqRptGrafList4.getTimeRegionM(canva: TCanvas;
  jNumScale, PixPerInch: integer; dtBeg, dtEnd: double; var tBeg, tEnd: double;
  valWidth, valHeight: integer): boolean;
var
  jBottom, jC2, jWidth, jC1, jWnd: integer;
  pw: TprqRptGrafWindow;
  pg:  TprqRptGraf1;
begin
  result := false;
  jWnd := 0;
  pw := nil;

  for jC1 := 1 to self.GrafWindows.Count do
  begin
    if self.isDrawWnd(jC1) then
    begin
      pw := GrafWindows[jC1].ukz as TprqRptGrafWindow;
      for jC2 := 1 to pw.Grafiks.Count do
      begin
        pg := pw.Grafiks[jC2].ukz as TprqRptGraf1;
        if pg.bActive then Inc(jWnd);
      end;
      if jWnd > 0 then
      begin
        break;
      end;
    end;
  end;

  if jWnd = 0 then Exit;

// ��������� ��������� �������
// ����� ��������
  Height      := valHeight;
  Width       := valWidth;
  jBottom := 0;

  try
// ������ ����� ������
    setDefFont3(canva);
    self.HeadFSize := self.getSizeFont(self.Canvas, PixPerInch, self.sizeHead);
    self.ScalFSize := self.getSizeFont(self.Canvas, PixPerInch, self.sizeScale);
    self.TimeFSize := self.getSizeFont(self.Canvas, PixPerInch, self.sizeTimes);
    self.PrintRamkaU(1, 1);

// ��������� ���� ����
//    pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
    try

      jWidth := ((LogWidth - LogOtsLeft - LogOtsRight - pc005_505_App_Shift5 - pc005_505_App_Shift6) div jWnd);
      for jC1 := 1 to pw.Grafiks.Count do
      begin
        pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
        if pg.bActive then
        begin
          pw.wnd_all.Left   := LogOtsLeft + pc005_505_App_Shift1;
          pw.wnd_all.Top    := LogHeadLineHeight;                    // ����������� � �����
          pw.wnd_all.Right  := LogOtsLeft + pc005_505_App_Shift5 + jWidth;
          pw.wnd_all.Bottom := LogHeight - LogOtsBottom - pc005_505_App_Shift1;

          pw.wnd_Nadpisi    := pw.wnd_all;
          pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
          pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
          LogHeadLineHeight := pw.wnd_Nadpisi.Top;
          setDefFont3(canva);
          jBottom := self.getHeightsignGrafListM;

          pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
          pw.wnd_Scale.Right    := pw.wnd_Scale.Left + pc005_505_App_Shift5;
          pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;

  // ��������� ��������� ���������������
          pw.PrintScale(self, jNumScale, dtBeg, dtEnd, tBeg, tEnd);
          result := true;
        end;

        // ������� ������� ��������!
        setDefFont3(canva);
        pw.signGrafList3M(self, pw);
        pw.wnd_Nadpisi.Bottom := jBottom;

        // �������� ����� � ������ ���������
        // ��������� ��������� ���������������
        pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;
        pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
        pw.PrintScale(self, jNumScale, dtBeg, dtEnd, tBeg, tEnd);

        Exit;
      end;

    finally
    end;

  except
  end;
end;

procedure TprqRptGrafList4.imageListU2M(map: TBitMap;
  OtherParams: prqTobject; jNumScale, PixPerInch: integer; dtBeg, dtEnd: double;
  var tBeg, tEnd: double; n1, n2: integer);
var
  jBottom,
  logHL, jNumGrf, jWidth, jC1, jWnd, jCrntWnd: integer;
  pwPrev, pw: TprqRptGrafWindow;
  pg:  TprqRptGraf1;
  pCh: TprqRptTX;
//txtScale: double;
begin
  jWnd := 0; // ������� ������
  jBottom := 0;

  for jC1 := 1 to self.GrafWindows.Count do
  begin
    if self.isDrawWnd(jC1) then
    begin
      if (GrafWindows[jC1].ukz as TprqRptGrafWindow).isActiveGraph then Inc(jWnd);
    end;
  end;

  if jWnd = 0 then Exit;


// ��������� ��������� �������
// ����� ��������
  Height      := map.Height;
  Width       := map.Width;

  // ������ ������� ������� ��� ��������


  try
// ������ ����� ������
    setDefFont3(map);
    self.HeadFSize := self.getSizeFont(self.Canvas, PixPerInch, self.sizeHead);
    self.ScalFSize := self.getSizeFont(self.Canvas, PixPerInch, self.sizeScale);
    self.TimeFSize := self.getSizeFont(self.Canvas, PixPerInch, self.sizeTimes);
    PrintRamkaU(n1, n2);

    logHL := LogHeadLineHeight;

    // ���� �� ������ ��������� �������� � ������ �����
    jCrntWnd := 0;
    jWidth := ((LogWidth - LogOtsLeft - LogOtsRight - pc005_505_App_Shift5 - pc005_505_App_Shift6) div jWnd);
    pwPrev := nil;
    for jNumGrf := 1 to self.GrafWindows.Count do
    begin
      if not self.isDrawWnd(jNumGrf) then continue;
      pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
      // ��������� ������� �������� � �������� �����
      if not pw.isActiveGraph then continue;

      LogHeadLineHeight := logHL;

      // ��������� ���� ����
      try

        Inc(jCrntWnd);
        if jCrntWnd = 1 then
        begin
          pw.wnd_all.Left   := LogOtsLeft + pc005_505_App_Shift1;
          pw.wnd_all.Top    := LogHeadLineHeight;                    // ����������� � �����
          pw.wnd_all.Right  := LogOtsLeft + pc005_505_App_Shift5 + jWidth;
          pw.wnd_all.Bottom := LogHeight - LogOtsBottom - pc005_505_App_Shift1;

          pw.wnd_Nadpisi    := pw.wnd_all;
          pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
          pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
          LogHeadLineHeight := pw.wnd_Nadpisi.Top;
          setDefFont3(map);
          jBottom := self.getHeightsignGrafListM;

          pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
          pw.wnd_Scale.Right    := pw.wnd_Scale.Left + pc005_505_App_Shift5;
          pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;

          pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
          pw.wnd_Graf.Right     := pw.wnd_all.Right;
          pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;
        end
        else
        begin
          pw.wnd_all.Left := pwPrev.wnd_all.Right;
          pw.wnd_all.Top := pwPrev.wnd_all.Top;                    // ����������� � �����
          pw.wnd_all.Right := pwPrev.wnd_all.Right + jWidth;
          pw.wnd_all.Bottom := pwPrev.wnd_all.Bottom;

          pw.wnd_Nadpisi := pw.wnd_all;
          pw.wnd_Nadpisi.Left := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
          pw.wnd_Nadpisi.Top := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
          LogHeadLineHeight := pw.wnd_Nadpisi.Top;

          pw.wnd_Scale.Left     := pwPrev.wnd_Nadpisi.Left;
          pw.wnd_Scale.Right    := pwPrev.wnd_Scale.Left + pc005_505_App_Shift5;
          pw.wnd_Scale.Bottom   := pwPrev.wnd_all.Bottom;

          pw.wnd_Graf.Left := pw.wnd_Nadpisi.Left;
          pw.wnd_Graf.Right := pw.wnd_all.Right;
          pw.wnd_Graf.Bottom := pwPrev.wnd_Graf.Bottom;
        end;

        // ������� ������� ��������!
        setDefFont3(map);
        LogHeadLineHeight := pw.wnd_Nadpisi.Top;
        pw.signGrafList3M(self, pw);
        pw.wnd_Nadpisi.Bottom := jBottom;

        // �������� ����� � ������ ���������
        if jCrntWnd = 1 then
        begin
      // ��������� ��������� ���������������
          pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;
          pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
          pw.PrintScale(self, jNumScale, dtBeg, dtEnd, tBeg, tEnd);
        end
        else
        begin
      // ���������
          pw.wnd_Scale.Top      := pwPrev.wnd_Scale.Top;
          pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
          pw.dTimeScale.CloneClass(pwPrev.dTimeScale);
          pw.yNet.Clone(pwPrev.yNet);
        end;
        pw.PrintNetXY(self);

        // �������� �������
        for jC1 := 1 to pw.Grafiks.Count do
        begin
          pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
          if pg.bActive then
          begin

            // ������ ��������
            setDefFont3(map);
            pCh := FindOtherParams(pg.nChanal, OtherParams);
            if Assigned(pCh) then
            begin
              if TprqRptGrafWindow.check(pCh.xVal, pCh.yTime) then
              begin
                pw.risGrafTOutU1(self, pg, pCh.xVal, pCh.yTime, tBeg, tEnd);
              end;
            end;

          end;
        end;

      finally
        pwPrev := pw;
      end;

// =========================================================

    end;

  except
  end;
end;

function TprqRptGrafList4.getHeightsignGrafListMprint(pw: TprqRptGrafWindow): integer;
var
  jC1, jYHi, jYWi: Integer;
  pg: TprqRptGraf1;
  fs: TFont;
begin
// ��������� �������� � ��������
  fs := self.Canvas.Font;
  result := self.LogHeadLineHeight;
  try
    self.Canvas.Font.Style  := fs.Style + [fsBold];
    self.Canvas.Font.Size  := self.ScalFSize;
//    self.Canvas.Font.Size  := pg.fnSize; // gList.sz08; //pg.fnSize;

    for jC1 := 1 to pw.Grafiks.Count do
    begin
      pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
      if not pg.bActive then continue;

  // �������
      jYWi  := (self.Canvas.TextHeight(pc005_505_HeigtShab) * 8) div 11;
      jYHi  := self.PointXTOlog(jYWi) + pc005_505_App_Shift6 + pw.netWidth {pg.xLogSize};
      result := result + jYHi;

  // ��������� ������
      if pw.bSignScaleVal and (pw.cntXStep>1) then
      begin
        Inc(result, jYHi - pc005_505_App_Shift4);
      end;
    end;

  finally
    self.Canvas.Font  := fs;
  end;
end;

function TprqRptGrafList4.getHeightsignGrafListM(pw: TprqRptGrafWindow; txtScale: double): integer;
var
  jC1, jYHi, jYWi: Integer;
  pg: TprqRptGraf1;
  fs: TFont;
begin
// ������ ��������� �������� � ��������
  fs := self.Canvas.Font;
  result := self.LogHeadLineHeight;
  try
    self.Canvas.Font.Style  := fs.Style + [fsBold];

    for jC1 := 1 to pw.Grafiks.Count do
    begin
      pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
      if not pg.bActive then continue;

      self.Canvas.Font.Size  := Trunc(pg.fnSize * txtScale);
      jYWi  := self.Canvas.TextHeight(pc005_505_HeigtShab);
      jYHi  := self.PointXTOlog(jYWi) + pc005_505_App_Shift6 + pw.netWidth {pg.xLogSize};

      result := result + jYHi;
    end;

  finally
    self.Canvas.Font  := fs;
  end;
end;

function TprqRptGrafList4.getHeightsignGrafListMprint: integer;
var
  jC1, jYHi: Integer;
  pw: TprqRptGrafWindow;
begin
// ������ ��������� �������� � ��������
  result := 0;
  for jC1 := 1 to self.GrafWindows.Count do
  begin
    if self.isDrawWnd(jC1) then
    begin
      pw := GrafWindows[jC1].ukz as TprqRptGrafWindow;
      if not pw.isActiveGraph then continue;
      jYHi := self.getHeightsignGrafListMprint(pw);
      if jYHi > result then
      begin
        result := jYHi;
      end;
    end;
  end;
end;

function TprqRptGrafList4.getHeightsignGrafListM(txtScale: double): integer;
var
  jC1, jYHi: Integer;
  pw: TprqRptGrafWindow;
begin
// ������ ��������� �������� � ��������
  result := 0;
  for jC1 := 1 to self.GrafWindows.Count do
  begin
    if self.isDrawWnd(jC1) then
    begin
      pw := GrafWindows[jC1].ukz as TprqRptGrafWindow;
      if not pw.isActiveGraph then continue;
      jYHi := self.getHeightsignGrafListM(pw, txtScale);
      if jYHi > result then
      begin
        result := jYHi;
      end;
    end;
  end;
end;

procedure TprqRptGrafList4.printListU2M(canva: TCanvas;
  OtherParams: prqTobject; jNumScale, PixPerInch: integer; dtBeg, dtEnd: double;
  var tBeg, tEnd: double; n1, n2, valWidth,
  valHeight: integer);
var
  jBottom, logHL, jNumGrf, jWidth, jC1, jWnd, jCrntWnd: integer;
  pwPrev, pw: TprqRptGrafWindow;
  pg:  TprqRptGraf1;
  pCh: TprqRptTX;
begin
  jWnd := 0; // ������� ������

  for jC1 := 1 to self.GrafWindows.Count do
  begin
    if self.isDrawWnd(jC1) then
    begin
      if (GrafWindows[jC1].ukz as TprqRptGrafWindow).isActiveGraph then Inc(jWnd);
    end;
  end;

  if jWnd = 0 then Exit;


// ��������� ��������� �������
// ����� ��������
  Height      := valHeight;
  Width       := valWidth;

  try
// ������ ����� ������
    setDefFont3(canva);
    self.HeadFSize := self.getSizeFont(self.Canvas, PixPerInch, self.sizeHead);
    self.ScalFSize := self.getSizeFont(self.Canvas, PixPerInch, self.sizeScale);
    self.TimeFSize := self.getSizeFont(self.Canvas, PixPerInch, self.sizeTimes);
    PrintRamkaU(n1, n2);

    logHL := LogHeadLineHeight;
    jBottom := 0;

    // ���� �� ������ ��������� �������� � ������ �����
    jCrntWnd := 0;
    jWidth := ((LogWidth - LogOtsLeft - LogOtsRight - pc005_505_App_Shift5 - pc005_505_App_Shift6) div jWnd);
    pwPrev := nil;
    for jNumGrf := 1 to self.GrafWindows.Count do
    begin
      if not self.isDrawWnd(jNumGrf) then continue;
      pw := GrafWindows[jNumGrf].ukz as TprqRptGrafWindow;
      // ��������� ������� �������� � �������� �����
      if not pw.isActiveGraph then continue;

      LogHeadLineHeight := logHL;

      // ��������� ���� ����
      try

        Inc(jCrntWnd);
        if jCrntWnd = 1 then
        begin
          pw.wnd_all.Left   := LogOtsLeft + pc005_505_App_Shift1;
          pw.wnd_all.Top    := LogHeadLineHeight;                    // ����������� � �����
          pw.wnd_all.Right  := LogOtsLeft + pc005_505_App_Shift5 + jWidth;
          pw.wnd_all.Bottom := LogHeight - LogOtsBottom - pc005_505_App_Shift1;

          pw.wnd_Nadpisi    := pw.wnd_all;
          pw.wnd_Nadpisi.Left   := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
          pw.wnd_Nadpisi.Top    := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
          LogHeadLineHeight := pw.wnd_Nadpisi.Top;
          setDefFont3(canva);
          jBottom := self.getHeightsignGrafListM;

          pw.wnd_Scale.Left     := pw.wnd_Nadpisi.Left;
          pw.wnd_Scale.Right    := pw.wnd_Scale.Left + pc005_505_App_Shift5;
          pw.wnd_Scale.Bottom   := pw.wnd_all.Bottom;

          pw.wnd_Graf.Left      := pw.wnd_Scale.Right;
          pw.wnd_Graf.Right     := pw.wnd_all.Right;
          pw.wnd_Graf.Bottom    := pw.wnd_all.Bottom;
        end
        else
        begin
          pw.wnd_all.Left := pwPrev.wnd_all.Right;
          pw.wnd_all.Top := pwPrev.wnd_all.Top;                    // ����������� � �����
          pw.wnd_all.Right := pwPrev.wnd_all.Right + jWidth;
          pw.wnd_all.Bottom := pwPrev.wnd_all.Bottom;

          pw.wnd_Nadpisi := pw.wnd_all;
          pw.wnd_Nadpisi.Left := pw.wnd_Nadpisi.Left + pc005_505_App_Shift2;
          pw.wnd_Nadpisi.Top := pw.wnd_Nadpisi.Top + pc005_505_App_Shift2;
          LogHeadLineHeight := pw.wnd_Nadpisi.Top;

          pw.wnd_Scale.Left     := pwPrev.wnd_Nadpisi.Left;
          pw.wnd_Scale.Right    := pwPrev.wnd_Scale.Left + pc005_505_App_Shift5;
          pw.wnd_Scale.Bottom   := pwPrev.wnd_all.Bottom;

          pw.wnd_Graf.Left := pw.wnd_Nadpisi.Left;
          pw.wnd_Graf.Right := pw.wnd_all.Right;
          pw.wnd_Graf.Bottom := pwPrev.wnd_Graf.Bottom;
        end;

        // ������� ������� ��������!
        setDefFont3(canva);
        LogHeadLineHeight := pw.wnd_Nadpisi.Top;
        pw.signGrafList3M(self, pw);
        pw.wnd_Nadpisi.Bottom := jBottom;

        // �������� ����� � ������ ���������
        if jCrntWnd = 1 then
        begin
      // ��������� ��������� ���������������
          pw.wnd_Scale.Top      := pw.wnd_Nadpisi.Bottom + 13;
          pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
          pw.PrintScale(self, jNumScale, dtBeg, dtEnd, tBeg, tEnd);
        end
        else
        begin
      // ���������
          pw.wnd_Scale.Top      := pwPrev.wnd_Scale.Top;
          pw.wnd_Graf.Top       := pw.wnd_Scale.Top;
          pw.dTimeScale.CloneClass(pwPrev.dTimeScale);
          pw.yNet.Clone(pwPrev.yNet);
        end;
        pw.PrintNetXY(self);

        // �������� �������
        for jC1 := 1 to pw.Grafiks.Count do
        begin
          pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
          if pg.bActive then
          begin

            // ������ ��������
            setDefFont3(canva);
            pCh := FindOtherParams(pg.nChanal, OtherParams);
            if Assigned(pCh) then
            begin
              if TprqRptGrafWindow.check(pCh.xVal, pCh.yTime) then
              begin
                pw.risGrafTOutU1(self, pg, pCh.xVal, pCh.yTime, tBeg, tEnd);
              end;
            end;

          end;
        end;

      finally
        pwPrev := pw;
      end;

// =========================================================

    end;

  except
  end;
end;

constructor TprqRptGrafList4.Create;
var
  jC1: integer; d: double;
begin
  inherited;
  FdScales := prqTdouble.Create;
  FjScales := prqTinteger.Create;
  FjScales.Count := 4;
  FjScales[1]^ := 150;
  FjScales[2]^ := 300;
  FjScales[3]^ := 600;
  FjScales[4]^ := 1200;
  for jC1 := 1 to FjScales.Count do
  begin
    d := FjScales[jC1]^ / pc005_505_LogInch;
    FdScales.Append(@d);
  end;
end;

destructor TprqRptGrafList4.Destroy;
begin
  FdScales.Free;
  FjScales.Free;
  inherited;
end;

function TprqRptGrafList4.getSizeFont(fCanvas: TCanvas;
PixPerInch, heightStr: integer): integer;
var
  s1: string;
  j2: integer;
begin
  // ������ ������� ������
  s1 := pc005_505_HeigtShab;
  result := 1;
//  heightStr := self.logToPointY(heightStr);
  heightStr := (heightStr * PixPerInch) div pc005_505_LogInch;
  repeat
    Inc(result);
    fCanvas.Font.Size := result;
    j2 := fCanvas.TextHeight(s1);
  until (j2 >= heightStr) or (result > 1023);
  if j2 > heightStr then
  begin
    Dec(result);
  end;
end;

procedure TprqRptGrafList4.PrintRamkaU(n1, n2: integer);
var
  rLine, r: TRect;
  s1: String;
begin
// ����� ������
  r.Left   := LogOtsLeft;
  r.Top    := LogOtsTop;
  r.Right  := LogWidth - LogOtsRight;
  r.Bottom := LogHeight - LogOtsBottom;
  Canvas.Pen.Color := ramColor;
  LogContur(r, ramWidth);

// �������� ���������
// ������ ������ �������
  s1 := WorkData + ': ' + Mestorogd + ' \ ' + Kust + ' \ ' + Skvagina + ' \ ' + Rabota;
  rLine := r;
  PrintHeadLineU(rLine, s1);

// ������ ������ �������
  s1 := pc005_505_SHB_NamPar_8 + MainPersons;
  rLine.Top := rLine.Bottom;
  PrintHeadLineU(rLine, s1);

  LogHeadLineHeight := rLine.Bottom;
  PrintBottomLineU(n1, n2);
end;

procedure TprqRptGrafList4.PrintHeadLineU(var r: TRect;
  const sHeadLine: String);
var
  rTxt, rLine: TRect;
  jY, jX, jWi:   Integer;
  fs: TFont;
begin
// ��������� �������� ������
  rLine.Left  := r.Left  + pc005_505_App_Shift3;
  rLine.Top   := r.Top   + pc005_505_App_Shift3;
  rLine.Right := r.Right - pc005_505_App_Shift3;

  fs := Canvas.Font;
  try
    Canvas.Font.Name := pc005_505_Serif; //pc005_505_Arial;
    Canvas.Font.Size := self.HeadFSize;
                 jWi := Canvas.TextHeight(sHeadLine);
        rLine.Bottom := rLine.Top + PointXTOlog(jWi) + pc005_505_App_Shift3a;
            r.Bottom := rLine.Bottom;

                  jX := logToPointX(rLine.Left);
                  jY := logToPointY(rLine.Top);
                rTxt := logToPointXY(rLine);
    Canvas.TextRect(rTxt, jX, jY, sHeadLine);

    logMoveTo(r.Left, r.Bottom);
    logLineTo(r.Right, r.Bottom, ramWidth);
  finally
    Canvas.Font  := fs;
  end;
end;

procedure TprqRptGrafList4.PrintBottomLineU(n1, n2: integer);
var
  jY, jX, jWi:   Integer;
  fs: TFont;
  s1: String;
begin
  fs := Canvas.Font;
  if n1 < 1 then
  begin
    Exit;
  end;

  try
    Canvas.Font.Name   := pc005_505_Serif; //pc005_505_Arial;
    Canvas.Font.Size  := Round(self.HeadFSize * 0.75);

// ����� ��������
    s1 := IntToStr(n1) + ' / ' + IntToStr(n2);
    jWi := Canvas.TextWidth(s1);
    jX := (logToPointX(LogWidth) - jWi) div 2;
    jY := logToPointY(LogHeight - LogOtsBottom + 12);
    Canvas.TextOut(jX, jY, s1);

  finally
    Canvas.Font  := fs;
  end;
end;

function TprqRptGrafList4.getPrinterResolution(fCanvas: TCanvas; PgHeight,
  lsHeight: integer): integer;
var
  delta, deltaC, ds: double;
  jSc, jC1: integer;
begin
  ds := pgHeight;
  ds := ds / lsHeight;

  jSc := self.FdScales.Count;
  delta := self.FdScales[jSc]^;
  result := self.FjScales[jSc]^;
  for jC1 := 1 to self.FdScales.Count do
  begin
    deltaC := abs(self.FdScales[jC1]^ - ds);
    if deltaC < delta then
    begin
      delta := deltaC;
      jSc := jC1;
      result := self.FjScales[jSc]^;
    end;
  end;
end;

function TprqRptGrafList4.getHeightsignGrafListM: integer;
var
  jC1, jYHi: Integer;
  pw: TprqRptGrafWindow;
begin
// ������ ��������� �������� � ��������
  result := 0;
  for jC1 := 1 to self.GrafWindows.Count do
  begin
    if self.isDrawWnd(jC1) then
    begin
      pw := GrafWindows[jC1].ukz as TprqRptGrafWindow;
      if not pw.isActiveGraph then continue;
      jYHi := self.getHeightsignGrafListM(pw);
      if jYHi > result then
      begin
        result := jYHi;
      end;
    end;
  end;
end;

function TprqRptGrafList4.getHeightsignGrafListM(
  pw: TprqRptGrafWindow): integer;
var
  jC1, jYHi, jYWi: Integer;
  pg: TprqRptGraf1;
  fs: TFont;
begin
// ������ ��������� �������� � ��������
  fs := self.Canvas.Font;
  result := self.LogHeadLineHeight;
  try
    self.Canvas.Font.Style  := fs.Style + [fsBold];
    self.Canvas.Font.Size  := self.ScalFSize;

    for jC1 := 1 to pw.Grafiks.Count do
    begin
      pg := pw.Grafiks[jC1].ukz as TprqRptGraf1;
      if not pg.bActive then continue;

  // �������
      jYWi  := self.Canvas.TextHeight(pc005_505_HeigtShab);
      jYHi  := self.PointXTOlog(jYWi) + pc005_505_App_Shift6 + pw.netWidth {pg.xLogSize};
      result := result + jYHi;

  // ��������� ������
      if pw.bSignScaleVal and (pw.cntXStep>1) then
      begin
        Inc(result, jYHi - pc005_505_App_Shift4);
      end;
    end;

  finally
    self.Canvas.Font  := fs;
  end;
end;

end.
