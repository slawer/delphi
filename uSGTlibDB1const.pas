unit uSGTlibDB1const;

interface
const
//  pc006_501_DepDLLMaxCnt   = 1000; // Ограничитель при освобождении библиотеки
//  pc006_501_DepDLLMaxErr   =  100; // Максимальный аварийный код завершения библиотеки
//  pc006_501_DepDLLIntErr1  = 1001; // Аварийный код завершения по событию

  pc006_501_DBerrCount = 'Дата начала интервала больше даты окончания интервала';

  pc006_501_001 = 'Не удалось соединиться с Базой Данных сеанса № %d: "%s"';
  pc006_501_002 = 'Ошибки чтения "%s" из Базы Данных сеанса № %d: "%s"';
  pc006_501_003 = 'Не удалось соединиться с дополнительной Базой Данных: "%s"';
  pc006_501_004 = 'Ошибки чтения "%s" из дополнительной Базы Данных: "%s"';

  pc006_501_Err1 = 'Дата начала интервала больше даты окончания интервала';
  pc006_501_Err2 = 'Не удалось соединиться с БД';

  pc006_501_DBDerr_001    = 'Не найден файл с описанием конфигурации БД. Проверьте настройки программы';
  pc006_501_DBDerr_002    = 'Чтение и анализ файла с описанием конфигурации БД прервана с сообщением:' + #13#10 +
                            '--------------' + #13#10 +
                            '"%s"';
  pc006_501_DBDerr_003    = 'Загрузка файла с описанием конфигурации БД прервана с сообщением:' + #13#10 +
                            '--------------' + #13#10 +
                            '"%s"';
  pc006_501_DBDerr_004    = 'Структура файла с описанием конфигурации БД не поддаётся интерпретации. Трансляция прекращена';
  pc006_501_DBDerr_005    = 'Не найден файл с описанием проведённых работ. Проверьте настройки программы';
  pc006_501_DBDerr_006    = 'Структура файла с описанием проведённых работ не поддаётся интерпретации. Трансляция прекращена';

  pc006_501_xmlDBD_001    = 'sgt_configuration';
  pc006_501_xmlDBD_002a   = 'data_base';
  pc006_501_xmlDBD_002    = 'datasource';
  pc006_501_xmlDBD_003    = 'userid';
  pc006_501_xmlDBD_004    = 'password';
  pc006_501_xmlDBD_005    = 'commutator';
  pc006_501_xmlDBD_006    = 'parameters';
  pc006_501_xmlDBD_007    = 'parameter';

  pc006_501_xmlDBD_008    = 'name';
  pc006_501_xmlDBD_009    = 'desc';
  pc006_501_xmlDBD_010    = 'units';
  pc006_501_xmlDBD_011    = 'issavetodb';
  pc006_501_xmlDBD_012    = 'devmanindex';
  pc006_501_xmlDBD_013    = 'devmandescription';
  pc006_501_xmlDBD_014    = 'decimal_points';
  pc006_501_xmlDBD_015    = 'guid';
//  pc006_501_xmlDBD_0..    = 'channelnumber';


  pc006_501_xmlDBD_051  = 'works';
  pc006_501_xmlDBD_052  = 'work';
  pc006_501_xmlDBD_053  = 'field';
  pc006_501_xmlDBD_054  = 'bush';
  pc006_501_xmlDBD_055  = 'well';
  pc006_501_xmlDBD_056  = 'customer';
  pc006_501_xmlDBD_057  = 'performer';
  pc006_501_xmlDBD_058  = 'comment';
  pc006_501_xmlDBD_059  = 'starttime';
  pc006_501_xmlDBD_060  = 'starting_depth';
  pc006_501_xmlDBD_061  = 'guid';
  pc006_501_xmlDBD_062  = 'actived';
  pc006_501_xmlDBD_063  = 'sessions';
  pc006_501_xmlDBD_064  = 'session';
  pc006_501_xmlDBD_065  = 'number';
  pc006_501_xmlDBD_066  = 'description';
  pc006_501_xmlDBD_067  = 'date_time';
  pc006_501_xmlDBD_068  = 'actived';
  pc006_501_xmlDBD_069  = 'data_base';

implementation

end.
