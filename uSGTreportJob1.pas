unit uSGTreportJob1;

interface
uses
  Windows, SysUtils, registry, IniFiles, Math, Classes, uAbstrArray,
  uMainData, uExportXLSv3Const, uExportLassV2Const, uCoderDosWin1,
  xmldom, XMLIntf, msxmldom, XMLDoc, Variants, uAbstrExcel,
  uDEPdescript2, uSGTreportJob1Const, uSGTlibDB1, uDEPdescriptconst, uOreolProtocol6;

type

  SGTreportJob1 = class(DEPreportJobAll)
  private

  public
    tmpSgtRptParamName:  string;      // ��� ���������� ����� ��� ������ �� ��
    xlsSgtRptShblnName:  string;      // ��� ��������� ������� �������
    xlsSgtRptReprtName:  string;      // ��� ��������� �������

    DEPrptParam:  TDEPrptSGT;

    dStart: TDateTime;     // ���� ������ �������
    Skva, Kust, Zakaz, Podr, Mast: string; // ��������, ����, ...

    function  createRaport: Integer; // �������� �������
    procedure calcSvodka; // ������ ������, ������ ������� ������������ �������
    procedure _mdfyCouners(pRcd: PrcdDEPstepProc);
    function _setDepth(dE: single): single;
    function _setNumberEtap(dE: single): integer;

    constructor Create;
    destructor  Destroy; override;
  end;

implementation
uses uSupport;

{ SGTreportJob1 }

constructor SGTreportJob1.Create;
begin
  inherited;
  DEPrptParam  := TDEPrptSGT.Create;
  tmpSgtRptParamName := '';
  xlsSgtRptShblnName := '';
  xlsSgtRptReprtName := '';
end;

destructor SGTreportJob1.Destroy;
begin
  DEPrptParam.Free;
  inherited;
end;

function SGTreportJob1.createRaport: Integer;
var
  sNameFile, s1: String;
  xls: TprqExcel;
  jColCount, jCol1, jCol2, jCol3, jPos, jC1, j1, jL: integer;
  vVal: Variant;
  dT: TDateTime;
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
    vVal := self.dStart;
    xls.putString(pc006_501_Shab_Col5, pc006_501_Shab_Row5, vVal);
    vVal := self.Skva;
    xls.putString(pc006_501_Shab_Col6, pc006_501_Shab_Row6, vVal);
    vVal := self.Kust;
    xls.putString(pc006_501_Shab_Col7, pc006_501_Shab_Row7, vVal);
    vVal := self.Zakaz;
    xls.putString(pc006_501_Shab_Col8, pc006_501_Shab_Row8, vVal);
    vVal := self.Podr;
    xls.putString(pc006_501_Shab_Col9, pc006_501_Shab_Row9, vVal);
    vVal := self.Mast;
    xls.putString(pc006_501_Shab_Col10,pc006_501_Shab_Row10,vVal);

    vVal := Trunc(self.DEPqueParam.dBeg);
    xls.putString(pc006_501_Shab_Col1, pc006_501_Shab_Row1, vVal);
    vVal := self.DEPrptParam.dptBeg;
    xls.putString(pc006_501_Shab_Col2, pc006_501_Shab_Row2, vVal);
    vVal := self.DEPrptParam.dptEnd;
    xls.putString(pc006_501_Shab_Col3, pc006_501_Shab_Row3, vVal);
    vVal := self.DEPrptParam.dptEnd - self.DEPrptParam.dptBeg;
    xls.putString(pc006_501_Shab_Col4, pc006_501_Shab_Row4, vVal);

// ������� ���������
    jL := DEPrptParam.listSost.Count;
    jPos := 0;
    jColCount := 0;
    jCol1 := pc006_501_Shab_SostProcCol1;
    jCol2 := pc006_501_Shab_SostProcCol1a;
    jCol3 := pc006_501_Shab_SostProcCol1b;
    if jL > 0 then
    begin
      for jC1 := 1 to jL do
      begin
//        if not isSostTall(DEPrptParam.listSost[jC1]) then continue;
        Inc(jPos);
        if jPos > pc006_501_Shab_SostProcRowCnt then
        begin
          if jColCount = 1 then break;
          jPos := 1;
          jCol1 := pc006_501_Shab_SostProcCol2;
          jCol2 := pc006_501_Shab_SostProcCol2a;
          jCol3 := pc006_501_Shab_SostProcCol2b;
          Inc(jColCount);
        end;
        dT := DEPrptParam.listSost[jC1].dBeg;
        xls.putString(jCol1, pc006_501_Shab_SostProcRow + jPos - 1, dT);
        dT := DEPrptParam.listSost[jC1].dEnd;
        xls.putString(jCol2, pc006_501_Shab_SostProcRow + jPos - 1, dT);
        j1 := DEPrptParam.listSost[jC1].Etap;
        s1 := getNameEtapProc(j1);
        xls.putString(jCol3, pc006_501_Shab_SostProcRow + jPos - 1, s1);
      end;
    end;

// ������� ������
    dT := DEPrptParam.dTspo;
    xls.putString(pc006_501_Shab_SvodkaColspo,  pc006_501_Shab_SvodkaRow, dT);
    dT := DEPrptParam.dTprom;
    xls.putString(pc006_501_Shab_SvodkaColprom, pc006_501_Shab_SvodkaRow, dT);
    dT := DEPrptParam.dTpror;
    xls.putString(pc006_501_Shab_SvodkaColpror, pc006_501_Shab_SvodkaRow, dT);
    dT := DEPrptParam.dTbur;
    xls.putString(pc006_501_Shab_SvodkaColbur,  pc006_501_Shab_SvodkaRow, dT);
    dT := DEPrptParam.dTnar;
    xls.putString(pc006_501_Shab_SvodkaColnar,  pc006_501_Shab_SvodkaRow, dT);
{
    dT := DEPrptParam.dTpzr;
    xls.putString(pc006_501_Shab_SvodkaColpzr,  pc006_501_Shab_SvodkaRow, dT);
}

// ��������� ����
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
                   pc006_501_ConfigRPTxlsPrfx +
                   formatDateTime(pc006_501_ConfigRPTxlsName, Now) +
                   pc006_501_ConfigRPTxlsType;
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

procedure SGTreportJob1.calcSvodka;
var
  rcd:  rcdDEPstepProc;
  jL, jEtap, {jRezhim,} jLngVal, jC1:  integer;
  dE: single;
  dT, dTimOut: TDateTime; // ������ ��������
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


// �������� ��������� ������ � �������
  jLngVal := self.DEPqueParam.valReport.Count;
  for jC1 := 1 to jLngVal do
  begin
    if jC1 = 1 then
    begin
      rcd.dBeg   := self.DEPqueParam.valReport.getValField(jC1, 1);
      rcd.dEnd   := rcd.dBeg;
      dE         := self.DEPqueParam.valReport.getValField(jC1, 3);
      rcd.Etap   := _setNumberEtap(dE);
//      rcd.Etap := self.DEPrptParam.valReport.getValField(jC1, 4);
    end
    else
    begin

      dT         := self.DEPqueParam.valReport.getValField(jC1, 1);
      dE         := self.DEPqueParam.valReport.getValField(jC1, 3);
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
    dE                      := self.DEPqueParam.valReport.getValField(1, 2);
    self.DEPrptParam.dptBeg := _setDepth(dE);
    dE                      := self.DEPqueParam.valReport.getValField(jL, 2);
    self.DEPrptParam.dptEnd := _setDepth(dE);
    if self.DEPrptParam.dptBeg > self.DEPrptParam.dptEnd then
    begin
      self.DEPrptParam.dptEnd := self.DEPrptParam.dptBeg;
    end;
  end
  else
  begin
    self.DEPrptParam.dptBeg := 0;
    self.DEPrptParam.dptEnd := 0;
  end;
end;

procedure SGTreportJob1._mdfyCouners(pRcd: PrcdDEPstepProc);
begin
  if isSostTspo (pRcd) then addInterval(self.DEPrptParam.dTspo , pRcd);
  if isSostTprom(pRcd) then addInterval(self.DEPrptParam.dTprom, pRcd);
  if isSostTpror(pRcd) then addInterval(self.DEPrptParam.dTpror, pRcd);
  if isSostTbur (pRcd) then addInterval(self.DEPrptParam.dTbur , pRcd);
  if isSostTnar (pRcd) then addInterval(self.DEPrptParam.dTnar , pRcd);
end;

function SGTreportJob1._setDepth(dE: single): single;
begin
  if dE >= uOreolProtocol6.cdbTServVal then
  begin
    result := 0;
  end
  else
  begin
    result := dE;
  end;
end;

function SGTreportJob1._setNumberEtap(dE: single): integer;
begin
  if dE >= uOreolProtocol6.cdbTServVal then
  begin
    result := pc005_504_EtapProc_Ind0;
  end
  else
  begin
    try
      result := Round(dE);

// ���������� - �� ��������� � ����������
//        result := (result div 256)  -  1;

      if result > pc005_504_EtapProc_Ind7 then result := pc005_504_EtapProc_Ind0;

    except
      result := pc005_504_EtapProc_Ind0;
    end;
  end;
end;

end.
