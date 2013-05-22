unit uGraphPatterns1;

interface
uses
  Windows, SysUtils, uAbstrArray, Graphics, Math, uGraphPatterns1const;
//  , uMainData,
//  xmldom, XMLIntf, msxmldom, XMLDoc, Classes, Variants;


type

// �����, ����������� ����������� ��������� ������
  rcdTrackPattern =  packed record
    active:   boolean;    // "����������" ������� � �����
    number:   integer;    // "�����" ������� � �����
    nChanal:  Integer;    // ����� ������
    sName:    String[63]; // ��� ���������   - ��� ����������� ������������ � �������� �������������!
    sPodp:    String[7];  // �������="����"
    sEdIzm:   String[7];  // �������="�/��3"
    diaMin:   Double;     // �������="0.6"
    diaMax:   Double;     // ��������="2.6"
    Color:    Tcolor;     // ����="clGreen"
    xLogSize: Integer;    // ������� ����� (0.1 ��,  "0.8" * 10)
    xLogStep: Integer;    // ���_��������� (0.1 ��,  "0.5" * 10)
    fnSize:   Integer;    // ������_�������="10"
    Precision:Integer;    // ����� ������ ����� ������� � ������������� �����
//    Digits:   Integer;    // ������ ���� � ������������� �����
  end;
  PrcdTrackPattern = ^rcdTrackPattern;

  TTrackPattern = class(prqTabstract1)
  private
    Factive: boolean;
    FSelect: boolean;
    function    GetPntDyn(j: Integer): PrcdTrackPattern;
    procedure Setactive(const Value: boolean);
    procedure SetSelect(const Value: boolean);
  protected
    function  Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
  public
    // ���������, ��� ������ ���� ������� � �������
    property active: boolean read Factive write Setactive;

    // ���������, ��� ������ ���� ������ ��� ������ �� �����
    property Select: boolean read FSelect write SetSelect;

    property    pntDyn[j:Integer]: PrcdTrackPattern read GetPntDyn; default;
    procedure   Clone(Source: TTrackPattern);
    constructor Create;
    destructor  Destroy; override;
  end;

{
// �����, ����������� ������ ����� c ��������� "� �����"
// ����� ������������ ����� ��������� ��������
  TTrackPatterns = class(prqTobject)
  private
    Factive: boolean;
    procedure Setactive(const Value: boolean);
  protected
  public
    // ���������, ��� ���� ���� ������ ���� ������� �� �����
    property active: boolean read Factive write Setactive;

    function    GetObjPnt(j: Integer): TTrackPattern;

    procedure   Clone(Source: TTrackPatterns); // ����� ������� �������������

    constructor Create;
    destructor Destroy; override;
  end;
}

// ����� ������������ ����� ��������� ������
  TGraphListPattern = class(prqTobject)
  private
    Factive: boolean;
    Fname: string;
    FSelectedTrack: integer;
    procedure Setactive(const Value: boolean);
    procedure Setname(const Value: string);
    procedure SetSelectedTrack(const Value: integer);
  public
    // ���������, ��� ��� ���������� ������ ������ ���� ������ �����
    property active: boolean read Factive write Setactive;

    // ��� �������
    property name: string read Fname write Setname;

    // ��������� �� ����, ������� ��������������� �� ������
    property SelectedTrack: integer read FSelectedTrack write SetSelectedTrack;

    // ������������ ������ ������ "��������" �������� ������� (��, ������� ������ � ��)
    function getGraficsList: TTrackPattern;

    // ������������ ������ ������ "��������" �������� ������� (��, ������� ������ � ��)
    procedure setScaleFontSize(Value: integer);

    function    GetObjPnt(j: Integer): TTrackPattern;

    procedure   Clone(Source: TGraphListPattern); // ����� ������� �������������

    constructor Create;
    destructor Destroy; override;
  end;


// �����, ����������� ��������� �������� ����� c ��������� "� �����"
  TGraphListPatterns = class(prqTobject)
  private
    FSelectedPattern: integer;
    procedure SetSelectedPattern(const Value: integer);
  public
    function GetObjPnt(j: Integer): TGraphListPattern;

    // ���������, ��� ����� ���������� ��� ���������� ������� �����
    property SelectedPattern: integer read FSelectedPattern write SetSelectedPattern;

    // ������ � ���������� ����� ���������� �����
    function getSelectedTrack: TTrackPattern;

    // ���������, ���� �� �������� ������� �� ��������� �����
    function isActiveGraph: boolean;

    // �������� ������ ������
    function addEmptyPattern: integer;

    procedure   Clone(Source: TGraphListPatterns);

    constructor Create;
    destructor Destroy; override;
  end;


implementation

{ TGraphListPatterns }

procedure TGraphListPatterns.Clone(Source: TGraphListPatterns);
var
  jC1: Integer;
begin
  inherited Clone(Source);

  for jC1 := 1 to Count do
  begin
    self[jC1].ukz := TGraphListPattern.Create;
    (self[jC1].ukz as TGraphListPattern).Clone( (Source[jC1].ukz as TGraphListPattern) );
  end;
end;

constructor TGraphListPatterns.Create;
begin
  inherited;
end;

destructor TGraphListPatterns.Destroy;
begin
  inherited;
end;

function TGraphListPatterns.getSelectedTrack: TTrackPattern;
var
  c1: TGraphListPattern;
begin
  result := nil;
  c1 := GetObjPnt(FSelectedPattern);
  if c1 = nil then Exit;
  result := c1.GetObjPnt(c1.FSelectedTrack);
end;

function TGraphListPatterns.GetObjPnt(j: Integer): TGraphListPattern;
begin
  result := (inherited GetObjPnt(j)) as TGraphListPattern;
end;

function TGraphListPatterns.isActiveGraph: boolean;
var
  c1: TGraphListPattern;
  c2: TTrackPattern;
  jC2, jC1: integer;
begin
  result := false;
  c1 := GetObjPnt(FSelectedPattern);
  if c1 = nil then Exit;

  for jC1 := 1 to c1.Count do
  begin
    c2 := c1.GetObjPnt(jC1);
    if c2 = nil then continue;
    if not c2.Factive then continue;
    for jC2 := 1 to c2.Count do
    begin
      if not c2[jC2].active then continue;
      result := true;
      Exit;
    end;
  end;
end;

{ TTrackPatterns

procedure TTrackPatterns.Clone(Source: TTrackPatterns);
var
  jC1: Integer;
begin
  inherited Clone(Source);

  self.Factive := Source.Factive;

  for jC1 := 1 to Count do
  begin
    self[jC1].ukz := TTrackPattern.Create;
    (self[jC1].ukz as TTrackPattern).Clone( (Source[jC1].ukz as TTrackPattern) );
  end;
end;

constructor TTrackPatterns.Create;
begin
  inherited;
  Factive := false;
end;

destructor TTrackPatterns.Destroy;
begin
  inherited;
end;

function TTrackPatterns.GetObjPnt(j: Integer): TTrackPattern;
begin
  result := (inherited GetObjPnt(j)) as TTrackPattern;
end;

procedure TTrackPatterns.Setactive(const Value: boolean);
begin
  Factive := Value;
end;

}

procedure TGraphListPatterns.SetSelectedPattern(const Value: integer);
begin
  FSelectedPattern := Value;
end;

function TGraphListPatterns.addEmptyPattern: integer;
var
  jC2, jC1, j1: integer;
  rcd: rcdTcontainer;
  p1: TGraphListPattern;
  pTrack: TTrackPattern;
  pGraf: PrcdTrackPattern;
begin
  // ������ ������
  j1 := self.Count + 1;
  rcd.key := j1;
  rcd.ukz := TGraphListPattern.Create;
  self.Append(@rcd);

  p1 := rcd.ukz as TGraphListPattern;

  p1.Fname := format(pc003_157_001, [j1]);
  p1.Factive := false; // �� ��������� �� ������
  p1.FSelectedTrack := 1; // �� ��������� ������ ���� � 1

  // ������ 5 ������
  for jC1 := 1 to pc003_157_002 do
  begin
    rcd.key := jC1;
    rcd.ukz := TTrackPattern.Create;
    p1.Append(@rcd);
    pTrack := rcd.ukz as TTrackPattern;
    pTrack.Factive := false;
    pTrack.FSelect := (jC1 = 1);

    // ������ 5 �������� � �����
    pTrack.Count := pc003_157_003;
    for jC2 := 1 to pc003_157_003 do
    begin
      pGraf := pTrack[jC2];
      pGraf.active   := false;
      pGraf.number   := jC2;
      pGraf.nChanal  := -1;
      pGraf.sName    := '';
      pGraf.sPodp    := '';
      pGraf.sEdIzm   := '';
      pGraf.diaMin   :=  0;
      pGraf.diaMax   :=  0;
      pGraf.Color    := clBlack;
      pGraf.xLogSize :=  5;
      pGraf.xLogStep := 10;
      pGraf.fnSize   :=  8;
      pGraf.Precision :=  0;
//      pGraf.Digits    :=  3;
    end;
  end;

  result := j1;
end;

{ TGraphListPattern }

procedure TGraphListPattern.Clone(Source: TGraphListPattern);
var
  jC1: Integer;
begin
  inherited Clone(Source);

  self.Factive := Source.Factive;

  for jC1 := 1 to Count do
  begin
    self[jC1].ukz := TTrackPattern.Create; // ���� ������������
    (self[jC1].ukz as TTrackPattern).Clone( (Source[jC1].ukz as TTrackPattern) );
  end;
end;

constructor TGraphListPattern.Create;
begin
  inherited;
  self.Factive := false;
end;

destructor TGraphListPattern.Destroy;
begin
  inherited;
end;

function TGraphListPattern.getGraficsList: TTrackPattern;
var
  jC2, jC1: integer;
  p1: TTrackPattern;
begin
  result := TTrackPattern.Create;
  for jC1 := 1 to self.Count do
  begin
    p1 := self[jC1].ukz as TTrackPattern;
    if not p1.Factive then continue;
    for jC2 := 1 to p1.Count do
    begin
      if not p1[jC2].active then continue;
      result.Append(p1[jC2]);
    end;
  end;
end;

function TGraphListPattern.GetObjPnt(j: Integer): TTrackPattern;
begin
  result := (inherited GetObjPnt(j)) as TTrackPattern;
end;

procedure TGraphListPattern.Setactive(const Value: boolean);
begin
  Factive := Value;
end;

procedure TGraphListPattern.Setname(const Value: string);
begin
  Fname := Value;
end;

procedure TGraphListPattern.setScaleFontSize(Value: integer);
var
  jC2, jC1: integer;
  p1: TTrackPattern;
begin
  for jC1 := 1 to self.Count do
  begin
    p1 := self[jC1].ukz as TTrackPattern;
    for jC2 := 1 to p1.Count do
    begin
      p1[jC2].fnSize := Value;
    end;
  end;
end;

procedure TGraphListPattern.SetSelectedTrack(const Value: integer);
begin
  FSelectedTrack := Value;
end;

{ TTrackPattern }

function TTrackPattern.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign( PrcdTrackPattern(ukz1).nChanal - PrcdTrackPattern(ukz2).nChanal );
     end;
  2: begin
       result := sign( PrcdTrackPattern(ukz1).number - PrcdTrackPattern(ukz2).number );
     end;
  else
    result := 0;
  end;
  Inc(result, 2);
end;

procedure TTrackPattern.Clone(Source: TTrackPattern);
begin
    inherited Clone(Source);
end;

constructor TTrackPattern.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTrackPattern);
end;

destructor TTrackPattern.Destroy;
begin
  inherited;
end;

function TTrackPattern.GetPntDyn(j: Integer): PrcdTrackPattern;
begin
  result := GetPnt(j);
end;

procedure TTrackPattern.Setactive(const Value: boolean);
begin
  Factive := Value;
end;

procedure TTrackPattern.SetSelect(const Value: boolean);
begin
  FSelect := Value;
end;

end.
