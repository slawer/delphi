unit uExportLASconst;

interface
uses
  uAbstrArray, uOreolProtocol6, Math;

const
  pc006_108_jMain       = 6108;
  pc006_108_Caption     = 'Экспорт данных в LASS формат';

  pc006_108_frm01       = '%d <%s>';
  pc006_108_frm02       = 'Обнаружена ошибка даты/времени в строке № %d, колонке № %d';
  pc006_108_frm03       = '%d %s[%s] (%s)';

  pc006_108_CrntD       = 1;
  pc006_108_PrevD       = 2;
  pc006_108_DBasD       = 3;
  pc006_108_Hread_01tim = 5000;           // Время ожидания завершения процесса в мсек
  pc006_108_Hread_01typ = 136001;         // "Тип" процесса
  pc006_108_Hread_01cpt  = 'Экспорт данных в LASS формат';

// [col,row]
  pc006_108_sg1_00_00   = 'Интервал:';
  pc006_108_sg1_01_00   = 'Дата';
  pc006_108_sg1_02_00   = 'Время';
  pc006_108_sg1_00_01   = 'Начало';
  pc006_108_sg1_00_02   = 'Конец';

  pc006_108_CmbBx1_Msht = 1000;
  pc006_108_CmbBx1_00   = 'мм';
  pc006_108_CmbBx1_01   = 'см';
  pc006_108_CmbBx1_02   = 'м';

  pc006_108_CmbBx2_01   = 'Первое значение на интервале';
  pc006_108_CmbBx2_02   = 'Среднее значение на интервале';
  pc006_108_CmbBx2_03   = 'Частотный выбор на интервале';

  pc006_108_CmbBx3_00   = 'Заголовки колонок отсутсвуют';
  pc006_108_CmbBx3_01   = 'Имена каналов';
  pc006_108_CmbBx3_02   = 'Номера каналов';

  pc006_108_CmbBx4_00   = 'Использовать предыдущее значение';
  pc006_108_CmbBx4_01   = 'Заполнить значением NAN';
//  pc006_108_CmbBx4_02   = 'Линейная интерполяция';

  pc006_108_CmbBx5_00   = 'MS DOS Ascii';
  pc006_108_CmbBx5_01   = 'Windows Cirilic (1251)';

  pc006_108_CmbBx6_00   = 'Пробел ( )';
  pc006_108_CmbBx6_01   = 'Табуляция ( )';
  pc006_108_CmbBx6_02   = 'Запятая ( , )';
  pc006_108_CmbBx6_03   = 'Точка с запятой ( ; )';
  pc006_108_CmbBx6_04   = 'Ввести "вручную" ниже:';

  pc006_108_CmbBx7_00   = 'Точка ( . )';
  pc006_108_CmbBx7_01   = 'Запятая ( , )';
  pc006_108_CmbBx7_02   = 'Ввести "вручную" ниже:';

  pc006_108_001         = 'Интервал времени начинается позже, чем кончается';
  pc006_108_002         = 'Не выделен ни один канал для экспорта';
  pc006_108_003         = 'Выполняется экспорт данных';
  pc006_108_004         = 'Экспорт данных невозможен, программа выполняет предыдущую операцию';
  pc006_108_005         = 'Экспорт данных невозможен, Длина строки-разделителя == 0';
  pc006_108_006         = 'Указанный файл существует. Перезаписать?';
  pc006_108_007         = 'Укажите, пожалуйста файл, в который будет экспортироваться База Данных';
  pc006_108_008         = 'Экспорт данных невозможен, обнаружена ошибка в записи констатны Nan';
  pc006_108_009         = 'Экспорт данных невозможен, размер окна интерполяции должен быть больше размера шага вывода';
  pc006_108_010         = 'Не указана отметка глубины. Продолжить?';
  pc006_108_011         = 'Экспорт данных невозможен, программа выполняет предыдущую операцию';
  pc006_108_012         = #13#10 + 'Экспорт в LASS формат:';
  pc006_108_013         = 'Соединение с БД %s';
  pc006_108_014         = '  Сервер БД: ';
  pc006_108_015         = 'База данных: ';
  pc006_108_016         = 'Ошибка соединения с сервером:';
  pc006_108_017         = 'Экспорт из БД завершён по требованию пользователя';
  pc006_108_019         = 'Экспорт из БД аварийно завершён';
  pc006_108_020         = 'Ошибка чтения данных из БД:';
  pc006_108_021         = 'Чтение окончено, всего прочитано %d записей';
  pc006_108_022         = 'В заданном интервале данные отсутствуют';
  pc006_108_024         = 'Экспорт данных в LASS формат завершён. Выведено %d строк';

  pc006_108_101         = 'Дата';
  pc006_108_102         = 'Глубина';
  pc006_108_103         = 'Индекс';

  pc006_108_frmSizeInt  = 'Размер окна интерполяции (в %s):';

  pc006_108_frm0        = 'dd.mm.yyyy hh:nn:ss,zzz';
  pc006_108_frm1        = 'dd.mm.yyyy hh:nn:ss';
  pc006_108_frm2        = 'dd.mm.yyyy hh:nn';
  pc006_108_frm4        = 'hh:nn:ss';
  pc006_108_PrtStep     = '    ';
  pc006_108_TypeFls     = 'LASS формат (*.las)|*.las|Текстовый (*.txt)|*.txt|Все (*.*)|*.*';
  pc006_108_TypeFl1     = 'las';
  pc006_108_TypeFl2     = 'txt';

  pc006_108_frmH0       = '%10.3f';
  pc006_108_frmH1       = '%10.2f';
  pc006_108_frmH2       = '%10.0f';

  pc006_108_frmV0       = '%10.3f';
  pc006_108_frmI0       = '%10d';
  pc006_108_frmS0       = '%10s';

  pc006_108_CodeDOS     = 0;
  pc006_108_CodeWin     = 1;

  pc006_108_CodeChProb  = 0;
  pc006_108_CodeChTab   = 1; //
  pc006_108_CodeChComa  = 2; // ,
  pc006_108_CodeChCoPt  = 3; // ;
  pc006_108_CodeChManu  = 4; // ввести в ручную
  pc006_108_SCodeChProb  = ' ';
  pc006_108_SCodeChTab   = #8; //
  pc006_108_SCodeChComa  = ','; // ,
  pc006_108_SCodeChCoPt  = ';'; // ;

  pc006_108_ComaChPoint = 0;
  pc006_108_ComaChComa  = 1; // ,
  pc006_108_ComaChManu  = 2; // ввести в ручную
  pc006_108_SComaChPoint = '.';
  pc006_108_SComaChComa  = ','; // ,

  pc006_108_EmptyHeadField = '---';

// Оформление заголовка LASS формат файла
  pc006_108_LAS_VI_B     = '~V  Version Information';
  pc006_108_LAS_VI_1     = '  VERS.                             2.0: CWLS log ASCII standard';
  pc006_108_LAS_VI_2     = '  WRAP.                              NO: One line per depth step';

  pc006_108_LAS_WI_B     = '~Well Information block';
  pc006_108_LAS_WI_MU    = '# Mnem.Unit      Data type       Information';
  pc006_108_LAS_WI_01    = '  STRT.M                            %s: Start depth';
  pc006_108_LAS_WI_02    = '  STOP.M                            %s: Ending depth';
  pc006_108_LAS_WI_03    = '  STEP.M                               : Step increment';
  pc006_108_LAS_WI_04    = '  NULL.                             %s: Null value';
  pc006_108_LAS_WI_05    = '  COMP.                                : Company name';
  pc006_108_LAS_WI_06    = '  WELL.                                : Well name';
  pc006_108_LAS_WI_07    = '  FLD .                                : Field';
  pc006_108_LAS_WI_08    = '  LOC .                                : Location';
  pc006_108_LAS_WI_09    = '  CNTY.                                : County';
  pc006_108_LAS_WI_10    = '  STAT.                                : State';
  pc006_108_LAS_WI_11    = '  CTRY.                                : Country';
  pc006_108_LAS_WI_12    = '  SRVC.                                : Service Co.';
  pc006_108_LAS_WI_13    = '  DATE.                                : Date';
  pc006_108_LAS_WI_14    = '  UWI .                                : Unique well identifier';
  pc006_108_LAS_WI_15    = '  API .                                : API well number';

  pc006_108_LAS_CI_B     = '~Curve Information block';
  pc006_108_LAS_CI_MU    = '#Mnem.Unit  :Curve desc';
  pc006_108_LAS_CI_XX    = 'COL%d.units   :%s';

  pc006_108_LAS_AD_B     = '~Ascii Data';


  type

    prqTExpLassJob = class
    public
      bIncTime, bIncDepth, bIncIndex: Boolean;
      bOrigin:   Boolean;          // True - выводить данные "как есть"
      jMethod:   Integer;          // Метод прореживания данных
      jInterp:   Integer;          // Метод интерполяции данных
      jInterval: Integer;          // Индекс интервала (мм, см, м)
      vInterval: Integer;          // Величина интервала в ед. (мм, см, м)
      jLegend:   Integer;          // Способ подписывания колонок
      vInterpol: Integer;          // Величина интервала интеполяции в ед. (мм, см, м)


      jCodeFile: Integer;          // Кодировка файла
      jCodeChar: Integer;          // Выбор разделителя
      sCodeChar: String;           // Строка разделитель

      jComaChar: Integer;          // Выбор десятичной точки
      sComaChar: String;           // Строка десятичной точки

      bTreamFld: Boolean;          // Флаг отбрасывать лишние пробелы

      dNot, dNot1, dNot2: Double;  // Границы "нет данных" в БД и само значение
      dNotIn, dNotIn1, dNotIn2: Double;  // Границы "нет данных" в интервале и само значение

      jStep:       Integer;        // Шаг запроса в мм
      jStepInterp: Integer;        // Шаг интепрляции в мм
      sFrm:      String;           // Формат печати даты/времени
      sFrmH:     String;           // Формат печати Глубины
      hBeg, hEnd: Double;          // Границы глубин, которые попадают в интервал
      constNan:  Double;           // Константа Nan
      rcdExport: rcdCMD_GetMeasuring;
      valExport: prqTabsField;
      valLegend: prqTpointer;

      sFileName: String;
      isExist:   Boolean;          // Файл уже существует!

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

{ prqTExpLassJob }

constructor prqTExpLassJob.Create;
begin
  bIncTime        := False;
  bIncDepth       := False;
  bIncIndex       := False;
  constNan        := -9999.99;
  rcdExport.tySd  := 0;
  rcdExport.dtBeg := 0;
  rcdExport.dtEnd := 0;
  rcdExport.pFld  := prqTinteger.Create;
  valExport       := prqTabsField.Create;
  valLegend       := prqTpointer.Create;
  sFileName       := '';
  bTreamFld       := true;
end;

destructor prqTExpLassJob.Destroy;
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
