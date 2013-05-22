unit uRaportKst1data;

interface
uses
  Classes, SysUtils, Math, Dialogs, uMainData, uAbstrArray, uOreolProtocol,
  uVisualCement1data, NPSourses, DateUtils, Graphics,
  ScktComp, Grids;

type
  TFunNumber = (nfParametr, nfMedium, nfMulty);

const
  pc003_05_FunMedNam   = '&среднее';
  pc003_05_FunMltNam   = '&умножение';

  pc003_05_Kmls = 0.011574074074074074074074074074074;

  pc003_05_extBBA  = '.BBA';
  pc003_05_extSPD  = '.SPD';
  pc003_05_extXLS  = '.XLS';

type

  rcdTinteger2 = packed record
    key,      // ключ
    val       // значение
      :Integer;
  end;
  PrcdTinteger2 = ^rcdTinteger2;
  prqTinteger2 = class(prqTAbstract1)
  private
    function    GetPntDyn(j: Integer): PrcdTinteger2;
  public
    property    pntDyn[j:Integer]: PrcdTinteger2 read GetPntDyn; default;

    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
//      1 - сравнить по key
//      2 - сравнить по val
//      3 - сравнить по key + val

    constructor Create;
    destructor  Destroy; override;
  end;

// Описание заголовка отчета
  TORPReportTop1 = class
  public
    jVersion:      Integer; // Версия метафайла
    modeSrcMestor: Integer; // Источник описания месторождения (создание отчета)
    modeSrcMestorB:Boolean; // Источник описания месторождения (создание отчета)
    modeXLSStage:  Boolean; // Источник описания этапов (создание отчета)
    modeKRSStage:  Boolean; // Источник описания этапов (создание отчета)
    modeKRSTimes:  Boolean; // Источник описания этапов (создание отчета)

    dtJobBeg: TDateTime;
    dtJobEnd: TDateTime;
    dtJobDur: TDateTime;

    NameRptFile: string; // Имя файла - Заголовка Отчета
    NameShbFile: string; // Имя файла - xls Шаблона отчета
    NameParFile: string; // Имя файла - xls Параметры (Шаблона) отчета
    sTabStages:  string; // Имя файла - Таб состояний
    NameXLSFile: string; // Имя файла - xls отчета
    NameSpdFile: string; // Имя файла с описаниями этапов

    sMestoRozhd:  string;  // Месторождение
    sKust:        string;  // куст
    sSkvazhina:   string;  // Скважина
    sZadanie:     string;  // Задание
    sVidRabot:    string;  // Вид Работ

    sZakazchik:   string;  // Заказчик/Подрядчик
    sPodrdchik:   string;  // Заказчик/Подрядчик

    constructor Create;
    destructor  Destroy; override;
  end;




// Описание структур, Используется при чтении данных из БД в отчет RPT2
// ====================================================================

// Параметр
  rcdTparDBrpt2 = packed record
// Параметры графика
    chanNumber:    Integer;    // Номер Канала
    chanBuiltName: string[63]; // Встроенное имя Канала

// Параметры БД
    dbChanNumber:  Integer;    // Номер Канала БД
    dbChanName:    string[63]; // Имя канала БД

// Параметры Преобразования
// Сигнал = shftChanal + multChanal * modeAverag(Данные из БД)
    bActive:       Boolean;    // Параметр активен (заполняется данными из БД)
    modeAverag:    Integer;    // Номер метода усреднения 0...
    shftChanal:    Double;     // Сдвиг значения
    multChanal:    Double;     // множитель значения
  end;
  PrcdTparDBrpt2 = ^rcdTparDBrpt2;
  prqTparDBrpt2 = class(prqTAbstract1)
  private
    function    GetPntDyn(j: Integer): PrcdTparDBrpt2;
  public
    property    pntDyn[j:Integer]: PrcdTparDBrpt2 read GetPntDyn; default;

    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
//      1 - сравнить по chanNumber

    constructor Create;
    destructor  Destroy; override;
  end;

// Массив упакованных данных (из источника)
  rcdTparDataRpt2 = packed record
    WTime:  string[5];
    FlowIn: word;
    PresIn: word;
    DensIn: word;
    TempIn: smallint;
  end;
  PrcdTparDataRpt2 = ^rcdTparDataRpt2;
  prqTparDataRpt2 = class(prqTAbstract1)
  private
    function    GetPntDyn(j: Integer): PrcdTparDataRpt2;
  public
    property    pntDyn[j:Integer]: PrcdTparDataRpt2 read GetPntDyn; default;

    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;

    constructor Create;
    destructor  Destroy; override;
  end;

// Массив исходных данных из источника
  rcdTparDataDBRpt2 = packed record
    WTime:  Double;
    numChn: Array[1..4] of Integer;
    valChn: Array[1..4] of Single;
  end;
  PrcdTparDataDBRpt2 = ^rcdTparDataDBRpt2;
  prqTparDataDBRpt2 = class(prqTAbstract1)
  private
    function    GetPntDyn(j: Integer): PrcdTparDataDBRpt2;
  public
    property    pntDyn[j:Integer]: PrcdTparDataDBRpt2 read GetPntDyn; default;

    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
// mode 1 = сравнить WTime:  Double;

    constructor Create;
    destructor  Destroy; override;
  end;

  rcdTparDataDBRpt3 = packed record
    WTime:  Double;
    numChn: Array[1..4] of Integer;
    valChn: Array[1..4] of Single;
  end;
  PrcdTparDataDBRpt3 = ^rcdTparDataDBRpt3;
  prqTparDataDBRpt3 = class(prqTAbstract1)
  private
    function    GetPntDyn(j: Integer): PrcdTparDataDBRpt3;
  public
    property    pntDyn[j:Integer]: PrcdTparDataDBRpt3 read GetPntDyn; default;

    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
// mode 1 = сравнить WTime:  Double;

    constructor Create;
    destructor  Destroy; override;
  end;

  rcdTparDataDBRpt5 = packed record
    WTime:  Double;
    numChn: Array[1..5] of Integer;
    valChn: Array[1..5] of Single;
  end;
  PrcdTparDataDBRpt5 = ^rcdTparDataDBRpt5;
  prqTparDataDBRpt5 = class(prqTAbstract1)
  private
    function    GetPntDyn(j: Integer): PrcdTparDataDBRpt5;
  public
    property    pntDyn[j:Integer]: PrcdTparDataDBRpt5 read GetPntDyn; default;

    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
// mode 1 = сравнить WTime:  Double;

    constructor Create;
    destructor  Destroy; override;
  end;

// Описание графического листа отчета
  TORPGrafPageTab1 = class
  public
    DATfileName: string;         // Имя файла, куда выводятся данные
    listDescript:  string[63];   // Описание листа

    dtSQLBeg: TDateTime;
    dtSQLBegC: TDateTime;
    dtSQLEnd: TDateTime;

    param: prqTparDBrpt2;        // Список параметров
    data:  prqTparDataRpt2;      // Загружаемые данные
    dataIn: prqTparDataDBRpt2;   // Исходные данные из БД

    ParamDat:TParamData;         // Данные листа

    constructor Create;
    destructor  Destroy; override;
  end;
//
// ====================================================================


  rcdORPstageTab1 = packed record
    jNumber:    Integer;      // Номер этапа, 0 - общее описание
    sStageName:  string[63];  // Имя Этапа
    sLineName:   string[63];  // Имя линий (параметров) Этапа
    sFrm:        string[255]; // Формула нити (параметра) Этапа
    Chanal:    Integer;       // Номер канала Вычисления
    value:      Double;       // Значение параметра этапа
    plan:       Double;       // Плановое значение параметра этапа
    vaverage:   Double;       // Среднее Значение параметра этапа
    vmax:       Double;       // Максимальное Значение параметра этапа
    vmin:       Double;       // Минимальное Значение параметра этапа
    beg:        Double;       // Начало этапа
    dur:        Double;       // Продолжительность этапа
    jLine:      Integer;      // Количество линий (параметров) в этапе
  end;
  PrcdORPstageTab1 = ^rcdORPstageTab1;
  TORPstageTab1 = class(prqTabstract2)
  private
    function    GetPntDyn(j: Integer): PrcdORPstageTab1;
  protected
  public
    property    pntDyn[j:Integer]: PrcdORPstageTab1 read GetPntDyn; default;
    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
    procedure   ClearRCD(n: Integer);
    constructor Create;
  end;

  rcdORPNumCStageTab1 = packed record
    jColNumber:  Integer;     // Номер колонки
    jStgNumber:  Integer;     // Номер этапа
    sLineName:   string[63];  // Общее Имя Этапа
    sVariantN:   string[63];  // Имя Варианта
    nmFunction:  TFunNumber;  // Номер ассоциированной функции
    sPar1:       string[63];  // Имя Параметра 1
    sPar2:       string[63];  // Имя Параметра 2
    bSearch:     Boolean;     // Признак использования
  end;
  PrcdORPNumCStageTab1 = ^rcdORPNumCStageTab1;
  TORPNumCStageTab1 = class(prqTabstract2)
  private
    function    GetPntDyn(j: Integer): PrcdORPNumCStageTab1;
  protected
  public
    property    pntDyn[j:Integer]: PrcdORPNumCStageTab1 read GetPntDyn; default;
    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;

class function getNumFuncion(const sName: string): TFunNumber;

    constructor Create;
  end;

  rcdORPVariantTab1 = packed record
    bSearch: Boolean; // Признак использования
    sVariantN:   string[63];  // Имя Варианта
  end;
  PrcdORPVariantTab1 = ^rcdORPVariantTab1;
  TORPVariantTab1 = class(prqTabstract2)
  private
    function    GetPntDyn(j: Integer): PrcdORPVariantTab1;
  protected
  public
    property    pntDyn[j:Integer]: PrcdORPVariantTab1 read GetPntDyn; default;
    procedure   addNewVariant(const sV: string);
    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
    constructor Create;
  end;

  TOreolStages1 = class(TObject)
  private
    function transStr(str: TStringList; const sKey: string; var sErr: string; nLine: Integer; var sVal: string): boolean;
    function transDbl(str: TStringList; const sKey: string; var sErr: string; nLine: Integer; var dVal: Double): boolean;
    function transDbl1(str: TStringList; const sKey: string; var sErr: string; nLine: Integer; var dVal: Double): boolean;
    function transDbl2(str: TStringList; const sKey: string; var sErr: string; nLine: Integer;
                       var dVal, dMed, dMin, dMax: Double): boolean;
    function transDblInf(str: TStringList; var sErr: string; nLine: Integer;
                         var dVal: Double; var Chanal: Integer): boolean;
    function transInt(str: TStringList; const sKey: string; var sErr: string; nLine: Integer; var jVal: Integer): boolean;
    function trans3Int(str: TStringList; const sKey: string; var sErr: string; nLine: Integer; var jVal1, jVal2, jVal3: Integer): boolean;
    function nextLine(str: TStringList; var sErr: string; var nLine: Integer): boolean; overload;
    function nextLine(const sKey: string; str: TStringList; var sErr: string; var nLine: Integer): boolean; overload;

  protected

  public
    jVerCnf:   Integer; // Версия конфиг файла
    jLineCnt:  Integer; // Количество нитей этапов

    jStageCnt:   Integer; // Количество этапов в задании
    jStageExec:  Integer; // Исполняемый этап задания
    jStageAlloc: Integer; // Выделенный этап задания
    jStageMode:  Integer; // Состояние задания (0-4 редактирование, исполнение, архив, пауза, перерыв м/у этапами)

    dscLine:   TORPstageTab1; // Описание линий и этапов
    dscRepStag: TORPNumCStageTab1; // Таблица соответствия имен этапов, номеров колонок
    dscVariant: TORPVariantTab1;   // Описание вариантов

    function Translator(str: TStringList): string;
    function Translator2(str: TStringList): string;
    function Translator3(str: TStringList): string; // Версии 3 - 4
    function Translator8(str: TStringList): string; // Версии 6 - 8
    function Translator9(str: TStringList): string; // Версии 9 - ...

    function getValFuncion(jStage, jIndSTGPar: Integer;  const sVar: string;
var numCol: Integer; var dVal, dDur: Double): string; overload;
    function getValFuncion(jStage, jIndSTGPar: Integer;
var numCol: Integer; var dVal, dDur: Double): string; overload;
    function getModifyParNam(jNumStage: Integer): String;

    constructor Create;
    destructor Destroy; override;
  published

  end;

  TOreolStages = TOreolStages1;

  rcdXLS_shab_Param = packed record
    sParamName:  string[63];  // Имя параметра
    sShtName:    string[63];  // Имя Excel страницы
    sValue:      string[127]; // Значение параметра
    jColNumber:  Integer;     // Номер колонки
    jRowNumber:  Integer;     // Номер столбца
  end;
  PrcdXLS_shab_Param = ^rcdXLS_shab_Param;
  TXLS_shab_Param = class(prqTabstract2)
  private
    function    GetPntDyn(j: Integer): PrcdXLS_shab_Param;
  protected
  public
    property    pntDyn[j:Integer]: PrcdXLS_shab_Param read GetPntDyn; default;
    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;

    function    getParam(const sName: string): Integer;

    constructor Create;
  end;

  rcdXLS_shab_TabDopPar = packed record
    sTabDopParName:  string[63];  // Имя параметра
    jColNumber:  Integer;     // Номер колонки
  end;
  PrcdXLS_shab_TabDopPar = ^rcdXLS_shab_TabDopPar;
  TXLS_shab_TabDopPar = class(prqTabstract2)
  private
    function    GetPntDyn(j: Integer): PrcdXLS_shab_TabDopPar;
  protected
  public
    property    pntDyn[j:Integer]: PrcdXLS_shab_TabDopPar read GetPntDyn; default;
    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
    constructor Create;
  end;

  TXLS_shab_Table = class
  private
  protected
  public
    sTabName:           string[63];  // Имя таблицы
    sShtName:           string[63];  // Имя Excel страницы
    jRowFirst:             Integer;  // Номер 1-й строки
    jRows:                 Integer;  // Всего строк
    NumCols:           prqTInteger;  // Номера колонок
    DopPar:    TXLS_shab_TabDopPar;  // Таб доп парам

    sParGrid:          TStringGrid;  // Значение таблицы

    constructor Create;
    destructor Destroy; override;
  end;


  TXLS_shab_Dscrpt = class
  public
    Param: TXLS_shab_Param;
    Table: prqTobject;

    function newTableCreate: Integer;
    function getTable(const sTabName: string): Integer;

    constructor Create;
    destructor Destroy; override;
  end;

  rcdTEtapJob = packed record
    dataBeg,      // Начало
    dataEnd       // конец интервала
      : Double;
    etNumber,     // номер строки в таблице этапов
    nChPlotn,     // номер канала "Плотность"
    nChPlot2,     // номер канала "Плотность2"
    nChDavln,     //              "Давление"
    modeDavln,    // 1 = Максимальное давление,  2 = среднее давление
    nChRashd,     //              "Расход"
    nChSumRd      //              "Суммарный расход"
      :Integer;
    nBlPlotn,     // Блокировочные значения
    nBlPlot2,
    nBlDavln,
    nBlRashd,
    nBlSumRd
      : Double;
  end;
  PrcdTEtapJob = ^rcdTEtapJob;
  prqTEtapJob = class(prqTAbstract1)
  private
    function    GetPntDyn(j: Integer): PrcdTEtapJob;
  public
    property    pntDyn[j:Integer]: PrcdTEtapJob read GetPntDyn; default;

    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
//      1 - сравнить
//      2 - сравнить
//      3 - сравнить

    constructor Create;
    destructor  Destroy; override;
  end;


  TrptKst1 = class(prqTTaskObject)
  private

  protected

  public
    bSaveParam:   Boolean;
    OpenDialog1: TOpenDialog;
    ClientSocket1: TClientSocket;

    dirHome:     string; // Директория размещения нач данных  'c:\Cement\';
    dirHomeRpt:  string; // 'c:\Cement\ + 'Archive\';
    dirHomeEtc:  string; // 'c:\Cement\ + 'etc\';
    dirHomeDat:  string; // 'c:\Cement\ + 'dat\';
    dirHomeLogo: string; // 'c:\Cement\ + 'logo\';

    dirStart:    string; // Стартовая директория
    dirCrnt:     string; // Текущая директория

    NameDataFile: string;

    reportTop: TORPReportTop1; // Заголовок отчета

    listParam:   TODBhistTab;     // Список параметров из базы данных
    dscStages:   TOreolStages;    // Описание этапов
    dscBur:      TOreolBurDskrpt; // Описание буровой

    GrafPages:   prqTobject;      // Список листов приложения
    nomList:     Integer;         // Номер редактируемого листа

    shab_Dscrpt: TXLS_shab_Dscrpt;// Описание шаблона

    EtapJob:     prqTEtapJob;     // список заданий к БД
    EtapIn:      prqTobject;      // Список Данных для этапа

    procedure synchro(jEtalon: Integer);     overload; // синхронизация листов
    procedure synchro(jFrom, jTo: Integer);  overload; // синхронизация листов
    procedure initSpd(jN: Integer); // Очистить лист
    procedure LoadSpd(var sErr: string); // загрузка spd File
    procedure SaveSpd(var sErr: string); // сохранение spd File

    function SaveToBBAfile(numGrafPages: Integer; var sErr: string): boolean;

// Получить таблицу "name" из шаблона
    function getStringsFromShab(const name: string): TStringGrid;

    constructor Create;
    destructor Destroy; override;
  published
  end;

  TrptKst = TrptKst1;


implementation
uses
  uSupport;

{ TrptKst1 }

const
  sErr01 = 'Файл неизвестного формата. Тансляция таблицы этапов невозможна';
  sErr02 = 'Длина файла меньше ожидаемой. Тансляция таблицы этапов незавершена';
  sErr03 = 'Ошибка формата в строке %d = "%s". Тансляция таблицы этапов незавершена';
  sErr04 = 'Версия Таблицы Этапов не равна %d. Тансляция таблицы этапов незавершена';
  sErr05 = 'Тансляция Таблицы Этапов версии %d невозможна. Тансляция таблицы этапов незавершена';


constructor TrptKst1.Create;
begin
  inherited;

  reportTop   := TORPReportTop1.Create;
  GrafPages   := prqTobject.Create;
  listParam   := TODBhistTab.Create;
  dscStages   := TOreolStages.Create;
  dscBur      := TOreolBurDskrpt.Create;
  OpenDialog1 := nil;
  shab_Dscrpt := TXLS_shab_Dscrpt.Create;
  EtapJob     := prqTEtapJob.Create;
  EtapIn      := prqTobject.Create;
end;

destructor TrptKst1.Destroy;
begin
  OpenDialog1 := nil;
  reportTop.Free;
  listParam.Free;
  dscStages.Free;
  dscBur.Free;
  GrafPages.Free;
  shab_Dscrpt.Free;
  EtapJob.Free;
  EtapIn.Free;
  inherited;
end;

function TrptKst1.getStringsFromShab(const name: string): TStringGrid;
var
  jTab: Integer;
begin
  jTab := shab_Dscrpt.getTable(name);
  result := nil;
  if jTab = 0 then Exit;
  result := (shab_Dscrpt.Table[jTab].ukz as TXLS_shab_Table).sParGrid;
end;

procedure TrptKst1.initSpd(jN: Integer);
var
  p1: TORPGrafPageTab1;
  i, k: Integer;
begin
  p1 := GrafPages[jN].ukz as TORPGrafPageTab1;
  p1.ParamDat.IntervalCount := 1;
  p1.ParamDat.ReperCount    := 1;
  p1.ParamDat.MarkCount     := 2;

  for i:=1 to MaxReperTab do p1.ParamDat.ReperTab[i].Pos:=-1; // 50

  for i:=1 to MaxIntervalTab do p1.ParamDat.IntervalTab[i].R_Pos:=-1; // 20

  for i:=1 to StrKolon do
  begin
    for k:=1 to MaxKolonTab do p1.ParamDat.KolonTab[i].flag[k]:=False;
  end;

  for i:=1 to StrSkvagina do
  begin
    for k:=1 to MaxSkvaginaTab do p1.ParamDat.SkvaTab[i].flag[k]:=False;
  end;

  for i:=2 to StrZakachka do // все строки кроме (1)
  begin
    p1.ParamDat.ZakachTab[i].Param3:='Этап'+IntToStr(i);
    p1.ParamDat.ZakachTab[i].Mark:=-1;
    for k:=2 to MaxZakachParam do
    begin
      p1.ParamDat.ZakachTab[i].flag[k]:=False;
    end;
  end;
end;

procedure TrptKst1.LoadSpd;
var
  FSPD:File of TParamData;
  j2, j1, jC1: Integer;
begin
  sErr := '';
  j1 := 0;
  if FileExists(reportTop.NameSpdFile) then
  begin
    AssignFile(FSPD, reportTop.NameSpdFile);
    FileMode := 0;  // Set file access to read only
    Reset(FSPD);
    try
      for jC1 := 1 to GrafPages.Count do
      begin
        if Eof(FSPD) then break;
        Read(FSPD, (GrafPages[jC1].ukz as TORPGrafPageTab1).ParamDat);
        j1 := jC1;
      end;
    except
      on E: Exception do
      begin
        sErr := E.Message;
      end;
    end;
    CloseFile(FSPD);
  end;

  if j1 > 0 then j2 := j1+1 else j2 := 1;
  if j1 < GrafPages.Count then
  begin
    for jC1 := j2 to GrafPages.Count do
    begin
      initSpd(jC1);
      if j1 > 0 then synchro(j1, jC1);
    end;
  end;
end;

procedure TrptKst1.SaveSpd(var sErr: string);
var
  FSPD:File of TParamData;
  jC1: Integer;
begin
  sErr := '';
  AssignFile(FSPD, reportTop.NameSpdFile);
  try
    Rewrite(FSPD);
    for jC1 := 1 to GrafPages.Count  do
    begin
      Write(FSPD, (GrafPages[jC1].ukz as TORPGrafPageTab1).ParamDat);
    end;
  except
    on E: Exception do
    begin
      sErr := E.Message;
    end;
  end;
  CloseFile(FSPD);
end;

function TrptKst1.SaveToBBAfile(numGrafPages: Integer;
  var sErr: string): boolean;
var
  p1: TORPGrafPageTab1;
  myFile: File of TBase;
  FileShb: String;
  j2, jSumFlow, jC1: Integer;
  j1: Int64;
begin

  FileShb := clrFileNameExt(reportTop.NameRptFile);

  p1 := GrafPages[numGrafPages].ukz as TORPGrafPageTab1;
  p1.DATfileName := FileShb + '_' + prqGuidRedString;
  p1.DATfileName := p1.DATfileName + pc003_05_extBBA;
  try
    AssignFile(myFile, p1.DATfileName);
    Rewrite(myFile);
                                      
    Header.StartTime   := TimeOf(p1.dtSQLBegC);
    Header.StartDate   := DateOf(p1.dtSQLBeg);
    Header.Reserv      := '';
    Write(myFile, CurrStr); // Записать дату и время в заголовок файла

    StrPlase.Plase     := reportTop.sMestoRozhd;
    StrPlase.Reserv    := '';
    Write(myFile, CurrStr); // Записать месторождение в заголовок графика

    StrComplex.Complex := reportTop.sSkvazhina;
    StrComplex.Reserv  := '';
    Write(myFile, CurrStr); // Записать скважину/куст в заголовок графика

    StrWork.Work       := reportTop.sVidRabot;
    StrWork.Reserv     := '';
    Write(myFile, CurrStr); // Записать вид работ в заголовок графика

    StrTask.Task       := reportTop.sZadanie;
    StrTask.Reserv     := '';
    Write(myFile, CurrStr); // Записать задание в заголовок графика


// Записать данные
    jSumFlow := 0; j1 := 0;
    for jC1 := 1 to p1.data.Count do
    begin
      CurrStr.WTime   := p1.data[jC1].WTime;
      CurrStr.FlowIn  := p1.data[jC1].FlowIn;
      CurrStr.PresIn  := p1.data[jC1].PresIn;
      CurrStr.DensIn  := p1.data[jC1].DensIn;
      CurrStr.TempIn  := p1.data[jC1].TempIn;

      Inc(j1, CurrStr.FlowIn);
      j2 := Round(j1 * KfIn / 100000);
      if j2 > jSumFlow then
      begin
        CurrStr.Reserv1 := 85; // 55H
        jSumFlow := j2;
      end
      else
      begin
        CurrStr.Reserv1 := 0;
      end;
      CurrStr.Reserv2 := 0;
      CurrStr.Reserv3 := 0;
      Write(myFile, CurrStr); // Записать задание в заголовок графика
    end;


    CloseFile(myFile);

    sErr := '';
    result := True;
  except
    on E: Exception do
    begin
      sErr := E.Message;
      result := False;
    end;
  end;
end;

procedure TrptKst1.synchro(jEtalon: Integer);
var
  jC1: Integer;
begin
  for jC1 := 1 to GrafPages.Count do
  begin
    if jC1 <> jEtalon then
    begin
      (GrafPages[jC1].ukz as TORPGrafPageTab1).ParamDat.ZakachTab :=
                               (GrafPages[jEtalon].ukz as TORPGrafPageTab1).ParamDat.ZakachTab;
      (GrafPages[jC1].ukz as TORPGrafPageTab1).ParamDat.MarkCount :=
                               (GrafPages[jEtalon].ukz as TORPGrafPageTab1).ParamDat.MarkCount;
    end;
  end;
end;

procedure TrptKst1.synchro(jFrom, jTo: Integer);
begin
  (GrafPages[jTo].ukz as TORPGrafPageTab1).ParamDat.ZakachTab :=
                               (GrafPages[jFrom].ukz as TORPGrafPageTab1).ParamDat.ZakachTab;
  (GrafPages[jTo].ukz as TORPGrafPageTab1).ParamDat.MarkCount :=
                               (GrafPages[jFrom].ukz as TORPGrafPageTab1).ParamDat.MarkCount;
end;

{ TORPstageTab1 }

function TORPstageTab1.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign(PrcdORPstageTab1(ukz1).jNumber - PrcdORPstageTab1(ukz2).jNumber) + 2;
     end;
  2: begin
       result := sign(AnsiCompareStr(PrcdORPstageTab1(ukz1).sLineName, PrcdORPstageTab1(ukz2).sLineName)) + 2;
     end;
  3: begin
       result := sign(PrcdORPstageTab1(ukz1).value - PrcdORPstageTab1(ukz2).value) + 2;
     end;
  12:begin
       result := sign(PrcdORPstageTab1(ukz1).jNumber - PrcdORPstageTab1(ukz2).jNumber) + 2;
       if result = 2 then
         result := sign(AnsiCompareStr(PrcdORPstageTab1(ukz1).sLineName, PrcdORPstageTab1(ukz2).sLineName)) + 2;
     end;
  else begin result := 0; end;
  end;
end;

procedure TORPstageTab1.ClearRCD(n: Integer);
begin
  if (n > count) OR (n < 1) then exit;
  self[n].jNumber    := 0;
  self[n].sLineName  := '';
  self[n].sFrm       := '';
  self[n].sStageName := '';
  self[n].value      := 0;
  self[n].plan       := 0;
  self[n].vaverage   := 0;
  self[n].vmax       := 0;
  self[n].vmin       := 0;
  self[n].beg        := 0;
  self[n].dur        := 0;
  self[n].jLine      := 0;
end;

constructor TORPstageTab1.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdORPstageTab1);
end;

function TORPstageTab1.GetPntDyn(j: Integer): PrcdORPstageTab1;
begin
  result := GetPnt(j);
end;

{ TOreolStages1 }

constructor TOreolStages1.Create;
begin
  dscLine := TORPstageTab1.Create;
  dscRepStag := TORPNumCStageTab1.Create;
  dscVariant := TORPVariantTab1.Create;
  inherited;
end;

destructor TOreolStages1.Destroy;
begin
  dscLine.Free;
  dscRepStag.Free;
  dscVariant.Free;

  inherited;
end;

function TOreolStages1.getModifyParNam(jNumStage: Integer): String;
var
  j1, jC1: Integer;
  dMaxVal: Double;
  rS: rcdORPVariantTab1;
begin
  dMaxVal := 0; result := '';

  for jC1 := 1 to dscLine.Count do
  begin
    if dscLine[jC1].jNumber <> jNumStage then continue;

    rS.sVariantN := dscLine[jC1].sLineName;
    j1 := dscVariant.Find(@rS, 1);
    if j1 = 0 then continue;

    if dMaxVal > dscLine[jC1].value then continue;
    if dscVariant[j1].bSearch then Exit;

    dMaxVal := dscLine[jC1].value;
    dscVariant[j1].bSearch := True;
    result := rS.sVariantN;
  end;
end;

function TOreolStages1.getValFuncion(jStage, jIndSTGPar: Integer; const sVar: string;
  var numCol: Integer; var dVal, dDur: Double): string;
var
  j3, j2, j1: Integer;
  rS: rcdORPNumCStageTab1;
  rcd: rcdORPstageTab1;
begin
  result := '';
  if dscRepStag[jIndSTGPar].sVariantN <> sVar then Exit;

// Поиск соотв параметра
  case dscRepStag[jIndSTGPar].nmFunction of
nfMedium: begin
      rS.sVariantN  := sVar;
      rS.sLineName := dscRepStag[jIndSTGPar].sLineName;
      j1 := dscRepStag.Find(@rS, 24); // Ищем индекс "колонки"
      if j1 = 0 then Exit;
      numCol := dscRepStag[j1].jColNumber;

      rcd.jNumber := jStage;
      rcd.sLineName := dscRepStag[jIndSTGPar].sPar1;
      j2 := dscLine.Find(@rcd, 12); // Ищем индекс Параметра этапа
      if j2 = 0 then Exit;
      try
        dDur := dscLine[j2].dur;
        dVal := dscLine[j2].value / dscLine[j2].dur * pc003_05_Kmls;
        result := FormatFloat('0.00', dVal);
      except
      end;
    end;

nfMulty: begin
      rS.sVariantN  := sVar;
      rS.sLineName := dscRepStag[jIndSTGPar].sLineName;
      j1 := dscRepStag.Find(@rS, 24); // Ищем индекс "колонки"
      if j1 = 0 then Exit;
      numCol := dscRepStag[j1].jColNumber;

      rcd.jNumber := jStage;
      rcd.sLineName := dscRepStag[jIndSTGPar].sPar1;
      j2 := dscLine.Find(@rcd, 12); // Ищем индекс Параметра этапа
      if j2 = 0 then Exit;

      rcd.jNumber := jStage;
      rcd.sLineName := dscRepStag[jIndSTGPar].sPar2;
      j3 := dscLine.Find(@rcd, 12); // Ищем индекс Параметра этапа
      if j3 = 0 then Exit;

      dDur := dscLine[j2].dur;
      dVal := dscLine[j2].value * dscLine[j3].value;
      result := FormatFloat('0.00', dVal);
    end;

else begin // Простой параметр
      rS.sVariantN  := sVar;
      rS.sLineName := dscRepStag[jIndSTGPar].sLineName;
      j1 := dscRepStag.Find(@rS, 24); // Ищем индекс "колонки"
      if j1 = 0 then Exit;
      numCol := dscRepStag[j1].jColNumber;

      rcd.jNumber := jStage;
      rcd.sLineName := rS.sLineName;
      j2 := dscLine.Find(@rcd, 12); // Ищем индекс Параметра этапа
      if j2 = 0 then Exit;
      dDur := dscLine[j2].dur;
      dVal := dscLine[j2].value;
      result := FormatFloat('0.00', dVal);
    end;
  end;
end;

function TOreolStages1.getValFuncion(jStage, jIndSTGPar: Integer;
  var numCol: Integer; var dVal, dDur: Double): string;
var
  j3, j2, j1: Integer;
  rS: rcdORPNumCStageTab1;
  rcd: rcdORPstageTab1;
begin
  result := '';
  rS.sLineName := dscRepStag[jIndSTGPar].sLineName;
  j1 := dscRepStag.Find(@rS, 2); // Ищем индекс "колонки"
  if j1 = 0 then Exit;
  numCol := dscRepStag[j1].jColNumber;

// Поиск соотв параметра
  case dscRepStag[jIndSTGPar].nmFunction of
nfMedium: begin
      rcd.jNumber := jStage;
      rcd.sLineName := dscRepStag[jIndSTGPar].sPar1;
      j2 := dscLine.Find(@rcd, 12); // Ищем индекс Параметра этапа
      if j2 = 0 then Exit;
      dDur := dscLine[j2].dur;
      try
        dVal := dscLine[j2].value / dscLine[j2].dur * pc003_05_Kmls;
        result := FormatFloat('0.00', dVal);
      except
      end;
    end;

nfMulty: begin
      rcd.jNumber := jStage;
      rcd.sLineName := dscRepStag[jIndSTGPar].sPar1;
      j2 := dscLine.Find(@rcd, 12); // Ищем индекс Параметра этапа
      if j2 = 0 then Exit;
      dDur := dscLine[j2].dur;

      rcd.sLineName := dscRepStag[jIndSTGPar].sPar2;
      j3 := dscLine.Find(@rcd, 12); // Ищем индекс Параметра этапа
      if j3 = 0 then Exit;

      dVal := dscLine[j2].value * dscLine[j3].value;
      result := FormatFloat('0.00', dVal);
    end;

else begin // Простой параметр
      rcd.jNumber := jStage;
      rcd.sLineName := dscRepStag[jIndSTGPar].sLineName;
      j2 := dscLine.Find(@rcd, 12); // Ищем индекс Параметра этапа
      if j2 = 0 then Exit;
      dDur := dscLine[j2].dur;

      dVal := dscLine[j2].value;
      result := FormatFloat('0.00', dVal);
    end;
  end;
end;

function TOreolStages1.nextLine(str: TStringList; var sErr: string;
  var nLine: Integer): boolean;
begin
  result := False;
  repeat
    Inc(nLine);
    if nLine >= str.Count then begin sErr := sErr02; Exit; end;
  until Length(str[nLine]) > 0;
  result := True;
end;

function TOreolStages1.nextLine(const sKey: string; str: TStringList;
  var sErr: string; var nLine: Integer): boolean;
begin
  result := False;
  repeat
    Inc(nLine);
    if nLine >= str.Count then begin sErr := sErr02; Exit; end;
  until Pos(sKey, str[nLine]) = 1;
  result := True;
end;

function TOreolStages1.trans3Int(str: TStringList; const sKey: string;
  var sErr: string; nLine: Integer; var jVal1, jVal2,
  jVal3: Integer): boolean;
var
  s0, s1: string;
  jC1: Integer;
begin
  result := False;
  if nLine >= str.Count then begin sErr := sErr02; Exit; end;
  s0 := str[nLine];
  s1 := Copy(s0, 1, 3);
  if s1 <> sKey then begin sErr := format(sErr03, [nLine + 1, s0]); Exit; end;

  s0 := Copy(s0, 5, Length(s0));
  s1 := prqGetIdentify(' ', s0, jC1);
  result := prqStrToInt(s1, jVal1);
  if result then
  begin
    s0 := Trim(Copy(s0, jC1, Length(s0)));
    s1 := prqGetIdentify(' ', s0, jC1);
    result := prqStrToInt(s1, jVal2);
  end;
  if result then
  begin
    s0 := Trim(Copy(s0, jC1, Length(s0)));
    s1 := prqGetIdentify(' ', s0, jC1);
    result := prqStrToInt(s1, jVal3);
  end;

  if not result then sErr := format(sErr03, [1, s0]);
end;

function TOreolStages1.transDbl(str: TStringList; const sKey: string;
  var sErr: string; nLine: Integer; var dVal: Double): boolean;
var
  s0, s1: string;
begin
  result := False;
  if nLine >= str.Count then begin sErr := sErr02; Exit; end;
  s0 := str[nLine];
  s1 := Copy(s0, 1, 3);
  if s1 <> sKey then begin sErr := format(sErr03, [nLine + 1, s0]); Exit; end;
  s1 := Copy(s0, 5, Length(s0));

  result := prqStrToFloat(s1, dVal);
  if not result then sErr := format(sErr03, [1, s0]);
end;

function TOreolStages1.transDbl1(str: TStringList; const sKey: string;
  var sErr: string; nLine: Integer; var dVal: Double): boolean;
var
  s0, s1: string;
  jC1: Integer;
begin
  result := False;
  if nLine >= str.Count then begin sErr := sErr02; Exit; end;
  s0 := str[nLine];
  s1 := Copy(s0, 1, 3);
  if s1 <> sKey then begin sErr := format(sErr03, [nLine + 1, s0]); Exit; end;

  s1 := prqGetIdentify(' ', Trim(Copy(s0, 5, Length(s0))), jC1);

  result := prqStrToFloat(s1, dVal);
  if not result then sErr := format(sErr03, [1, s0]);
end;

function TOreolStages1.transDbl2(str: TStringList; const sKey: string;
  var sErr: string; nLine: Integer; var dVal, dMed, dMin, dMax: Double): boolean;
var
  s0, s1: string;
  jC1: Integer;
begin
  result := False;
  if nLine >= str.Count then begin sErr := sErr02; Exit; end;
  s0 := str[nLine];
  s1 := Copy(s0, 1, 3);
  if s1 <> sKey then begin sErr := format(sErr03, [nLine + 1, s0]); Exit; end;

  s1 := prqGetIdentify(' ', Trim(Copy(s0, 5, Length(s0))), jC1);

  dVal := 0; dMed := 0; dMin := 0; dMax := 0;
  try
    result := prqStrToFloat(s1, dVal); // Значение
    if not result then Exit;

    s0 := Trim(Copy(s0, 3 + jC1, Length(s0)));
    if Length(s0) < 2 then Exit;
    jC1 := Pos('(', s0);
    if jC1 = 0 then Exit;

  // Min
    s0 := Trim(Copy(s0, jC1+1, Length(s0)));
    s1 := prqGetIdentify(' ', s0, jC1);
    result := prqStrToFloat(s1, dMin); // Значение Минимальное

  // Max
    s0 := Trim(Copy(s0, jC1, Length(s0)));
    s1 := prqGetIdentify(' ', s0, jC1);
    result := prqStrToFloat(s1, dMax); // Значение Максимальное

  // Aver
    s0 := Trim(Copy(s0, jC1, Length(s0)));
    s1 := prqGetIdentify(' ', s0, jC1);
    result := prqStrToFloat(s1, dMed); // Значение Среднее

  finally
    if not result then sErr := format(sErr03, [1, s0]);
  end;
end;

function TOreolStages1.transDblInf(str: TStringList; var sErr: string;
  nLine: Integer; var dVal: Double; var Chanal: Integer): boolean;
var
  s0, s1: string;
  jC1: Integer;
begin
  result := False;
  sErr := '';
  if nLine >= str.Count then begin sErr := sErr02; Exit; end;
// INF 7F 15.000000 81
// INF F 15.000000 81

  s0 := str[nLine];
  s0 := Trim( Copy(s0, 5, Length(s0)) );
  s1 := prqGetIdentify(' ', s0, jC1);
  s0 := Trim(Copy(s0, jC1, Length(s0)));
  s1 := prqGetIdentify(' ', s0, jC1);
  result := prqStrToFloat(s1, dVal);

  if result then
  begin
    s0 := Trim(Copy(s0, jC1, Length(s0)));
    s1 := prqGetIdentify(' ', s0, jC1);
    result := prqStrToInt(s1, Chanal);
  end;

  if not result then sErr := format(sErr03, [1, s0]);
end;

function TOreolStages1.transInt(str: TStringList; const sKey: string;
  var sErr: string; nLine: Integer; var jVal: Integer): boolean;
var
  s0, s1: string;
begin
  result := False;
  if nLine >= str.Count then begin sErr := sErr02; Exit; end;
  s0 := str[nLine];
  s1 := Copy(s0, 1, 3);
  if s1 <> sKey then begin sErr := format(sErr03, [nLine + 1, s0]); Exit; end;
  s1 := Copy(s0, 5, Length(s0));
  try
    jVal := StrToInt(s1);
    result := True;
  except
    sErr := format(sErr03, [1, s0]); Exit;
  end;
end;

function TOreolStages1.Translator(str: TStringList): string;
var
  jLineN: Integer;
begin
// Чтение версии
  jLineN := -1;
  if not nextLine(str, result, jLineN) then Exit;
  if not transInt(str, 'VER', result, 0, jVerCnf) then Exit;
  case jVerCnf of
       2: result := Translator2(str);
    3..5: result := Translator3(str);
    6..8: result := Translator8(str);
  9..999: result := Translator9(str);
  else
    result := format(sErr05, [jVerCnf]);
  end;
end;

function TOreolStages1.Translator2(str: TStringList): string;
var
  s1: string;
  j2, jC2, jLS, jLS0, j1, jC1, jLineN: Integer;
  d1: Double;
  rcdS1: rcdORPstageTab1;
begin
  result        := '';
  jLineCnt      := 0;
  jStageCnt     := 0;
  dscLine.Count := 0;
  jVerCnf       := 0;
  if str.Count < 4 then begin result := sErr01; Exit; end;

// Чтение версии
  jLineN := -1;
  if not nextLine(str, result, jLineN) then Exit;
  if not transInt(str, 'VER', result, 0, jVerCnf) then Exit;
  if jVerCnf <> 2 then begin result := format(sErr04, [2]); Exit; end;

// Чтение количества нитей
  Inc(jLineN); // Пропуск 'END 0'
  if not nextLine(str, result, jLineN) then Exit;
  if not transInt(str, 'N_T', result, jLineN, jLineCnt) then Exit;
  if jLineCnt < 1 then Exit;

// Трансляция описания нитей
  for jC1 := 1 to jLineCnt do
  begin
    if not nextLine(str, result, jLineN) then Exit;
    dscLine.Count := dscLine.Count + 1;
    dscLine.ClearRCD(dscLine.Count);

// Имя нити
    if not transStr(str, 'NAM', result, jLineN, s1) then Exit;
    dscLine[dscLine.Count].sLineName  := s1;

// формула нити
    if not nextLine(str, result, jLineN) then Exit;
    if not transStr(str, 'FRM', result, jLineN, s1) then Exit;
    dscLine[dscLine.Count].sFrm  := s1;
  end;

// Трансляция кол этапов
  if not nextLine(str, result, jLineN) then Exit;
  if not transInt(str, 'N_S', result, jLineN, jStageCnt) then Exit;
  if jStageCnt < 1 then Exit; // Нет ни одного этапа


// Трансляция этапов
  for jC1 := 1 to jStageCnt do
  begin
    dscLine.Count := dscLine.Count + 1;
    dscLine.ClearRCD(dscLine.Count);

// Имя "конкретного" этапа
    if not nextLine(str, result, jLineN) then Exit;
    if not transStr(str, 'NAM', result, jLineN, s1) then Exit;
    dscLine[dscLine.Count].sStageName := s1;

// Номер этапа
    if not nextLine(str, result, jLineN) then Exit;
    if not transInt(str, 'NUM', result, jLineN, j1) then Exit;
    dscLine[dscLine.Count].jNumber := j1;

// Начало этапа
    if not nextLine(str, result, jLineN) then Exit;
    if not transDbl(str, 'BEG', result, jLineN, d1) then Exit;
    dscLine[dscLine.Count].beg := d1;

// Продолжительность этапа
    if not nextLine(str, result, jLineN) then Exit;
    if not transDbl(str, 'DUR', result, jLineN, d1) then Exit;
    dscLine[dscLine.Count].dur := d1;

// Кол линий этапа
    if not nextLine(str, result, jLineN) then Exit;
    if not transInt(str, 'N_C', result, jLineN, jLS) then Exit;
    dscLine[dscLine.Count].jLine := jLS;
    if jLS < 1 then begin result := format(sErr03, [jLineN + 1, str[jLineN]]); Exit; end;

    jLS0 := dscLine.Count;
    for jC2 := 1 to jLS do
    begin
      if jC2 > 1 then
      begin
        dscLine.Count := dscLine.Count + 1;
        dscLine[dscLine.Count]^ := dscLine[jLS0]^;
      end;

// Имя этапа
      if not nextLine(str, result, jLineN) then Exit;
      if not transStr(str, 'NAM', result, jLineN, s1) then Exit;
      dscLine[dscLine.Count].sLineName := s1;
      if dscLine[dscLine.Count].jNumber = 1 then
      begin
        rcdS1.jNumber := 0;
        rcdS1.sLineName := dscLine[dscLine.Count].sLineName;
        j2 := dscLine.Find(@rcdS1, 12);
        if j2 > 0 then
        begin
          dscLine[j2].beg := dscLine[dscLine.Count].beg;
        end;
      end;

// формула нити
      if not nextLine(str, result, jLineN) then Exit;
      if not transStr(str, 'FRM', result, jLineN, s1) then Exit;
      dscLine[dscLine.Count].sFrm  := s1;

// Объём этапа
      if not nextLine(str, result, jLineN) then Exit;
      if not transDbl(str, 'VAL', result, jLineN, d1) then Exit;
      dscLine[dscLine.Count].value := d1;

      rcdS1.jNumber := 0;
      rcdS1.sLineName := dscLine[dscLine.Count].sLineName;
      j2 := dscLine.Find(@rcdS1, 12);
      if j2 > 0 then
      begin
        dscLine[j2].value := dscLine[j2].value + dscLine[dscLine.Count].value;
      end;
      rcdS1.jNumber := 0;
      rcdS1.sLineName := dscLine[dscLine.Count].sLineName;
      j2 := dscLine.Find(@rcdS1, 12);
      if j2 > 0 then
      begin
        dscLine[j2].dur := dscLine[j2].dur + dscLine[dscLine.Count].dur;
      end;
    end;
  end;
end;

function TOreolStages1.Translator3(str: TStringList): string;
var
  s1: string;
  jC2, jLS, jLS0, j1, jC1, jLineN: Integer;
  d1: Double;
begin
  result        := '';
  jLineCnt      := 0;
  jStageCnt     := 0;
  dscLine.Count := 0;
  jVerCnf       := 0;
  if str.Count < 3 then begin result := sErr01; Exit; end;

// Чтение версии
  jLineN := -1;
  if not nextLine(str, result, jLineN) then Exit;
  if not transInt(str, 'VER', result, 0, jVerCnf) then Exit;
  if (jVerCnf < 3) OR (jVerCnf > 5) then
  begin
    result := format(sErr05, [jVerCnf]); Exit;
  end;

  if not nextLine(str, result, jLineN) then Exit; // Пропуск 'END 0'

// Трансляция кол этапов
  if not nextLine(str, result, jLineN) then Exit;
  if not transInt(str, 'N_S', result, jLineN, jStageCnt) then Exit;
  if jStageCnt < 1 then Exit; // Нет ни одного этапа

// Трансляция этапов
  for jC1 := 1 to jStageCnt do
  begin
    dscLine.Count := dscLine.Count + 1;
    dscLine.ClearRCD(dscLine.Count);

// Имя "конкретного" этапа
    if not nextLine(str, result, jLineN) then Exit;
    if not transStr(str, 'NAM', result, jLineN, s1) then Exit;
    dscLine[dscLine.Count].sStageName := s1;

// Номер этапа
    if not nextLine(str, result, jLineN) then Exit;
    if not transInt(str, 'NUM', result, jLineN, j1) then Exit;
    dscLine[dscLine.Count].jNumber := j1;

// Начало этапа
    if not nextLine(str, result, jLineN) then Exit;
    if not transDbl(str, 'BEG', result, jLineN, d1) then Exit;
    dscLine[dscLine.Count].beg := d1;

// Продолжительность этапа
    if not nextLine(str, result, jLineN) then Exit;
    if not transDbl(str, 'DUR', result, jLineN, d1) then Exit;
    dscLine[dscLine.Count].dur := d1;

// Кол линий этапа
    if not nextLine(str, result, jLineN) then Exit;
    if not transInt(str, 'N_C', result, jLineN, jLS) then Exit;
    if jLS < 1 then begin result := format(sErr03, [jLineN + 1, str[jLineN]]); Exit; end;
    dscLine[dscLine.Count].jLine := jLS;

    jLS0 := dscLine.Count;
    for jC2 := 1 to jLS do
    begin
      if jC2 > 1 then
      begin
        dscLine.Count := dscLine.Count + 1;
        dscLine[dscLine.Count]^ := dscLine[jLS0]^;
      end;

// Имя нити (параметра этапа)
      if not nextLine(str, result, jLineN) then Exit;
      if not transStr(str, 'NAM', result, jLineN, s1) then Exit;
      dscLine[dscLine.Count].sLineName := s1;

// формула нити (параметра этапа)
      if not nextLine(str, result, jLineN) then Exit;
      if not transStr(str, 'FRM', result, jLineN, s1) then Exit;
      dscLine[dscLine.Count].sFrm  := s1;

// Значение параметра этапа
      if not nextLine(str, result, jLineN) then Exit;
      if not transDbl1(str, 'VAL', result, jLineN, d1) then Exit;
      dscLine[dscLine.Count].value := d1;
    end;
  end;
end;

function TOreolStages1.Translator8(str: TStringList): string;
var
  s1: string;
  jC2, jLS, jLS0, j1, jC1, jLineN: Integer;
  d1: Double;
begin
  result        := '';
  jLineCnt      := 0;
  jStageCnt     := 0;
  dscLine.Count := 0;
  jVerCnf       := 0;
  if str.Count < 3 then begin result := sErr01; Exit; end;

// Чтение версии
  jLineN := -1;
  if not nextLine(str, result, jLineN) then Exit;
  if not transInt(str, 'VER', result, 0, jVerCnf) then Exit;
  if (jVerCnf < 6) {OR (jVerCnf > 8)} then
  begin
    result := format(sErr05, [jVerCnf]); Exit;
  end;

// Трансляция кол этапов
  if not nextLine('N_S', str, result, jLineN) then Exit;
  if not transInt(str, 'N_S', result, jLineN, jStageCnt) then Exit;
  if jStageCnt < 1 then Exit; // Нет ни одного этапа

// Трансляция этапов
  for jC1 := 1 to jStageCnt do
  begin
    dscLine.Count := dscLine.Count + 1;
    dscLine.ClearRCD(dscLine.Count);

// Имя "конкретного" этапа
    if not nextLine('NAM', str, result, jLineN) then Exit;
    if not transStr(str, 'NAM', result, jLineN, s1) then Exit;
    dscLine[dscLine.Count].sStageName := s1;

// Номер этапа
    if not nextLine('NUM', str, result, jLineN) then Exit;
    if not transInt(str, 'NUM', result, jLineN, j1) then Exit;
    dscLine[dscLine.Count].jNumber := j1;

// Начало этапа
    if not nextLine('BEG', str, result, jLineN) then Exit;
    if not transDbl(str, 'BEG', result, jLineN, d1) then Exit;
    dscLine[dscLine.Count].beg := d1;

// Продолжительность этапа
    if not nextLine('DUR', str, result, jLineN) then Exit;
    if not transDbl(str, 'DUR', result, jLineN, d1) then Exit;
    dscLine[dscLine.Count].dur := d1;

// Кол линий этапа
    if not nextLine('N_C', str, result, jLineN) then Exit;
    if not transInt(str, 'N_C', result, jLineN, jLS) then Exit;
    if jLS < 1 then begin result := format(sErr03, [jLineN + 1, str[jLineN]]); Exit; end;
    dscLine[dscLine.Count].jLine := jLS;

    jLS0 := dscLine.Count;
    for jC2 := 1 to jLS do
    begin
      if jC2 > 1 then
      begin
        dscLine.Count := dscLine.Count + 1;
        dscLine[dscLine.Count]^ := dscLine[jLS0]^;
      end;

// Имя нити (параметра этапа)
      if not nextLine('NAM', str, result, jLineN) then Exit;
      if not transStr(str, 'NAM', result, jLineN, s1) then Exit;
      dscLine[dscLine.Count].sLineName := s1;

// формула нити (параметра этапа)
      if not nextLine('FRM', str, result, jLineN) then Exit;
      if not transStr(str, 'FRM', result, jLineN, s1) then Exit;
      dscLine[dscLine.Count].sFrm  := s1;

// Значение параметра этапа
      if not nextLine('VAL', str, result, jLineN) then Exit;
      if not transDbl1(str, 'VAL', result, jLineN, d1) then Exit;
      dscLine[dscLine.Count].value := d1;
    end;
  end;
end;

function TOreolStages1.Translator9(str: TStringList): string;
var
  s1: string;
  jC2, jLS, jLS0, j1, jC1, jLineN: Integer;
  d1, dVal, dMed, dMin, dMax: Double;
begin
  result        := '';
  jLineCnt      := 0;
  jStageCnt     := 0; jStageExec    := 0; jStageAlloc   := 0; jStageMode    := 0;
  dscLine.Count := 0;
  jVerCnf       := 0;
  if str.Count < 3 then begin result := sErr01; Exit; end;

// Чтение версии
  jLineN := -1;
  if not nextLine(str, result, jLineN) then Exit;
  if not transInt(str, 'VER', result, 0, jVerCnf) then Exit;
  if (jVerCnf < 9) {OR (jVerCnf > 8)} then
  begin
    result := format(sErr05, [jVerCnf]); Exit;
  end;

// Чтение состояния Stages
  if not nextLine('EXE', str, result, jLineN) then Exit;
  if not trans3Int(str, 'EXE', result, jLineN, jStageExec, jStageAlloc, jStageMode) then Exit;

// Трансляция кол этапов
  if not nextLine('N_S', str, result, jLineN) then Exit;
  if not transInt(str, 'N_S', result, jLineN, jStageCnt) then Exit;
  if jStageCnt < 1 then Exit; // Нет ни одного этапа

// Трансляция этапов
  for jC1 := 1 to jStageCnt do
  begin
    dscLine.Count := dscLine.Count + 1;
    dscLine.ClearRCD(dscLine.Count);

// Имя "конкретного" этапа
    if not nextLine('NAM', str, result, jLineN) then Exit;
    if not transStr(str, 'NAM', result, jLineN, s1) then Exit;
    dscLine[dscLine.Count].sStageName := s1;

// Номер этапа
    if not nextLine('NUM', str, result, jLineN) then Exit;
    if not transInt(str, 'NUM', result, jLineN, j1) then Exit;
    dscLine[dscLine.Count].jNumber := j1;

// Начало этапа
    if not nextLine('BEG', str, result, jLineN) then Exit;
    if not transDbl(str, 'BEG', result, jLineN, d1) then Exit;
    dscLine[dscLine.Count].beg := d1;

// Продолжительность этапа
    if not nextLine('DUR', str, result, jLineN) then Exit;
    if not transDbl(str, 'DUR', result, jLineN, d1) then Exit;
    dscLine[dscLine.Count].dur := d1;

// Кол линий этапа
    if not nextLine('N_C', str, result, jLineN) then Exit;
    if not transInt(str, 'N_C', result, jLineN, jLS) then Exit;
    if jLS < 1 then begin result := format(sErr03, [jLineN + 1, str[jLineN]]); Exit; end;
    dscLine[dscLine.Count].jLine := jLS;

    jLS0 := dscLine.Count;
    for jC2 := 1 to jLS do
    begin
      if jC2 > 1 then
      begin
        dscLine.Count := dscLine.Count + 1;
        dscLine[dscLine.Count]^ := dscLine[jLS0]^;
      end;

// Имя нити (параметра этапа)
      if not nextLine('NAM', str, result, jLineN) then Exit;
      if not transStr(str, 'NAM', result, jLineN, s1) then Exit;
      dscLine[dscLine.Count].sLineName := s1;

// формула нити (параметра этапа)
      if not nextLine('FRM', str, result, jLineN) then Exit;
      if not transStr(str, 'FRM', result, jLineN, s1) then Exit;
      dscLine[dscLine.Count].sFrm := s1;

// Плановое Значение параметра этапа
      if not nextLine('INF', str, result, jLineN) then Exit;
      if not transDblInf(str, result, jLineN, dVal, j1) then Exit;
      dscLine[dscLine.Count].plan   := dVal;
      dscLine[dscLine.Count].Chanal := j1;

// Значение параметра этапа
      if not nextLine('VAL', str, result, jLineN) then Exit;
      if not transDbl2(str, 'VAL', result, jLineN, dVal, dMed, dMin, dMax) then Exit;
      dscLine[dscLine.Count].value   := dVal;
      dscLine[dscLine.Count].vaverage:= dMed;
      dscLine[dscLine.Count].vmax    := dMax;
      dscLine[dscLine.Count].vmin    := dMin;
    end;
  end;
end;

function TOreolStages1.transStr(str: TStringList; const sKey: string; var sErr: string;
  nLine: Integer; var sVal: string): boolean;
var
  s0, s1: string;
begin
  result := False;
  if nLine >= str.Count then begin sErr := sErr02; Exit; end;
  s0 := str[nLine];
  s1 := Copy(s0, 1, 3);
  if s1 <> sKey then begin sErr := format(sErr03, [nLine + 1, s0]); Exit; end;
  s1 := Trim(Copy(s0, 5, Length(s0)));
  if Length (s1) = 0 then begin sErr := format(sErr03, [nLine + 1, s0]); Exit; end;
  sVal := s1;
  result := True;
end;

{ TORPNumCStageTab1 }

function TORPNumCStageTab1.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign(PrcdORPNumCStageTab1(ukz1).jColNumber - PrcdORPNumCStageTab1(ukz2).jColNumber) + 2;
     end;
  2: begin
       result := sign(AnsiCompareStr(AnsiLowerCase(PrcdORPNumCStageTab1(ukz1).sLineName),
                                     AnsiLowerCase(PrcdORPNumCStageTab1(ukz2).sLineName))) + 2;
     end;
  3: begin
       result := sign(PrcdORPNumCStageTab1(ukz1).jStgNumber - PrcdORPNumCStageTab1(ukz2).jStgNumber) + 2;
     end;
  4: begin
       result := sign(AnsiCompareStr(AnsiLowerCase(PrcdORPNumCStageTab1(ukz1).sVariantN),
                                                   AnsiLowerCase(PrcdORPNumCStageTab1(ukz2).sVariantN))) + 2;
     end;
  12:begin
       result := sign(PrcdORPNumCStageTab1(ukz1).jColNumber - PrcdORPNumCStageTab1(ukz2).jColNumber);
       if result = 0 then
         result := sign(
  AnsiCompareStr(AnsiLowerCase(PrcdORPNumCStageTab1(ukz1).sLineName),
                 AnsiLowerCase(PrcdORPNumCStageTab1(ukz2).sLineName)));
       Inc(result, 2)
     end;
  32:begin
       result := sign(PrcdORPNumCStageTab1(ukz1).jStgNumber - PrcdORPNumCStageTab1(ukz2).jStgNumber);
       if result = 0 then
         result := sign(
  AnsiCompareStr(AnsiLowerCase(PrcdORPNumCStageTab1(ukz1).sLineName),
                 AnsiLowerCase(PrcdORPNumCStageTab1(ukz2).sLineName)));
       Inc(result, 2)
     end;
  24:begin
       result := sign(
  AnsiCompareStr(AnsiLowerCase(PrcdORPNumCStageTab1(ukz1).sLineName),
                 AnsiLowerCase(PrcdORPNumCStageTab1(ukz2).sLineName)));
       if result = 0 then
         result := sign(
  AnsiCompareStr(AnsiLowerCase(PrcdORPNumCStageTab1(ukz1).sVariantN),
                 AnsiLowerCase(PrcdORPNumCStageTab1(ukz2).sVariantN)));
       Inc(result, 2)
     end;

  else begin result := 0; end;
  end;
end;

constructor TORPNumCStageTab1.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdORPNumCStageTab1);
end;

class function TORPNumCStageTab1.getNumFuncion(const sName: string): TFunNumber;
begin
  if Pos(pc003_05_FunMedNam, AnsiLowerCase(sName)) = 1 then result := nfMedium
  else
  if Pos(pc003_05_FunMltNam, AnsiLowerCase(sName)) = 1 then result := nfMulty
  else
    result := nfParametr;
end;

function TORPNumCStageTab1.GetPntDyn(j: Integer): PrcdORPNumCStageTab1;
begin
  result := GetPnt(j);
end;

{ TORPVariantTab1 }

procedure TORPVariantTab1.addNewVariant(const sV: string);
var
  rS: rcdORPVariantTab1;
begin
  rS.bSearch := False; rS.sVariantN := sV; if Find(@rS, 1) = 0 then Append(@rS);
end;

function TORPVariantTab1.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign(AnsiCompareStr(AnsiLowerCase(PrcdORPVariantTab1(ukz1).sVariantN),
                                     AnsiLowerCase(PrcdORPVariantTab1(ukz2).sVariantN))) + 2;
     end;
  else begin result := 0; end;
  end;
end;

constructor TORPVariantTab1.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdORPVariantTab1);
end;

function TORPVariantTab1.GetPntDyn(j: Integer): PrcdORPVariantTab1;
begin
  result := GetPnt(j);
end;

{ prqTinteger2 }

function prqTinteger2.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
var
  j1: Integer;
begin
//      1 - сравнить по key
//      2 - сравнить по val
//      3 - сравнить по key + val
  case mode of
  1: begin
       j1 := rcdTinteger2(ukz1^).key - rcdTinteger2(ukz2^).key;
     end;
  2: begin
       j1 := rcdTinteger2(ukz1^).val - rcdTinteger2(ukz2^).val;
     end;

  3: begin
       j1 := rcdTinteger2(ukz1^).key - rcdTinteger2(ukz2^).key;
       if j1 = 0 then j1 := rcdTinteger2(ukz1^).val - rcdTinteger2(ukz2^).val;
     end;

  else begin result := 0; Exit; end;
  end;

  if j1 < 0 then result := 1 else if j1 = 0 then result := 2 else result := 3;
end;

constructor prqTinteger2.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTinteger2);
end;

destructor prqTinteger2.Destroy;
begin
  inherited;
end;

function prqTinteger2.GetPntDyn(j: Integer): PrcdTinteger2;
begin
  result := self.GetPnt(j);
end;

{ TORPGrafPageTab1 }

constructor TORPGrafPageTab1.Create;
begin
  param    := prqTparDBrpt2.Create;
  data     := prqTparDataRpt2.Create;
  dataIn   := prqTparDataDBRpt2.Create;

  ParamDat.IntervalCount := 1; // Количество интервалов на графике
  ParamDat.ReperCount    := 1; // Количество реперов на графике
  ParamDat.MarkCount     := 2; // Количество маркеров на графике (1-Начало работ)
end;

destructor TORPGrafPageTab1.Destroy;
begin
  param.Free;
  data.Free;
  dataIn.Free;
  inherited;
end;

{ TORPReportTop1 }

constructor TORPReportTop1.Create;
begin
  modeSrcMestor := 0;
  modeXLSStage  := False;
  modeKRSStage  := False;

  NameRptFile := '';
  NameShbFile := '';
  NameParFile := '';
  NameSpdFile := '';
  sTabStages  := '';
  NameXLSFile := '';

  sMestoRozhd := '';
  sKust       := '';
  sSkvazhina  := '';
  sZadanie    := '';
  sVidRabot   := '';
  sZakazchik  := '';
  sPodrdchik  := '';
end;

destructor TORPReportTop1.Destroy;
begin
end;

{ prqTparDBrpt2 }

function prqTparDBrpt2.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
var
  j1: Integer;
begin
//      1 - сравнить по chanNumber
  case mode of
  1: begin
       j1 := rcdTparDBrpt2(ukz1^).chanNumber - rcdTparDBrpt2(ukz2^).chanNumber;
     end;

  else begin result := 0; Exit; end;
  end;

  if j1 < 0 then result := 1 else if j1 = 0 then result := 2 else result := 3;
end;

constructor prqTparDBrpt2.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTparDBrpt2);
end;

destructor prqTparDBrpt2.Destroy;
begin
  inherited;
end;

function prqTparDBrpt2.GetPntDyn(j: Integer): PrcdTparDBrpt2;
begin
  result := GetPnt(j);
end;

{ prqTparDataRpt2 }

function prqTparDataRpt2.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
begin
  result := 2;
end;

constructor prqTparDataRpt2.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTparDataRpt2);
end;

destructor prqTparDataRpt2.Destroy;
begin
  inherited;
end;

function prqTparDataRpt2.GetPntDyn(j: Integer): PrcdTparDataRpt2;
begin
  result := GetPnt(j);
end;

{ prqTparDataDBRpt2 }

function prqTparDataDBRpt2.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
var
  j1: Integer;
begin
// mode 1 = сравнить WTime:  Double;
  case mode of
  1: begin
       j1 := sign(rcdTparDataDBRpt2(ukz1^).WTime - rcdTparDataDBRpt2(ukz2^).WTime);
     end;

  else begin result := 0; Exit; end;
  end;
  result := j1 + 2;
end;

constructor prqTparDataDBRpt2.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTparDataDBRpt2);
end;

destructor prqTparDataDBRpt2.Destroy;
begin
  inherited;
end;

function prqTparDataDBRpt2.GetPntDyn(j: Integer): PrcdTparDataDBRpt2;
begin
  result := GetPnt(j);
end;

{ TXLS_shab_Param }

function TXLS_shab_Param.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign( AnsiCompareStr(
                           AnsiLowerCase(PrcdXLS_shab_Param(ukz1).sParamName),
                           AnsiLowerCase(PrcdXLS_shab_Param(ukz2).sParamName)
                       )
                 ) + 2;
     end;
  else begin result := 0; end;
  end;
end;

constructor TXLS_shab_Param.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdXLS_shab_Param);
end;

function TXLS_shab_Param.getParam(const sName: string): Integer;
var
  rcd: rcdXLS_shab_Param;
begin
  rcd.sParamName := sName;
  result := Find(@rcd, 1);
end;

function TXLS_shab_Param.GetPntDyn(j: Integer): PrcdXLS_shab_Param;
begin
  result := GetPnt(j);
end;

{ TXLS_shab_Dscrpt }

constructor TXLS_shab_Dscrpt.Create;
begin
  inherited;
  Param := TXLS_shab_Param.Create;
  Table := prqTobject.Create;
end;

destructor TXLS_shab_Dscrpt.Destroy;
begin
  Param.Free;
  Table.Free;
  inherited;
end;

function TXLS_shab_Dscrpt.getTable(const sTabName: string): Integer;
var
  jC1: Integer;
begin
  result := 0;
  for jC1 := 1 to Table.Count do
  begin
    if AnsiLowerCase( (Table[jC1].ukz as TXLS_shab_Table).sTabName ) =
                   AnsiLowerCase(sTabName) then
    begin
      result := jC1;
      Exit;
    end;       
  end;
end;

function TXLS_shab_Dscrpt.newTableCreate: Integer;
var
  rcd: rcdTcontainer;
begin
  rcd.key := 0;
  rcd.ukz := TXLS_shab_Table.Create;
  Table.Append(@rcd);
  result := Table.Count;
end;

{ TXLS_shab_TabDopPar }

function TXLS_shab_TabDopPar.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign( AnsiCompareStr(
                           AnsiLowerCase(PrcdXLS_shab_TabDopPar(ukz1).sTabDopParName),
                           AnsiLowerCase(PrcdXLS_shab_TabDopPar(ukz2).sTabDopParName)
                       )
                 ) + 2;
     end;
  else begin result := 0; end;
  end;
end;

constructor TXLS_shab_TabDopPar.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdXLS_shab_TabDopPar);
end;

function TXLS_shab_TabDopPar.GetPntDyn(j: Integer): PrcdXLS_shab_TabDopPar;
begin
  result := GetPnt(j);
end;

{ TXLS_shab_Table }

constructor TXLS_shab_Table.Create;
begin
  DopPar   := TXLS_shab_TabDopPar.Create;
  NumCols  :=         prqTInteger.Create;
  sParGrid :=         TStringGrid.Create(nil);
end;

destructor TXLS_shab_Table.Destroy;
begin
  DopPar.Free;
  NumCols.Free;
  sParGrid.Free;
  inherited;
end;

{ prqTEtapJob }

function prqTEtapJob.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
begin
  result := 2;
end;

constructor prqTEtapJob.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTEtapJob);
end;

destructor prqTEtapJob.Destroy;
begin
  inherited;
end;

function prqTEtapJob.GetPntDyn(j: Integer): PrcdTEtapJob;
begin
  result := self.GetPnt(j);
end;

{ prqTparDataDBRpt3 }

function prqTparDataDBRpt3.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
var
  j1: Integer;
begin
// mode 1 = сравнить WTime:  Double;
  case mode of
  1: begin
       j1 := sign(rcdTparDataDBRpt3(ukz1^).WTime - rcdTparDataDBRpt3(ukz2^).WTime);
     end;

  else begin result := 0; Exit; end;
  end;
  result := j1 + 2;
end;

constructor prqTparDataDBRpt3.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTparDataDBRpt3);
end;

destructor prqTparDataDBRpt3.Destroy;
begin
  inherited;
end;

function prqTparDataDBRpt3.GetPntDyn(j: Integer): PrcdTparDataDBRpt3;
begin
  result := GetPnt(j);
end;

{ prqTparDataDBRpt5 }

function prqTparDataDBRpt5.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
var
  j1: Integer;
begin
// mode 1 = сравнить WTime:  Double;
  case mode of
  1: begin
       j1 := sign(rcdTparDataDBRpt5(ukz1^).WTime - rcdTparDataDBRpt5(ukz2^).WTime);
     end;

  else begin result := 0; Exit; end;
  end;
  result := j1 + 2;
end;

constructor prqTparDataDBRpt5.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTparDataDBRpt5);
end;

destructor prqTparDataDBRpt5.Destroy;
begin
  inherited;
end;

function prqTparDataDBRpt5.GetPntDyn(j: Integer): PrcdTparDataDBRpt5;
begin
  result := GetPnt(j);
end;

end.
