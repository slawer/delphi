unit uExportXLSConst;

interface
uses
  uAbstrArray, uOreolProtocol6, Math;

const
  pc006_107_jMain       = 6107;
  pc006_107_Caption     = 'Экспорт данных в XLS';

  pc006_107_frm01       = '%d %s[%s] (%s)';
  pc006_107_frm02       = 'Обнаружена ошибка даты/времени в строке № %d, колонке № %d';

  pc006_107_CrntD       = 1;
  pc006_107_PrevD       = 2;
  pc006_107_DBasD       = 3;

// [col,row]
  pc006_107_sg1_00_00   = 'Интервал:';
  pc006_107_sg1_01_00   = 'Дата';
  pc006_107_sg1_02_00   = 'Время';
  pc006_107_sg1_00_01   = 'Начало';
  pc006_107_sg1_00_02   = 'Конец';

  pc006_107_CmbBx1_00   = 'мСек';
  pc006_107_CmbBx1_01   = 'Сек.';
  pc006_107_CmbBx1_02   = 'Мин.';

  pc006_107_CmbBx2_01   = 'Частотный выбор';
  pc006_107_CmbBx2_02   = 'Среднее на интервале';

  pc006_107_CmbBx3_00   = 'Заголовки колонок отсутсвуют';
  pc006_107_CmbBx3_01   = 'Имена каналов';
  pc006_107_CmbBx3_02   = 'Номера каналов';

  pc006_107_CmbBx4_00   = 'Константа Nan';
  pc006_107_CmbBx4_01   = 'Использовать предыдущее значение';
//  pc006_107_CmbBx4_00   = 'Оставить "как есть"';
//  pc006_107_CmbBx4_02   = 'Линейная интерполяция';

  pc006_107_CmbBx5_00   = 'Выводить в файл - оставить "как есть"';
  pc006_107_CmbBx5_01   = 'Использовать предыдущее значение';
  pc006_107_CmbBx5_02   = 'Подавление пустых строк';

  pc006_107_frm0        = 'dd.mm.yyyy hh:nn:ss.zzz';
  pc006_107_frm1        = 'dd.mm.yyyy hh:nn:ss';
  pc006_107_frm2        = 'dd.mm.yyyy hh:nn';
  pc006_107_frm4        = 'hh:nn:ss';
  pc006_107_PrtStep     = '    ';

  pc006_107_Hread_01tim  = 5000;           // Время ожидания завершения процесса в мсек
  pc006_107_Hread_01typ  = 139001;         // "Тип" процесса
  pc006_107_Hread_01cpt  = 'Соединение с файлом данных АК';

  pc006_107_WindowXLSSize  = 5000;

  pc006_107_001         = 'Интервал времени начинается позже, чем кончается';
  pc006_107_002         = 'Не выделен ни один канал для экспорта';
  pc006_107_003         = 'Выполняется экспорт данных';
  pc006_107_004         = 'Экспорт данных невозможен, программа выполняет предыдущую операцию';

  pc006_107_011         = 'Чтение данных из БД';
  pc006_107_012         = 'Чтение окончено, всего прочитано %d записей';
  pc006_107_013         = 'Экспорт данных в XLS формат завершён. Выведено %d строк';
  pc006_107_015         = 'Экспорт из БД завершён по требованию пользователя';
  pc006_107_016         = #13#10 + 'Экспорт в Excel:';
  pc006_107_017         = 'Ошибка соединения с сервером:';
  pc006_107_018         = 'Ошибка чтения данных из БД:';
  pc006_107_019         = 'Экспорт из БД аварийно завершён';
  pc006_107_020         = 'База данных: ';
  pc006_107_021         = '  Сервер БД: ';
  pc006_107_022         = 'В заданном интервале данные отсутствуют';

  pc006_107_111         = 'Дата';
  pc006_107_112         = 'Глубина';
  pc006_107_113         = 'Индекс';

  type

    prqTExpJob = class
    public
      bIncTime, bIncDepth, bIncIndex: Boolean;
      bOrigin:   Boolean;          // True - выводить данные "как есть"
      jMethod:   Integer;          // Метод прореживания данных
      jInterp:   Integer;          // Метод интерполяции данных
      jAdmiss:   Integer;          // Метод пропуска пустых строк
      jInterval: Integer;          // Индекс интервала (мсек, сек, мин)
      vInterval: Integer;          // Величина интервала в ед. (мсек, сек, мин)
      jLegend:   Integer;          // Способ подписывания колонок
      dNot, dNot1, dNot2: Double;  // Границы "нет данных" в БД и само значение
      dNotIn, dNotIn1, dNotIn2: Double;  // Границы "нет данных" в интервале и само значение
      dStep:     Double;           // Шаг запроса
      sFrm:      String;           // Формат печати строки даты/времени
//      dtBeg, dtEnd: Double; // Временные рамки, в запросе рамки запроса шире
      rcdExport: rcdCMD_GetMeasuring;
      valExport: prqTabsField;
      valLegend: prqTpointer;
      constructor Create;
      destructor Destroy; override;
    end;

    rcdValStat =  packed record
      dVal:  Double;    // Значение
      jCnt:  Integer;   // Частота появления
    end;
    PrcdValStat = ^rcdValStat;

    prqValStat = class(prqTabstract1)
    private
      function    GetPntDyn(j: Integer): PrcdValStat;
    protected
      function  Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
    public
      property    pntDyn[j:Integer]: PrcdValStat read GetPntDyn; default;
      constructor Create;
    end;


implementation

{ prqTExpJob }

constructor prqTExpJob.Create;
begin
  bIncTime        := False;
  bIncDepth       := False;
  bIncIndex       := False;
  rcdExport.tySd  := 0;
  rcdExport.dtBeg := 0;
  rcdExport.dtEnd := 0;
  rcdExport.pFld  := prqTinteger.Create;
  valExport       := prqTabsField.Create;
  valLegend       := prqTpointer.Create;
end;

destructor prqTExpJob.Destroy;
begin
  rcdExport.pFld.Free;
  valExport.Free;
  valLegend.Free;
  inherited;
end;

{ prqValStat }

function prqValStat.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign( PrcdValStat(ukz1).dVal - PrcdValStat(ukz2).dVal );
     end;
  2: begin
       result := sign( PrcdValStat(ukz1).jCnt - PrcdValStat(ukz2).jCnt );
     end;
  else
    result := 0;
  end;
  Inc(result, 2);
end;

constructor prqValStat.Create;
begin
  FrcdSize := SizeOf(rcdValStat);
end;

function prqValStat.GetPntDyn(j: Integer): PrcdValStat;
begin
  result := GetPnt(j);
end;

end.
