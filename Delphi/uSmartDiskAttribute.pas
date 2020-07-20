unit uSmartDiskAttribute;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Spin, ComCtrls, ExtCtrls, uSANDeployServerApi,
  Mask;

type
  TfSmartDiskAttribute = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox3: TGroupBox;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    bConfirm: TBitBtn;
    bCancel: TBitBtn;
    bApply: TBitBtn;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox4: TGroupBox;
    gbPassword: TGroupBox;
    RemoteManagement_ChangePassword: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    RemoteManagement_Port: TEdit;
    RemoteManagement_IPAddress: TComboBox;
    Label5: TLabel;
    RemoteManagement_UserName: TEdit;
    Label6: TLabel;
    RemoteManagement_NewPassword: TEdit;
    Label7: TLabel;
    RemoteManagement_ConfirmPassword: TEdit;
    LoadBalance_Server_Remove: TBitBtn;
    LoadBalance_Server_Add: TBitBtn;
    LoadBalance_ListView_Server: TListView;
    Label30: TLabel;
    License_LicenseFile: TEdit;
    BootServer_Inport: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    General_Port: TEdit;
    General_IPAddress: TComboBox;
    GroupBox2: TGroupBox;
    General_BootService: TCheckBox;
    General_ListView: TListView;
    Label13: TLabel;
    BootServer_BootMode: TComboBox;
    GroupBox6: TGroupBox;
    Label14: TLabel;
    BootServer_Gateway: TComboBox;
    BootServer_HostName: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    BootServer_BootIQN: TComboBox;
    BootServer_SaveDataMode: TComboBox;
    Label23: TLabel;
    BootServer_IDLen: TSpinEdit;
    LoadBalance_Server_Refresh: TBitBtn;
    LoadBalance_Server_Synchronize: TBitBtn;
    LoadBalance_ListView_Sync: TListView;
    LoadBalance_Sync_Delete: TBitBtn;
    LoadBalance_Sync_Add: TBitBtn;
    LoadBalance_Sync_Refresh: TBitBtn;
    LoadBalance_Sync_Synchronize: TBitBtn;
    edDNS: TEdit;
    edStartIp: TEdit;
    edEndIp: TEdit;
    edIpMask: TEdit;
    chkAutoBal: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure LoadBalance_Server_AddClick(Sender: TObject);
    procedure LoadBalance_SynchronizeClick(Sender: TObject);
    procedure RemoteManagement_ChangePasswordClick(Sender: TObject);
    procedure bConfirmClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure bApplyClick(Sender: TObject);
    procedure LoadBalance_Server_RefreshClick(Sender: TObject);
    procedure LoadBalance_Server_RemoveClick(Sender: TObject);
    procedure LoadBalance_Sync_AddClick(Sender: TObject);
    procedure LoadBalance_Sync_DeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadBalance_Sync_RefreshClick(Sender: TObject);
    procedure LoadBalance_Sync_SynchronizeClick(Sender: TObject);
  private
    { Private declarations }
    FServerConfig: ISCSI_SERVER_CONFIG;
    FApplicationTargetList: TList;
    procedure ClearData(ListView: TListView);
    procedure ClearApplicationTargetData(List: TList);
    procedure GetApplications(List: TList);
    procedure FillConfig;
    procedure FillSyncApp(List: TList);
    procedure GetTargets(aStrings: TStrings);
    function LoadServerConfig: Boolean;
    procedure RefreshSubServers;
    procedure RefreshApplications;
    procedure SaveServerConfig;
  public
    { Public declarations }
  end;

var
  fSmartDiskAttribute: TfSmartDiskAttribute;

implementation

uses uConnectToServer, uSynchronizeServer, uAddSynchronization, WinSock;

type
  PApplicationTargetData = ^TApplicationTargetData;
  TApplicationTargetData = record
    hTarget, hApplication: KHANDLE;
    App: ISCSI_APPLICATION;
  end;

const
  cAllAddresses = 'All Addresses';

{$R *.dfm}

procedure TfSmartDiskAttribute.FillConfig;

  function GetBootIQNIndex(aStrings: TStrings; const aIqn: string): Integer;
  var
    I: Integer;
  begin
    Result:= -1;
    if (aStrings = nil) then
      Exit;
    for I:= 0 to aStrings.Count-1 do
      if aStrings[I] = aIqn then
      begin
        Result:= I;
        Exit;
      end;
  end;

var
  I: Integer;
  ia: TInAddr;
  s: string;
  item: TListItem;
begin
  if (FServerConfig.RemoteControl.IPAddress <> 0) then
  begin
    ia.S_addr:= FServerConfig.RemoteControl.IPAddress;
    s:= StrPas(inet_ntoa(ia));
  end
  else
    s:= cAllAddresses;
  RemoteManagement_IPAddress.Items.Add(s);
  RemoteManagement_NewPassword.Text:= StrPas(@FServerConfig.RemoteControl.Password[0]);
  RemoteManagement_ConfirmPassword.Text:= StrPas(@FServerConfig.RemoteControl.Password[0]);
  RemoteManagement_Port.Text:= IntToStr(FServerConfig.RemoteControl.Port);
  RemoteManagement_UserName.Text:= StrPas(@FServerConfig.RemoteControl.UserName[0]);
  if (FServerConfig.ulAddress <> 0) then
  begin
    ia.S_addr:= FServerConfig.ulAddress;
    s:= StrPas(inet_ntoa(ia));
  end
  else
    s:= cAllAddresses;
  General_IPAddress.Items.Add(s);
  General_Port.Text:= IntToStr(FServerConfig.usPort);
  General_ListView.Items.Clear;
  for I:= Low(FServerConfig.Portal) to High(FServerConfig.Portal) do
  begin
    if FServerConfig.Portal[I].ulNatAddress = 0 then
      Continue;
    ia.S_addr:= FServerConfig.Portal[I].ulNatAddress;
    s:= StrPas(inet_ntoa(ia));
    General_IPAddress.Items.Add(s);
    RemoteManagement_IPAddress.Items.Add(s);
    item:= General_ListView.Items.Add();
    item.Caption:= StrPas(inet_ntoa(ia));
    item.Checked:= FServerConfig.Portal[I].ulType <> TARGET_PORTAL_DISABLED;
  end;
  if General_IPAddress.Items.Count > 0 then
    General_IPAddress.ItemIndex:= 0;
  if RemoteManagement_IPAddress.Items.Count > 0 then
    RemoteManagement_IPAddress.ItemIndex:= 0;
  General_BootService.Checked:= FServerConfig.Params.Pxe.Start;
  BootServer_BootMode.ItemIndex:= FServerConfig.Params.Pxe.BootMode;
  ia.S_addr:= FServerConfig.Params.Pxe.NetConfig[FServerConfig.Params.Pxe.ActiceNetConfig].Gateway;
  BootServer_Gateway.Text:= StrPas(inet_ntoa(ia));
  ia.S_addr:= FServerConfig.Params.Pxe.NetConfig[FServerConfig.Params.Pxe.ActiceNetConfig].Dns;
  edDNS.Text:= StrPas(inet_ntoa(ia));
  ia.S_addr:= FServerConfig.Params.Pxe.NetConfig[FServerConfig.Params.Pxe.ActiceNetConfig].StartIP;
  edStartIp.Text:= StrPas(inet_ntoa(ia));
  ia.S_addr:= FServerConfig.Params.Pxe.NetConfig[FServerConfig.Params.Pxe.ActiceNetConfig].EndIP;
  edEndIp.Text:= StrPas(inet_ntoa(ia));
  ia.S_addr:= FServerConfig.Params.Pxe.NetConfig[FServerConfig.Params.Pxe.ActiceNetConfig].Mask;
  edIpMask.Text:= StrPas(inet_ntoa(ia));
  BootServer_HostName.Text:= StrPas(@FServerConfig.Params.Pxe.HostPerfix[0]);
  BootServer_IDLen.Value:= FServerConfig.Params.Pxe.HostIDLen;
  GetTargets(BootServer_BootIQN.Items);
  s:= StrPas(@FServerConfig.Params.Pxe.DefaultIQN[0]);
  BootServer_BootIQN.ItemIndex:= GetBootIQNIndex(BootServer_BootIQN.Items, s);
  BootServer_SaveDataMode.ItemIndex:= FServerConfig.Params.Pxe.Flags and 1;
  if BootServer_SaveDataMode.ItemIndex < 0 then
    BootServer_SaveDataMode.ItemIndex:= 0;
  chkAutoBal.Checked:= (FServerConfig.Params.Pxe.Flags and ISCSI_PXE_FLAG_AUTO_LOADBANLANCE) <> 0
end;

procedure TfSmartDiskAttribute.FormShow(Sender: TObject);
begin
  Case Tag of
    0:
           // Click Root in the TreeView] SmartDisk iSCSI Attribute
           PageControl1.ActivePageIndex := 0;

    1: begin
           // Click BootServer in the TreeView] Attribute
           PageControl1.Pages[0].TabVisible := False; // Remote Management
           PageControl1.Pages[1].TabVisible := False; // Load Balance

           PageControl1.ActivePageIndex := 2;

           // Work... (Load data)
         end;
  end;
  RefreshSubServers();
  RefreshApplications();
  if LoadServerConfig() then
    FillConfig()
  else
    Application.MessageBox('Failed to load server config!', nil, MB_OK or MB_ICONWARNING);
end;

procedure TfSmartDiskAttribute.LoadBalance_Server_AddClick(Sender: TObject);
var
  IsConnected: Boolean;
  ss: ISCSI_SERVER;
  dwRet: Longword;
begin
  fConnectToServer := TfConnectToServer.Create(Self);
  try
    fConnectToServer.Tag := 300; // Add Server
    fConnectToServer.ShowModal;
    IsConnected := fConnectToServer.IsConnect;
    if IsConnected then
    begin
      FillChar(ss, SizeOf(ISCSI_SERVER), 0);
      StrPCopy(@ss.ServerName[0], fConnectToServer.ServerAddress.Text);
      StrPCopy(@ss.UserName[0], fConnectToServer.UserName.Text);
      StrPCopy(@ss.Password[0], fConnectToServer.Password.Text);
      ss.Port:= StrToInt(fConnectToServer.ServerPort.Text);
    end;
  finally
    FreeAndNil(fConnectToServer);
  end;

  if IsConnected then
  begin
    dwRet:= uSANDeployServerApi.AddSubServer(ss);
    if dwRet = 0 then
      RefreshSubServers();
  end;
end;


procedure TfSmartDiskAttribute.LoadBalance_SynchronizeClick(
  Sender: TObject);
begin
  // Synchronize Server
  fSynchronizeServer := TfSynchronizeServer.Create(Self);
  try
    fSynchronizeServer.ShowModal;
  finally
    FreeAndNil(fSynchronizeServer);
  end;
end;

function TfSmartDiskAttribute.LoadServerConfig: Boolean;
begin
  Result:= uSANDeployServerApi.GetServerConfig(FServerConfig) = 0;
end;

procedure TfSmartDiskAttribute.RemoteManagement_ChangePasswordClick(
  Sender: TObject);
begin
  RemoteManagement_NewPassword.Enabled:= RemoteManagement_ChangePassword.Checked;
  RemoteManagement_ConfirmPassword.Enabled:= RemoteManagement_ChangePassword.Checked;
end;

procedure TfSmartDiskAttribute.SaveServerConfig;
var
  I: Integer;
  dwRet: Longword;
begin
  if(RemoteManagement_IPAddress.Text = 'All Addresses') then
  begin
  FServerConfig.RemoteControl.IPAddress:= 0;
  end
  else
  begin
  FServerConfig.RemoteControl.IPAddress:= inet_addr(PAnsiChar(RemoteManagement_IPAddress.Text));
  end;
  I:= StrToIntDef(RemoteManagement_Port.Text, -1);
  if (I < 0) or (I > High(Word)) then
  begin
    Application.MessageBox('Please enter a valid control port number (0-65535)', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  FServerConfig.RemoteControl.Port:= I;

  if RemoteManagement_UserName.Text = '' then
  begin
    Application.MessageBox('Please enter the user name', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  FillChar(FServerConfig.RemoteControl.UserName, SizeOf(FServerConfig.RemoteControl.UserName), 0);
  StrPCopy(@FServerConfig.RemoteControl.UserName[0], RemoteManagement_UserName.Text);

  if RemoteManagement_ChangePassword.Checked then
  begin
    if RemoteManagement_NewPassword.Text <> RemoteManagement_ConfirmPassword.Text then
    begin
      Application.MessageBox('The new password you entered does not match the confirm password!', nil, MB_OK or MB_ICONWARNING);
      Exit;
    end;
    FillChar(FServerConfig.RemoteControl.Password, SizeOf(FServerConfig.RemoteControl.Password), 0);
    StrPCopy(@FServerConfig.RemoteControl.Password[0], RemoteManagement_NewPassword.Text);
  end;

  if(General_IPAddress.Text = 'All Addresses') then
  begin
  FServerConfig.ulAddress:= 0;
  end
  else
  begin
  FServerConfig.ulAddress:= inet_addr(PAnsiChar(General_IPAddress.Text));
  end;

  I:= StrToIntDef(General_Port.Text, -1);
  if (I < 0) or (I > High(Word)) then
  begin
    Application.MessageBox('Please enter a valid iSCSI server port number (0-65535)', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  FServerConfig.usPort:= I;

  for I:= Low(FServerConfig.Portal) to High(FServerConfig.Portal) do
  begin
    if I < General_ListView.Items.Count then
      if General_ListView.Items[I].Checked then
        FServerConfig.Portal[I].ulType:= TARGET_PORTAL_DYNAMIC
      else
        FServerConfig.Portal[I].ulType:= TARGET_PORTAL_DISABLED;
  end;

  if BootServer_BootMode.ItemIndex < 0 then
  begin
    Application.MessageBox('Please select a boot mode', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  FServerConfig.Params.Pxe.Start:= General_BootService.Checked;

  if BootServer_SaveDataMode.ItemIndex < 0 then
  begin
    Application.MessageBox('Please select a save data mode', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  
  FServerConfig.Params.Pxe.Flags:= BootServer_SaveDataMode.ItemIndex;
  if chkAutoBal.Checked then
    FServerConfig.Params.Pxe.Flags := FServerConfig.Params.Pxe.Flags or ISCSI_PXE_FLAG_AUTO_LOADBANLANCE;

  FServerConfig.Params.Pxe.BootMode:= BootServer_BootMode.ItemIndex;
  FServerConfig.Params.Pxe.NetConfig[FServerConfig.Params.Pxe.ActiceNetConfig].Gateway:= inet_addr(PAnsiChar(BootServer_Gateway.Text));
  FServerConfig.Params.Pxe.NetConfig[FServerConfig.Params.Pxe.ActiceNetConfig].Dns:= inet_addr(PAnsiChar(edDNS.Text));
  FServerConfig.Params.Pxe.NetConfig[FServerConfig.Params.Pxe.ActiceNetConfig].StartIP:= inet_addr(PAnsiChar(edStartIp.Text));
  FServerConfig.Params.Pxe.NetConfig[FServerConfig.Params.Pxe.ActiceNetConfig].EndIP:= inet_addr(PAnsiChar(edEndIp.Text));
  FServerConfig.Params.Pxe.NetConfig[FServerConfig.Params.Pxe.ActiceNetConfig].Mask:= inet_addr(PAnsiChar(edIpMask.Text));

  FillChar(FServerConfig.Params.Pxe.HostPerfix, SizeOf(FServerConfig.Params.Pxe.HostPerfix), 0);
  StrPCopy(@FServerConfig.Params.Pxe.HostPerfix[0], BootServer_HostName.Text);
  FServerConfig.Params.Pxe.HostIDLen:= BootServer_IDLen.Value;

  FillChar(FServerConfig.Params.Pxe.DefaultIQN[0],
    SizeOf(FServerConfig.Params.Pxe.DefaultIQN), 0);
  StrPCopy(@FServerConfig.Params.Pxe.DefaultIQN[0], BootServer_BootIQN.Text);
  dwRet:= uSANDeployServerApi.SetServerConfig(FServerConfig);
  if dwRet = 0 then
    Application.MessageBox('Server config saved successfully!', nil, MB_OK or MB_ICONINFORMATION)
  else
    Application.MessageBox('Server config save failed!', nil, MB_OK or MB_ICONWARNING);
end;


procedure TfSmartDiskAttribute.bConfirmClick(Sender: TObject);
begin
  SaveServerConfig();
  Close;
end;

procedure TfSmartDiskAttribute.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfSmartDiskAttribute.bApplyClick(Sender: TObject);
begin
  SaveServerConfig();
end;

procedure TfSmartDiskAttribute.LoadBalance_Server_RefreshClick(
  Sender: TObject);
begin
  RefreshSubServers();
end;

procedure TfSmartDiskAttribute.RefreshSubServers;
const
  ConnMsg: array[Boolean] of string = ('No', 'Yes');
var
  hFirst, hFind: KHANDLE;
  dwRet: Longword;
  ss: ISCSI_SERVER;
  ph: PInt64;
  Item: TListItem;
  bState: LongBool;
begin
  LoadBalance_ListView_Server.Items.BeginUpdate();
  try
    ClearData(LoadBalance_ListView_Server);
    hFirst:= 0;
    dwRet:= uSANDeployServerApi.FindFirstSubServer(hFirst);
    if (dwRet = 0) and (hFirst <> 0) then
    begin
      if (uSANDeployServerApi.GetSubServerConfig(hFirst, ss) <> 0)
        or (uSANDeployServerApi.GetSubServerState(hFirst, bState) <> 0) then
        Exit;
      New(ph);
      ph^:= hFirst;
      Item:= LoadBalance_ListView_Server.Items.Add();
      Item.Caption:= StrPas(@ss.ServerName[0]);
      Item.Data:= ph;
      Item.SubItems.Add(StrPas(@ss.UserName[0]));
      Item.SubItems.Add(IntToStr(ss.Port));
      Item.SubItems.Add(ConnMsg[Boolean(bState)]);
      repeat
        hFind:= 0;
        dwRet:= FindNextSubServer(hFirst, hFind);
        if (dwRet = 0) and (hFind <> 0) then
        begin
          if (uSANDeployServerApi.GetSubServerConfig(hFind, ss) <> 0)
            or (uSANDeployServerApi.GetSubServerState(hFind, bState) <> 0) then
            Exit;

          New(ph);
          ph^:= hFind;
          Item:= LoadBalance_ListView_Server.Items.Add();
          Item.Caption:= StrPas(@ss.ServerName[0]);
          Item.Data:= ph;
          Item.SubItems.Add(StrPas(@ss.UserName[0]));
          Item.SubItems.Add(IntToStr(ss.Port));
          Item.SubItems.Add(ConnMsg[Boolean(bState)]);
          hFirst:= hFind;
        end;
      until
        (dwRet <> 0) or (hFind = 0);
    end;
  finally
    LoadBalance_ListView_Server.Items.EndUpdate();
  end;
end;

procedure TfSmartDiskAttribute.ClearData(ListView: TListView);
var
  I: Integer;
  ph: PInt64;
begin
  if ListView = nil then
    Exit;
  for I:= 0 to ListView.Items.Count-1 do
  begin
    ph:= ListView.Items[I].Data;
    if ph = nil then
      Continue;
    Dispose(ph);
  end;
  ListView.Items.Clear;
end;

procedure TfSmartDiskAttribute.LoadBalance_Server_RemoveClick(
  Sender: TObject);
var
  ph: PInt64;
  dwRet: Longword;
begin
  if (LoadBalance_ListView_Server.Selected = nil) or
    (LoadBalance_ListView_Server.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a server first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  ph:= LoadBalance_ListView_Server.Selected.Data;
  dwRet:= uSANDeployServerApi.DeleteSubServer(ph^);
  if dwRet <> 0 then
    Application.MessageBox('Deleting server failed!', nil, MB_OK or MB_ICONWARNING);
  RefreshSubServers();
end;


procedure TfSmartDiskAttribute.LoadBalance_Sync_AddClick(Sender: TObject);
var
  bOK, bTryConnectServer: Boolean;
  strLocalTargetName, strRemoteTargetName: string;
  dwRet: Longword;
  app: ISCSI_APPLICATION;
  ia: TInAddr;
  CurrentPort: Word;
  SubServer: ISCSI_SERVER;
  SubServerConfig: ISCSI_SERVER_CONFIG;
  CurrentIP, LocalIP, RemoteIP: Longword;
  LocalPort, RemotePort: Word;
  SyncType: Integer;
  hTarget: KHANDLE;
  hRemoteTarget: KHANDLE;
  hAppLocal: KHANDLE;
  hAppRemote: KHANDLE;
  LiOffset: LARGE_INTEGER;
begin
  CurrentIP:= uSANDeployServerApi.GetIP();
  CurrentPort:= uSANDeployServerApi.GetPort();
  fAddSynchronization:= TfAddSynchronization.Create(Self);
  fAddSynchronization.LocalServerConfig:= FServerConfig;
  try
    fAddSynchronization.ShowModal;
    bOK:= fAddSynchronization.IsOk;
    bTryConnectServer:= fAddSynchronization.IsTryConntectRemoteServer;
    strLocalTargetName:= fAddSynchronization.LocalTargetName;
    strRemoteTargetName:= fAddSynchronization.RemoteTargetName;
    SubServer:= fAddSynchronization.SubServer;
    SubServerConfig:= fAddSynchronization.SubServerConfig;
    LocalIP:= fAddSynchronization.LocalIP;
    RemoteIP:= fAddSynchronization.RemoteIP;
    SyncType:= fAddSynchronization.Tag;
    LocalPort:= fAddSynchronization.LocalPort;
    RemotePort:= fAddSynchronization.RemotePort;
    hTarget:= fAddSynchronization.LocalTargetHandle;
    hRemoteTarget:=  fAddSynchronization.RemoteTargetHandle;
  finally
    FreeAndNil(fAddSynchronization);
  end;

  if bTryConnectServer then
  begin
    ia.S_addr:= CurrentIP;
    dwRet:= uSANDeployServerApi.ConnectTo(inet_ntoa(ia), CurrentPort,
      @FServerConfig.RemoteControl.UserName[0], @FServerConfig.RemoteControl.Password[0]);
    if dwRet <> 0 then
    begin
      Application.MessageBox('Can''t connect to server!', nil, MB_OK or MB_ICONWARNING);
      Exit;
    end;
  end;

  if bOK and (strLocalTargetName <> '') and (strRemoteTargetName <> '') then
  begin
    FillChar(app, SizeOf(ISCSI_APPLICATION), 0);
    app.Id:= Longword(-1);
    app.AppType:= ISCSI_APPLICATION_TYPE_CLUSTER;
    app.Params.FailOver.CreateNew:= True;
    StrCopy(@app.TargetName[0], PAnsiChar(strLocalTargetName));
    StrPCopy(@app.Params.FailOver.iSCSI.TargetName[0], strRemoteTargetName);
    app.Params.FailOver.iSCSI.LocalPort:= 0;
    app.Params.FailOver.iSCSI.LocalPortal:= LocalIP;
    app.Params.FailOver.iSCSI.Host:= RemoteIP;
    app.Params.FailOver.iSCSI.Port:= RemotePort;
    GetWindowsDirectory(@app.Params.FailOver.WorkPath[0], MAX_PATH);
    dwRet:= uSANDeployServerApi.CreateApplication(hAppLocal, PAnsiChar(strLocalTargetName), app);
    if dwRet <> 0 then
    begin
      Application.MessageBox('Create sync failed!', nil, MB_OK or MB_ICONWARNING);
      Exit;
    end;

    dwRet:= uSANDeployServerApi.ConnectTo(@SubServer.ServerName[0], SubServer.Port,
        @SubServer.UserName[0], @SubServer.Password[0]);
    if dwRet <> 0 then
    begin
      Application.MessageBox('Could not connect to Second Server!', nil, MB_OK or MB_ICONWARNING);
      Exit;
    end;

    app.Id:= Longword(-1);
    app.AppType:= ISCSI_APPLICATION_TYPE_CLUSTER;
    app.Params.FailOver.CreateNew:= True;
    StrCopy(@app.TargetName[0], PAnsiChar(strRemoteTargetName));
    app.Params.FailOver.iSCSI.LocalPortal:= RemoteIP;
    app.Params.FailOver.iSCSI.LocalPort:= 0;
    app.Params.FailOver.iSCSI.Host:= LocalIP;
    app.Params.FailOver.iSCSI.Port:= LocalPort;
    StrPCopy(@app.Params.FailOver.iSCSI.TargetName[0], strLocalTargetName);
    GetWindowsDirectory(@app.Params.FailOver.WorkPath[0], MAX_PATH);
    dwRet:= uSANDeployServerApi.CreateApplication(hAppRemote, PAnsiChar(strRemoteTargetName), app);
    if dwRet <> 0 then
    begin
      Application.MessageBox('Create sync failed!', nil, MB_OK or MB_ICONWARNING);
      Exit;
    end;

    case SyncType of
      0:
        begin
        uSANDeployServerApi.ConnectTo(inet_ntoa(ia), CurrentPort,
      @FServerConfig.RemoteControl.UserName[0], @FServerConfig.RemoteControl.Password[0]);
        uSANDeployServerApi.StartApplicationSync(hTarget, hAppLocal,true, LiOffset,LiOffset);
        end;
      1:
       begin
        uSANDeployServerApi.StartApplicationSync(hRemoteTarget, hAppRemote, true, LiOffset,LiOffset);
        end;
      2:
      begin
        uSANDeployServerApi.ConnectTo(inet_ntoa(ia), CurrentPort,
      @FServerConfig.RemoteControl.UserName[0], @FServerConfig.RemoteControl.Password[0]);
        uSANDeployServerApi.StartApplicationSync(hTarget, hAppLocal,false, LiOffset,LiOffset);
        end;
    end;

    uSANDeployServerApi.ConnectTo(inet_ntoa(ia), CurrentPort,
      @FServerConfig.RemoteControl.UserName[0], @FServerConfig.RemoteControl.Password[0]);

    RefreshApplications();
  end
  else
    Application.MessageBox('No target selected!', nil, MB_OK or MB_ICONWARNING);
end;

procedure TfSmartDiskAttribute.LoadBalance_Sync_DeleteClick(
  Sender: TObject);
var
  dwRet: Longword;
  P: PApplicationTargetData;
begin
  if (LoadBalance_ListView_Sync.Selected = nil)
    or (LoadBalance_ListView_Sync.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a sync first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  P:= LoadBalance_ListView_Sync.Selected.Data;
  dwRet:= uSANDeployServerApi.DeleteApplication(P^.hTarget, P^.hApplication);
  if (dwRet <> 0) then
    Application.MessageBox('Delete Sync failed!', nil, MB_OK or MB_ICONWARNING);
  RefreshApplications();
end;

procedure TfSmartDiskAttribute.ClearApplicationTargetData(List: TList);
var
  I: Integer;
  P: PApplicationTargetData;
begin
  if List = nil then
    Exit;
  for I:= 0 to List.Count-1 do
  begin
    P:= List.Items[I];
    if P = nil then
      Exit;
    Dispose(P);
  end;
  List.Clear;
end;

procedure TfSmartDiskAttribute.GetApplications(List: TList);
var
  dwRet0, dwRet1, dwRet2: Longword;
  khStartTarget, khFindTarget: KHANDLE;
  khStartApplication, khFindApplication: KHANDLE;
  P: PApplicationTargetData;
begin
  if List = nil then
    Exit;
  ClearApplicationTargetData(List);

  khStartTarget:= 0;
  repeat
    khFindTarget:= 0;
    dwRet0:= uSANDeployServerApi.FindNextTargetEx(khStartTarget, khFindTarget);
    if (dwRet0 = 0) and (khFindTarget <> 0) then
    begin
      khStartApplication:= 0;
      repeat
        khFindApplication:= 0;
        dwRet1:= uSANDeployServerApi.FindNextApplication(khFindTarget, khStartApplication, khFindApplication);
        if (dwRet1 = 0) and (khFindApplication <> 0) then
        begin
          New(P);
          ZeroMemory(P, SizeOf(TApplicationTargetData));
          P^.hTarget:= khFindTarget;
          P^.hApplication:= khFindApplication;
          dwRet2:= uSANDeployServerApi.GetApplicationConfig(khFindTarget, khFindApplication, P^.App);
          if (dwRet2 = 0) then
            List.Add(P)
          else
            Dispose(P);
          khStartApplication:= khFindApplication;
        end;
      until (dwRet1 <> 0) or (khFindApplication = 0);

      khStartTarget:= khFindTarget;
    end;
  until (dwRet0 <> 0) or (khFindTarget = 0);

end;

procedure TfSmartDiskAttribute.FormCreate(Sender: TObject);
begin
  FApplicationTargetList:= TList.Create;
end;

procedure TfSmartDiskAttribute.FormDestroy(Sender: TObject);
begin
  ClearApplicationTargetData(FApplicationTargetList);
  FApplicationTargetList.Free;
end;

function StatusText(ApplicationStatus: Longword): string;
begin
  Result:= '';
  case ApplicationStatus of
		ord(ISCSI_APPLICATION_STATUS_FAIL): Result:= 'Failed';
		ord(ISCSI_APPLICATION_STATUS_PENDING): Result:= 'Pending';
		ord(ISCSI_APPLICATION_STATUS_WORKING): Result:= 'Working';
		ord(ISCSI_APPLICATION_STATUS_FAILOVERING): Result:= 'FailOvering';
  end;

  end;

procedure TfSmartDiskAttribute.FillSyncApp(List: TList);
var
  I: Integer;
  P: PApplicationTargetData;
  Item: TListItem;
  ia: TInAddr;

  Progress: LongWord;
	SyncResult: LongWord;
begin
  if List = nil then
    Exit;
  LoadBalance_ListView_Sync.Items.BeginUpdate();
  try
    LoadBalance_ListView_Sync.Items.Clear();
    for I:= 0 to List.Count-1 do
    begin
      P:= List.Items[I];
      if P = nil then
        Continue;
      ia.S_addr:= P^.App.Params.FailOver.iSCSI.Host;
      Item:= LoadBalance_ListView_Sync.Items.Add();
      Item.Caption:= StrPas(@P^.App.TargetName[0]);
      Item.SubItems.Add(StrPas(inet_ntoa(ia)));
      Item.SubItems.Add(StrPas(@P^.App.Params.FailOver.iSCSI.TargetName[0]));
      Item.SubItems.Add(StatusText(P^.App.Status));

      if P^.App.Status = ord(ISCSI_APPLICATION_STATUS_WORKING) then
      begin

        GetApplicationSyncProgress(P^.hTarget,P^.hApplication,Progress);
        GetApplicationSyncResult(P^.hTarget,P^.hApplication,SyncResult);

        if SyncResult = 1 then
          begin
           Item.SubItems.Strings[2] := 'Sync: ' + IntToStr(Progress) + '%';
          end;
      end;

      Item.Data:= P;


    end;
  finally
    LoadBalance_ListView_Sync.Items.EndUpdate();
  end;
end;

procedure TfSmartDiskAttribute.LoadBalance_Sync_RefreshClick(
  Sender: TObject);
begin
  RefreshApplications();
end;

procedure TfSmartDiskAttribute.RefreshApplications;
begin
  GetApplications(FApplicationTargetList);
  FillSyncApp(FApplicationTargetList);
end;

procedure TfSmartDiskAttribute.GetTargets(aStrings: TStrings);
var
  hStartTarget, hFindTarget: KHANDLE;
  dwRet: Longword;
  iste: TIScsiTargetEx;
  ph: PInt64;
begin
  if aStrings = nil then
    Exit;
  aStrings.Clear;
  hStartTarget:= 0;
  repeat
    hFindTarget:= 0;
    dwRet:= uSANDeployServerApi.FindNextTargetEx(hStartTarget, hFindTarget);
    if (dwRet = 0) then
    begin
      if (uSANDeployServerApi.GetTargetConfigEx(hFindTarget, iste) = 0) then
        aStrings.Add(StrPas(iste.TargetName));
    end
    else
      Break;
    hStartTarget:= hFindTarget;
  until (dwRet <> 0) or (hFindTarget = 0);
end;

procedure TfSmartDiskAttribute.LoadBalance_Sync_SynchronizeClick(
  Sender: TObject);
var
  dwRet: Longword;
  P: PApplicationTargetData;
  L: LARGE_INTEGER;
begin
  if (LoadBalance_ListView_Sync.Selected = nil)
    or (LoadBalance_ListView_Sync.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a sync first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  L.QuadPart:= 0;
  P:= LoadBalance_ListView_Sync.Selected.Data;
  dwRet:= uSANDeployServerApi.StartApplicationSync(P^.hTarget, P^.hApplication, true, L, L);
  if (dwRet <> 0) then
    Application.MessageBox('Delete Sync failed!', nil, MB_OK or MB_ICONWARNING);
  RefreshApplications();
end;

end.
