program ClientDB;

uses
  Forms,
  uClientDB in 'uClientDB.pas' {OreolClientDB4},
  uMainConst in '..\..\Support\uMainConst.pas',
  uMainData in '..\..\Support\uMainData.pas',
  upf1 in '..\..\Support\upf1.pas' {pf1},
  uAbstrArray in '..\..\Support\uAbstrArray.pas',
  uSupport in '..\..\Support\uSupport.pas',
  upf2 in '..\..\Support\upf2.pas' {pf2},
  uMsgDial in '..\..\Support\uMsgDial.pas',
  uShowProc in '..\..\Support\uShowProc.pas' {pf2ShowProc},
  uClientDB3const in 'uClientDB3const.pas',
  uSupportConst in '..\..\Support\uSupportConst.pas',
  uClientDB4const in 'uClientDB4const.pas',
  uShowProc1 in '..\..\Support\uShowProc1.pas' {pf2ShowProc1},
  uOreolProtocol in '..\DB_Protokols\uOreolProtocol.pas',
  uKRSfunction in '..\DB_Protokols\uKRSfunction.pas',
  uKRSfunctionConst in '..\DB_Protokols\uKRSfunctionConst.pas';

{$R *.res}

var
  MainMutex: THandle;
begin
  if CheckCopyProg(pc003_23_MutName, pc003_23_ProjectName, MainMutex) then
  begin
    Application.Initialize;
    Application.CreateForm(TOreolClientDB4, OreolClientDB4);
  Application.Run;
  end;
end.
