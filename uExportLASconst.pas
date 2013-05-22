unit uExportLASconst;

interface
uses
  uAbstrArray, uOreolProtocol6, Math;

const
  pc006_108_jMain       = 6108;
  pc006_108_Caption     = '������� ������ � LASS ������';

  pc006_108_frm01       = '%d <%s>';
  pc006_108_frm02       = '���������� ������ ����/������� � ������ � %d, ������� � %d';
  pc006_108_frm03       = '%d %s[%s] (%s)';

  pc006_108_CrntD       = 1;
  pc006_108_PrevD       = 2;
  pc006_108_DBasD       = 3;
  pc006_108_Hread_01tim = 5000;           // ����� �������� ���������� �������� � ����
  pc006_108_Hread_01typ = 136001;         // "���" ��������
  pc006_108_Hread_01cpt  = '������� ������ � LASS ������';

// [col,row]
  pc006_108_sg1_00_00   = '��������:';
  pc006_108_sg1_01_00   = '����';
  pc006_108_sg1_02_00   = '�����';
  pc006_108_sg1_00_01   = '������';
  pc006_108_sg1_00_02   = '�����';

  pc006_108_CmbBx1_Msht = 1000;
  pc006_108_CmbBx1_00   = '��';
  pc006_108_CmbBx1_01   = '��';
  pc006_108_CmbBx1_02   = '�';

  pc006_108_CmbBx2_01   = '������ �������� �� ���������';
  pc006_108_CmbBx2_02   = '������� �������� �� ���������';
  pc006_108_CmbBx2_03   = '��������� ����� �� ���������';

  pc006_108_CmbBx3_00   = '��������� ������� ����������';
  pc006_108_CmbBx3_01   = '����� �������';
  pc006_108_CmbBx3_02   = '������ �������';

  pc006_108_CmbBx4_00   = '������������ ���������� ��������';
  pc006_108_CmbBx4_01   = '��������� ��������� NAN';
//  pc006_108_CmbBx4_02   = '�������� ������������';

  pc006_108_CmbBx5_00   = 'MS DOS Ascii';
  pc006_108_CmbBx5_01   = 'Windows Cirilic (1251)';

  pc006_108_CmbBx6_00   = '������ ( )';
  pc006_108_CmbBx6_01   = '��������� ( )';
  pc006_108_CmbBx6_02   = '������� ( , )';
  pc006_108_CmbBx6_03   = '����� � ������� ( ; )';
  pc006_108_CmbBx6_04   = '������ "�������" ����:';

  pc006_108_CmbBx7_00   = '����� ( . )';
  pc006_108_CmbBx7_01   = '������� ( , )';
  pc006_108_CmbBx7_02   = '������ "�������" ����:';

  pc006_108_001         = '�������� ������� ���������� �����, ��� ���������';
  pc006_108_002         = '�� ������� �� ���� ����� ��� ��������';
  pc006_108_003         = '����������� ������� ������';
  pc006_108_004         = '������� ������ ����������, ��������� ��������� ���������� ��������';
  pc006_108_005         = '������� ������ ����������, ����� ������-����������� == 0';
  pc006_108_006         = '��������� ���� ����������. ������������?';
  pc006_108_007         = '�������, ���������� ����, � ������� ����� ���������������� ���� ������';
  pc006_108_008         = '������� ������ ����������, ���������� ������ � ������ ��������� Nan';
  pc006_108_009         = '������� ������ ����������, ������ ���� ������������ ������ ���� ������ ������� ���� ������';
  pc006_108_010         = '�� ������� ������� �������. ����������?';
  pc006_108_011         = '������� ������ ����������, ��������� ��������� ���������� ��������';
  pc006_108_012         = #13#10 + '������� � LASS ������:';
  pc006_108_013         = '���������� � �� %s';
  pc006_108_014         = '  ������ ��: ';
  pc006_108_015         = '���� ������: ';
  pc006_108_016         = '������ ���������� � ��������:';
  pc006_108_017         = '������� �� �� �������� �� ���������� ������������';
  pc006_108_019         = '������� �� �� �������� ��������';
  pc006_108_020         = '������ ������ ������ �� ��:';
  pc006_108_021         = '������ ��������, ����� ��������� %d �������';
  pc006_108_022         = '� �������� ��������� ������ �����������';
  pc006_108_024         = '������� ������ � LASS ������ ��������. �������� %d �����';

  pc006_108_101         = '����';
  pc006_108_102         = '�������';
  pc006_108_103         = '������';

  pc006_108_frmSizeInt  = '������ ���� ������������ (� %s):';

  pc006_108_frm0        = 'dd.mm.yyyy hh:nn:ss,zzz';
  pc006_108_frm1        = 'dd.mm.yyyy hh:nn:ss';
  pc006_108_frm2        = 'dd.mm.yyyy hh:nn';
  pc006_108_frm4        = 'hh:nn:ss';
  pc006_108_PrtStep     = '    ';
  pc006_108_TypeFls     = 'LASS ������ (*.las)|*.las|��������� (*.txt)|*.txt|��� (*.*)|*.*';
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
  pc006_108_CodeChManu  = 4; // ������ � ������
  pc006_108_SCodeChProb  = ' ';
  pc006_108_SCodeChTab   = #8; //
  pc006_108_SCodeChComa  = ','; // ,
  pc006_108_SCodeChCoPt  = ';'; // ;

  pc006_108_ComaChPoint = 0;
  pc006_108_ComaChComa  = 1; // ,
  pc006_108_ComaChManu  = 2; // ������ � ������
  pc006_108_SComaChPoint = '.';
  pc006_108_SComaChComa  = ','; // ,

  pc006_108_EmptyHeadField = '---';

// ���������� ��������� LASS ������ �����
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
      bOrigin:   Boolean;          // True - �������� ������ "��� ����"
      jMethod:   Integer;          // ����� ������������ ������
      jInterp:   Integer;          // ����� ������������ ������
      jInterval: Integer;          // ������ ��������� (��, ��, �)
      vInterval: Integer;          // �������� ��������� � ��. (��, ��, �)
      jLegend:   Integer;          // ������ ������������ �������
      vInterpol: Integer;          // �������� ��������� ����������� � ��. (��, ��, �)


      jCodeFile: Integer;          // ��������� �����
      jCodeChar: Integer;          // ����� �����������
      sCodeChar: String;           // ������ �����������

      jComaChar: Integer;          // ����� ���������� �����
      sComaChar: String;           // ������ ���������� �����

      bTreamFld: Boolean;          // ���� ����������� ������ �������

      dNot, dNot1, dNot2: Double;  // ������� "��� ������" � �� � ���� ��������
      dNotIn, dNotIn1, dNotIn2: Double;  // ������� "��� ������" � ��������� � ���� ��������

      jStep:       Integer;        // ��� ������� � ��
      jStepInterp: Integer;        // ��� ����������� � ��
      sFrm:      String;           // ������ ������ ����/�������
      sFrmH:     String;           // ������ ������ �������
      hBeg, hEnd: Double;          // ������� ������, ������� �������� � ��������
      constNan:  Double;           // ��������� Nan
      rcdExport: rcdCMD_GetMeasuring;
      valExport: prqTabsField;
      valLegend: prqTpointer;

      sFileName: String;
      isExist:   Boolean;          // ���� ��� ����������!

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
