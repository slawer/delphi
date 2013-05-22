program DBviewer;

uses
  Forms,
  upf1 in '..\..\Support\upf1.pas' {pf1},
  upf2 in '..\..\Support\upf2.pas' {pf2},
  uSupport in '..\..\Support\uSupport.pas',
  uMainConst in '..\..\Support\uMainConst.pas',
  uMainData in '..\..\Support\uMainData.pas',
  uDBviewer in 'uDBviewer.pas' {cDBviewer},
  uAbstrArray in '..\..\Support\uAbstrArray.pas',
  uAbstrGeometry in '..\..\Support\uAbstrGeometry.pas',
  uShowProc in '..\..\Support\uShowProc.pas' {pf2ShowProc},
  uAbstrExcel in '..\..\Support\uAbstrExcel.pas',
  uSupportConst in '..\..\Support\uSupportConst.pas',
  uMsgDial in '..\..\Support\uMsgDial.pas',
  uShowProc1 in '..\..\Support\uShowProc1.pas' {pf2ShowProc1},
  uDBviewerConst in 'uDBviewerConst.pas',
  uDEPgrafJob2 in 'uDEPgrafJob2.pas',
  uCoderDosWin1 in '..\..\Support\uCoderDosWin1.pas',
  uDEPdescript2 in 'uDEPdescript2.pas',
  uShowDEPparam1 in 'uShowDEPparam1.pas' {cShowDEPparam1},
  uShowDEPparam1const in 'uShowDEPparam1const.pas',
  uDEPgrafJob2Const in 'uDEPgrafJob2Const.pas',
  uShowSGTparam1 in 'uShowSGTparam1.pas' {cShowSGTparam1},
  uShowSGTparam1const in 'uShowSGTparam1const.pas',
  uEdtSGTparam1 in 'uEdtSGTparam1.pas' {cEdtSGTparam1},
  uEdtSGTparam1const in 'uEdtSGTparam1const.pas',
  uShowDEPparam2 in 'uShowDEPparam2.pas' {cShowDEPparam2},
  uCalendar1 in 'uCalendar1.pas' {cCalendar1},
  uShowREPparam2 in 'uShowREPparam2.pas' {cShowREPparam2},
  uShowREPparam2const in 'uShowREPparam2const.pas',
  uSGTlibDB1 in 'uSGTlibDB1.pas',
  uDBVreportQuery in 'uDBVreportQuery.pas' {cDBVreportQuery},
  uDBVreportQueryconst in 'uDBVreportQueryconst.pas',
  uDEPprotShow1 in 'uDEPprotShow1.pas' {cDEPprotShow1},
  uDEPprotShow1const in 'uDEPprotShow1const.pas',
  uDEPGrafList1 in 'uDEPGrafList1.pas',
  uGrafTune1const in 'uGrafTune1const.pas',
  uDEPdescript2const in 'uDEPdescript2const.pas',
  uGrafTune2 in 'uGrafTune2.pas' {cGrafTune2},
  uShowImage3 in 'uShowImage3.pas' {cShowImage3},
  uShowImageConst in 'uShowImageConst.pas',
  uEditParam2v2 in 'uEditParam2v2.pas' {cEditParam2},
  uEditParam2Const in 'uEditParam2Const.pas',
  uSGTlibDB1const in 'uSGTlibDB1const.pas',
  uGraphPatterns1 in 'uGraphPatterns1.pas',
  uGraphPatterns1const in 'uGraphPatterns1const.pas',
  uOreolDBDirect2 in '..\DB_Protokols\uOreolDBDirect2.pas',
  uOreolDBDirect2const in '..\DB_Protokols\uOreolDBDirect2const.pas',
  uOreolProtocol6 in '..\DB_Protokols\uOreolProtocol6.pas',
  uDBviewer_TuneDB in 'uDBviewer_TuneDB.pas' {cDBviewer_TuneDB},
  uDBviewer_TuneDBconst in 'uDBviewer_TuneDBconst.pas',
  uDBVgrafQuery in 'uDBVgrafQuery.pas' {cDBVgrafQuery},
  uDBVgrafQueryconst in 'uDBVgrafQueryconst.pas',
  uExportXLS in 'uExportXLS.pas' {cExportXLS},
  uExportXLSConst in 'uExportXLSConst.pas',
  uKRSfunctionConst in '..\DB_Protokols\uKRSfunctionConst.pas',
  uExportLAS in 'uExportLAS.pas' {cExportLAS},
  uExportLASconst in 'uExportLASconst.pas',
  uKRSfunctionV3 in '..\DB_Protokols\uKRSfunctionV3.pas',
  uDBservice3Job in 'uDBservice3Job.pas',
  uKRSfunctionV3Const in '..\DB_Protokols\uKRSfunctionV3Const.pas',
  uQueryDopCond in 'uQueryDopCond.pas' {cQueryDopCond},
  uQueryDopCondConst in 'uQueryDopCondConst.pas',
  uTransfer1 in 'uTransfer1.pas' {cTransfer1},
  uTransfer1const in 'uTransfer1const.pas';

{$R *.res}

begin
  Application.Initialize;

  Application.CreateForm(TcDBviewer, cDBviewer);
  Application.CreateForm(TcDEPprotShow1, cDEPprotShow1);
  Application.CreateForm(TcEditParam2, cEditParam2);
  Application.CreateForm(TcQueryDopCond, cQueryDopCond);
  if not cDBviewer.bAvar then
  begin
    Application.Run;
  end;
end.
