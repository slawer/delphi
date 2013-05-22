unit uSGTlibDB1;

interface
uses
  Windows, SysUtils, registry, IniFiles, Math, Classes, uAbstrArray,
  uMainData,
  xmldom, XMLIntf, msxmldom, XMLDoc, Variants, uAbstrExcel, uSGTlibDB1Const,
  uOreolDBDirect2, uOreolProtocol6, DB, ADODB;

type


// Класс, описывающий параметры цикла работ,
// каждая из которрых содержит последовательность сеансов
  rcdSGTWorkList =  packed record
    guid: String[38]; // GUID Задания
    Mesto: String[127]; // Месторождение
    Kust: String[127]; // Куст
    Skvzh: String[127]; // Скважина
    Works: String[127]; // Задание на работу
    startTime: TDateTime; // Дата создания задания
    starting_depth: double; // Старторвая глубина
    customer: String[127]; // Заказчик
    performer: String[127]; // Исполнитель
    actived: boolean; // Активное задание
  end;
  PrcdSGTWorkList = ^rcdSGTWorkList;

  TSGTWorkList = class(prqTabstract1)
  private
    function    GetPntDyn(j: Integer): PrcdSGTWorkList;
  protected
    function  Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
  public
    property    pntDyn[j:Integer]: PrcdSGTWorkList read GetPntDyn; default;
    procedure   Clone(Source: TSGTWorkList);

    // Проверить структуру
    // Если в работе несколько активных - оставить активной последнюю
    // Если в работе нет активных - сделать активной последнюю
    procedure   CheckActiveWork;
    function    GetActiveWork: Integer;
    function    GetDescriptFromGuid(const sG: string): string;

    class procedure clearRecord(var rcd: rcdSGTWorkList);
    constructor Create;
    destructor  Destroy; override;
  end;
// =================================================


// Класс, содержащий список сеансов, рассортированный по номеру сеанса
  rcdSGTReisList =  packed record
    numbReis: integer; // Номер рейса
    description: string[127]; // Описание реса
    dtCreate: TDateTime; // Дата создания рейса
    GUIDwrk: String[38]; // GUID Задания (обратная ссылка)
    DBaseName: String[127]; // Имя БД
    include: Boolean; // включить БД в запрос
    actived: Boolean; // включить БД в запрос
  end;
  PrcdSGTReisList = ^rcdSGTReisList;

  TSGTReisList = class(prqTabstract1)
  private
    function    GetPntDyn(j: Integer): PrcdSGTReisList;
  protected
    function  Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
  public
    property    pntDyn[j:Integer]: PrcdSGTReisList read GetPntDyn; default;
    procedure   Clone(Source: TSGTReisList);

    // Проверить структуру
    // Если в работе несколько активных - оставить активной последнюю
    // Если в работе нет активных - сделать активной последнюю
    procedure   CheckActiveReis;

    class procedure clearRecord(var rcd: rcdSGTReisList);
    constructor Create;
    destructor  Destroy; override;
  end;
// =================================================


// Описание параметров БД
  rcdSGTtableList =  packed record
    numbParam: integer; // Номер параметра
    nameParam: String[63]; // имя параметра // 'name';
    desc: String[7]; // короткое имя параметра // 'desc';
    typeParam: String[7]; // единица измерения // 'units';
    GUIDParam: String[38]; // GUID параметра // 'guid';
    dtCreate: TDateTime; // Дата создания таблицы
    dtFirstRcd: TDateTime; // Дата вывода 1-й записи в таблицу
    dtLastRcd: TDateTime; // Дата вывода последней записи в таблицу
    bSaveDB: boolean; // Признак сохранения в БД // 'issavetodb';
    devmanindex: integer; // Номер параметра в devman // devmanindex
    devmandescription: String[63]; // имя параметра в devman // 'devmandescription';
    decimal_points: integer; // количество знаков после запятой // decimal_points

  end;
  PrcdSGTtableList = ^rcdSGTtableList;

  TSGTTableList = class(prqTabstract1)
  private
    function    GetPntDyn(j: Integer): PrcdSGTtableList;
  protected
    function  Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
  public
    property    pntDyn[j:Integer]: PrcdSGTtableList read GetPntDyn; default;
    procedure   Clone(Source: TSGTTableList);
    class procedure clearRecord(var rcd: rcdSGTtableList);
    constructor Create;
    destructor  Destroy; override;
  end;
// =================================================

{
  arrLPTSTR = array [1..256] of LPTSTR;           ParrLPTSTR = ^arrLPTSTR;
  arrParamNumber = array[1..256] of Integer;      ParrParamNumber = ^arrParamNumber;
}

  SGTlibDB1 = class(prqTTaskObject)
  private
    FPathToTree: string;
    FConnectCount: integer;
    function AddNewField(numPar, jChNum: integer; dCrnt, hCrnt: Double; const sF: string): string;
    procedure SetPathToTree(const Value: string);
    procedure SetConnectCount(const Value: integer);

  public
    sErr: string; // Строка с текстом последней ошибки
    cnfDbdParamName:      string;   // Имя файла с конфигурацией базы данных (описание СГТ)
    cnfDbdWorksName:      string;   // Имя файла с конфигурацией проведённых работ

    oreolDB: TOreolDBDirect2; // БД
    WorkList: TSGTWorkList;
    ReisList: TSGTReisList;
//    DopDBList: TSGTReisList;
    TableList: TSGTTableList;
    QueryList: TSGTReisList;

// Настройки БД пользователя
    gbl_DBUserName: String[37]; // Имя пользователя
    gbl_DBUserPass: String[37]; // Пароль пользователя пользователя
    gbl_DataSource: String[127]; // Ссылка на строку источник данных

// Настройки БД из СГТ
    sgt_DBUserName: String[37]; // Имя пользователя
    sgt_DBUserPass: String[37]; // Пароль пользователя пользователя
    sgt_DataSource: String[127]; // Ссылка на строку источник данных

    bServProj: boolean; // True == ссылка на сервер берётся из настроек проекта иначе - вводится из формы настроек

    property PathToTree: string read FPathToTree write SetPathToTree;
    property ConnectCount: integer read FConnectCount write SetConnectCount;

    procedure   Clone(Source: SGTlibDB1);

    // Запрос к БД по интервалу времени на список параметров
    // Возвращает код завершения из списка
    function CreateDataFileByTime(
      ParameterID: prqTInteger;        // Список запрашиваемых параметров (определяет их последовательность при выводе)
      valExport: prqTabsField;         // Класс - приёмник значений параметров из базы данных
      const StartDateTime: Double;     // Начало интервала
      const StopDateTime: Double;      // Конец интервала
      const EmptyValue: single         // Значение при отсутствии параметра (не регистрировался)
    ): Integer;
    //   0 - нормальное завершение программы
    //   1 - Считана часть данных, были ошибки
    //  11 - Дата начала интервала больше даты окончания интервала
    //  12 - Не удалось соединиться с БД
    // 101 - прерывание при работе со списком параметров
    // 102 - Список параметров запроса пуст
    // 103 - В буфере для параметров нет места для данных (число столбцов меньше 4)
    // 111 - прерывание при запросе к БД

    function  LibInit(ADOConnection1: TADOConnection; const vPathToTree: string): Boolean;
    function  getDataSource: string;
    procedure getDataBaseTuning(var sDBUserName, sDBUserPass, sDataSource: string);
    procedure addError(const s1: string);

    function  dbdWorkLoad(XMLDocument1: TXMLDocument): Integer;
    function  dbdWkTranslator(XmlNode: IXMLNode): boolean;
    function  dbdWkTranslator2(XmlNode: IXMLNode): boolean; // Разбор узла work
    function  dbdWkTranslator3(XmlNode: IXMLNode; const wrk: rcdSGTWorkList): boolean; // Разбор узла sessions
    function  dbdWkTranslator4(XmlNode: IXMLNode; const wrk: rcdSGTWorkList): boolean; // Разбор узла session

    function  dbdParamLoad(XMLDocument1: TXMLDocument): Integer;
    function  dbdPmTranslator(XmlNode: IXMLNode): boolean;
    function  dbdPmTranslator2(XmlNode: IXMLNode): boolean; // Разбор узла commutator
    function  dbdPmTranslator3(XmlNode: IXMLNode): boolean; // Разбор узла parameters
    function  dbdPmTranslator4(XmlNode: IXMLNode; var jNumber: integer): boolean; // Разбор узла parameter
    function  dbdPmTranslator5(XmlNode: IXMLNode): boolean; // Разбор узла data_base

    constructor Create;
    destructor  Destroy; override;
  end;


implementation
uses uSupport;

{ SGTlibDB1 }

constructor SGTlibDB1.Create;
begin
  inherited;
  gbl_DBUserName := 'sa';
  gbl_DBUserPass := '';
  gbl_DataSource := '';

  sgt_DBUserName := 'sa';
  sgt_DBUserPass := '';
  sgt_DataSource := '';

  cnfDbdParamName := '';
  ConnectCount := 1;
  self.oreolDB := nil;
  WorkList := TSGTWorkList.Create;
  ReisList := TSGTReisList.Create;
  QueryList := TSGTReisList.Create;
//  DopDBList := TSGTReisList.Create;
  TableList := TSGTTableList.Create;
end;

destructor SGTlibDB1.Destroy;
begin
  if Assigned(self.oreolDB) then
  begin
    self.oreolDB.disConnectDB(0);
    self.oreolDB.Free;
  end;
  WorkList.Free;
  ReisList.Free;
//  DopDBList.Free;
  TableList.Free;
  QueryList.Free;
  inherited;
end;

function SGTlibDB1.LibInit(ADOConnection1: TADOConnection; const vPathToTree: string): Boolean;
var
  jC1: integer;
  rcd: rcdSGTtableList;
begin
  self.oreolDB := TOreolDBDirect2.Create;
  self.oreolDB.setDBType(ADOConnection1);
  self.FPathToTree := vPathToTree;

  // Процедура чтения структуры дерева проектов и составления описания

  // Формирование списка работ
  //  WorkList: TSGTWorkList;
  // ==============================================

  // Формирование списка рейсов
  ReisList.Count := 0;

  // ==============================================
  // Формирование списка таблиц (параметров)
  TableList.Count := 256;
  TSGTtableList.clearRecord(rcd);
  for jC1 := 1 to TableList.Count do
  begin
    rcd.numbParam := jC1;
    TableList[jC1]^ := rcd;
  end;

  // ==============================================
  result := true;
end;

procedure SGTlibDB1.addError(const s1: string);
begin
  if (Length(sErr) > 0)  and  (Length(s1) > 0) then sErr := sErr + #13#10;
  sErr := sErr + s1;
end;

function SGTlibDB1.AddNewField(numPar, jChNum: integer; dCrnt,
  hCrnt: Double; const sF: string): string;
var
  d1: Double;
begin
  case numPar of
    1: result := formatDateTime('dd.mm.yyyy hh:nn:ss', dCrnt);
    2: result := format(sF, [hCrnt]);
  else
    begin
      d1 := jChNum;
      result := format(sF, [d1]);
    end;
  end;
end;

procedure SGTlibDB1.SetPathToTree(const Value: string);
begin
  FPathToTree := Value;
end;

procedure SGTlibDB1.Clone(Source: SGTlibDB1);
begin
  if not Assigned(Source) then Exit;
  FPathToTree := Source.FPathToTree;
  sErr := Source.sErr;
  cnfDbdParamName := Source.cnfDbdParamName;

  gbl_DBUserName := Source.gbl_DBUserName;
  gbl_DBUserPass := Source.gbl_DBUserPass;
  gbl_DataSource := Source.gbl_DataSource;

  sgt_DBUserName := Source.sgt_DBUserName;
  sgt_DBUserPass := Source.sgt_DBUserPass;
  sgt_DataSource := Source.sgt_DataSource;

  ConnectCount := Source.ConnectCount;

  oreolDB := Source.oreolDB;

  WorkList.Clone(Source.WorkList);
  ReisList.Clone(Source.ReisList);
  QueryList.Clone(Source.QueryList);
//  DopDBList.Clone(Source.DopDBList);
  TableList.Clone(Source.TableList);
end;

function SGTlibDB1.CreateDataFileByTime(
      ParameterID: prqTInteger;        // Список запрашиваемых параметров (определяет их последовательность при выводе)
      valExport: prqTabsField;         // Класс - приёмник значений параметров из базы данных
      const StartDateTime: Double;     // Начало интервала
      const StopDateTime: Double;      // Конец интервала
      const EmptyValue: single         // Значение при отсутствии параметра (не регистрировался)
    ): Integer;
var
  bFind, bItog, bRes: Boolean;
  rcdTList: rcdSGTtableList;
  j1, jCprm2, jCprm1, jPrm1, jPrm2, jC2, jC1, procResult: Integer;
  cnctMsg: TOP_ErrorMsg;
  s1, _sErr: string;
  _valExport: prqTabsField; // Внутренний клас для приёма данных запроса
  _ParameterID: prqTInteger; // Внутренний клас для формирования списка парамтеров на основании GUID
  dt1, dt2: TDateTime;
  sDBUserName, sDBUserPass, sDataSource: string;
begin
  result := 0;
  bItog := true;
//  self.sErr := '';

  if StopDateTime <= StartDateTime then
  begin
    self.sErr := pc006_501_Err1;
    result := 11;
    Exit;
  end;

  _valExport := prqTabsField.Create;
  try
    _valExport.clrField;
    for jC2 := 1 to valExport.listField.Count do
    begin
      case jC2 of // Тип параметра
        1:
           _valExport.addField(uAbstrArray.ftInteger, 0); // индекс - Integer
        2:
           _valExport.addField(uAbstrArray.ftDouble, 0); // Время - Double

      else
           _valExport.addField(uAbstrArray.ftSingle, 0); // Прочие - Single по умолчанию
      end;
    end;


    for jC1 := 1 to self.QueryList.Count do
    begin

      if not self.QueryList[jC1].include then
      begin
        dt1 := self.QueryList[jC1].dtCreate;
        if dt1 >= StopDateTime then continue;
        if jC1 < self.QueryList.Count then
        begin
          dt2 := self.QueryList[jC1+1].dtCreate;
          if dt2 <= StartDateTime then continue;
        end;
      end;

        // 1. Соединиться с БД
      self.getDataBaseTuning(sDBUserName, sDBUserPass, sDataSource);

      bRes := self.oreolDB.ConnectDB(
                sDBUserName, // self.gbl_DBUserName,
                sDBUserPass, // self.gbl_DBUserPass,
                sDataSource, // self.gbl_DataSource,
                self.QueryList[jC1].DBaseName,
                cnctMsg,
                0);

      if not bRes then
      begin
        result := 12;
        if self.QueryList[jC1].numbReis < 0 then
        begin
          s1 := format(pc006_501_003, [self.QueryList[jC1].DBaseName]);
        end
        else
        begin
          s1 := format(pc006_501_001, [self.QueryList[jC1].numbReis, self.QueryList[jC1].DBaseName]);
        end;
        self.addError( s1 );
        bItog := false;
        continue;
      end;

      _valExport.Count := 0;

      _ParameterID := prqTInteger.Create();
      try

        // Подготовить список параметров
        for jCprm1 := 1 to ParameterID.Count do
        begin
          bFind := false;
          rcdTList.numbParam := ParameterID[jCprm1]^;
          jPrm1 := self.TableList.Find(@rcdTList, 1); // Поиск параметра в списке таблиц
          if jPrm1 > 0 then
          begin
            s1 := self.TableList[jPrm1].GUIDParam;
            for jCprm2 := 1 to self.oreolDB.tab_Main.Count do
            begin
              if self.oreolDB.tab_Main[jCprm2].tab_guid = s1 then
              begin
                _ParameterID.Append( @(self.oreolDB.tab_Main[jCprm2].numbe_prm) );
                bFind := true;
                break;
              end;
            end;
          end;
          if not bFind then
          begin
            j1 := -1;
            _ParameterID.Append( @j1 );
          end;
        end;

        // Вызов процедуры чтения из БД
        procResult := self.oreolDB.GetDataFromDateTime(_ParameterID, _valExport, StartDateTime, StopDateTime, 0, EmptyValue, _sErr);
      finally
        _ParameterID.Free();
      end;

      if self.oreolDB.isConnected then
      begin // Разорвать существующее соединение
        try
          self.oreolDB.disConnectDB(0);
        except
        end;
      end;

      case procResult of
        0:
        begin
          if _valExport.Count > 0 then
          begin
            for jC2 := 1 to _valExport.Count do
            begin
              valExport.Append(_valExport[jC2]);
              valExport.ReSortFast(2, valExport.Count);
            end;
          end;
          continue;
        end;
        1:
        begin
          self.sErr := _sErr;
          result := 101;
          Exit;
        end;
        2:
        begin
          self.sErr := _sErr;
          result := 102;
          Exit;
        end;
        3:
        begin
          self.sErr := _sErr;
          result := 103;
          Exit;
        end;
      else
        begin
          // 111 - прерывание при запросе к БД
          if self.QueryList[jC1].numbReis < 0 then
          begin
            s1 := format(pc006_501_004, [_sErr, self.QueryList[jC1].DBaseName]);
          end
          else
          begin
            s1 := format(pc006_501_002, [_sErr, self.QueryList[jC1].numbReis, self.QueryList[jC1].DBaseName]);
          end;
          self.addError(s1);
          bItog := false;
        end;
      end;
    end;

    if valExport.Count > 0 then
    begin
      if bItog then
      begin
        result := 0;
      end
      else
      begin
        result := 1;
      end;
    end;

  finally
    _valExport.Free;
  end;
end;

procedure SGTlibDB1.SetConnectCount(const Value: integer);
begin
  FConnectCount := Value;
end;

function SGTlibDB1.getDataSource: string;
begin
  if self.bServProj then
  begin
    result := self.sgt_DataSource;
  end
  else
  begin
    result := self.gbl_DataSource;
  end;
end;

function SGTlibDB1.dbdParamLoad(XMLDocument1: TXMLDocument): Integer;
begin
  result := 0;
  self.sErr := '';

  if not FileExists(self.cnfDbdParamName) then
  begin
    self.sErr := pc006_501_DBDerr_001;
    result := -1; // Не найден файл с описаним конфигурации БД
    Exit;
  end;

  try
    XMLDocument1.LoadFromFile(self.cnfDbdParamName);

    try

      if not self.dbdPmTranslator(XMLDocument1.DocumentElement) then
      begin
        result := 1;
      end;

    except
      on E: Exception do begin
        self.sErr := format(pc006_501_DBDerr_002, [E.Message]);
        result := -2;
        exit;
      end;
    end;

  except
    on E: Exception do begin
      self.sErr := pc006_501_DBDerr_003;
      result := -1;
      exit;
    end;
  end;
end;

function SGTlibDB1.dbdPmTranslator(XmlNode: IXMLNode): boolean;
var
  jC1: Integer;
  ChildNode: IXMLNode;
  s1: string;
begin
  result := false;
  self.sErr := '';
  try

// Разборка узла
    if XmlNode.NodeName = pc006_501_xmlDBD_001 then
    begin


// Разбор конфигурации
      for jC1 := 1 to xmlNode.ChildNodes.Count do
      begin

        ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
        s1 := AnsiLowerCase(ChildNode.NodeName);
        if s1 = pc006_501_xmlDBD_002a then
        begin
// Разборка настройка Баз Данных
          result := self.dbdPmTranslator5(ChildNode);
          if not result then Exit;
          continue;
        end;

        if s1 = pc006_501_xmlDBD_005 then
        begin
// Разборка списка параметров
          result := self.dbdPmTranslator2(ChildNode);
          if not result then Exit;
          continue;
        end;
      end;

    end
    else
    begin
      self.sErr := pc006_501_DBDerr_004;
    end;

  except
    on E: Exception do
    begin
      self.sErr := E.Message;
    end;
  end;
end;

function SGTlibDB1.dbdPmTranslator2(XmlNode: IXMLNode): boolean;
var
  jC1: Integer;
  ChildNode: IXMLNode;
  s1: string;
begin
  result := false;
  self.sErr := '';
  try

// Разборка узла
    for jC1 := 1 to xmlNode.ChildNodes.Count do
    begin
      ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
      s1 := AnsiLowerCase(ChildNode.NodeName);
      if s1 = pc006_501_xmlDBD_006 then
      begin
        result := self.dbdPmTranslator3(ChildNode);
        Exit;
      end;
    end;

  except
    on E: Exception do
    begin
      self.sErr := E.Message;
    end;
  end;
end;

function SGTlibDB1.dbdPmTranslator3(XmlNode: IXMLNode): boolean;
var
  jNumber, jC1: Integer;
  ChildNode: IXMLNode;
  s1: string;
begin
  result := false;
  self.sErr := '';
  try

// Разборка узла
    jNumber := 0;
    for jC1 := 1 to xmlNode.ChildNodes.Count do
    begin
      ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
      s1 := AnsiLowerCase(ChildNode.NodeName);
      if s1 = pc006_501_xmlDBD_007 then
      begin
        Inc(jNumber);
        result := self.dbdPmTranslator4(ChildNode, jNumber);
        if not result then
        begin
          Exit;
        end;
      end;
    end;

  except
    on E: Exception do
    begin
      self.sErr := E.Message;
    end;
  end;
end;

function SGTlibDB1.dbdPmTranslator4(XmlNode: IXMLNode;
  var jNumber: integer): boolean;
var
  j1, jC1: Integer;
  ChildNode: IXMLNode;
  s1: string;
  rcd: rcdSGTtableList;
begin
  result := false;
  self.sErr := '';
  TSGTTableList.clearRecord(rcd);
  rcd.numbParam := jNumber;
  try

// Разборка узла
    for jC1 := 1 to xmlNode.ChildNodes.Count do
    begin
      ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
      s1 := AnsiLowerCase(ChildNode.NodeName);

      if s1 = pc006_501_xmlDBD_008 then
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.nameParam := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_009 then
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.desc := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_010 then
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.typeParam := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_011 then
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          if AnsiLowerCase(ChildNode.NodeValue) = 'false' then
          begin
            rcd.bSaveDB := false;
          end
          else
          begin
            rcd.bSaveDB := true;
          end;
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_012 then
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          if uSupport.prqStrToInt(ChildNode.NodeValue, j1) then
          begin
            rcd.devmanindex := j1;
          end;
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_013 then
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.devmandescription := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_014 then
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          if uSupport.prqStrToInt(ChildNode.NodeValue, j1) then
          begin
            rcd.decimal_points := j1;
          end;
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_015 then
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.GUIDParam := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;
    end;

    j1 := self.TableList.Find(@rcd, 1);
    if j1 > 0 then
    begin
      self.TableList[j1]^ := rcd;
    end;

    result := true;

  except
    on E: Exception do
    begin
      self.sErr := E.Message;
    end;
  end;
end;

function SGTlibDB1.dbdWorkLoad(XMLDocument1: TXMLDocument): Integer;
begin
  result := 0;
  self.sErr := '';

  if not FileExists(self.cnfDbdWorksName) then
  begin
    self.sErr := pc006_501_DBDerr_005;
    result := -1; // Не найден файл с описанием проведённых работ
    Exit;
  end;

  self.ReisList.Count := 0;

  try
    XMLDocument1.LoadFromFile(self.cnfDbdWorksName);

    try

      if not self.dbdWkTranslator(XMLDocument1.DocumentElement) then
      begin
        result := 1;
      end;

      self.WorkList.CheckActiveWork();
      self.ReisList.CheckActiveReis();

    except
      on E: Exception do begin
        self.sErr := format(pc006_501_DBDerr_002, [E.Message]);
        result := -2;
        exit;
      end;
    end;

  except
    on E: Exception do begin
      self.sErr := pc006_501_DBDerr_003;
      result := -1;
      exit;
    end;
  end;
end;

function SGTlibDB1.dbdWkTranslator(XmlNode: IXMLNode): boolean;
var
  jC1: Integer;
  ChildNode: IXMLNode;
  s1: string;
begin
  result := false;
  self.sErr := '';
  try

// Разборка узла
    if XmlNode.NodeName = pc006_501_xmlDBD_051 then
    begin

// Разбор конфигурации
      for jC1 := 1 to xmlNode.ChildNodes.Count do
      begin
        ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
        s1 := AnsiLowerCase(ChildNode.NodeName);

        if s1 = pc006_501_xmlDBD_052 then // Разборка списка работ
        begin
          result := self.dbdWkTranslator2(ChildNode);
          if not result then Exit;
          continue;
        end;
      end;

    end
    else
    begin
      self.sErr := pc006_501_DBDerr_006;
    end;

  except
    on E: Exception do
    begin
      self.sErr := E.Message;
    end;
  end;
end;

function SGTlibDB1.dbdWkTranslator2(XmlNode: IXMLNode): boolean;
var
  jC1: Integer;
  ChildNode: IXMLNode;
  SessionsNode: IXMLNode;
  s1: string;
  rcd: rcdSGTWorkList;
begin
  result := false;
  self.sErr := '';
  TSGTWorkList.clearRecord(rcd);
  try

// Разборка узла
    SessionsNode := nil;
    for jC1 := 1 to xmlNode.ChildNodes.Count do
    begin
      ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
      s1 := AnsiLowerCase(ChildNode.NodeName);

      if s1 = pc006_501_xmlDBD_053 then //  = 'field';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.Mesto := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_054 then // = 'bush';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.Kust := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_055 then // = 'well';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.Skvzh := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_056 then // = 'customer';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.customer := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_057 then // = 'performer';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.performer := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_058 then // = 'comment';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.Works := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_059 then // = 'starttime';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.startTime := StrToDateTime(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_060 then // = 'starting_depth';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.starting_depth := StrToFloat(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_061 then // = 'guid';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.guid := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_062 then // = 'actived';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          if AnsiLowerCase(ChildNode.NodeValue) = 'false' then
          begin
            rcd.actived := false;
          end
          else
          begin
            rcd.actived := true;
          end;
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_063 then // = 'sessions';
      begin
        SessionsNode := ChildNode;
        continue;
      end;
    end;

    self.WorkList.Append(@rcd);

    if Assigned(SessionsNode) then
    begin
      result := dbdWkTranslator3(SessionsNode, rcd);
    end
    else
    begin
      result := true;
    end;

  except
    on E: Exception do
    begin
      self.sErr := E.Message;
    end;
  end;
end;

function SGTlibDB1.dbdWkTranslator3(XmlNode: IXMLNode;
  const wrk: rcdSGTWorkList): boolean;
var
  jC1: Integer;
  ChildNode: IXMLNode;
  s1: string;
begin
  result := false;
  try

// Разборка узла
    for jC1 := 1 to xmlNode.ChildNodes.Count do
    begin
      ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
      s1 := AnsiLowerCase(ChildNode.NodeName);

      if s1 = pc006_501_xmlDBD_064 then //  = 'session';
      begin
        result := dbdWkTranslator4(ChildNode, wrk);
        if not result then
        begin
          Exit;
        end;
        continue;
      end;

    end;

  except
    on E: Exception do
    begin
      self.sErr := E.Message;
    end;
  end;
end;

function SGTlibDB1.dbdWkTranslator4(XmlNode: IXMLNode;
  const wrk: rcdSGTWorkList): boolean;
var
  jC1: Integer;
  ChildNode: IXMLNode;
  s1: string;
  rcd: rcdSGTReisList;
begin
  result := false;
  self.sErr := '';
  TSGTReisList.clearRecord(rcd);
  try

// Разборка узла
    for jC1 := 1 to xmlNode.ChildNodes.Count do
    begin
      ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
      s1 := AnsiLowerCase(ChildNode.NodeName);

      if s1 = pc006_501_xmlDBD_065 then //  = 'number';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.numbReis := StrToInt(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_066 then //  = 'description';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.description := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 =   pc006_501_xmlDBD_067 then // = 'date_time';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.dtCreate := StrToDateTime(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_068 then // = 'actived';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          if AnsiLowerCase(ChildNode.NodeValue) = 'false' then
          begin
            rcd.actived := false;
          end
          else
          begin
            rcd.actived := true;
          end;
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_069 then // = 'data_base';
      begin
        if not (ChildNode.NodeValue = Null) then
        begin
          rcd.DBaseName := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;
    end;

    rcd.GUIDwrk := wrk.guid;
    self.ReisList.Append(@rcd);

    result := true;

  except
    on E: Exception do
    begin
      self.sErr := E.Message;
    end;
  end;
end;

function SGTlibDB1.dbdPmTranslator5(XmlNode: IXMLNode): boolean;
var
  jC1: Integer;
  ChildNode: IXMLNode;
  s1: string;
begin
  result := true;
  self.sErr := '';
  try

// Разборка узла
    for jC1 := 1 to xmlNode.ChildNodes.Count do
    begin
      ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
      s1 := AnsiLowerCase(ChildNode.NodeName);

      if s1 = pc006_501_xmlDBD_002 then
      begin
        if ChildNode.NodeValue = Null then
        begin
          self.sgt_DataSource := '';
        end
        else
        begin
          self.sgt_DataSource := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_003 then
      begin
        if ChildNode.NodeValue = Null then
        begin
          self.sgt_DBUserName := 'sa';
        end
        else
        begin
          self.sgt_DBUserName := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

      if s1 = pc006_501_xmlDBD_004 then
      begin
        if ChildNode.NodeValue = Null then
        begin
          self.sgt_DBUserPass := '';
        end
        else
        begin
          self.sgt_DBUserPass := Trim(ChildNode.NodeValue);
        end;
        continue;
      end;

    end;

  except
    on E: Exception do
    begin
      result := false;
      self.sErr := E.Message;
    end;
  end;
end;

procedure SGTlibDB1.getDataBaseTuning(var sDBUserName, sDBUserPass,
  sDataSource: string);
begin
  if self.bServProj then
  begin
    sDBUserName := self.sgt_DBUserName;
    sDBUserPass := self.sgt_DBUserPass;
    sDataSource := self.sgt_DataSource;
  end
  else
  begin
    sDBUserName := self.gbl_DBUserName;
    sDBUserPass := self.gbl_DBUserPass;
    sDataSource := self.gbl_DataSource;
  end;
end;

{ TSGTWorkList }

function TSGTWorkList.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
var
  s1, s2: string;
  j1, j2: integer;
begin
  case mode of
  1: begin
       s1 := AnsiUpperCase(PrcdSGTWorkList(ukz1).guid);
       s2 := AnsiUpperCase(PrcdSGTWorkList(ukz2).guid);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  2: begin
       s1 := AnsiUpperCase(PrcdSGTWorkList(ukz1).Mesto);
       s2 := AnsiUpperCase(PrcdSGTWorkList(ukz2).Mesto);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  3: begin
       s1 := AnsiUpperCase(PrcdSGTWorkList(ukz1).Kust);
       s2 := AnsiUpperCase(PrcdSGTWorkList(ukz2).Kust);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  4: begin
       s1 := AnsiUpperCase(PrcdSGTWorkList(ukz1).Skvzh);
       s2 := AnsiUpperCase(PrcdSGTWorkList(ukz2).Skvzh);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  5: begin
       s1 := AnsiUpperCase(PrcdSGTWorkList(ukz1).Works);
       s2 := AnsiUpperCase(PrcdSGTWorkList(ukz2).Works);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  6: begin
       result := sign( PrcdSGTWorkList(ukz1).startTime - PrcdSGTWorkList(ukz2).startTime );
     end;
  7: begin
       result := sign( PrcdSGTWorkList(ukz1).starting_depth - PrcdSGTWorkList(ukz2).starting_depth );
     end;
  8: begin
       s1 := AnsiUpperCase(PrcdSGTWorkList(ukz1).customer);
       s2 := AnsiUpperCase(PrcdSGTWorkList(ukz2).customer);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  9: begin
       s1 := AnsiUpperCase(PrcdSGTWorkList(ukz1).performer);
       s2 := AnsiUpperCase(PrcdSGTWorkList(ukz2).performer);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
 10: begin
       if PrcdSGTWorkList(ukz1).actived then j1 := 1 else j1 := 0;
       if PrcdSGTWorkList(ukz2).actived then j2 := 1 else j2 := 0;
       result := sign( j1 - j2 );
     end;
  else
    result := 0;
  end;
  Inc(result, 2);
end;

procedure TSGTWorkList.CheckActiveWork;
var
  jAct, jC1: integer;
begin
  if self.Count = 0 then Exit;

  jAct := 0;

  for jC1 := 1 to self.Count do
  begin
    if self[jC1].actived then
    begin
      if jAct > 0 then
      begin
        self[jC1].actived := false;
      end;
      jAct := jC1;
    end;
  end;

  if jAct = 0 then
  begin
    self[self.Count].actived := true;
  end;
end;

class procedure TSGTWorkList.clearRecord(var rcd: rcdSGTWorkList);
begin
  rcd.guid := '';
  rcd.Mesto := '';
  rcd.Kust := '';
  rcd.Skvzh := '';
  rcd.Works := '';
  rcd.startTime := 0;
  rcd.starting_depth := 0;
  rcd.customer := '';
  rcd.performer := '';
  rcd.actived := false;
end;

procedure TSGTWorkList.Clone(Source: TSGTWorkList);
begin
  if not Assigned(Source) then Exit;
  inherited Clone(Source);
end;

constructor TSGTWorkList.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdSGTWorkList);
end;

destructor TSGTWorkList.Destroy;
begin
  inherited;
end;

function TSGTWorkList.GetActiveWork: Integer;
var
  jC1: integer;
begin
  result := self.Count;
  if result = 0 then Exit;

  result := 0;
  for jC1 := 1 to self.Count do
  begin
    if self[jC1].actived then
    begin
      if result > 0 then
      begin
        self[jC1].actived := false;
      end;
      result := jC1;
    end;
  end;

  if result = 0 then
  begin
    self[self.Count].actived := true;
    result := self.Count;
  end;
end;

function TSGTWorkList.GetDescriptFromGuid(const sG: string): string;
var
  jC1: Integer;
begin
  result := '';
  for jC1 := 1 to self.Count do
  begin
    if sG = self[jC1].guid then
    begin
      result := self[jC1].Works;
      Exit;
    end;
  end;
end;

function TSGTWorkList.GetPntDyn(j: Integer): PrcdSGTWorkList;
begin
  result := GetPnt(j);
end;

{ TSGTReisList }

function TSGTReisList.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
var
  s1, s2: string;
  j1, j2: integer;
begin
  case mode of
  1: begin
       result := sign( PrcdSGTReisList(ukz1).numbReis - PrcdSGTReisList(ukz2).numbReis );
     end;
  2: begin
       s1 := AnsiUpperCase(PrcdSGTReisList(ukz1).description);
       s2 := AnsiUpperCase(PrcdSGTReisList(ukz2).description);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  3: begin
       result := sign( PrcdSGTReisList(ukz1).dtCreate - PrcdSGTReisList(ukz2).dtCreate );
     end;
  4: begin
       s1 := AnsiUpperCase(PrcdSGTReisList(ukz1).GUIDwrk);
       s2 := AnsiUpperCase(PrcdSGTReisList(ukz2).GUIDwrk);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  5: begin
       s1 := AnsiUpperCase(PrcdSGTReisList(ukz1).DBaseName);
       s2 := AnsiUpperCase(PrcdSGTReisList(ukz2).DBaseName);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  6: begin
       if PrcdSGTReisList(ukz1).include then j1 := 1 else j1 := 0;
       if PrcdSGTReisList(ukz2).include then j2 := 1 else j2 := 0;
       result := sign( j1 - j2 );
     end;
  7: begin
       if PrcdSGTReisList(ukz1).actived then j1 := 1 else j1 := 0;
       if PrcdSGTReisList(ukz2).actived then j2 := 1 else j2 := 0;
       result := sign( j1 - j2 );
     end;
  else
    result := 0;
  end;
  Inc(result, 2);
end;

procedure TSGTReisList.CheckActiveReis;
var
  jAct, jC1: integer;
  s1: string;
begin
  if self.Count = 0 then Exit;

  s1 := self[1].GUIDwrk;
  jAct := 0;

  for jC1 := 1 to self.Count do
  begin
    if s1 = self[jC1].GUIDwrk then
    begin
      if self[jC1].actived then
      begin
        if jAct > 0 then
        begin
          self[jC1].actived := false;
        end;
        jAct := jC1;
      end;
    end
    else
    begin
      if jAct = 0 then
      begin
        self[jC1-1].actived := true;
      end;
      s1 := self[jC1].GUIDwrk;
      if self[jC1].actived then
      begin
        jAct := jC1;
      end
      else
      begin
        jAct := 0;
      end;
    end;
  end;

  if jAct = 0 then
  begin
    self[self.Count].actived := true;
  end;
end;

class procedure TSGTReisList.clearRecord(var rcd: rcdSGTReisList);
begin
  rcd.numbReis := 0;
  rcd.description := '';
  rcd.dtCreate := 0;
  rcd.GUIDwrk := '';
  rcd.DBaseName := '';
  rcd.include := false;
  rcd.actived := false;
end;

procedure TSGTReisList.Clone(Source: TSGTReisList);
begin
  if not Assigned(Source) then Exit;
  inherited Clone(Source);
end;

constructor TSGTReisList.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdSGTReisList);
end;

destructor TSGTReisList.Destroy;
begin
  inherited;
end;

function TSGTReisList.GetPntDyn(j: Integer): PrcdSGTReisList;
begin
  result := GetPnt(j);
end;

{ TSGTTableList }

function TSGTTableList.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
var
  s1, s2: string;
  j1, j2: integer;
begin
  case mode of
  1: begin
       result := sign( PrcdSGTTableList(ukz1).numbParam - PrcdSGTTableList(ukz2).numbParam );
     end;
  2: begin
       s1 := AnsiUpperCase(PrcdSGTTableList(ukz1).nameParam);
       s2 := AnsiUpperCase(PrcdSGTTableList(ukz2).nameParam);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  3: begin
       s1 := AnsiUpperCase(PrcdSGTTableList(ukz1).desc);
       s2 := AnsiUpperCase(PrcdSGTTableList(ukz2).desc);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  4: begin
       s1 := AnsiUpperCase(PrcdSGTTableList(ukz1).typeParam);
       s2 := AnsiUpperCase(PrcdSGTTableList(ukz2).typeParam);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  5: begin
       s1 := AnsiUpperCase(PrcdSGTTableList(ukz1).GUIDParam);
       s2 := AnsiUpperCase(PrcdSGTTableList(ukz2).GUIDParam);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
  6: begin
       result := sign( PrcdSGTTableList(ukz1).dtCreate - PrcdSGTTableList(ukz2).dtCreate );
     end;
  7: begin
       result := sign( PrcdSGTTableList(ukz1).dtFirstRcd - PrcdSGTTableList(ukz2).dtFirstRcd );
     end;
  8: begin
       result := sign( PrcdSGTTableList(ukz1).dtLastRcd - PrcdSGTTableList(ukz2).dtLastRcd );
     end;
  9: begin
       if PrcdSGTTableList(ukz1).bSaveDB then j1 := 1 else j1 := 0;
       if PrcdSGTTableList(ukz2).bSaveDB then j2 := 1 else j2 := 0;
       result := sign( j1 - j2 );
     end;
 10: begin
       result := sign( PrcdSGTTableList(ukz1).devmanindex - PrcdSGTTableList(ukz2).devmanindex );
     end;
 11: begin
       s1 := AnsiUpperCase(PrcdSGTTableList(ukz1).devmandescription);
       s2 := AnsiUpperCase(PrcdSGTTableList(ukz2).devmandescription);
       result := sign( SysUtils.CompareStr(s1, s2) );
     end;
 12: begin
       result := sign( PrcdSGTTableList(ukz1).decimal_points - PrcdSGTTableList(ukz2).decimal_points );
     end;
  else
    result := 0;
  end;
  Inc(result, 2);
end;

class procedure TSGTTableList.clearRecord(var rcd: rcdSGTtableList);
begin
  rcd.numbParam := -1;
  rcd.nameParam := '';
  rcd.desc := '';
  rcd.typeParam := '';
  rcd.GUIDParam := '';
  rcd.dtCreate := 0;
  rcd.dtFirstRcd := 0;
  rcd.dtLastRcd := 0;
  rcd.bSaveDB := false;
  rcd.devmanindex := -1;
  rcd.devmandescription := '';
  rcd.decimal_points := 0;
end;

procedure TSGTTableList.Clone(Source: TSGTTableList);
begin
  if not Assigned(Source) then Exit;
  inherited Clone(Source);
end;

constructor TSGTTableList.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdSGTTableList);
end;

destructor TSGTTableList.Destroy;
begin
  inherited;
end;

function TSGTTableList.GetPntDyn(j: Integer): PrcdSGTtableList;
begin
  result := GetPnt(j);
end;

end.
