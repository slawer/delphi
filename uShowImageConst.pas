unit uShowImageConst;

interface
uses Math, Types, Graphics, uDEPGrafList1, uAbstrArray;

const
  pc005_110_jMain       = 5110;
  pc005_110_Caption     = '���������� �������� � ������';
  pc005_110_PrinterTitle = '������ ��������';

  pc005_110_AcceptMsg   = 131; // ��������� "��������� ���������"
  pc005_110_AcceptMsg1  = 132; // ��������� "������� ������"

  pc005_110_CB01_00     = '��������';
//  pc005_110_CB01_01     = '����� ����';
//  pc005_110_CB01_02     = '������� ����';
//  pc005_110_CB01_03     = '����������� ����';
//  pc005_110_CB01_04     = '������������� ����';
  pc005_110_CB01_05     = '������� ��������';

  pc005_110_CB01_01cl   = clGreen;
  pc005_110_CB01_05cl   = clBlue;

  pc005_110_CB01_05val  = 1;

  pc005_110_GD1_0_0     = '�����';
  pc005_110_GD1_1_0     = '��������';

//  pc005_110_001         = 2; // ���������� ��������
  pc005_110_002         = '������ �������� ';
  pc005_110_003         = '����������� ��������� � ������� ������. �� �������?';
  pc005_110_004         = '��������� ���������!';
  pc005_110_005         = '�������� ���������� ��������� �����������. �� �������?';
  pc005_110_006         = '��������� ����������� ��������!';
  pc005_110_007         = '��������� ���������� ���� �����������?';
  pc005_110_008         = '������������!';

  pc005_110_101         = '���������� ������� ��������� ����';
  pc005_110_102         = '��� �������� ������ ���� � %d "%s" - �������? �� �������?';
  pc005_110_103         = '���� ����� �����';
  pc005_110_104         = '��� �����:';
  pc005_110_105         = '����� ����';
  pc005_110_106         = '������ ������� ��������� ���� ��������';

  pc005_110_111         = '���������� ������� ������������� ����';
  pc005_110_112         = '��� �������������� ������ ���� � %d "%s" - �������������? �� �������?';
  pc005_110_113         = '���� ����� �����';
  pc005_110_114         = '����� ��� �����:';

  pc005_110_121         = '���������� ������� ������������ ����';
  pc005_110_123         = '������ ���������� ������ ����� ���� ��� �����';
  pc005_110_124         = '������ ���������� ������ ����� ���� ����� ������������ �����';
  pc005_110_125         = '������ ���������� ����� ����� ���� ��� ������';
  pc005_110_126         = '������ ���������� ����� ����� ���� ������ ���������� �����';

  pc005_110_131         = '���������� ������ �������� ��������������';
  pc005_110_132         = '������ ��� ����� ������ �����';

type
  TScreenShot1 = class
  private
  public
    fOtherParams: prqTobject;
    fgListArch: TprqRptGrafList4;
    procedure CloneClass(Source: TScreenShot1);
    constructor Create;
    destructor Destroy; override;
  end;

  TArrScreenShot1 = class(prqTobject)
  private
  public
    procedure CloneClass(Source: TArrScreenShot1);
    constructor Create;
    destructor Destroy; override;
  end;

  rcdTGrafInterval = packed record
    dTime:  Double;    // �����, ��������������� ��� �����
    pntImg: TPoint;    // ���������� ���� � ������������ �����������
    pntLog: TPoint;    // ���������� ���� ���������� � ������������ ����� � ������ ������
  end;
  PrcdTGrafInterval = ^rcdTGrafInterval;
  prqTGrafInterval = class(prqTabstract1)
  private
    function    GetPntDyn(j: Integer): PrcdTGrafInterval;
  protected
    function  Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
  public

// ��������� �������� ���������:
    intMod: Integer;

    property    pntDyn[j:Integer]: PrcdTGrafInterval read GetPntDyn; default;

    function  FindNearest(dTime: Double): Integer;

    constructor Create;
    destructor Destroy; override;
  end;


implementation

{ prqTGrafInterval }

function prqTGrafInterval.Check(ukz1, ukz2: Pointer;
  mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign(PrcdTGrafInterval(ukz1).dTime - PrcdTGrafInterval(ukz2).dTime) + 2;
     end;
  2: begin
       result := sign(PrcdTGrafInterval(ukz1).pntImg.Y - PrcdTGrafInterval(ukz2).pntImg.Y) + 2;
     end;
  3: begin
       result := sign(PrcdTGrafInterval(ukz1).pntLog.Y - PrcdTGrafInterval(ukz2).pntLog.Y) + 2;
     end;
  else begin result := 0; end;
  end;
end;

constructor prqTGrafInterval.Create;
begin
  inherited;
  FrcdSize := SizeOf(rcdTGrafInterval);
end;

destructor prqTGrafInterval.Destroy;
begin
  inherited;
end;

function prqTGrafInterval.FindNearest(dTime: Double): Integer;
var
  jC1: Integer;
  dD, dD2: Double;
begin
  result := 0;
  if Count = 0 then Exit;

  dD := Abs(self[1].dTime - dTime);
  result := 1;

  for jC1 := 2 to Count do
  begin
    dD2 := Abs(self[jC1].dTime - dTime);
    if dD2 < dD then
    begin
      result := jC1;
      dD     := dD2;
    end;
  end;
end;

function prqTGrafInterval.GetPntDyn(j: Integer): PrcdTGrafInterval;
begin
  result := GetPnt(j);
end;

{ TArrScreenShot1 }

procedure TArrScreenShot1.CloneClass(Source: TArrScreenShot1);
var
  jC1: Integer;
begin
  if not Assigned(Source) then Exit;

//  self.jUkz  := Source.jUkz;
  self.Count := Source.Count;
  for jC1 := 1 to self.Count do
  begin
    if not Assigned(self[jC1].ukz) then
    begin
      self[jC1].ukz := TScreenShot1.Create;
    end;
    (self[jC1].ukz as TScreenShot1).CloneClass(Source[jC1].ukz as TScreenShot1);
    self[jC1].key := Source[jC1].key;
  end;
end;

constructor TArrScreenShot1.Create;
begin
  inherited;
end;

destructor TArrScreenShot1.Destroy;
begin
  inherited;
end;

{ TScreenShot1 }

procedure TScreenShot1.CloneClass(Source: TScreenShot1);
var
  jC1: Integer;
begin
  if not Assigned(Source) then Exit;

  self.fOtherParams.Clone(Source.fOtherParams);
  for jC1 := 1 to self.fOtherParams.Count do
  begin
    self.fOtherParams[jC1].ukz := TprqRptTX.Create;
    (self.fOtherParams[jC1].ukz as TprqRptTX).CloneClass(Source.fOtherParams[jC1].ukz as TprqRptTX);
  end;

  self.fgListArch.CloneClass(Source.fgListArch);
end;

constructor TScreenShot1.Create;
begin
  fgListArch    := TprqRptGrafList4.Create;
  fOtherParams  := prqTobject.Create;
end;

destructor TScreenShot1.Destroy;
begin
  fgListArch.Free;
  fOtherParams.Free;
  inherited;
end;
end.
