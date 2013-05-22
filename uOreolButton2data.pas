unit uOreolButton2data;

interface
uses
  uAbstrArray, SysUtils, Math, Classes, IniFiles, Grids, Dialogs;


type

  rcdODButton2Par1 = packed record
    BKSDName:  String[15]; // Имя коробки
    BKSDNumb:  Integer;    // Номер коробки
    iD:  Integer;          // Порядковый Номер
  end;
  PrcdODButton2Par1 = ^rcdODButton2Par1;
  prqTODButton2Par1 = class(prqTabstract1)
  private
    function GetPntDyn(j: Integer): PrcdODButton2Par1;
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

    property pntDyn[j:Integer]: PrcdODButton2Par1 read GetPntDyn; default;
    constructor Create;
  end;


implementation

const
  col01 = 'Имя БКСД';
  col02 = 'Адр';

  shb01 = 'Не используется';
  shb02 = 'Не определена';
  shb03 = 'Сброс <%s>';

  err01 = 'Ошибка в Адресе БКСД в строке № %d';


{ prqTODButton2Par1 }

function prqTODButton2Par1.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign( rcdODButton2Par1(ukz1^).BKSDNumb - rcdODButton2Par1(ukz2^).BKSDNumb ) + 2;
     end;
  else begin result := 0; Exit; end;
  end;
end;

constructor prqTODButton2Par1.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdODButton2Par1);
end;

procedure prqTODButton2Par1.fillStringGrid(StringGrid1: TStringGrid);
var
  jC1: Integer;
begin
  for jC1 := 1 to Count do
  begin
    StringGrid1.Cells[1,jC1] := self[jC1].BKSDName;
    StringGrid1.Cells[2,jC1] := IntToStr(self[jC1].BKSDNumb);
  end;
end;

function prqTODButton2Par1.getButtonName(jNum: Integer): String;
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

function prqTODButton2Par1.GetPntDyn(j: Integer): PrcdODButton2Par1;
begin
  result := GetPnt(j);
end;

procedure prqTODButton2Par1.GetStrings(iniFile: TMemIniFile; Number: Integer);
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
  end;
end;

procedure prqTODButton2Par1.initSelf;
var
  jC1: Integer;
begin
  for jC1 := 1 to Count do
  begin
    self[jC1].BKSDName := shb01;
    self[jC1].BKSDNumb := 0;
  end;
end;

procedure prqTODButton2Par1.SetStrings(iniFile: TMemIniFile; Number: Integer);
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
    self[jC1].iD := jC1;
  end;
end;

procedure prqTODButton2Par1.signStringGrid(StringGrid1: TStringGrid);
var
  jC1: Integer;
begin
  StringGrid1.ColCount := 3;
  StringGrid1.RowCount := Count + 1;
  StringGrid1.Cells[1,0] := col01;
  StringGrid1.Cells[2,0] := col02;

  for jC1 := 1 to Count do
  begin
    StringGrid1.Cells[0,jC1] := IntToStr(jC1);
    StringGrid1.Cells[1,jC1] := shb01;
    StringGrid1.Cells[2,jC1] := '0';
  end;
end;

function prqTODButton2Par1.tranStringGrid(StringGrid1: TStringGrid): Boolean;
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
    self[jC1].iD := jC1;
  end;
end;

end.
