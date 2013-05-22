program SetUstavkiV2;

uses
  Forms,
  uSetUstavkiV2 in 'uSetUstavkiV2.pas' {cSetUstavki},
  uSetUstavkiConst in 'uSetUstavkiConst.pas',
  uSetUstavkiTune in 'uSetUstavkiTune.pas' {OreolSetBlockTune},
  uSetUstavkiTuneConst in 'uSetUstavkiTuneConst.pas',
  uDNSprotocol in '..\DB_Protokols\uDNSprotocol.pas',
  uOreolNWTune1const in 'uOreolNWTune1const.pas',
  uOreolNWTune1 in 'uOreolNWTune1.pas' {OreolNWTune1},
  upf1 in '..\..\Support\upf1.pas' {pf1},
  upf2 in '..\..\Support\upf2.pas' {pf2},
  uSupport in '..\..\Support\uSupport.pas',
  uOreolBegTuneBtn2const in 'uOreolBegTuneBtn2const.pas',
  uOreolBegTuneBtn2 in 'uOreolBegTuneBtn2.pas' {OreolBegTuneBtn2},
  uSetUstavkiData in 'uSetUstavkiData.pas',
  uAbstrArray in '..\..\Support\uAbstrArray.pas',
  uAbstrButtonPanel in 'uAbstrButtonPanel.pas',
  uMainConst in '..\..\Support\uMainConst.pas',
  uMainData in '..\..\Support\uMainData.pas',
  uMsgDial in '..\..\Support\uMsgDial.pas',
  uShowProc in '..\..\Support\uShowProc.pas' {pf2ShowProc},
  uSupportConst in '..\..\Support\uSupportConst.pas',
  uShowProc1 in '..\..\Support\uShowProc1.pas' {pf2ShowProc1},
  uOreolProtocol in '..\DB_Protokols\uOreolProtocol.pas',
  uInputPassword in '..\..\Support\uInputPassword.pas' {cInputPassword};

{$R *.res}

var
  MainMutex: THandle;
begin
  if CheckCopyProg(pc006_02_MutName, pc006_02_ProjectName, MainMutex) then
  begin
    Application.Initialize;
    Application.CreateForm(TcSetUstavki, cSetUstavki);
  Application.CreateForm(TcInputPassword, cInputPassword);
  Application.Run;
  end;
end.
