program SetTime;

uses
  Forms,
  uSetTime in 'uSetTime.pas' {cSetTime},
  uSetTimeConst in 'uSetTimeConst.pas',
  uOreolBtnTune2 in 'uOreolBtnTune2.pas' {OreolBtnTune2},
  uOreolBtnTune2const in 'uOreolBtnTune2const.pas',
  upf1 in '..\..\Support\upf1.pas' {pf1},
  upf2 in '..\..\Support\upf2.pas' {pf2},
  uSupport in '..\..\Support\uSupport.pas',
  uOreolSetTime2BegTune in 'uOreolSetTime2BegTune.pas' {OreolSetTime2BegTune},
  uOreolButton2data in 'uOreolButton2data.pas',
  uAbstrArray in '..\..\Support\uAbstrArray.pas',
  uMainConst in '..\..\Support\uMainConst.pas',
  uMainData in '..\..\Support\uMainData.pas',
  uMsgDial in '..\..\Support\uMsgDial.pas',
  uShowProc in '..\..\Support\uShowProc.pas' {pf2ShowProc},
  uSupportConst in '..\..\Support\uSupportConst.pas',
  uShowProc1 in '..\..\Support\uShowProc1.pas' {pf2ShowProc1},
  uDNSprotocol in '..\DB_Protokols\uDNSprotocol.pas',
  uAbstrButtonPanel in 'uAbstrButtonPanel.pas',
  uOreolNWTune1 in 'uOreolNWTune1.pas' {OreolNWTune1},
  uOreolNWTune1const in 'uOreolNWTune1const.pas',
  uOreolProtocol in '..\DB_Protokols\uOreolProtocol.pas',
  uInputPassword in '..\..\Support\uInputPassword.pas' {cInputPassword};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TcSetTime, cSetTime);
  Application.CreateForm(TcInputPassword, cInputPassword);
  Application.Run;
end.
