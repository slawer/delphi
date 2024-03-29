unit uTransfer1const;

interface
uses
  SysUtils, Classes, uAbstrArray, Math, Variants,
  xmldom, XMLIntf, msxmldom, XMLDoc;

const
  pc006_110_jMain       = 6110;
  pc006_110_jMainProc1  = 6110000;
  pc006_110_jMainProc2  = 6110000;
  pc006_110_Caption     = '������� ������ �� ���������� �����������';
  pc006_110_CTpass      = '{0E04FBCE-2683-406F-93D1-2C52E7CAE9E3}.CTb.xml';

  pc006_110_Msg1        = pc006_110_jMain;

  pc006_110_SGTcnhCount = 256; // ���������� ������� � ��
  pc006_110_CNTcnhCount = 1024; // ���������� ������� � �����

  pc006_110_frm01       = '%d <%s>';
  pc006_110_frm02       = '���������� ������ ����/������� � ������ � %d, ������� � %d';

  pc006_110_CodeMSG01   = 301; // ��������� ������� ��������
  pc006_110_CodeMSG02   = 302; // ������ ��
  pc006_110_CodeMSG03   = 303; // �������� ���������� ��������

  pc006_110_CrntD       = 1;
  pc006_110_PrevD       = 2;
  pc006_110_DBasD       = 3;

// [col,row]
  pc006_110_sg1_00_00   = '��������:';
  pc006_110_sg1_01_00   = '����';
  pc006_110_sg1_02_00   = '�����';
  pc006_110_sg1_00_01   = '������';
  pc006_110_sg1_00_02   = '�����';

  pc006_110_sg2_00_00   = '��������:';
  pc006_110_sg2_01_00   = '����';
  pc006_110_sg2_02_00   = '�����';
  pc006_110_sg2_00_01   = '������';
  pc006_110_sg2_00_02   = '�����';

  pc006_110_sg3_00_00   = '�:';
  pc006_110_sg3_01_00   = '�� (����)';
  pc006_110_sg3_02_00   = '�����';
  pc006_110_sg3_03_00   = '�� (����)';
  pc006_110_sg3_04_00   = '�����';
//  pc006_110_sg3_05_00   = '�����';

  pc006_110_CBL_01_00   = '�� %s %s �� %s %s';

  pc006_110_sg5_00_00   = '� � ��';
  pc006_110_sg5_01_00   = '��� ������ � ��';
  pc006_110_sg5_02_00   = '� � �����';

  pc006_110_sg3_eps1    = 7;

  pc006_110_BlckPrmCnt  = 126;
  pc006_110_defDBsize   = 10;
  pc006_110_verDBnumb   = 3;

  pc006_110_001         = '�������� ������� ���������� �����, ��� ���������';
//  pc006_110_002         = '�� ������� �� ���� ����� ��� �������� ������';
  pc006_110_003         = '����������� ������� ������';
  pc006_110_004         = '������� ������ ����������, ��������� ��������� ���������� ��������';
  pc006_110_005         = '�������� �������, ��������� � �������, ����������� � ����� ������';
  pc006_110_006         = '���������� ������ � ������ %s � ���� "� � �����"';
  pc006_110_007         = '���������� ������ � ������ %s. ���� "� � �����" ������ ���� � ��������� �� 0 �� %d';
  pc006_110_008         = '';
  pc006_110_009         = '���������� �������������� ������� ������ ��� ��������������';
  pc006_110_010         = '������� ������������ ��������. ���� ������� ����, ���������� �������������� ��������. ����������?';
  pc006_110_011         = '����������� ���������, ����� ���������� ������';
  pc006_110_012         = '�� �� ������������ � ����� � ������� (��� � ��������� ����� ����� ���������� ���������� = 0)';
  pc006_110_013         = '�� ������� ��������� ��� �������� � ��';
  pc006_110_014         = '�������� � %d [%s] ����������� � ��. ����������?';
  pc006_110_015         = '�������� � %d [%s] ������ � ���������� ������� ��� ��������. ����������?';
  pc006_110_016         = '��������� �������� � %d [%s]. ����������?';
  pc006_110_017         = '���������� �������������� ������������ � ��';
  pc006_110_018         = '� ��������� ����� ����������� ����� �������, ��������� �������� ������';
  pc006_110_019         = '���������� ������ � ������ %d. ���� "� � �����" ������ ���� � ��������� �� 0 �� %d. ���������, ����������';
  pc006_110_020         = '������ ������� �������:';
  pc006_110_021         = '��������� ������ ������� ������� ������!';
  pc006_110_022         = '���������, ����������, ���������� ��������� KRS � ��������� �������!';
  pc006_110_023         = '���������� ��������� ���������� ����������� �������';
  pc006_110_024         = '������� ������� �� ��������. �� ����������� �� ���������� �������?';
  pc006_110_025         = '���������� ��������� �������������� ������� ������������';
  pc006_110_026         = '����������� ���������� � ������ ������ �����������';
  pc006_110_027         = '������� �������� �������������, �������� ����������� ���������� ���������';
  pc006_110_028         = '���������� � ������ ������ �����������';
  pc006_110_029         = '���������� � ������ ������ ����������� ���������';
  pc006_110_030         = '����������� �������� ��';
  pc006_110_031         = '������� ������� ���������';
  pc006_110_032         = '  �������� �������  %5d';
  pc006_110_033         = '  ���������� ������ %5d';
  pc006_110_034         = '������� ������ �� �����';
  pc006_110_035         = '����������� ������� ������ � ��';
  pc006_110_036         = '�������, ���������, ��� ��';
  pc006_110_037         = '�������� �� ����������� �������� �� ����������� �������. � ������ ���������� �������� ������������� ���������';
  pc006_110_038         = '����������� �������� ������ � ��';
  pc006_110_039         = '����� � �� ���������� �� ������� �� ����������� �������. � ������ ���������� �������� ������������� ���������';
  pc006_110_040         = '�������� ��������� � %d ����������� �������� �� ����������� �������. � ������ ���������� �������� ������������� ���������';

  pc006_110_frm0        = 'dd.mm.yyyy hh:nn:ss.zzz';
  pc006_110_frm1        = 'dd.mm.yyyy hh:nn:ss';
  pc006_110_frm2        = 'dd.mm.yyyy hh:nn';
  pc006_110_frm3        = 'dd-mm-yy hh:nn:ss.zzz';
  pc006_110_frm4        = 'hh:nn:ss';
  pc006_110_frm5        = 'db_%s';
  pc006_110_frm6        = 'yyyy_mm_dd_hh_nn_ss';

  pc006_110_Err1        = 'TcACtransfer1.Err1 ���������� ������ � 0� ������� ������ ������� ������������. ���������� �������� ������������� ��';
  pc006_110_Err2        = 'TcACtransfer1.Err2 �� ������� ������ � ������� ������������. ���������� �������� ������������� ��';
  pc006_110_Err3        = 'TcACtransfer1.Err3 ���������� ������ � 0� ������� ������ ������� ������������. ���������� �������� ������������� ��';

  pc006_110_Hread_01tim  = 5000;           // ����� �������� ���������� �������� � ����
  pc006_110_Hread_01typ  = 611001;         // "���" ��������
  pc006_110_Hread_01cpt  = '���������� � ������ ������ �����������';
  pc006_110_Hread_02cpt  = '������� ������ �� ����� �����������';


  pc006_110_XMLerr_000    = 0; // ���������� ����������
  pc006_110_XMLerr_001    = 1; // ����������� ������ �����
  pc006_110_XMLerr_002    = 2; // ���� ������������ ���������� ��� �� �������� ������������
//  pc006_110_XMLerr_003    = 3; // ���� ������������ ���������� ��� �� �������� ������������
//  pc006_110_XMLerr_010    =-1; // ���� ������������ ���������� ��� �� ������
  pc006_110_XMLerr_011    =-2; // ���� ������������ ���������� ��� �� ������

  pc006_110_xml1          = '<?xml version="1.0" encoding="UTF-8"?>';
  pc006_110_xml10         = '<dbDBserviceJob Ver="1">';

  pc006_110_xml11         = '<TfileACdescript.pathNET Val="%s"/>';
  pc006_110_xml12         = '<TfileACdescript.pathFld Val="%s"/>';
  pc006_110_xml13         = '<TCrossTableTab>';
  pc006_110_xml14         = '  <rcdCrossTableTab DBNumberChanal="%d" DBNameChanal= "%s" FlNumberChanal="%d" bSaveDB="%s" bActive="%s"/>';
  pc006_110_xml15         = '</TCrossTableTab>';

  pc006_110_xml50         = 'dbDBserviceJob';
  pc006_110_xml51         = 'Ver';
  pc006_110_xml52         = 'TfileACdescript.pathNET';
  pc006_110_xml53         = 'Val';
  pc006_110_xml54         = 'TfileACdescript.pathFld';
  pc006_110_xml55         = 'Val';
  pc006_110_xml56         = '1';
  pc006_110_xml57         = 'TCrossTableTab';
  pc006_110_xml58         = 'rcdCrossTableTab';
  pc006_110_xml59         = 'DBNumberChanal';
  pc006_110_xml60         = 'DBNameChanal';
  pc006_110_xml61         = 'FlNumberChanal';
  pc006_110_xml62         = 'bSaveDB';
  pc006_110_xml63         = 'bActive';

  pc006_110_xml99         = '</dbDBserviceJob>';

  pc006_110_201  = '���� ������������ ���������� �� ������. ' +
                   '���������� ������ ��������� ��������� ������� ����������� ������';
  pc006_110_202 = '������ ����� ������������ ���������� �����������'
                        + #13#10 +'���������� ������ ��������� ������������ ���������� ���';

type
  rcdCrossTableTab = packed record
    DBNumberChanal: integer; // ����� ������ � ��
    DBNameChanal:   string[127]; // ��� ������
    FlNumberChanal: integer; // ����� ������ � �����
    bSaveDB:        boolean; // ������� ���������� � ��
    bActive:        boolean; // ������� ����������
    guidChanal:     string[128]; // ��� ������
  end;
  PrcdCrossTableTab = ^rcdCrossTableTab;
  TCrossTableTab = class(prqTabstract1)
  private
    function    GetPntDyn(j: Integer): PrcdCrossTableTab;
  protected
  public
    property    pntDyn[j:Integer]: PrcdCrossTableTab read GetPntDyn; default;
    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;

    function    lineCount(bHideNotActive, bHideNotSaved: boolean): Integer;
    function    getActiveParam: Integer;
    constructor Create;
  end;

  rcdMetTdesript = packed record
    DateTime: TDateTime;
    FirstIndex: Int64;
    CheckIndex: Int64;
  end;
  PrcdMetTdesript = ^rcdMetTdesript;
  TMetTdesript = class(prqTabstract1)
  private
    FIndexBeg: integer;
    FIndexEnd: integer;
    FErr: string;
    function    GetPntDyn(j: Integer): PrcdMetTdesript;
    procedure SetIndexBeg(const Value: integer);
    procedure SetIndexEnd(const Value: integer);
    procedure SetErr(const Value: string);
  protected
  public
    property    Err: string read FErr write SetErr;
    property    IndexBeg: integer read FIndexBeg write SetIndexBeg;
    property    IndexEnd: integer read FIndexEnd write SetIndexEnd;
    property    pntDyn[j:Integer]: PrcdMetTdesript read GetPntDyn; default;
    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;
    function    FindInterval(dBeg, dEnd: Double): boolean;
    constructor Create;
  end;

  rcdDatInterval = packed record
    rcdTo:   rcdMetTdesript;
    rcdFrom: rcdMetTdesript;
  end;
  PrcdDatInterval = ^rcdDatInterval;
  TDatInterval = class(prqTabstract1)
  private
    fIndexBeg: integer;
    fIndexEnd: integer;
    fErr:       string;

    function    GetPntDyn(j: Integer): PrcdDatInterval;
    function    GetErr: string;
  protected
  public
    property    Err: string read GetErr;

    property    pntDyn[j:Integer]: PrcdDatInterval read GetPntDyn; default;
    function    Check(ukz1, ukz2: Pointer; mode: Integer): Integer; override;

    constructor Create;
  end;

  TfileACdescript = class(TObject)
  private
    FsErr: string;
    procedure SetsErr(const Value: string);
  protected
    jBegOfData, jEndOfData, jMaxShift, jSblk, jStrSize: integer;

  public
    pathNET: string;    // ���� � ����� � ����
    pathFld: string;    // ���� � ����� � �����
    path: string;    // ���� � �����
//    method: integer; // ����� �������: 1 - �� ����, 2 - � �����, 3 - ������ ������������

    j_SizeBuf: Int64; // ������ ������ ����� ������������ ���������� (������ �������������, �� ������ �� ������ DeviceManager2). �� ��������� ����� 512 ������;
    j_MetTCnt: Int64; // ���������� ����� �����/�������� (������������, ����� 1024);
    j_DataSze: Int64; // ������ ������� � ������� ����������� ������;
    j_MetTSft: Int64; // �������� ����� ����� �����/��������;
    j_DataSft: Int64; // �������� ����� ������;
    j_ParmCnt: Int64; // ���������� ����������, ������������ � �����;
    j_MetTPrd: Int64; // ������� ���������� ����� �����/��������;
    j_DataPrd: Int64; // ������� ���������� ������ � ����.

    b_Revolut: boolean; // ���� �������� ����� ������ ����� ������


    MetTdesript: TMetTdesript;
    DatInterval: TDatInterval;

    property sErr: string read FsErr write SetsErr;

    procedure _InitInerval(jBeg, jEnd: integer); // ���������� ������� ������ ���������
    function _getStrSize: Integer;               // ���������� ������ � ����� ������
    function _getBlkSize: Integer;               // ���������� ������, � ������ ������, ��������� � ����� ������
    function _isInternal(shftCurr, jBeg, jEnd: integer): boolean; // �������� ������� ������ ���������
    procedure _NextBlock(var shftCurr: integer; bSrez: boolean; FileStream: TFileStream);
    function  testCreateDataFile(
                  DataFileName: String;
                  StartDateTime, StopDateTime: Double;
                  Precision, Digits, jBeg, jEnd: Integer;
                  var sErr: string
                                ): Integer;

    procedure Clear;

    constructor Create;
    destructor  Destroy; override;
  end;


  prqTACTJob = class
  private
    FsErr: string;
    procedure SetsErr(const Value: string);
  public
    bDopProtokol: boolean;
    dtBeg, dtEnd: TDateTime; // ��������� �����, � ������� ����� ������� ����

    filePath: string;
    fileDescript: TfileACdescript;
    CrossTableTab: TCrossTableTab;

    property sErr: string read FsErr write SetsErr;

    function  allParamLoad(XMLDocument1: TXMLDocument): Integer;
    function  allParamTranslator(XmlNode: IXMLNode): Integer;
    function  allParamTranslatVer1(XmlNode: IXMLNode): Integer;

    function  allParamSave: Integer;

    constructor Create;
    destructor Destroy; override;
  end;

implementation
uses
  uSupport;

{ prqTACTJob }

function prqTACTJob.allParamLoad(XMLDocument1: TXMLDocument): Integer;
var
  Stream: TFileStream;
  Root: IXMLNode;
begin
  self.sErr := '';

  if not FileExists(self.filePath) then
  begin
    result := pc006_110_XMLerr_011; // �� ������ ���� ������������
    self.sErr := pc006_110_201;
    Exit;
  end;

  Stream := TFileStream.Create(self.filePath, fmOpenRead);
  try

    XMLDocument1.LoadFromStream(Stream, xetUTF_8);

    XMLDocument1.Active := True;
    Root := XMLDocument1.DocumentElement;
    result := allParamTranslator(Root);

  finally
    Stream.Free;
  end;
end;

function prqTACTJob.allParamSave: Integer;
var
  fileTxt: TextFile;
  wsXML: WideString;
  jC1: Integer;
begin
  AssignFile(fileTxt, self.filePath);
  try
    try
      Rewrite(fileTxt);

// ���������
      wsXML  := pc006_110_xml1;             WriteLn(fileTxt, UTF8Encode(wsXML));
      wsXML  := pc006_110_xml10;            WriteLn(fileTxt, UTF8Encode(wsXML));


// ���� �����
      wsXML  := format(pc006_110_xml11, [self.fileDescript.pathNET]);
                                            WriteLn(fileTxt, UTF8Encode(wsXML));
      wsXML  := format(pc006_110_xml12, [self.fileDescript.pathFld]);
                                            WriteLn(fileTxt, UTF8Encode(wsXML));

// ���� ������ ������� ����� �������
      wsXML  := pc006_110_xml13;            WriteLn(fileTxt, UTF8Encode(wsXML));
      for jC1 := 1 to self.CrossTableTab.Count do
      begin
        wsXML  := format(pc006_110_xml14,
                        [self.CrossTableTab[jC1].DBNumberChanal,
                         self.CrossTableTab[jC1].DBNameChanal,
                         self.CrossTableTab[jC1].FlNumberChanal,
                         uSupport.BoolToStr(self.CrossTableTab[jC1].bSaveDB),
                         uSupport.BoolToStr(self.CrossTableTab[jC1].bActive)
                        ]);
                                            WriteLn(fileTxt, UTF8Encode(wsXML));
      end;
      wsXML  := pc006_110_xml15;            WriteLn(fileTxt, UTF8Encode(wsXML));

  // �����
      wsXML  := pc006_110_xml99;            Write(fileTxt, UTF8Encode(wsXML));
      result := 0;
    except
      on E: Exception do
      begin
        sErr   := E.Message;
        result := 1;
      end;
    end;
  finally
    CloseFile(fileTxt);
  end;
end;

function prqTACTJob.allParamTranslator(XmlNode: IXMLNode): Integer;
var
  jVer, jC1: Integer;
  AttrNode: IXMLNode;
begin
  if XmlNode.NodeName = Null then
  begin
    result := pc006_110_XMLerr_002;
    Exit;
  end;

  if XmlNode.NodeName = pc006_110_xml50 then
  begin
// ������ ������ �����������
    jVer   := 0;
    result := pc006_110_XMLerr_001;
    for jC1 := 1 to xmlNode.AttributeNodes.Count do
    begin
      AttrNode := xmlNode.AttributeNodes.Nodes[jC1 - 1];
      if AttrNode.NodeName = Null then continue;
      if AttrNode.NodeName <> pc006_110_xml51 then continue;

      if AttrNode.Text = Null then
      begin
        sErr := pc006_110_202;
        Exit;
      end;

      if AttrNode.Text <> pc006_110_xml56 then
      begin
        sErr := uSupport.Podmena('#ver', AttrNode.Text, pc006_110_201);
        Exit;
      end;

      jVer := 1;
      break;
    end;

    if jVer = 1 then
    begin
      result := allParamTranslatVer1(XmlNode);
    end
    else
    begin
      sErr := pc006_110_202;
    end;
  end
  else
  begin
    result := pc006_110_XMLerr_002;
  end;
end;

function prqTACTJob.allParamTranslatVer1(XmlNode: IXMLNode): Integer;
var
  j1, jC2, jCattr1, jC1: Integer;
  ChildNode, ChildNode2: IXMLNode;
  AttrNode: IXMLNode;
  rcdCT: rcdCrossTableTab;
begin
  result := pc006_110_XMLerr_000;
  for jC1 := 1 to xmlNode.ChildNodes.Count do
  begin
    ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
    if ChildNode.NodeName = Null then continue;

    if ChildNode.NodeName = pc006_110_xml52 then // 'TfileACdescript.pathNET ';
    begin
      for jCattr1 := 1 to ChildNode.AttributeNodes.Count do
      begin
        AttrNode := ChildNode.AttributeNodes.Nodes[jCattr1 - 1];
        if AttrNode.NodeName = Null then continue;
        if AttrNode.NodeName = pc006_110_xml53 then
        begin
          if AttrNode.Text = Null then continue;
          self.fileDescript.pathNET := AttrNode.Text;
          break;
        end;
      end;
    end;

    if ChildNode.NodeName = pc006_110_xml54 then // 'TfileACdescript.pathNET ';
    begin
      for jCattr1 := 1 to ChildNode.AttributeNodes.Count do
      begin
        AttrNode := ChildNode.AttributeNodes.Nodes[jCattr1 - 1];
        if AttrNode.NodeName = Null then continue;
        if AttrNode.NodeName = pc006_110_xml55 then
        begin
          if AttrNode.Text = Null then continue;
          self.fileDescript.pathFld := AttrNode.Text;
          break;
        end;
      end;
    end;

    if ChildNode.NodeName = pc006_110_xml57 then // 'TCrossTableTab';
    begin
      for jC2 := 1 to ChildNode.ChildNodes.Count do
      begin
        ChildNode2 := ChildNode.ChildNodes.Nodes[jC2 - 1];
        if ChildNode2.NodeName = Null then continue;
        if ChildNode2.NodeName = pc006_110_xml58 then // 'rcdCrossTableTab'
        begin
          rcdCT.DBNumberChanal := -1;
          rcdCT.DBNameChanal   := '';
          rcdCT.FlNumberChanal := -1;
          rcdCT.bSaveDB        := false;
          rcdCT.bActive        := false;
          rcdCT.guidChanal     := '';
          for jCattr1 := 1 to ChildNode2.AttributeNodes.Count do
          begin
            AttrNode := ChildNode2.AttributeNodes.Nodes[jCattr1 - 1];
            if AttrNode.NodeName = Null then continue;
            if AttrNode.Text = Null then continue;

            if AttrNode.NodeName = pc006_110_xml59 then
            begin
              if not uSupport.prqStrToInt(AttrNode.Text, rcdCT.DBNumberChanal) then rcdCT.DBNumberChanal := -1;
              continue;
            end;

            if AttrNode.NodeName = pc006_110_xml60 then
            begin
              rcdCT.DBNameChanal := AttrNode.Text;
              continue;
            end;

            if AttrNode.NodeName = pc006_110_xml61 then
            begin
              if not uSupport.prqStrToInt(AttrNode.Text, rcdCT.FlNumberChanal) then rcdCT.FlNumberChanal := -1;
              continue;
            end;

            if AttrNode.NodeName = pc006_110_xml62 then
            begin
              rcdCT.bSaveDB := uSupport.StrToBool(AttrNode.Text);
              continue;
            end;

            if AttrNode.NodeName = pc006_110_xml63 then
            begin
              rcdCT.bActive := uSupport.StrToBool(AttrNode.Text);
              continue;
            end;
          end;

          if rcdCT.DBNumberChanal = -1 then continue;
          j1 := self.CrossTableTab.Find(@rcdCT, 1);
          if j1 > 0 then
          begin
            self.CrossTableTab[j1].FlNumberChanal := rcdCT.FlNumberChanal;
          end;
        end;
      end;
      self.CrossTableTab.Sort(1);
    end;

  end;
end;

constructor prqTACTJob.Create;
begin
  inherited;
  bDopProtokol := false;
  fileDescript := TfileACdescript.Create;
  CrossTableTab:= TCrossTableTab.Create;
end;

destructor prqTACTJob.Destroy;
begin
  fileDescript.Free;
  CrossTableTab.Free;
  inherited;
end;


procedure prqTACTJob.SetsErr(const Value: string);
begin
  FsErr := Value;
end;

{ TfileACdescript }

procedure TfileACdescript.Clear;
begin
//  method    := 0;
  j_SizeBuf := 0;
  j_MetTCnt := 0;
  j_DataSze := 0;
  j_MetTSft := 0;
  j_DataSft := 0;
  j_ParmCnt := 0;
  j_MetTPrd := 0;
  j_DataPrd := 0;
  MetTdesript.Count := 0;
  DatInterval.Count := 0;
end;

constructor TfileACdescript.Create;
begin
  pathNET   := '\\192.168.0.17\Transfer\Obmen.sd'; // ����� ����������� � ����� ���������
  pathFld   := 'H:\1.sd';
  path      := '';

  j_SizeBuf := 0;
  j_MetTCnt := 0;
  j_DataSze := 0;
  j_MetTSft := 0;
  j_DataSft := 0;
  j_ParmCnt := 0;
  j_MetTPrd := 0;
  j_DataPrd := 0;
  MetTdesript := TMetTdesript.Create;
  DatInterval := TDatInterval.Create;
end;

destructor TfileACdescript.Destroy;
begin
  MetTdesript.Free;
  inherited;
end;

procedure TfileACdescript.SetsErr(const Value: string);
begin
  FsErr := Value;
end;

function TfileACdescript.testCreateDataFile(DataFileName: String;
  StartDateTime, StopDateTime: Double; Precision, Digits, jBeg, jEnd: Integer;
  var sErr: string): Integer;
var
  fileTxt: TextFile;
  fName, sF, sD, s1: String;
  shftCurr, jC1, jC1inBlock: Integer;
  dCrnt, dCrntPrev: Double;
  sCrnt, sCrntPrev: String;
  vCrnt: single;
  FileStream: TFileStream;
begin
  sD := '; ';
  sF    := '%' + IntToStr(Digits) + '.' + IntToStr(Precision) + 'f';

  self.b_Revolut := false;
  fName := DataFileName;
  FileStream := nil;
  try
    FileStream := TFileStream.Create(self.pathFld, fmOpenRead or fmShareDenyNone);
    AssignFile(fileTxt, fName);
    try
      Rewrite(fileTxt);

      shftCurr := self.DatInterval[jBeg].rcdFrom.FirstIndex;
      FileStream.Seek(shftCurr, soFromBeginning);
      dCrntPrev := 0;

      while true do
      begin
        if not _isInternal(shftCurr, jBeg, jEnd) then
        begin
          break;
        end;

        s1 := '';

        FileStream.Read(dCrnt, SizeOf(dCrnt));

        if dCrnt = 0 then
        begin
          self._NextBlock(shftCurr, true, FileStream);
          continue;
        end;

        if dCrnt > StopDateTime then break;

        if dCrnt < StartDateTime then
        begin
          self._NextBlock(shftCurr, true, FileStream);
          continue;
        end;

        if dCrntPrev > dCrnt then break;

        sCrnt     := DateTimeToStr(dCrnt);
        sCrntPrev := DateTimeToStr(dCrntPrev);
        if sCrnt = sCrntPrev then
        begin
          self._NextBlock(shftCurr, true, FileStream);
          continue;
        end;

        jC1inBlock := 0;
        for jC1 := 1 to self.j_ParmCnt do
        begin
          if jC1 = 1 then
          begin
            s1 := IntToHex(shftCurr, 8) + sD + formatDateTime('dd.mm.yy hh:nn:ss', dCrnt);
          end;

          s1 := s1 + sD;
          Inc(jC1inBlock);
          if jC1inBlock > pc006_110_BlckPrmCnt then
          begin
            jC1inBlock := 1;

            FileStream.Read(dCrnt, SizeOf(dCrnt));
            if dCrnt = 0 then break;
            if dCrnt > StopDateTime then break;
            continue;
          end;

          FileStream.Read(vCrnt, SizeOf(vCrnt));
          s1 := s1 + format(sF, [vCrnt]);
        end;

        if Length(s1) > 0 then
        begin
          WriteLn(fileTxt, s1);
          self._NextBlock(shftCurr, true, FileStream);
        end
        else
        begin
          break;
        end;

        dCrntPrev := dCrnt;
      end;

  // �����
      result := 0;
    finally
      FileStream.Free;
      CloseFile(fileTxt);
    end;
  except
    on E: Exception do
    begin
      FileStream.Free;
      sErr := E.Message;
      result := 1;
    end;
  end;
end;

function TfileACdescript._getBlkSize: Integer;
begin
  try
    result := self.j_MetTPrd div self.j_DataPrd;
  except
    result := 30;
  end;
end;

function TfileACdescript._getStrSize: Integer;
var
  j1: integer;
begin
  try
    j1 := ( ((self.j_ParmCnt - 1) div pc006_110_BlckPrmCnt) + 1 );
    result := self.j_SizeBuf * j1;
  except
    result := self.j_SizeBuf;
  end;
end;

procedure TfileACdescript._InitInerval(jBeg, jEnd: integer);
begin
  self.jStrSize     :=   _getStrSize;
  self.jSblk        :=   self.jStrSize * _getBlkSize;

  self.jBegOfData   :=   self.MetTdesript[jBeg].FirstIndex;
  self.jEndOfData   :=   self.MetTdesript[jEnd].FirstIndex + jSblk;
  self.jMaxShift    :=   self.j_DataSze + self.j_DataSft;

  if self.jEndOfData > self.jMaxShift then
  begin
    self.jEndOfData := (self.jEndOfData - self.jMaxShift) + self.j_DataSft;
    if self.jBegOfData < self.jEndOfData then
    begin
      self.jEndOfData := self.jBegOfData;
    end;
  end;
end;

function TfileACdescript._isInternal(shftCurr, jBeg,
  jEnd: integer): boolean;
begin
  if self.jBegOfData < self.jEndOfData then
  begin
    if (shftCurr >= self.jBegOfData)  and  (shftCurr <= self.jEndOfData) then
    begin
      result := true;
    end
    else
    begin
      result := false;
    end;
    Exit;
  end

  else

  begin //  jBegOfData >= jEndOfData
    if self.b_Revolut then
    begin
      if shftCurr <= self.jEndOfData then
      begin
        result := true;
      end
      else
      begin
        result := false;
      end;
    end
    else
    begin
      if (shftCurr >= self.jBegOfData)  and  (shftCurr <= self.jMaxShift) then
      begin
        result := true;
      end
      else
      begin
        result := false;
      end;
    end;
  end;
end;

procedure TfileACdescript._NextBlock(var shftCurr: integer; bSrez: boolean;
  FileStream: TFileStream);
var
  jPos: integer;
begin
  if bSrez then
  begin
    Inc(shftCurr, self.jStrSize);
  end
  else
  begin
    Inc(shftCurr, self.j_SizeBuf);
  end;

  if shftCurr >= self.jMaxShift then
  begin
    self.b_Revolut := true;
    shftCurr := self.j_DataSft;
    FileStream.Seek(shftCurr, soFromBeginning);
  end
  else
  begin
    jPos := FileStream.Position;
    FileStream.Seek(shftCurr - jPos, soFromCurrent);
  end;
end;

{ TMetTdesript }

function TMetTdesript.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign(PrcdMetTdesript(ukz1).DateTime - PrcdMetTdesript(ukz2).DateTime) + 2;
     end;
  2: begin
       result := sign(PrcdMetTdesript(ukz1).FirstIndex - PrcdMetTdesript(ukz2).FirstIndex) + 2;
     end;
  else begin result := 0; end;
  end;
end;

constructor TMetTdesript.Create;
begin
  FrcdSize := SizeOf(rcdMetTdesript);
end;

function TMetTdesript.FindInterval(dBeg, dEnd: Double): boolean;
var
  bEnd: Boolean;
  jCount, jC1: integer;
begin
// ����� ����� �������, ��������������� �������
// �������� ��������� � ���������
  result := false;
  jCount := self.Count;
  if jCount = 0 then
  begin
    self.fErr := pc006_110_018;
    Exit;
  end;

  if dBeg > self[1].DateTime then
  begin
    self.fErr := pc006_110_005;
    Exit;
  end;

  if dEnd < self[jCount].DateTime then
  begin
    self.fErr := pc006_110_005;
    Exit;
  end;

  bEnd := true;
  self.fIndexEnd := -1;
  self.fIndexBeg := -1;

  for jC1 := 1 to jCount do
  begin

    if bEnd then
    begin
      if dEnd < self[jC1].DateTime then continue;
      self.fIndexEnd := jC1;
      bEnd := false;
    end;

    if dBeg < self[jC1].DateTime then continue;
    self.fIndexBeg := jC1;
    break;

  end;

  if self.fIndexBeg = -1 then
  begin
    self.fIndexBeg := jCount;
  end;

  result := true;
end;

function TMetTdesript.GetPntDyn(j: Integer): PrcdMetTdesript;
begin
  result := GetPnt(j);
end;

procedure TMetTdesript.SetErr(const Value: string);
begin
  FErr := Value;
end;

procedure TMetTdesript.SetIndexBeg(const Value: integer);
begin
  FIndexBeg := Value;
end;

procedure TMetTdesript.SetIndexEnd(const Value: integer);
begin
  FIndexEnd := Value;
end;

{ TDatInterval }

function TDatInterval.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign(PrcdDatInterval(ukz1).rcdTo.DateTime     - PrcdDatInterval(ukz2).rcdTo.DateTime)     + 2;
     end;
  2: begin
       result := sign(PrcdDatInterval(ukz1).rcdTo.FirstIndex   - PrcdDatInterval(ukz2).rcdTo.FirstIndex)   + 2;
     end;
  3: begin
       result := sign(PrcdDatInterval(ukz1).rcdFrom.DateTime   - PrcdDatInterval(ukz2).rcdFrom.DateTime)   + 2;
     end;
  4: begin
       result := sign(PrcdDatInterval(ukz1).rcdFrom.FirstIndex - PrcdDatInterval(ukz2).rcdFrom.FirstIndex) + 2;
     end;
  else
     begin
       result := 0;
     end;
  end;
end;

constructor TDatInterval.Create;
begin
  FrcdSize := SizeOf(rcdDatInterval);
  fIndexBeg := 0;
  fIndexEnd := 0;
  fErr      := '';
end;

function TDatInterval.GetErr: string;
begin
  result := fErr;
end;

function TDatInterval.GetPntDyn(j: Integer): PrcdDatInterval;
begin
  result := GetPnt(j);
end;

{ TCrossTableTab }

function TCrossTableTab.Check(ukz1, ukz2: Pointer; mode: Integer): Integer;
begin
  case mode of
  1: begin
       result := sign(PrcdCrossTableTab(ukz1).DBNumberChanal - PrcdCrossTableTab(ukz2).DBNumberChanal) + 2;
     end;
  2: begin
       result := sign(PrcdCrossTableTab(ukz1).FlNumberChanal - PrcdCrossTableTab(ukz2).FlNumberChanal) + 2;
     end;
  else begin result := 0; end;
  end;
end;

constructor TCrossTableTab.Create;
begin
  FrcdSize := SizeOf(rcdCrossTableTab);
end;

function TCrossTableTab.getActiveParam: Integer;
var
  j1, jC1: integer;
begin
  j1 := 0;
  for jC1 := 1 to self.Count do
  begin
    if self[jC1].FlNumberChanal >= 0 then Inc(j1);
  end;
  result := j1;
end;

function TCrossTableTab.GetPntDyn(j: Integer): PrcdCrossTableTab;
begin
  result := GetPnt(j);
end;

function TCrossTableTab.lineCount(bHideNotActive, bHideNotSaved: boolean): Integer;
var
  j1, jC1: integer;
begin
  j1 := 0;
  for jC1 := 1 to self.Count do
  begin
    if bHideNotActive then
    begin
      if self[jC1].FlNumberChanal < 0 then
      begin
        continue;
      end;
//      if not self[jC1].bActive then continue;
    end;
    if bHideNotSaved then
    begin
      if not self[jC1].bSaveDB then continue;
    end;
    Inc(j1);
  end;
  result := j1;
end;

end.
