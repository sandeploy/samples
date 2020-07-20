program Srv_Mgr;

uses
  Forms,
  uMain in 'uMain.pas' {fMain},
  uCreateUsers in 'uCreateUsers.pas' {fCreateUsers},
  uCreateGroups in 'uCreateGroups.pas' {fCreateGroups},
  uChooseUser in 'uChooseUser.pas' {fChooseUser},
  uCreateVolume in 'uCreateVolume.pas' {fCreateVolume},
  uVolumeAttribute in 'uVolumeAttribute.pas' {fVolumeAttribute},
  uCreateTarget in 'uCreateTarget.pas' {fCreateTarget},
  uTargetAttribute in 'uTargetAttribute.pas' {fTargetAttribute},
  uSmartDiskAttribute in 'uSmartDiskAttribute.pas' {fSmartDiskAttribute},
  uAddWorkstation in 'uAddWorkstation.pas' {fAddWorkstation},
  uConnectToServer in 'uConnectToServer.pas' {fConnectToServer},
  uSynchronizeServer in 'uSynchronizeServer.pas' {fSynchronizeServer},
  uSANDeployServerApi in 'uSANDeployServerApi.pas',
  uAddEditSnapShot in 'uAddEditSnapShot.pas' {fNewEditSnapShot},
  uAddSynchronization in 'uAddSynchronization.pas' {fAddSynchronization},
  uUtils in 'uUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
