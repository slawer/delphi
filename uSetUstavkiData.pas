unit uSetUstavkiData;

interface
uses
  uAbstrArray, SysUtils, Math, Classes, IniFiles, Grids, Dialogs;


type

  rcdSetUstavkiData1 = packed record
    BKSDName:  String[47]; // Имя коробки, надпись на кнопке
    BKSDNumb:  Integer;    // Номер коробки
    Comanda:   Integer;    // Команда
    Registr:   Integer;    // Регистра
    Ustavka:   Integer;    // Уставка
    Delitel:   Integer;    // Делитель (1, 10, 100, 1000)
    RO:        Integer;    // 0 - можно изменять, 1 - только для чтения
    l_B:       Integer;    // от 1 до 4 размер поля в байтах
    iD:  Integer;          // Порядковый Номер
  end;
  PrcdSetUstavkiData1 = ^rcdSetUstavkiData1;
  TSetUstavkiData1 = class(prqTabstract1)
  private
    function GetPntDyn(j: Integer): PrcdSetUstavkiData1;
  protected
    function Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
  public
{
  Формирует ини файла в List на основе содержимого класса
}
    procedure GetStrings(iniFile: TMemIniFile; Number: Integer);

{
  Формирует содержимое класса на основе ини файла в List
}
    procedure SetStrings(iniFile: TMemIniFile; Number: Integer);

{
  Подписать Таблицу
}
    procedure signStringGrid(StringGrid1: TStringGrid);

{
  Заполнить Таблицу содержимым класса
}
    procedure fillStringGrid(StringGrid1: TStringGrid);

{
  Перенести содержимое из Таблицы в класс
}
    function tranStringGrid(StringGrid1: TStringGrid): Boolean;

{
  Обнулить содержимое класса
}
    procedure initSelf;

{
  Сформировать имя кнопки
}
    function getButtonName(jNum: Integer): String;

    property pntDyn[j:Integer]: PrcdSetUstavkiData1 read GetPntDyn; default;
    constructor Create;
  end;


implementation
uses
  uSupport;

const
  col01 = 'Надпись';
  col02 = 'Адрес';
  col03 = 'Страница';
  col04 = 'Регистр';
  col05 = 'Уставка';
  col06 = 'Делитель';
  col07 = 'RO';
  col08 = 'l(B)';

  shb01 = 'Не используется';
  shb02 = 'Не определена';
  shb03 = 'Сброс <%s>';

  err01 = 'Ошибка в поле "Адрес БКСД" в строке № %d';
  err02 = 'Ошибка в поле "Страница" в строке № %d';
  err03 = 'Ошибка в поле "Регистр" в строке № %d';
  err04 = 'Ошибка в поле "Уставка" в строке № %d';
  err05 = 'Ошибка в поле "Делитель" в строке № %d';
  err06 = 'Ошибка в поле "R0 (только для чтения)" в строке № %d';
  err07 = 'Ошибка в поле "l(B) (длина в байтах)" в строке № %d';


{ TSetUstavkiData1 }

function TSetUstavkiData1.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign( rcdSetUstavkiData1(ukz1^).BKSDNumb - rcdSetUstavkiData1(ukz2^).BKSDNumb ) + 2;
     end;
  else begin result := 0; Exit; end;
  end;
end;

constructor TSetUstavkiData1.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdSetUstavkiData1);
end;

procedure TSetUstavkiData1.fillStringGrid(StringGrid1: TStringGrid);
var
  jC1: Integer;
begin
  for jC1 := 1 to Count do
  begin
    StringGrid1.Cells[1,jC1] := self[jC1].BKSDName;
    StringGrid1.Cells[2,jC1] := IntToStr(self[jC1].BKSDNumb);
    StringGrid1.Cells[3,jC1] := IntToStr(self[jC1].Comanda);
    StringGrid1.Cells[4,jC1] := IntToStr(self[jC1].Registr);
    StringGrid1.Cells[5,jC1] := IntToStr(self[jC1].Ustavka);
    StringGrid1.Cells[6,jC1] := IntToStr(self[jC1].Delitel);
    StringGrid1.Cells[7,jC1] := IntToStr(self[jC1].RO);
    StringGrid1.Cells[8,jC1] := IntToStr(self[jC1].l_B);
  end;
end;

function TSetUstavkiData1.getButtonName(jNum: Integer): String;
begin
  result := shb02;
  if (jNum > 0)  AND  (jNum <= Count) then
  begin
    if self[jNum].BKSDNumb > 0 then
    begin
      result := format(shb03, [self[jNum].BKSDName]);
    end
    else
    begin
      result := shb01;
    end;

  end;
end;

function TSetUstavkiData1.GetPntDyn(j: Integer): PrcdSetUstavkiData1;
begin
  result := GetPnt(j);
end;

procedure TSetUstavkiData1.GetStrings(iniFile: TMemIniFile;
  Number: Integer);
var
  s0, s1: String;
  jC1: Integer;
begin
  iniFile.Clear;

// Заголовок класса
  s0 := ClassName + '_' + IntToStr(Number);
  iniFile.WriteString(s0, 'Count', IntToStr(Count));

// Записи
  for jC1 := 1 to Count do
  begin
    s1 := s0 + '_rcd_'+IntToStr(jC1);
    iniFile.WriteString(s1, 'BKSDName', self[jC1].BKSDName);
    iniFile.WriteString(s1, 'BKSDNumb', IntToStr(self[jC1].BKSDNumb));
    iniFile.WriteString(s1, 'Comanda', IntToStr(self[jC1].Comanda));
    iniFile.WriteString(s1, 'Registr', IntToStr(self[jC1].Registr));
    iniFile.WriteString(s1, 'Ustavka', IntToStr(self[jC1].Ustavka));
    iniFile.WriteString(s1, 'Delitel', IntToStr(self[jC1].Delitel));
    iniFile.WriteString(s1, 'RO', IntToStr(self[jC1].RO));
    iniFile.WriteString(s1, 'l_B', IntToStr(self[jC1].l_B));
  end;
end;

procedure TSetUstavkiData1.initSelf;
var
  jC1: Integer;
begin
  for jC1 := 1 to Count do
  begin
    self[jC1].BKSDName := shb01;
    self[jC1].BKSDNumb := 0;
    self[jC1].Comanda  := 0;
    self[jC1].Registr  := 0;
    self[jC1].Ustavka  := 0;
    self[jC1].Delitel  := 0;
    self[jC1].RO       := 0;
    self[jC1].l_B      := 2;
  end;
end;

procedure TSetUstavkiData1.SetStrings(iniFile: TMemIniFile;
  Number: Integer);
var
  s0, s1: String;
  jCount,jC1: Integer;
begin
// Заголовок класса
  s0 := ClassName + '_' + IntToStr(Number);
  try
    jCount := StrToInt(iniFile.ReadString(s0, 'Count', '0'));
  except
    jCount := 0;
  end;

// Записи
  for jC1 := 1 to jCount do
  begin
    if jC1 > Count then Exit;
    s1 := s0 + '_rcd_'+IntToStr(jC1);

    self[jC1].BKSDName := iniFile.ReadString(s1, 'BKSDName', '');

    try
      self[jC1].BKSDNumb := StrToInt(iniFile.ReadString(s1, 'BKSDNumb', '0'));
    except
      self[jC1].BKSDNumb := 0;
    end;

    try
      self[jC1].Comanda := StrToInt(iniFile.ReadString(s1, 'Comanda', '0'));
    except
      self[jC1].Comanda := 0;
    end;

    try
      self[jC1].Registr := StrToInt(iniFile.ReadString(s1, 'Registr', '0'));
    except
      self[jC1].Registr := 0;
    end;

    try
      self[jC1].Ustavka := StrToInt(iniFile.ReadString(s1, 'Ustavka', '0'));
    except
      self[jC1].Ustavka := 0;
    end;

    try
      self[jC1].Delitel := StrToInt(iniFile.ReadString(s1, 'Delitel', '0'));
    except
      self[jC1].Delitel := 0;
    end;

    try
      self[jC1].RO := StrToInt(iniFile.ReadString(s1, 'RO', '0'));
    except
      self[jC1].RO := 0;
    end;

    try
      self[jC1].l_B := StrToInt(iniFile.ReadString(s1, 'l_B', '2'));
    except
      self[jC1].l_B := 2;
    end;

    self[jC1].iD := jC1;
  end;
end;

procedure TSetUstavkiData1.signStringGrid(StringGrid1: TStringGrid);
var
  jC1: Integer;
begin
  StringGrid1.ColCount := 9;
  StringGrid1.RowCount := Count + 1;
  StringGrid1.Cells[1,0] := col01;
  StringGrid1.Cells[2,0] := col02;
  StringGrid1.Cells[3,0] := col03;
  StringGrid1.Cells[4,0] := col04;
  StringGrid1.Cells[5,0] := col05;
  StringGrid1.Cells[6,0] := col06;
  StringGrid1.Cells[7,0] := col07;
  StringGrid1.Cells[8,0] := col08;

  for jC1 := 1 to Count do
  begin
    StringGrid1.Cells[0,jC1] := IntToStr(jC1);
    StringGrid1.Cells[1,jC1] := shb01;
    StringGrid1.Cells[2,jC1] := '0';
    StringGrid1.Cells[3,jC1] := '0';
    StringGrid1.Cells[4,jC1] := '0';
    StringGrid1.Cells[5,jC1] := '0';
    StringGrid1.Cells[6,jC1] := '0';
    StringGrid1.Cells[7,jC1] := '0';
    StringGrid1.Cells[8,jC1] := '2';
  end;
end;

function TSetUstavkiData1.tranStringGrid(StringGrid1: TStringGrid): Boolean;
var
  jC1: Integer;
  s1: String;
begin
  result := True;
  for jC1 := 1 to Count do
  begin
    self[jC1].BKSDName := Trim(StringGrid1.Cells[1,jC1]);

    try
      s1 := Trim(StringGrid1.Cells[2,jC1]);
      if Length(s1) = 0 then s1 := '0';
      self[jC1].BKSDNumb := StrToInt(s1);
    except
      self[jC1].BKSDNumb := 0;
      result := False;
      ShowMessage(format(err01, [jC1]));
      Exit;
    end;

    try
      s1 := Trim(StringGrid1.Cells[3,jC1]);
      if Length(s1) = 0 then s1 := '0';
      self[jC1].Comanda := StrToInt(s1);
    except
      self[jC1].Comanda := 0;
      result := False;
      ShowMessage(format(err02, [jC1]));
      Exit;
    end;

    try
      s1 := Trim(StringGrid1.Cells[4,jC1]);
      if Length(s1) = 0 then s1 := '0';
      self[jC1].Registr := StrToInt(s1);
    except
      self[jC1].Registr := 0;
      result := False;
      ShowMessage(format(err03, [jC1]));
      Exit;
    end;

    try
      s1 := Trim(StringGrid1.Cells[5,jC1]);
      if Length(s1) = 0 then s1 := '0';
      self[jC1].Ustavka := StrToInt(s1);
    except
      self[jC1].Ustavka := 0;
      result := False;
      ShowMessage(format(err04, [jC1]));
      Exit;
    end;

    try
      s1 := Trim(StringGrid1.Cells[6,jC1]);
      if Length(s1) = 0 then s1 := '0';
      self[jC1].Delitel := StrToInt(s1);
    except
      self[jC1].Delitel := 0;
      result := False;
      ShowMessage(format(err05, [jC1]));
      Exit;
    end;

    try
      s1 := Trim(StringGrid1.Cells[7,jC1]);
      if Length(s1) = 0 then s1 := '0';
      self[jC1].RO := StrToInt(s1);
      if self[jC1].RO <> 0 then
      begin
        self[jC1].RO := 1;
      end;
    except
      self[jC1].RO := 0;
      result := False;
      ShowMessage(format(err06, [jC1]));
      Exit;
    end;

    try
      s1 := Trim(StringGrid1.Cells[8,jC1]);
      if Length(s1) = 0 then s1 := '2';
      self[jC1].l_B := StrToInt(s1);
      if self[jC1].l_B = 0 then self[jC1].l_B := 2;
      if (self[jC1].l_B < 1) or (self[jC1].l_B > 4) then
      begin
        self[jC1].l_B := 2;
        result := False;
        ShowMessage(format(err07, [jC1]));
        Exit;
      end;
    except
      self[jC1].l_B := 2;
      result := False;
      ShowMessage(format(err07, [jC1]));
      Exit;
    end;

    self[jC1].iD := jC1;
  end;
end;

end.
