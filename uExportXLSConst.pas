unit uExportXLSConst;

interface
uses
  uAbstrArray, uOreolProtocol6, Math;

const
  pc006_107_jMain       = 6107;
  pc006_107_Caption     = '������� ������ � XLS';

  pc006_107_frm01       = '%d %s[%s] (%s)';
  pc006_107_frm02       = '���������� ������ ����/������� � ������ � %d, ������� � %d';

  pc006_107_CrntD       = 1;
  pc006_107_PrevD       = 2;
  pc006_107_DBasD       = 3;

// [col,row]
  pc006_107_sg1_00_00   = '��������:';
  pc006_107_sg1_01_00   = '����';
  pc006_107_sg1_02_00   = '�����';
  pc006_107_sg1_00_01   = '������';
  pc006_107_sg1_00_02   = '�����';

  pc006_107_CmbBx1_00   = '����';
  pc006_107_CmbBx1_01   = '���.';
  pc006_107_CmbBx1_02   = '���.';

  pc006_107_CmbBx2_01   = '��������� �����';
  pc006_107_CmbBx2_02   = '������� �� ���������';

  pc006_107_CmbBx3_00   = '��������� ������� ����������';
  pc006_107_CmbBx3_01   = '����� �������';
  pc006_107_CmbBx3_02   = '������ �������';

  pc006_107_CmbBx4_00   = '��������� Nan';
  pc006_107_CmbBx4_01   = '������������ ���������� ��������';
//  pc006_107_CmbBx4_00   = '�������� "��� ����"';
//  pc006_107_CmbBx4_02   = '�������� ������������';

  pc006_107_CmbBx5_00   = '�������� � ���� - �������� "��� ����"';
  pc006_107_CmbBx5_01   = '������������ ���������� ��������';
  pc006_107_CmbBx5_02   = '���������� ������ �����';

  pc006_107_frm0        = 'dd.mm.yyyy hh:nn:ss.zzz';
  pc006_107_frm1        = 'dd.mm.yyyy hh:nn:ss';
  pc006_107_frm2        = 'dd.mm.yyyy hh:nn';
  pc006_107_frm4        = 'hh:nn:ss';
  pc006_107_PrtStep     = '    ';

  pc006_107_Hread_01tim  = 5000;           // ����� �������� ���������� �������� � ����
  pc006_107_Hread_01typ  = 139001;         // "���" ��������
  pc006_107_Hread_01cpt  = '���������� � ������ ������ ��';

  pc006_107_WindowXLSSize  = 5000;

  pc006_107_001         = '�������� ������� ���������� �����, ��� ���������';
  pc006_107_002         = '�� ������� �� ���� ����� ��� ��������';
  pc006_107_003         = '����������� ������� ������';
  pc006_107_004         = '������� ������ ����������, ��������� ��������� ���������� ��������';

  pc006_107_011         = '������ ������ �� ��';
  pc006_107_012         = '������ ��������, ����� ��������� %d �������';
  pc006_107_013         = '������� ������ � XLS ������ ��������. �������� %d �����';
  pc006_107_015         = '������� �� �� �������� �� ���������� ������������';
  pc006_107_016         = #13#10 + '������� � Excel:';
  pc006_107_017         = '������ ���������� � ��������:';
  pc006_107_018         = '������ ������ ������ �� ��:';
  pc006_107_019         = '������� �� �� �������� ��������';
  pc006_107_020         = '���� ������: ';
  pc006_107_021         = '  ������ ��: ';
  pc006_107_022         = '� �������� ��������� ������ �����������';

  pc006_107_111         = '����';
  pc006_107_112         = '�������';
  pc006_107_113         = '������';

  type

    prqTExpJob = class
    public
      bIncTime, bIncDepth, bIncIndex: Boolean;
      bOrigin:   Boolean;          // True - �������� ������ "��� ����"
      jMethod:   Integer;          // ����� ������������ ������
      jInterp:   Integer;          // ����� ������������ ������
      jAdmiss:   Integer;          // ����� �������� ������ �����
      jInterval: Integer;          // ������ ��������� (����, ���, ���)
      vInterval: Integer;          // �������� ��������� � ��. (����, ���, ���)
      jLegend:   Integer;          // ������ ������������ �������
      dNot, dNot1, dNot2: Double;  // ������� "��� ������" � �� � ���� ��������
      dNotIn, dNotIn1, dNotIn2: Double;  // ������� "��� ������" � ��������� � ���� ��������
      dStep:     Double;           // ��� �������
      sFrm:      String;           // ������ ������ ������ ����/�������
//      dtBeg, dtEnd: Double; // ��������� �����, � ������� ����� ������� ����
      rcdExport: rcdCMD_GetMeasuring;
      valExport: prqTabsField;
      valLegend: prqTpointer;
      constructor Create;
      destructor Destroy; override;
    end;

    rcdValStat =  packed record
      dVal:  Double;    // ��������
      jCnt:  Integer;   // ������� ���������
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
