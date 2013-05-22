unit uDEPgrafJob2;

interface
uses
  Windows, SysUtils, registry, IniFiles, Math, Classes, uAbstrArray,
  uMainData,
  xmldom, XMLIntf, msxmldom, XMLDoc, Variants, uAbstrExcel,
  uDEPdescript2, uDEPgrafJob2Const, uSGTlibDB1, Graphics, uDEPGrafList1,
  Dialogs, uGraphPatterns1, uOreolProtocol6, uDEPdescript2const, uKRSfunctionV3,
  uExportXLSConst;

type

  TDEPgrafJob1 = class(DEPreportJobAll)
  private
    FModify: boolean;
    FDOit: boolean;
    procedure _setGeoVal(AttrNode: IXMLNode; var jVal: integer);
    procedure _setClrVal(AttrNode: IXMLNode; var cVal: TColor);
    procedure _setIntVal(AttrNode: IXMLNode; var jVal: integer);
    procedure _setStrVal(AttrNode: IXMLNode; var sVal: string);
    procedure _setDblVal(AttrNode: IXMLNode; var dVal: Double);
    procedure SetDOit(const Value: boolean);
    procedure SetModify(const Value: boolean);

  public
    tmpSgtGraphParamName:  string; // ��� ���������� ����� ��� ������ �� ��
    xlsSgtGraphShblnName:  string; // ��� ��������� ����� � ���������
    xlsSgtGraphReprtName:  string; // ��� ����� � ���������
    bmpSgtGraphReprtName:  string; // ��� ��������� �������

    cnfSgtGraphParamName: string;   // ��� ����� � ������������� ������� ������� param
    xlsSgtRptShblnName: string;   // ��� ����� � �������� ������
    xlsSgtRptReprtName: string;   // ��� ����� � �������

//    DEPqueParam:  TDEPquery1;
    DEPGrhDescr:  TDEPGraphDescribe;
    DEPrptParam:  TDEPrptSGT;

    gList: TprqRptGrafList4; // ����������� ���� ������
    OtherParams: prqTobject;
    pctWidth: integer;
    pctHeight: integer;


    property DOit: boolean read FDOit write SetDOit;
    property Modify: boolean read FModify write SetModify;

    function  grfParamLoad: Integer;
    function  grfParamTranslator(XmlNode: IXMLNode): Integer;
    function  grfParamTranslatVer1(XmlNode: IXMLNode): Integer;
    function  grfParamTranslatVer1_1(XmlNode: IXMLNode): Integer; // �������
    function  grfParamTranslatVer1_2(XmlNode: IXMLNode): Integer; // ������
    function  grfParamTranslatVer1_3(XmlNode: IXMLNode): Integer; // ��������_�����
    function  grfParamTranslatVer1_4(XmlNode: IXMLNode): Integer; // ����������_�����
    function  grfParamTranslatVer1_5(XmlNode: IXMLNode): Integer; // ����������_��������
    function  grfParamTranslatVer1_6(XmlNode: IXMLNode; cTrack: TTrackPattern): Integer; // �����������_����
    function  grfParamTranslatVer1_7(XmlNode: IXMLNode; cTrack: TTrackPattern): Integer; // ������
    function  grfParamTranslatVer1_8(XmlNode: IXMLNode; Prcd: PrcdTrackPattern): Integer; // ����� ��������=...
    function  grfParamTranslatVer1_9(XmlNode: IXMLNode): Integer; // ����� ��������=...

    function  grfParamTranslatVer2(XmlNode: IXMLNode): Integer;
    function  grfParamTranslatVer2_1(XmlNode: IXMLNode): Integer; // �������
    function  grfParamTranslatVer2_6(XmlNode: IXMLNode; cList: TGraphListPattern): Integer; // �����������_����

    function  grfParamSave: Integer;

// ����� ������ ����� jCode � ����� cTrack
// ���� ������ �����������, �� �������� ���
    function  AddQueParam(jCode: Integer; cTrack: TTrackPattern): Integer; overload;

    function  AddGraphDescr(jCode: Integer): Integer;

    function  createDayliRaport: Integer; // �������� ����������� �������
    procedure calcSvodka; // ������ ������, ������ ������� ������������ �������
    procedure reductSvodka(jScale: integer; listSost: TDEPstepProc; dStep: TDateTime); // ������ ������ �� ���������� �������
    function _setNumberEtap(dE: single): integer;
    procedure _mdfyCouners(pRcd: PrcdDEPstepProc);
    function _setDepth(dE: single): single;

    function CreateRaport: Integer;       // �������� ��������

class function _CheckDouble(const Txt: String; var dRes: Double): Boolean;

    constructor Create;
    destructor  Destroy; override;
  end;


implementation
uses uSupport;

{ TDEPgrafJob1 }

function TDEPgrafJob1.AddGraphDescr(jCode: Integer): Integer;
var
  rcd: rcdDEPlistChanGraphDescr;
begin
  rcd.nChanal := jCode;
  result := self.DEPGrhDescr.listGrfS.Find(@rcd, 1);
  if result = 0 then
  begin
    rcd.active   := false;
    rcd.number   := 0;
//    rcd.nChanal  := -1;
    rcd.sName    := '';
    rcd.sPodp    := '';
    rcd.sEdIzm   := '';
    rcd.diaMin   :=  0;
    rcd.diaMax   :=  0;
    rcd.Color    := clBlack;
    rcd.xLogSize :=  5;
    rcd.xLogStep := 10;
    rcd.fnSize   :=  8;
    rcd.Precision :=  0;
//    rcd.Digits    :=  3;
    self.DEPGrhDescr.listGrfS.Append(@rcd);
    result := self.DEPGrhDescr.listGrfS.Count;
  end;
end;

function TDEPgrafJob1.AddQueParam(jCode: Integer;
  cTrack: TTrackPattern): Integer;
var
  rcd: rcdTrackPattern;
begin
  rcd.number := jCode;
  result := cTrack.Find(@rcd, 2);
  if result = 0 then
  begin
    rcd.active  := false;
    rcd.nChanal  := -1;
    rcd.sName    := '';
    rcd.sPodp    := '';
    rcd.sEdIzm   := '';
    rcd.diaMin   :=  0;
    rcd.diaMax   :=  0;
    rcd.Color    := clBlack;
    rcd.xLogSize :=  5;
    rcd.xLogStep := 10;
    rcd.fnSize   :=  8;
    rcd.Precision :=  0;
//    rcd.Digits    :=  3;
    cTrack.Append(@rcd);
    result := cTrack.Count;
  end;
end;

procedure TDEPgrafJob1.calcSvodka;
var
  rcd:  rcdDEPstepProc;
  jL, jEtap, {jRezhim,} jLngVal, jC1:  integer;
  dDpth, dE: single;
  dT, dTimOut: TDateTime; // ������ ��������
  bFirst: boolean;
begin
// ��������!
  self.DEPrptParam.listSost.Count := 0;
  self.DEPrptParam.dTspo          := 0;
  self.DEPrptParam.dTprom         := 0;
  self.DEPrptParam.dTpror         := 0;
  self.DEPrptParam.dTbur          := 0;
  self.DEPrptParam.dTnar          := 0;
  self.DEPrptParam.dTpzr          := 0;

  dTimOut := 1;
  dTimOut := dTimOut / (24 * 60); // ������� 1 ������
  bFirst := true;


// �������� ��������� ������ � �������
  jLngVal := self.DEPqueParam.valReport.Count;
  for jC1 := 1 to jLngVal do
  begin
    if bFirst then
    begin
      dE := self.DEPqueParam.valReport.getValField(jC1, 4);
      if not TkrsFunction.isValid(dE) then
      begin
        continue;
      end;
      rcd.dBeg   := self.DEPqueParam.valReport.getValField(jC1, 2);
      rcd.dEnd   := rcd.dBeg;
      rcd.Etap   := _setNumberEtap(dE);
      bFirst := false;
    end
    else
    begin

      dE         := self.DEPqueParam.valReport.getValField(jC1, 4);
      if not TkrsFunction.isValid(dE) then
      begin
        continue;
      end;
      dT         := self.DEPqueParam.valReport.getValField(jC1, 2);
      jEtap      := _setNumberEtap(dE);

      if (dT - rcd.dEnd) >= dTimOut then
      begin
// ��������� ���������� ��������
        if (rcd.dEnd - rcd.dBeg) > 0 then
        begin
          self.DEPrptParam.listSost.Append(@rcd);
          _mdfyCouners(@rcd);
        end;
// ��������� ������ ����������
        rcd.dBeg   := dT;
        rcd.dEnd   := dT;
        rcd.Etap   := jEtap;
        continue;
      end;

      rcd.dEnd   := dT;
      if (jEtap <> rcd.Etap) then
      begin
// ��������� ���������� ��������
        self.DEPrptParam.listSost.Append(@rcd);
        _mdfyCouners(@rcd);
// ��������� ������ ����������
        rcd.dBeg   := rcd.dEnd;
        rcd.Etap   := jEtap;
//        rcd.Rezhim := jRezhim;
      end;
    end;
  end;

  if rcd.dEnd > rcd.dBeg then
  begin
    self.DEPrptParam.listSost.Append(@rcd);
    _mdfyCouners(@rcd);
  end;

  jL := self.DEPqueParam.valReport.Count;
  if jL > 0 then
  begin
    self.DEPrptParam.dptBeg := 0;
    for jC1 := 1 to jL do
    begin
      dDpth := self.DEPqueParam.valReport.getValField(jC1, 5);
      if TkrsFunction.isValid(dDpth) then
      begin
        self.DEPrptParam.dptBeg := dDpth;
        break;
      end;
    end;

    self.DEPrptParam.dptEnd := self.DEPrptParam.dptBeg;
    for jC1 := jL downto 1 do
    begin
      dDpth := self.DEPqueParam.valReport.getValField(jC1, 5);
      if TkrsFunction.isValid(dDpth) then
      begin
        self.DEPrptParam.dptEnd := dDpth;
        break;
      end;
    end;
  end
  else
  begin
    self.DEPrptParam.dptBeg := 0;
    self.DEPrptParam.dptEnd := 0;
  end;
end;

constructor TDEPgrafJob1.Create;
begin
  inherited;
//  DEPqueParam  := TDEPquery1.Create;
  DEPGrhDescr  := TDEPGraphDescribe.Create;
  DEPrptParam  := TDEPrptSGT.Create;
  gList        := TprqRptGrafList4.Create;
  OtherParams  := prqTobject.Create;

  tmpSgtGraphParamName := '';
  xlsSgtGraphShblnName := '';
  xlsSgtGraphReprtName := '';

  xlsSgtRptShblnName := '';
  xlsSgtRptReprtName := '';
end;

function TDEPgrafJob1.createDayliRaport: Integer;
var
  sNameFile, s1: String;
  xls: TprqExcel;
  jScale, jColCount, jCol1, jCol2, jCol3, jCol4, jPos, jC1, j1, jL: integer;
  vVal: Variant;
  dStep, dT, dTb, dTe: TDateTime;
  _listSost: TDEPstepProc;
  xlsData: OLEVariant;  // ������ ��� �������� ������
begin
// ������� ���������, ���������� ��������� ��������
  calcSvodka;

// ������� ���� Excel �� �������
  if not prqSaveCopyFile(self.xlsSgtRptReprtName, s1) then addError(s1);
  if not prqCopyFile(self.xlsSgtRptShblnName, self.xlsSgtRptReprtName, s1) then
  begin
    addError(s1);
    result := 1;
    Exit;
  end;

// ���������� ��� ���� ���� ����
  xlsData := Null;
  xls := TprqExcel.Create;
  try
    if not xls.OpenWorkBook(self.xlsSgtRptReprtName) then
    begin
      addError(xls.strErr);
      result := 2;
      Exit;
    end;
    if not xls.OpenWorkSheet(1) then
    begin
      addError(xls.strErr);
      result := 2;
      Exit;
    end;

// �����
    vVal := Trunc(self.DEPqueParam.dBeg); // ���� ������
    xls.putString(pc006_502_Shab_Col1,  pc006_502_Shab_Row1, vVal);

{
      dE := self.DEPqueParam.valReport.getValField(jC1, 4);
}
    vVal := self.DEPrptParam.dptBeg; // �������(���. ���.)
    xls.putString(pc006_502_Shab_Col2,  pc006_502_Shab_Row2, vVal);

    vVal := self.DEPrptParam.dptEnd; // �������(���. ���.)
    xls.putString(pc006_502_Shab_Col3,  pc006_502_Shab_Row3, vVal);

    vVal := self.DEPrptParam.dptEnd - self.DEPrptParam.dptBeg; //  ��������
    xls.putString(pc006_502_Shab_Col4,  pc006_502_Shab_Row4, vVal);

    vVal := self.DEPqueParam.dStart; // ���� ������ �������
    xls.putString(pc006_502_Shab_Col5,  pc006_502_Shab_Row5, vVal);

    vVal := self.DEPqueParam.Skvagina; // ��������
    xls.putString(pc006_502_Shab_Col6,  pc006_502_Shab_Row6, vVal);

    vVal := self.DEPqueParam.Kust; // ����
    xls.putString(pc006_502_Shab_Col7,  pc006_502_Shab_Row7, vVal);

    vVal := self.DEPqueParam.Zakaz; // ��������
    xls.putString(pc006_502_Shab_Col8,  pc006_502_Shab_Row8, vVal);

    vVal := self.DEPqueParam.Podrjad; // ���������
    xls.putString(pc006_502_Shab_Col9,  pc006_502_Shab_Row9, vVal);

    vVal := self.DEPqueParam.Station; // �������
    xls.putString(pc006_502_Shab_Col11, pc006_502_Shab_Row11, vVal);

    vVal := self.DEPqueParam.MainPersons; // ������
    xls.putString(pc006_502_Shab_Col10, pc006_502_Shab_Row10,vVal);

// ������� ���������

    _listSost := TDEPstepProc.Create;
    jScale := 0;
    dStep := 1; dStep := dStep / (24 * 60); // 1 ������
    try
      for jC1 := 1 to 100 do
      begin
        self.reductSvodka(jScale, _listSost, dStep);
        jL := _listSost.Count;
        if jL <= pc006_502_Shab_SostProcCelCnt then break;
        Inc(jScale);
      end;

      jPos := 0;
      jColCount := 0;
      jCol1 := pc006_502_Shab_SostProcCol1;
      jCol2 := pc006_502_Shab_SostProcCol1a;
      jCol3 := pc006_502_Shab_SostProcCol1b;
      jCol4 := pc006_502_Shab_SostProcCol1c;
      if jL > 0 then
      begin
        for jC1 := 1 to jL do
        begin
          // if not isSostTall(_listSost[jC1]) then continue;
          Inc(jPos);
          if jPos > pc006_502_Shab_SostProcRowCnt then
          begin
            if jColCount = 1 then break;
            jPos := 1;
            jCol1 := pc006_502_Shab_SostProcCol2;
            jCol2 := pc006_502_Shab_SostProcCol2a;
            jCol3 := pc006_502_Shab_SostProcCol2b;
            jCol4 := pc006_502_Shab_SostProcCol2c;
            Inc(jColCount);
          end;
          dTb := _listSost[jC1].dBeg;
          xls.putString(jCol1, pc006_502_Shab_SostProcRow + jPos - 1, dTb);
          dTe := _listSost[jC1].dEnd;
          xls.putString(jCol2, pc006_502_Shab_SostProcRow + jPos - 1, dTe);
          xls.putString(jCol4, pc006_502_Shab_SostProcRow + jPos - 1, dTe-dTb);
          j1 := _listSost[jC1].Etap;
          s1 := getNameEtapProc(j1);
          xls.putString(jCol3, pc006_502_Shab_SostProcRow + jPos - 1, s1);
        end;
      end;

    finally
      _listSost.Free;
    end;

// ������� ������
    dT := DEPrptParam.dTspo;
    xls.putString(pc006_502_Shab_SvodkaColspo,  pc006_502_Shab_SvodkaRow, dT);
    dT := DEPrptParam.dTprom;
    xls.putString(pc006_502_Shab_SvodkaColprom, pc006_502_Shab_SvodkaRow, dT);
    dT := DEPrptParam.dTpror;
    xls.putString(pc006_502_Shab_SvodkaColpror, pc006_502_Shab_SvodkaRow, dT);
    dT := DEPrptParam.dTbur;
    xls.putString(pc006_502_Shab_SvodkaColbur,  pc006_502_Shab_SvodkaRow, dT);
    dT := DEPrptParam.dTnar;
    xls.putString(pc006_502_Shab_SvodkaColnar,  pc006_502_Shab_SvodkaRow, dT);
    dT := DEPrptParam.dTpzr;
    xls.putString(pc006_502_Shab_SvodkaColpzr,  pc006_502_Shab_SvodkaRow, dT);

// ����� ������� ���������
    if xls.OpenWorkSheet(2) then
    begin
      jL := self.DEPrptParam.listSost.Count;
      if jL > 0 then
      begin
        jPos := 1;
        xlsData := VarArrayCreate([1,jL+1, 1,4], varVariant);
        xlsData[jPos, 1] := '��';
        xlsData[jPos, 2] := '��';
        xlsData[jPos, 3] := '�����';
        xlsData[jPos, 4] := '��������';

        for jC1 := 1 to jL do
        begin
          Inc(jPos);
          dTb := self.DEPrptParam.listSost[jC1].dBeg;
//          xls.putString(1, jPos, dTb);
          xlsData[jPos, 1] := dTb;
          dTe := self.DEPrptParam.listSost[jC1].dEnd;
//          xls.putString(2, jPos, dTe);
          xlsData[jPos, 2] := dTe;
//          xls.putString(3, jPos, dTe-dTb);
          xlsData[jPos, 3] := dTe-dTb;
          j1 := self.DEPrptParam.listSost[jC1].Etap;
          s1 := getNameEtapProc(j1);
//          xls.putString(4, jPos, s1);
          xlsData[jPos, 4] := s1;
        end;

        if not xls.putVarArray(1,1, 4, jL + 1, xlsData, pc006_107_WindowXLSSize) then
        begin
          self.sErr := xls.strErr;
          Exit;
        end;
      end;
    end
    else
    begin
      addError(xls.strErr);
      result := 2;
    end;

// ��������� ����
    xls.SaveWorkBook(true);
    xls.Quit;
    result := 0;
  finally
    xls.Free;
    xlsData := Null;
  end;


  if result <> 0 then
  begin
    Exit;
  end;

// ���������� ��� ���� ���� ����
  sNameFile := self.DEPqueParam.DocPath +
                   pc006_502_ConfigRPTxlsPrfx +
                   formatDateTime(pc006_502_ConfigRPTxlsName, Now) +
                   pc006_502_ConfigRPTxlsType;
  if not prqSaveCopyFile(sNameFile, s1) then addError(s1);
  if not prqCopyFile(self.xlsSgtRptReprtName, sNameFile, s1) then
  begin
    addError(s1);
    self.lastDoc := self.xlsSgtRptReprtName;
  end
  else
  begin
    self.lastDoc := sNameFile;
  end;
end;

function TDEPgrafJob1.CreateRaport: Integer;
var
  sNameFile, s1: String;
  xls: TprqExcel;
begin
// ������� ���� Excel �� �������

  if not prqSaveCopyFile(self.xlsSgtGraphReprtName, s1) then addError(s1);
  if not prqCopyFile(self.xlsSgtGraphShblnName, self.xlsSgtGraphReprtName, s1) then
  begin
    addError(s1);
    result := 1;
    Exit;
  end;

// ���������� ��� ���� ���� ����
  xls := TprqExcel.Create;
  try
  
//    ShowMessage(self.xlsSgtGraphReprtName);

    if not xls.OpenWorkBook(self.xlsSgtGraphReprtName) then
    begin
      addError(xls.strErr);
      result := 2;
      Exit;
    end;
    if not xls.OpenWorkSheet(1) then
    begin
      addError(xls.strErr);
      result := 2;
      Exit;
    end;

// ������� ������
//    dT := DEPrptParam.dTspo;

    xls.putFileBMP(1, 1, self.pctWidth, self.pctHeight, self.bmpSgtGraphReprtName);

// �������� ����
    xls.SaveWorkBook(true);
    xls.Quit;
    result := 0;
  finally
    xls.Free;
  end;

  if result <> 0 then
  begin
    Exit;
  end;

// ���������� ��� ���� ���� ����
  sNameFile := self.DEPqueParam.DocPath +
                 pc006_502_ConfigRPTxlsPrfx +
                 formatDateTime(pc006_502_ConfigRPTxlsName, Now) +
                 pc006_502_ConfigRPTxlsType;
  if not prqSaveCopyFile(sNameFile, s1) then addError(s1);
  if not prqCopyFile(self.xlsSgtGraphReprtName, sNameFile, s1) then
  begin
    addError(s1);
    self.lastDoc := self.xlsSgtGraphReprtName;
  end
  else
  begin
    self.lastDoc := sNameFile;
  end;
end;

destructor TDEPgrafJob1.Destroy;
begin
//  DEPqueParam.Free;
  gList.Free;
  OtherParams.Free;
  DEPGrhDescr.Free;
  DEPrptParam.Free;
  inherited;
end;

function TDEPgrafJob1.grfParamLoad: Integer;
var
  Stream: TFileStream;
  Root: IXMLNode;
begin
  self.sErr := '';

  if Length(self.cnfSgtGraphParamName) = 0 then
  begin
    result := -1; // �� ������ ���� ������������
    Exit;
  end;
  if not FileExists(self.cnfSgtParamName) then
  begin
    result := -2; // �� ������ ���� ������������
    Exit;
  end;

  Stream := TFileStream.Create(self.cnfSgtGraphParamName, fmOpenRead);
  try

    XMLDocument1.LoadFromStream(Stream, xetUTF_8);

    XMLDocument1.Active := True;
    Root := XMLDocument1.DocumentElement;
    result := self.grfParamTranslator(Root);

  finally
    Stream.Free;
  end;
end;

function TDEPgrafJob1.grfParamSave: Integer;
var
  fileTxt: TextFile;
  wsXML: WideString;
  jTracs, jCliPt, j1, jC1: Integer;
  cLPt: TGraphListPattern;
  cTrs: TTrackPattern;
begin
  AssignFile(fileTxt, self.cnfSgtGraphParamName);
  try
    try
      Rewrite(fileTxt);

  // ���������
      wsXML  := pc006_502_xml1;
      WriteLn(fileTxt, UTF8Encode(wsXML));
  // ���������_��������_��� ������="2"
      wsXML  := pc006_502_xml20;
      WriteLn(fileTxt, UTF8Encode(wsXML));


  //================
  // �������
      wsXML  := pc006_502_xml10_01;
      WriteLn(fileTxt, UTF8Encode(wsXML));

    // ��������_�����
        wsXML  := format(pc006_502_xml10_04,
                        [TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.Pages.Height),
                         TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.Pages.Width),
                         TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.Pages.shiftLeft),
                         TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.Pages.shiftRight),
                         TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.Pages.shiftTop),
                         TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.Pages.shiftBottom)
                         ]);
        WriteLn(fileTxt, UTF8Encode(wsXML));

    // ����������_�����
        wsXML  := format(pc006_502_xml10_06,
                        [TDEPGraphDescribe.clrValueToStr(self.DEPGrhDescr.Pages.ramColor),
                         TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.Pages.ramWidth),
                         self.DEPGrhDescr.Pages.sizeZGL,
                         self.DEPGrhDescr.Pages.sizeTOUT
                         ]);
        WriteLn(fileTxt, UTF8Encode(wsXML));

    // ����������_��������
        if self.DEPGrhDescr.Graphiks.bSignScaleVal then
        begin
          j1 := 1;
        end
        else
        begin
          j1 := 0;
        end;
        wsXML  := format(pc006_502_xml10_08,
                        [TDEPGraphDescribe.clrValueToStr(self.DEPGrhDescr.Graphiks.netColor),
                         TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.Graphiks.netWidth),
                         TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.Graphiks.netYStep),
                         self.DEPGrhDescr.Graphiks.cntXStep,
                         TDEPGraphDescribe.clrValueToStr(self.DEPGrhDescr.Graphiks.ramColor),
                         TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.Graphiks.ramWidth),
                         self.DEPGrhDescr.Graphiks.TSclSize,
                         self.DEPGrhDescr.Graphiks.fnSize,
                         j1
                         ]);
        WriteLn(fileTxt, UTF8Encode(wsXML));


        // ���� �� ��������, ����������� � �������
        for jCliPt := 1 to self.DEPGrhDescr.GraphListPatterns.Count do
        begin

// '<�����������_���� �����="%d" ��������="%d">';
          cLPt := self.DEPGrhDescr.GraphListPatterns.GetObjPnt(jCliPt);
          if cLPt.active then
          begin
            j1 := 1;
          end
          else
          begin
            j1 := 0;
          end;
          wsXML  := format(pc006_502_xml20_01,[jCliPt,j1]);
          WriteLn(fileTxt, UTF8Encode(wsXML));

//  pc006_502_xml20_02      = '<���>%s</���>';
          wsXML  := format(pc006_502_xml20_02,[cLPt.name]);
          WriteLn(fileTxt, UTF8Encode(wsXML));

          // ���� �� ������ �������
          for jTracs := 1 to cLPt.Count do
          begin
//        = '<���� �����="%d" ��������="%d">';
            cTrs := cLPt.GetObjPnt(jTracs);
            if cTrs.active then
            begin
              j1 := 1;
            end
            else
            begin
              j1 := 0;
            end;
            wsXML  := format(pc006_502_xml20_03,[jTracs,j1]);
            WriteLn(fileTxt, UTF8Encode(wsXML));

            // ���� �� �������� �����
            for jC1 := 1 to cTrs.Count do
            begin
              // ������ �����="1" ��������="1"
              if cTrs[jC1].active then j1 := 1 else j1 := 0;
              wsXML  := format(pc006_502_xml10_30,[cTrs[jC1].number, j1]);
              WriteLn(fileTxt, UTF8Encode(wsXML));

      // ����� ��������=...
              wsXML  := format(pc006_502_xml10_35,
                          [cTrs[jC1].nChanal,
                           cTrs[jC1].sName,
                           cTrs[jC1].sPodp,
                           cTrs[jC1].sEdIzm,
                           FloatToStr(cTrs[jC1].diaMin),
                           FloatToStr(cTrs[jC1].diaMax),
                           TDEPGraphDescribe.clrValueToStr(cTrs[jC1].Color),
                           TDEPGraphDescribe.jValueToDStr(cTrs[jC1].xLogSize),
                           TDEPGraphDescribe.jValueToDStr(cTrs[jC1].xLogStep),
                           cTrs[jC1].fnSize,
                           cTrs[jC1].Precision
//                           cTrs[jC1].Digits
                           ]);
              WriteLn(fileTxt, UTF8Encode(wsXML));

              // </������>
              wsXML  := pc006_502_xml10_31;
              WriteLn(fileTxt, UTF8Encode(wsXML));
            end; // ����� ����� �� �������� �����

            // '</����>';
            wsXML  := pc006_502_xml20_04;
            WriteLn(fileTxt, UTF8Encode(wsXML));
          end; // ����� ����� �� ������ �� ������� �����

          //  </�����������_����>
          wsXML  := pc006_502_xml10_11;
          WriteLn(fileTxt, UTF8Encode(wsXML));
        end; // ����� ����� �� �������� ������

      // </�������>
      wsXML  := pc006_502_xml10_02;
      WriteLn(fileTxt, UTF8Encode(wsXML));


      //================
      // <������>
      wsXML  := pc006_502_xml11_01;
      WriteLn(fileTxt, UTF8Encode(wsXML));

      // ���� ������ �������
        for jC1 := 1 to self.DEPGrhDescr.listGrfS.Count do
        begin
          // ����� ��������=...
          wsXML  := format(pc006_502_xml10_35,
                          [self.DEPGrhDescr.listGrfS[jC1].nChanal,
                           self.DEPGrhDescr.listGrfS[jC1].sName,
                           self.DEPGrhDescr.listGrfS[jC1].sPodp,
                           self.DEPGrhDescr.listGrfS[jC1].sEdIzm,
                           FloatToStr(self.DEPGrhDescr.listGrfS[jC1].diaMin),
                           FloatToStr(self.DEPGrhDescr.listGrfS[jC1].diaMax),
                           TDEPGraphDescribe.clrValueToStr(self.DEPGrhDescr.listGrfS[jC1].Color),
                           TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.listGrfS[jC1].xLogSize),
                           TDEPGraphDescribe.jValueToDStr(self.DEPGrhDescr.listGrfS[jC1].xLogStep),
                           self.DEPGrhDescr.listGrfS[jC1].fnSize,
                           self.DEPGrhDescr.listGrfS[jC1].Precision
//                           self.DEPGrhDescr.listGrfS[jC1].Digits
                           ]);
          WriteLn(fileTxt, UTF8Encode(wsXML));
        end;

      // </������>
      wsXML  := pc006_502_xml11_02;
      WriteLn(fileTxt, UTF8Encode(wsXML));

      // �����
      wsXML  := pc006_502_xml11;
      Write(fileTxt, UTF8Encode(wsXML));
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
    self.Modify := false;
  end;
end;

function TDEPgrafJob1.grfParamTranslator(XmlNode: IXMLNode): Integer;
var
  jVer, jC1: Integer;
  AttrNode: IXMLNode;
begin
  if XmlNode.NodeName = Null then
  begin
    result := pc006_502_XMLerr_002;
    Exit;
  end;

  if XmlNode.NodeName = pc006_502_xml12 then
  begin
// ������ ������ �����������
    jVer   := 0;
    result := pc006_502_XMLerr_001;
    for jC1 := 1 to xmlNode.AttributeNodes.Count do
    begin
      AttrNode := xmlNode.AttributeNodes.Nodes[jC1 - 1];
      if AttrNode.NodeName = Null then continue;
      if AttrNode.NodeName <> pc006_502_xml13 then continue;

      if AttrNode.Text = Null then
      begin
        sErr := pc006_502_cMSG_002;
        Exit;
      end;

      if AttrNode.Text = pc006_502_xml14 then
      begin
        jVer := 1;
        break;
      end
      else
      if AttrNode.Text = pc006_502_xml15 then
      begin
        jVer := 2;
        break;
      end
      else
      begin
        sErr := Podmena('#ver', AttrNode.Text, pc006_502_cMSG_001);
        Exit;
      end;
    end;

    if jVer = 1 then
    begin
      result := grfParamTranslatVer1(XmlNode);
    end
    else
    if jVer = 2 then
    begin
      result := grfParamTranslatVer2(XmlNode);
    end
    else
    begin
      sErr := pc006_502_cMSG_002;
    end;
  end
  else
  begin
    result := pc006_502_XMLerr_002;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer1(XmlNode: IXMLNode): Integer;
var
  jC1: Integer;
  ChildNode: IXMLNode;
begin
  result := pc006_502_XMLerr_003;
  for jC1 := 1 to xmlNode.ChildNodes.Count do
  begin
    ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
    if ChildNode.NodeName = Null then continue;

    if ChildNode.NodeName = pc006_502_xml10_03 then // '<�������>>';
    begin
      result := grfParamTranslatVer1_1(ChildNode);
    end;

    if ChildNode.NodeName = pc006_502_xml11_03 then // '<������>';
    begin
      result := grfParamTranslatVer1_2(ChildNode);
    end;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer1_1(XmlNode: IXMLNode): Integer;
var
  jC1: Integer;
  ChildNode: IXMLNode;
  c1: TGraphListPattern;
  c2: TTrackPattern;
begin
  result := 0;
  for jC1 := 1 to xmlNode.ChildNodes.Count do
  begin
    ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
    if ChildNode.NodeName = Null then continue;

    if ChildNode.NodeName = pc006_502_xml10_05 then // ��������_�����
    begin
      result := grfParamTranslatVer1_3(ChildNode);
      if result <> 0 then Exit;
      continue;
    end;

    if ChildNode.NodeName = pc006_502_xml10_07 then // ����������_�����
    begin
      result := grfParamTranslatVer1_4(ChildNode);
      if result <> 0 then Exit;
      continue;
    end;

    if ChildNode.NodeName = pc006_502_xml10_09 then // ����������_��������
    begin
      result := grfParamTranslatVer1_5(ChildNode);
      if result <> 0 then Exit;
      continue;
    end;

    if ChildNode.NodeName = pc006_502_xml10_12 then // �����������_����
    begin

// ���������� �������� ��� ����������� ������������� � ������� 1
      self.DEPGrhDescr.GraphListPatterns.Count := 0;
      self.DEPGrhDescr.GraphListPatterns.addEmptyPattern;
      c1 := self.DEPGrhDescr.GraphListPatterns.GetObjPnt(1);
      c1.active := true;
      c1.SelectedTrack := 1;
      c1.name := pc006_502_xml20_05;
      c2 := c1[1].ukz as TTrackPattern;
      c2.active := true;
      c2.Select := true;
      result := grfParamTranslatVer1_6(ChildNode, c2);
      if result <> 0 then Exit;
      continue;
    end;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer1_2(XmlNode: IXMLNode): Integer;
var
  jC1: Integer;
  ChildNode: IXMLNode;
begin
// ������
  result := 0;
  for jC1 := 1 to XmlNode.ChildNodes.Count do
  begin
    ChildNode := XmlNode.ChildNodes.Nodes[jC1 - 1];
    if ChildNode.NodeName = Null then continue;

    if ChildNode.NodeName = pc006_502_xml10_36 then // �����
    begin
      result := grfParamTranslatVer1_9(ChildNode);
      if result <> 0 then Exit;
      continue;
    end;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer1_3(XmlNode: IXMLNode): Integer;
var
  jC1: Integer;
  AttrNode: IXMLNode;
begin
// ��������_�����
  result := 0;
  for jC1 := 1 to XmlNode.AttributeNodes.Count do
  begin
    AttrNode := XmlNode.AttributeNodes.Nodes[jC1 - 1];
    if AttrNode.NodeName = Null then continue;

    if AttrNode.NodeName = pc006_502_xml10_13 then // ������_�����
    begin
      _setGeoVal(AttrNode, self.DEPGrhDescr.Pages.Height);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_14 then // ������_�����
    begin
      _setGeoVal(AttrNode, self.DEPGrhDescr.Pages.Width);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_15 then // ������_�����
    begin
      _setGeoVal(AttrNode, self.DEPGrhDescr.Pages.shiftLeft);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_16 then // ������_������
    begin
      _setGeoVal(AttrNode, self.DEPGrhDescr.Pages.shiftRight);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_17 then // ������_������
    begin
      _setGeoVal(AttrNode, self.DEPGrhDescr.Pages.shiftTop);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_18 then // ������_�����
    begin
      _setGeoVal(AttrNode, self.DEPGrhDescr.Pages.shiftBottom);
      continue;
    end;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer1_4(XmlNode: IXMLNode): Integer;
var
  jC1: Integer;
  AttrNode: IXMLNode;
begin
// ����������_�����
  result := 0;
  for jC1 := 1 to XmlNode.AttributeNodes.Count do
  begin
    AttrNode := XmlNode.AttributeNodes.Nodes[jC1 - 1];
    if AttrNode.NodeName = Null then continue;

    if AttrNode.NodeName = pc006_502_xml10_19 then // ����_�����
    begin
      _setClrVal(AttrNode, self.DEPGrhDescr.Pages.ramColor);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_20 then // �������_�����
    begin
      _setGeoVal(AttrNode, self.DEPGrhDescr.Pages.ramWidth);
      continue;
    end;


    if AttrNode.NodeName = pc006_502_xml10_21 then // ������_������_���������
    begin
      _setIntVal(AttrNode, self.DEPGrhDescr.Pages.sizeZGL);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_22 then // ����_���
    begin
      _setIntVal(AttrNode, self.DEPGrhDescr.Pages.sizeTOUT);
      continue;
    end;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer1_5(XmlNode: IXMLNode): Integer;
var
  j1, jC1: Integer;
  AttrNode: IXMLNode;
begin
// ����������_��������
  result := 0;
  for jC1 := 1 to XmlNode.AttributeNodes.Count do
  begin
    AttrNode := XmlNode.AttributeNodes.Nodes[jC1 - 1];
    if AttrNode.NodeName = Null then continue;

    if AttrNode.NodeName = pc006_502_xml10_23 then // ����_�����
    begin
      _setClrVal(AttrNode, self.DEPGrhDescr.Graphiks.netColor);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_24 then // �������_�����
    begin
      _setGeoVal(AttrNode, self.DEPGrhDescr.Graphiks.netWidth);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_25 then // ���_��_�������
    begin
      _setGeoVal(AttrNode, self.DEPGrhDescr.Graphiks.netYStep);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_26 then // ��������_�����_��_Y
    begin
      _setIntVal(AttrNode, self.DEPGrhDescr.Graphiks.cntXStep);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_27 then // ����_�����
    begin
      _setClrVal(AttrNode, self.DEPGrhDescr.Graphiks.ramColor);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_28 then // �������_�����
    begin
      _setGeoVal(AttrNode, self.DEPGrhDescr.Graphiks.ramWidth);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_29 then // ������_�����
    begin
      _setIntVal(AttrNode, self.DEPGrhDescr.Graphiks.TSclSize);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml20_11 then // ������_�����
    begin
      _setIntVal(AttrNode, self.DEPGrhDescr.Graphiks.fnSize);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml20_12 then // ���������_�����
    begin
      j1 := 0;
      _setIntVal(AttrNode, j1);
      if j1 = 0 then
      begin
        self.DEPGrhDescr.Graphiks.bSignScaleVal := false;
      end
      else
      begin
        self.DEPGrhDescr.Graphiks.bSignScaleVal := true;
      end;
      continue;
    end;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer1_6(XmlNode: IXMLNode; cTrack: TTrackPattern): Integer;
var
  jC1: Integer;
  ChildNode: IXMLNode;
begin
// �����������_����
  result := 0;
  for jC1 := 1 to xmlNode.ChildNodes.Count do
  begin
    ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
    if ChildNode.NodeName = Null then continue;

    if ChildNode.NodeName = pc006_502_xml10_32 then // ������
    begin
      result := grfParamTranslatVer1_7(ChildNode, cTrack);
      if result <> 0 then Exit;
      continue;
    end;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer1_7(XmlNode: IXMLNode; cTrack: TTrackPattern): Integer;
var
  jCode, jRcd, jC1: Integer;
  ChildNode, AttrNode: IXMLNode;
begin
// ������
  result := 0;
    jRcd := 0;
  for jC1 := 1 to XmlNode.AttributeNodes.Count do
  begin
    AttrNode := XmlNode.AttributeNodes.Nodes[jC1 - 1];
    if AttrNode.NodeName = Null then continue;

    if AttrNode.NodeName = pc006_502_xml10_33 then // �����
    begin
      jCode := 0;
      self._setIntVal(AttrNode, jCode);
      if jCode = 0 then continue;
      jRcd := self.AddQueParam(jCode, cTrack);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_34 then // ��������
    begin
      if jRcd = 0 then continue;
      jCode := 0;
      self._setIntVal(AttrNode, jCode);
      if jCode = 0 then
        cTrack[jRcd].active := false
      else
        cTrack[jRcd].active := true;
      continue;
    end;
  end;

  if jRcd = 0 then Exit;

  for jC1 := 1 to XmlNode.ChildNodes.Count do
  begin
    ChildNode := XmlNode.ChildNodes.Nodes[jC1 - 1];
    if ChildNode.NodeName = Null then continue;

    if ChildNode.NodeName = pc006_502_xml10_36 then // �����
    begin
      result := grfParamTranslatVer1_8(ChildNode, cTrack[jRcd]);
      if result <> 0 then Exit;
      continue;
    end;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer1_8(XmlNode: IXMLNode;
  Prcd: PrcdTrackPattern): Integer;
var
  jC1: Integer;
  AttrNode: IXMLNode;
  s1: string;
begin
// ����������_��������
  result := 0;
  for jC1 := 1 to XmlNode.AttributeNodes.Count do
  begin
    AttrNode := XmlNode.AttributeNodes.Nodes[jC1 - 1];
    if AttrNode.NodeName = Null then continue;

    if AttrNode.NodeName = pc006_502_xml10_37 then // ��������
    begin
      _setIntVal(AttrNode, Prcd.nChanal);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_38 then // �������
    begin
      _setStrVal(AttrNode, s1);
      Prcd.sPodp := s1;
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_39 then // �������
    begin
      _setStrVal(AttrNode, s1);
      Prcd.sEdIzm := s1;
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_40 then // �������
    begin
      _setDblVal(AttrNode, Prcd.diaMin);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_41 then // ��������
    begin
      _setDblVal(AttrNode, Prcd.diaMax);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_42 then // ����
    begin
      _setClrVal(AttrNode, Prcd.Color);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_43 then // �������_�����
    begin
      _setGeoVal(AttrNode, Prcd.xLogSize);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_44 then // ���_���������
    begin
      _setGeoVal(AttrNode, Prcd.xLogStep);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_45 then // ������_�������
    begin
      _setIntVal(AttrNode, Prcd.fnSize);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_46 then // ������.��������
    begin
      _setIntVal(AttrNode, Prcd.Precision);
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml10_47 then // ���
    begin
      _setStrVal(AttrNode, s1);
      Prcd.sName := s1;
      continue;
    end;

    {
    if AttrNode.NodeName = pc006_502_xml10_48 then // ������.�����_��������
    begin
      _setIntVal(AttrNode, Prcd.Digits);
      continue;
    end;
    }
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer1_9(XmlNode: IXMLNode): Integer;
var
  jRcd: Integer;
  graph: rcdDEPlistChanGraphDescr;
begin
// ����������_��������
  result := grfParamTranslatVer1_8(XmlNode, @graph);
  if result <> 0 then Exit;

  jRcd := AddGraphDescr(graph.nChanal);
  self.DEPGrhDescr.listGrfS[jRcd]^ := graph;
end;

function TDEPgrafJob1.grfParamTranslatVer2(XmlNode: IXMLNode): Integer;
var
  jC1: Integer;
  ChildNode: IXMLNode;
begin
  result := pc006_502_XMLerr_003;
  for jC1 := 1 to xmlNode.ChildNodes.Count do
  begin
    ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
    if ChildNode.NodeName = Null then continue;

    if ChildNode.NodeName = pc006_502_xml10_03 then // '<�������>>';
    begin
      result := grfParamTranslatVer2_1(ChildNode);
    end;

    if ChildNode.NodeName = pc006_502_xml11_03 then // '<������>';
    begin
      result := grfParamTranslatVer1_2(ChildNode);
    end;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer2_1(XmlNode: IXMLNode): Integer;
var
  jN, jC1: Integer;
  ChildNode: IXMLNode;
  c1: TGraphListPattern;
begin
  result := 0;
  self.DEPGrhDescr.GraphListPatterns.Count := 0;
  for jC1 := 1 to xmlNode.ChildNodes.Count do
  begin
    ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
    if ChildNode.NodeName = Null then continue;

    if ChildNode.NodeName = pc006_502_xml10_05 then // ��������_�����
    begin
      result := grfParamTranslatVer1_3(ChildNode);
      if result <> 0 then Exit;
      continue;
    end;

    if ChildNode.NodeName = pc006_502_xml10_07 then // ����������_�����
    begin
      result := grfParamTranslatVer1_4(ChildNode);
      if result <> 0 then Exit;
      continue;
    end;

    if ChildNode.NodeName = pc006_502_xml10_09 then // ����������_��������
    begin
      result := grfParamTranslatVer1_5(ChildNode);
      if result <> 0 then Exit;
      continue;
    end;

    if ChildNode.NodeName = pc006_502_xml10_12 then // �����������_����
    begin
      jN := self.DEPGrhDescr.GraphListPatterns.addEmptyPattern;
      c1 := self.DEPGrhDescr.GraphListPatterns.GetObjPnt(jN);
      c1.active := true;
      c1.SelectedTrack := 1;
      c1.name := format(pc006_502_xml20_06, [jN]);
      result := grfParamTranslatVer2_6(ChildNode, c1);
      if result <> 0 then Exit;
      continue;
    end;
  end;
end;

function TDEPgrafJob1.grfParamTranslatVer2_6(XmlNode: IXMLNode;
  cList: TGraphListPattern): Integer;
var
  jC2, jTrack, j1, jC1: Integer;
  ChildNode, ChildNode2: IXMLNode;
  AttrNode: IXMLNode;
  cTrack: TTrackPattern;
begin
// �����������_����
  result := 0;
  for jC1 := 1 to xmlNode.AttributeNodes.Count do
  begin
    AttrNode := xmlNode.AttributeNodes.Nodes[jC1 - 1];
    if AttrNode.NodeName = Null then continue;

    if AttrNode.NodeName = pc006_502_xml20_07 then
    begin // ����� ������� ������������ ����, ��� ��� �� ������������ ������� �������� ����������
      continue;
    end;

    if AttrNode.NodeName = pc006_502_xml20_08 then
    begin
      if AttrNode.Text = Null then
      begin
        cList.active := false; // ���� �����������, �� �� ������
        continue;
      end;

      uSupport.prqStrToInt(AttrNode.Text, j1);
      if j1 = 0 then
      begin
        cList.active := false; // �� ������
      end
      else
      begin
        cList.active := true; // ������
      end;
      continue;
    end;
  end;

  // ������ ������
  jTrack := 0;
  for jC1 := 1 to xmlNode.ChildNodes.Count do
  begin
    ChildNode := xmlNode.ChildNodes.Nodes[jC1 - 1];
    if ChildNode.NodeName = Null then continue;

    if ChildNode.NodeName = pc006_502_xml20_10 then // Name
    begin
      if ChildNode.Text <> Null then
      begin
        cList.name := Trim(ChildNode.Text);
      end;
      continue;
    end;

    if ChildNode.NodeName = pc006_502_xml20_09 then // Track
    begin
      if jTrack >= cList.Count then continue;

      // �������� ����� �����
      Inc(jTrack);
      cTrack := cList.GetObjPnt(jTrack);
      cTrack.Select := false;

      // ��������� �����
      for jC2 := 1 to ChildNode.AttributeNodes.Count do
      begin
        AttrNode := ChildNode.AttributeNodes.Nodes[jC2 - 1];
        if AttrNode.NodeName = Null then continue;

        if AttrNode.NodeName = pc006_502_xml20_07 then
        begin // ����� ������� ������������ ����, ��� ��� �� ������������ ������� �������� ����������
          continue;
        end;

        if AttrNode.NodeName = pc006_502_xml20_08 then
        begin
          if AttrNode.Text = Null then
          begin
            cTrack.active := false; // ���� �����������, �� �� ������
            continue;
          end;

          uSupport.prqStrToInt(AttrNode.Text, j1);
          if j1 = 0 then
          begin
            cTrack.active := false; // �� ������
          end
          else
          begin
            cTrack.active := true; // ������
          end;
          continue;
        end;
      end;

      // ������ ��������
      for jC2 := 1 to ChildNode.ChildNodes.Count do
      begin
        ChildNode2 := ChildNode.ChildNodes.Nodes[jC2 - 1];
        if ChildNode2.NodeName = Null then continue;

        if ChildNode2.NodeName = pc006_502_xml10_32 then // ������
        begin
          result := grfParamTranslatVer1_7(ChildNode2, cTrack);
          if result <> 0 then Exit;
          continue;
        end;
      end;
    end;
  end;
end;

procedure TDEPgrafJob1.reductSvodka(jScale: integer; listSost: TDEPstepProc; dStep: TDateTime);
var
  rcd: rcdDEPstepProc;
  jC1: integer;
  bFirst: boolean;
begin
  listSost.Count := 0;
  if jScale <= 0 then
  begin

    listSost.AppendClass(DEPrptParam.listSost);

  end
  else
  begin

    dStep := dStep * jScale;
    bFirst := true;

    for jC1 := 1 to DEPrptParam.listSost.Count do
    begin

      if bFirst then
      begin

        rcd := DEPrptParam.listSost[jC1]^;
        if (rcd.dEnd - rcd.dBeg) >= dStep then
        begin
          listSost.Append(@rcd);
          continue;
        end;
        bFirst := false;
        continue;

      end
      else
      begin

        if (DEPrptParam.listSost[jC1].dEnd - DEPrptParam.listSost[jC1].dBeg) >= dStep then
        begin
          listSost.Append(@rcd);
          listSost.Append(DEPrptParam.listSost[jC1]);
          bFirst := true;
        end
        else
        begin
          rcd.Etap := pc006_503_Rezhim_Mixed;
          rcd.dEnd := DEPrptParam.listSost[jC1].dEnd;
        end;

      end;
    end;

    if not bFirst then
    begin
      listSost.Append(@rcd);
    end;
  end;
end;

procedure TDEPgrafJob1.SetDOit(const Value: boolean);
begin
  FDOit := Value;
end;

procedure TDEPgrafJob1.SetModify(const Value: boolean);
begin
  FModify := Value;
end;

class function TDEPgrafJob1._CheckDouble(const Txt: String; var dRes: Double): Boolean;
var
  s1: string;
begin
  result := false;
  s1 := Trim(Txt);
  if Length(s1) = 0 then  Exit;
  if not prqStrToFloat(s1, dRes) then Exit;
  result := true;
end;

procedure TDEPgrafJob1._mdfyCouners(pRcd: PrcdDEPstepProc);
begin
  if isSostTspo(pRcd.Etap) then addInterval(self.DEPrptParam.dTspo , pRcd);
  if isSostTprom(pRcd.Etap) then addInterval(self.DEPrptParam.dTprom, pRcd);
  if isSostTpror(pRcd.Etap) then addInterval(self.DEPrptParam.dTpror, pRcd);
  if isSostTbur(pRcd.Etap) then addInterval(self.DEPrptParam.dTbur , pRcd);
  if isSostTnar(pRcd.Etap) then addInterval(self.DEPrptParam.dTnar , pRcd);
  if isSostTpzr(pRcd.Etap) then addInterval(self.DEPrptParam.dTpzr , pRcd);
end;

procedure TDEPgrafJob1._setClrVal(AttrNode: IXMLNode; var cVal: TColor);
var
  j1: integer;
begin
  if AttrNode.Text = Null then Exit;
  if prqStrToInt(AttrNode.Text, j1) then cVal := j1;
end;

procedure TDEPgrafJob1._setDblVal(AttrNode: IXMLNode; var dVal: Double);
var
  d1: Double;
begin
  if AttrNode.Text = Null then Exit;
  if prqStrToFloat(AttrNode.Text, d1) then dVal := d1;
end;

function TDEPgrafJob1._setDepth(dE: single): single;
begin

  if TkrsFunction.isValid(dE) then
  begin
    result := dE;
  end
  else
  begin
    result := 0;
  end;
end;

procedure TDEPgrafJob1._setGeoVal(AttrNode: IXMLNode; var jVal: integer);
var
  d1: Double;
begin
  if AttrNode.Text = Null then Exit;
  prqStrToFloat(AttrNode.Text, d1);
  if d1 <= 0 then Exit;
  jVal := Round(d1 * 10);
end;

procedure TDEPgrafJob1._setIntVal(AttrNode: IXMLNode; var jVal: integer);
var
  j1: integer;
begin
  if AttrNode.Text = Null then Exit;
  if prqStrToInt(AttrNode.Text, j1) then jVal := j1;
end;

function TDEPgrafJob1._setNumberEtap(dE: single): integer;
begin
  if dE >= uOreolProtocol6.cdbTServVal1 then
  begin
    result := pc006_503_Rezhim_DoNotKnow;
  end
  else
  begin
    try
      result := Round(dE);
      if not self.isSostTall(result) then result := pc006_503_Rezhim_DoNotKnow;
    except
      result := pc006_503_Rezhim_DoNotKnow;
    end;
  end;
end;

procedure TDEPgrafJob1._setStrVal(AttrNode: IXMLNode; var sVal: string);
begin
  if AttrNode.Text = Null then Exit;
  sVal := AttrNode.Text;
end;

end.
