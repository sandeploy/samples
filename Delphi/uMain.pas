unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Menus, ComCtrls, ToolWin, ImgList, ExtCtrls,
  Buttons;

type
  TfMain = class(TForm)
    MainMenu: TMainMenu;
    MainMenu_File: TMenuItem;
    MainMenu_File1: TMenuItem;
    MainMenu_File2: TMenuItem;
    MainMenu_Action: TMenuItem;
    MainMenu_Help: TMenuItem;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel5: TPanel;
    Panel2: TPanel;
    Notebook: TNotebook;
    ListView_Root: TListView;
    Panel3: TPanel;
    Panel_SelectedText: TPanel;
    ListView_Groups: TListView;
    ListView_Volume: TListView;
    ListView_BootServer: TListView;
    ListView_Users: TListView;
    btnUsers: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Panel4: TPanel;
    User_Create: TBitBtn;
    User_SetPassword: TBitBtn;
    User_Delete: TBitBtn;
    User_Refresh: TBitBtn;
    Panel7: TPanel;
    Group_Create: TBitBtn;
    Group_AddtoGroup: TBitBtn;
    Group_Delete: TBitBtn;
    Group_Refresh: TBitBtn;
    Panel8: TPanel;
    Volume_Create: TBitBtn;
    Volume_Online: TBitBtn;
    Volume_Offline: TBitBtn;
    Volume_Delete: TBitBtn;
    Volume_Refresh: TBitBtn;
    Volume_Attribute: TBitBtn;
    Panel9: TPanel;
    Panel10: TPanel;
    ListView_SubTarget: TListView;
    Panel6: TPanel;
    Panel11: TPanel;
    ListView_Target: TListView;
    Target_Create: TBitBtn;
    Target_Online: TBitBtn;
    Target_Offline: TBitBtn;
    Target_Delete: TBitBtn;
    Target_Refresh: TBitBtn;
    Target_Attribute: TBitBtn;
    Splitter2: TSplitter;
    TargetClient_Remove: TBitBtn;
    TargetClient_SetCommit: TBitBtn;
    TargetClient_AddtoWorkstations: TBitBtn;
    TargetClient_Refresh: TBitBtn;
    Panel12: TPanel;
    BootServer_AddWorkstations: TBitBtn;
    BootServer_WakeupAll: TBitBtn;
    WorkStation_Attribute: TBitBtn;
    BootServer_Delete: TBitBtn;
    BootServer_Refresh: TBitBtn;
    Panel13: TPanel;
    Panel14: TPanel;
    BitBtn42: TBitBtn;
    BitBtn43: TBitBtn;
    BootServer_Attribute: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure MainMenu_File2Click(Sender: TObject);
    procedure MainMenu_File1Click(Sender: TObject);
    procedure btnUsersClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure User_CreateClick(Sender: TObject);
    procedure User_SetPasswordClick(Sender: TObject);
    procedure User_DeleteClick(Sender: TObject);
    procedure Group_CreateClick(Sender: TObject);
    procedure Group_DeleteClick(Sender: TObject);
    procedure Group_AddtoGroupClick(Sender: TObject);
    procedure Volume_CreateClick(Sender: TObject);
    procedure Volume_RefreshClick(Sender: TObject);
    procedure Volume_AttributeClick(Sender: TObject);
    procedure Target_CreateClick(Sender: TObject);
    procedure Target_RefreshClick(Sender: TObject);
    procedure Target_AttributeClick(Sender: TObject);
    procedure WorkStation_AttributeClick(Sender: TObject);
    procedure BootServer_AddWorkstationsClick(Sender: TObject);
    procedure BootServer_DeleteClick(Sender: TObject);
    procedure ListView_TargetSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure BitBtn42Click(Sender: TObject);
    procedure BitBtn43Click(Sender: TObject);
    procedure User_RefreshClick(Sender: TObject);
    procedure Group_RefreshClick(Sender: TObject);
    procedure Volume_DeleteClick(Sender: TObject);
    procedure Volume_OnlineClick(Sender: TObject);
    procedure Volume_OfflineClick(Sender: TObject);
    procedure Target_OnlineClick(Sender: TObject);
    procedure Target_OfflineClick(Sender: TObject);
    procedure Target_DeleteClick(Sender: TObject);
    procedure TargetClient_AddtoWorkstationsClick(Sender: TObject);
    procedure TargetClient_RemoveClick(Sender: TObject);
    procedure TargetClient_SetCommitClick(Sender: TObject);
    procedure TargetClient_RefreshClick(Sender: TObject);
    procedure BootServer_RefreshClick(Sender: TObject);
    procedure BootServer_WakeupAllClick(Sender: TObject);
    procedure ListView_VolumeDeletion(Sender: TObject; Item: TListItem);
    procedure ListView_VolumeDblClick(Sender: TObject);
    procedure BootServer_AttributeClick(Sender: TObject);
    //procedure Panel8Click(Sender: TObject);
  private
    { Private declarations }
    function GetGroupList(List: TStrings): Boolean;
    function GetUserList(List: TStrings): Boolean;
    procedure ClearData(ListView: TListView);
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

uses uConnectToServer, uSmartDiskAttribute, uCreateUsers, uCreateGroups,
  uCreateVolume, uCreateTarget, uVolumeAttribute, uAddWorkstation,
  uTargetAttribute, uSANDeployServerApi, uUtils, WinSock;

{$R *.dfm}

procedure TfMain.FormShow(Sender: TObject);
var
  IsConnected: Boolean;
begin
  // Login
  fConnectToServer := TfConnectToServer.Create(Self);
  try
    fConnectToServer.Tag := 100; // Login
    fConnectToServer.ShowModal;
    IsConnected := fConnectToServer.IsConnect;
  finally
    FreeAndNil(fConnectToServer);
  end;

  if IsConnected then
  begin
    // Work....

    Notebook.PageIndex := 0;
  end else
  begin

  end;
end;

procedure TfMain.MainMenu_File1Click(Sender: TObject);
begin
  // Option
end;

procedure TfMain.MainMenu_File2Click(Sender: TObject);
begin
  // Exit;
  Close;
end;


procedure TfMain.btnUsersClick(Sender: TObject);
begin
  // Users
  Panel_SelectedText.Caption := '  Users';
  User_Refresh.Click;
  Notebook.PageIndex := 1;
end;

procedure TfMain.BitBtn2Click(Sender: TObject);
begin
  // Groups
  Panel_SelectedText.Caption := '  Groups';
  Group_Refresh.Click;
  Notebook.PageIndex := 2;
end;

procedure TfMain.BitBtn3Click(Sender: TObject);
begin
  // Virtual Volumes
  Panel_SelectedText.Caption := '  Virtual Volumes';
  Volume_Refresh.Click;
  Notebook.PageIndex := 3;
end;

procedure TfMain.BitBtn4Click(Sender: TObject);
begin
  // iSCSI Targets
  Panel_SelectedText.Caption := '  iSCSI Targets';
  Target_Refresh.Click;
  Notebook.PageIndex := 4;
end;

procedure TfMain.BitBtn5Click(Sender: TObject);
begin
  // BootServer
  Panel_SelectedText.Caption := '  BootServer';
  BootServer_Refresh.Click;
  Notebook.PageIndex := 5;
end;

procedure TfMain.User_CreateClick(Sender: TObject);
var
  IsAdded: Boolean;
begin
  // Create User
  fCreateUsers := TfCreateUsers.Create(Self);
  try
    fCreateUsers.Tag := 0; // Create Users
    fCreateUsers.UserId:= Longword(-1);
    fCreateUsers.ShowModal;
    IsAdded := fCreateUsers.IsAdd;
  finally
    FreeAndNil(fCreateUsers);
  end;

  if IsAdded then
    // Refresh Users
    User_Refresh.Click;
end;

procedure TfMain.User_SetPasswordClick(Sender: TObject);
var
  IsEdited: Boolean;
begin
  if (ListView_Users.Selected = nil) or (ListView_Users.Selected.Caption = '') then
  begin
    Application.MessageBox('Please select a user first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  // Set Password
  fCreateUsers := TfCreateUsers.Create(Self);
  try
    fCreateUsers.Tag := 1; // Set Password
    fCreateUsers.UserId:= Longword(ListView_Users.Selected.Data);
    fCreateUsers.UserName.Text:= ListView_Users.Selected.Caption;
    fCreateUsers.ShowModal;
    IsEdited := fCreateUsers.IsAdd;
  finally
    FreeAndNil(fCreateUsers);
  end;

  if IsEdited then
    // Refresh Users
    User_Refresh.Click;
end;

procedure TfMain.User_DeleteClick(Sender: TObject);
var
  strUserName: string;
  dwRet: Longword;
begin
  // Delete User
  if (ListView_Users.Selected = nil) or (ListView_Users.Selected.Caption = '') then
  begin
    Application.MessageBox('Please select a user to delete!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  strUserName:= ListView_Users.Selected.Caption;
  if (Application.MessageBox(PAnsiChar('Are you sure to delete user ' + strUserName + ' ?'),
    nil, MB_YESNO or MB_ICONWARNING) = IDNO) then
      Exit;
  dwRet:= uSANDeployServerApi.DeleteUser(Longword(ListView_Users.Selected.Data));

  if dwRet <> 0 then
    Application.MessageBox(PChar('Delete user "' + strUserName + '" failed!'), nil, MB_OK or MB_ICONWARNING);

  // Work

  User_Refresh.Click;
end;

procedure TfMain.Group_CreateClick(Sender: TObject);
var
  IsAdded: Boolean;
begin
  // Create Group
  fCreateGroups := TfCreateGroups.Create(Self);
  try
    fCreateGroups.Tag := 0; // Create group
    fCreateGroups.GroupId:= Longword(-1);
    fCreateGroups.ShowModal;
    IsAdded := fCreateGroups.IsAdd;
  finally
    FreeAndNil(fCreateGroups);
  end;

  if IsAdded then
    // Refresh Groups
    Group_Refresh.Click();
end;

procedure TfMain.Group_DeleteClick(Sender: TObject);
var
  dwRet: Longword;
begin
  // Delete group
  if (ListView_Groups.Selected = nil) or (ListView_Groups.Selected.Caption = '') then
  begin
    Application.MessageBox('Please select a group to delete!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  if Application.MessageBox(PChar(Format('Are you sure to delete group "%s" ?', [ListView_Groups.Selected.Caption])), nil, MB_YESNO or MB_ICONQUESTION) = IDNO then
    Exit;
    
  dwRet:= uSANDeployServerApi.DeleteGroup(Longword(ListView_Groups.Selected.Data));
  if dwRet <> 0 then
    Application.MessageBox('Deleting group failed!', nil, MB_OK or MB_ICONWARNING);

  Group_Refresh.Click();
end;

function TfMain.GetUserList(List: TStrings): Boolean;

  function GetGroupName(pUserName: PAnsiChar; var strGroupName: string): Boolean;
  var
    I, dwGroupCount, dwRet: Longword;
    arrGroups: array[0..127] of Longword;
    pGroupName: PAnsiChar;
  begin
    Result:= False;
    dwGroupCount:= SizeOf(arrGroups);
    dwRet:= uSANDeployServerApi.GetGroups(pUserName, @arrGroups[0], @dwGroupCount);
    if (dwRet = 0) then
    begin
      Result:= True;
      dwGroupCount:= dwGroupCount div SizeOf(Longword);
      if dwGroupCount = 0 then
        Exit;
      GetMem(pGroupName, 256);
      for I := 0 to dwGroupCount - 1 do
      begin
        FillChar(pGroupName^, 256, 0);
        dwRet:= uSANDeployServerApi.GetGroupName(arrGroups[I], pGroupName, 255);
        if dwRet = 0 then
          if strGroupName = '' then
            strGroupName:= StrPas(pGroupName)
          else
            strGroupName:= strGroupName + ',' + StrPas(pGroupName)
        else
        begin
          Result:= False;
          Break;
        end;
      end;
      FreeMem(pGroupName);  
    end;
  end;

var
  arrUsers: array[0..1023] of Longword;
  I, dwRet, dwUserCount: Longword;
  pUserName: PAnsiChar;
  S, strGroupName: string;
begin
  Result:= False;
  if List = nil then
    Exit;
  dwUserCount:= SizeOf(arrUsers);
  dwRet:= uSANDeployServerApi.GetUsers(nil, @arrUsers[0], @dwUserCount);
  if (dwRet = 0) then
  begin
    Result:= True;
    dwUserCount:= dwUserCount div SizeOf(Longword);
    if dwUserCount = 0 then
      Exit;
    GetMem(pUserName, 256);
    for I := 0 to dwUserCount - 1 do
    begin
      FillChar(pUserName^, 256, 0);
      dwRet:= uSANDeployServerApi.GetUserNameFromID(arrUsers[I], pUserName, 255);
      if (dwRet <> 0) then
      begin
        Result:= False;
        Break;
      end;
      strGroupName:= '';
      if GetGroupName(pUserName, strGroupName) then
      begin
        S:= Format('%s=%s', [StrPas(pUserName), strGroupName]);
        List.AddObject(S, TObject(arrUsers[I]));
      end
      else
      begin
        Result:= False;
        Break;
      end;
    end;
    FreeMem(pUserName);
  end;
end;

procedure TfMain.Group_AddtoGroupClick(Sender: TObject);
var
  IsEdited: Boolean;
begin
  if (ListView_Groups.Selected = nil) or (ListView_Groups.Selected.Caption = '') then
  begin
    Application.MessageBox('Please select a group first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  
  // Add to Group
  fCreateGroups := TfCreateGroups.Create(Self);
  try
    fCreateGroups.GroupId:= Longword(ListView_Groups.Selected.Data);
    fCreateGroups.GroupName.Text:= ListView_Groups.Selected.Caption;
    fCreateGroups.Tag := 1; // Add to Group
    fCreateGroups.ShowModal;
    IsEdited := fCreateGroups.IsAdd;
  finally
    FreeAndNil(fCreateGroups);
  end;

  if IsEdited then
    // Refresh Groups
    Group_Refresh.Click();
end;

procedure TfMain.Volume_CreateClick(Sender: TObject);
var
  IsAdded: Boolean;
begin
  // Create Virtual Volume
  Volume_Create.Enabled:= False;
  fCreateVolume := TfCreateVolume.Create(Self);
  try
    fCreateVolume.ShowModal;
    IsAdded := fCreateVolume.IsAdd;
  finally
    FreeAndNil(fCreateVolume);
    Volume_Create.Enabled:= True;
  end;

  if IsAdded then
    // Refresh Volumes
    Volume_Refresh.Click();
end;

function TargetDeviceTypeToString(const ist: TIScsiTarget): string;
begin
  Result:= '';
  case ist.iScsiTargetDeviceType of
		ISCSI_TARGET_TYPE_DISK: Result:= 'Disk Volume';
		ISCSI_TARGET_TYPE_TAPE: Result:= 'Tape Volume';
		ISCSI_TARGET_TYPE_CDROM: Result:= 'CD-ROM Volume';
		ISCSI_TARGET_TYPE_SCSI:
      case ist.iScsiTargetMediaType of
        ISCSI_TARGET_MEDIA_TYPE_CDROM: Result:= 'CD-ROM Volume';
        ISCSI_TARGET_MEDIA_TYPE_DISK: Result:= 'Disk Volume';
        ISCSI_TARGET_MEDIA_TYPE_SCSI: Result:= 'CD-ROM Volume';
      end;
  end;
end;

function TargetSourceToString(const ist: TIScsiTarget): string;
begin
  Result:= '';
  case ist.iScsiTargetMediaType of
    ISCSI_TARGET_MEDIA_TYPE_MEMORY: Result:= 'Memory';
  else
    Result:= StrPas(@ist.FileName[0]);
  end;
end;

function TargetStatus(bEnabled: Boolean): string;
begin
  if bEnabled then
    Result:= 'Online'
  else
    Result:= 'Offline';
end;

function TargetAuthMode(dwAuthMode: Longword): string;
begin
  case dwAuthMode of
    ISCSI_AUTH_MODE_ANONYMOUS: Result:= 'anonymous full access';
    ISCSI_AUTH_MODE_CHAP: Result:= 'CHAP';
    ISCSI_AUTH_MODE_IPFILTER: Result:= 'IP filters';
    ISCSI_AUTH_MODE_BOTH: Result:= 'Both CHAP and IP filters';
    ISCSI_AUTH_MODE_OR: Result:= 'CHAP';
  end;
end;

procedure TfMain.Volume_RefreshClick(Sender: TObject);
var
  khStartTarget, khFindTarget: KHANDLE;
  dwRet: Longword;
  ist: TIScsiTarget;
  item: TListItem;
  p: PInt64;
begin
  // Refresh Volumes
  Volume_Refresh.Enabled:= False;
  khStartTarget:= 0;
  ListView_Volume.Items.BeginUpdate;
  try
    ClearData(ListView_Volume);
    ListView_Volume.Clear;
    repeat
      dwRet:= uSANDeployServerApi.FindNextTarget(khStartTarget, khFindTarget);
      if dwRet = 0 then
      begin
        if uSANDeployServerApi.GetTargetConfig(khFindTarget, ist) = 0 then
        begin
          item:= ListView_Volume.Items.Add();
          item.Caption:= TargetDeviceTypeToString(ist);
          item.SubItems.Add(TargetSourceToString(ist));
          item.SubItems.Add(FormatSize(ist.DeviceSize.QuadPart));
          item.SubItems.Add(TargetStatus(ist.bEnable));
          item.SubItems.Add(StrPas(ist.TargetName));
          item.SubItems.Add(StrPas(ist.VirtualWrite.VirtualWritePath));
          New(p);
          p^:= khFindTarget;
          item.Data:= p;
        end
        else
          Break;
        khStartTarget:= khFindTarget;
      end;
    until dwRet <> 0;
  finally
    ListView_Volume.Items.EndUpdate;
    Volume_Refresh.Enabled:= True;
  end;
end;

procedure TfMain.Volume_AttributeClick(Sender: TObject);
var
  IsEdited: Boolean;
  pkh: PInt64;
begin
  // Edit Volume Attribute
  if (ListView_Volume.Selected = nil) or (ListView_Volume.Selected.Data = nil) then
    Exit;
  fVolumeAttribute := TfVolumeAttribute.Create(Self);
  try
    pkh:= ListView_Volume.Selected.Data;
    fVolumeAttribute.VolumeHandle:= pkh^;
    fVolumeAttribute.ShowModal;
    IsEdited := fVolumeAttribute.IsAdd;
  finally
    FreeAndNil(fVolumeAttribute);
  end;

  if IsEdited then
    // Refresh Volumes
    Volume_Refresh.Click();
end;

procedure TfMain.Target_CreateClick(Sender: TObject);
var
  IsAdded: Boolean;
begin
  // Create Target
  fCreateTarget := TfCreateTarget.Create(Self);
  try
    fCreateTarget.ShowModal;
    IsAdded := fCreateTarget.IsAdd;
  finally
    FreeAndNil(fCreateTarget);
  end;

  if IsAdded then
    // Refresh Targets
    Target_Refresh.Click;
end;

procedure TfMain.Target_RefreshClick(Sender: TObject);
var
  dwRet: Longword;
  khStartTarget, khFindTarget: KHANDLE;
  ste: TIScsiTargetEx;
  item: TListItem;
  p: PInt64;
begin
  // Refresh Targets
  khStartTarget:= 0;
  khFindTarget:= 0;
  ListView_Target.Items.BeginUpdate;
  try
    ClearData(ListView_Target);
    ListView_Target.Clear;
    repeat
      dwRet:= uSANDeployServerApi.FindNextTargetEx(khStartTarget, khFindTarget);
      if (dwRet = 0) and (khFindTarget <> 0) then
      begin
        if uSANDeployServerApi.GetTargetConfigEx(khFindTarget, ste) = 0 then
        begin
          item:= ListView_Target.Items.Add();
          item.Caption:= StrPas(@ste.TargetName[0]);
          item.SubItems.Add(IntToStr(ste.LunCount));
          item.SubItems.Add(TargetAuthMode(ste.ulAuthMode));
          item.SubItems.Add(TargetStatus(ste.Enabled));
          New(p);
          p^:= khFindTarget;
          item.Data:= p;
        end
        else
          Break; 
        khStartTarget:= khFindTarget;
      end;
    until (dwRet <> 0) or (khFindTarget = 0);
  finally
    ListView_Target.Items.EndUpdate;
  end;
end;

procedure TfMain.Target_AttributeClick(Sender: TObject);
var
  IsEdited: Boolean;
begin
  // Edit Target Attribute
  if (ListView_Target.Selected = nil) or (ListView_Target.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a target first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  fTargetAttribute := TfTargetAttribute.Create(Self);
  try
    fTargetAttribute.TargetHandle:= PInt64(ListView_Target.Selected.Data)^;
    fTargetAttribute.ShowModal;
    IsEdited := fTargetAttribute.IsAdd;
  finally
    FreeAndNil(fTargetAttribute);
  end;

  if IsEdited then
    Target_Refresh.Click();
end;

procedure TfMain.WorkStation_AttributeClick(Sender: TObject);
var
  cc: TClientConfig;
  dwRet: Longword;
  kh: KHANDLE;
  IsAdded: Boolean;
begin
  if (ListView_BootServer.Selected = nil) or (ListView_BootServer.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a workstation first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  kh:= PInt64(ListView_BootServer.Selected.Data)^;
  dwRet:= uSANDeployServerApi.GetStaticClientConfig(0, kh, cc);
  if dwRet <> 0 then
  begin
    Application.MessageBox('Can''t get the workstaion information!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  IsAdded:= False;
  fAddWorkstation := TfAddWorkstation.Create(Self);
  try
    fAddWorkstation.Tag:= 1;
    fAddWorkstation.ClientHandle:= kh;
    fAddWorkstation.ClientConfig:= cc;
    fAddWorkstation.FillConfig;
    fAddWorkstation.ShowModal;
    IsAdded := fAddWorkstation.IsAddOrEdit;
  finally
    FreeAndNil(fAddWorkstation);
  end;
  if IsAdded then
    BootServer_Refresh.Click;
end;

procedure TfMain.BootServer_AddWorkstationsClick(Sender: TObject);
var
  IsAdded: Boolean;
begin
  // Click BootServer in the TreeView] Add Workstation
  IsAdded:= False;
  fAddWorkstation := TfAddWorkstation.Create(Self);
  try
    fAddWorkstation.ShowModal;
    IsAdded := fAddWorkstation.IsAddOrEdit;
  finally
    FreeAndNil(fAddWorkstation);
  end;

  if IsAdded then
    BootServer_Refresh.Click;
end;

procedure TfMain.BootServer_AttributeClick(Sender: TObject);
begin
  fSmartDiskAttribute := TfSmartDiskAttribute.Create(Self);
  try
    fSmartDiskAttribute.Tag := 1;
    fSmartDiskAttribute.ShowModal;
  finally
    FreeAndNil(fSmartDiskAttribute);
  end;
end;

procedure TfMain.BootServer_DeleteClick(Sender: TObject);
var
  kh: Int64;
  dwRet: Longword;
begin
  // Delete client in BootServer
  if (ListView_BootServer.Selected = nil) or (ListView_BootServer.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a workstation first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  kh:= PInt64(ListView_BootServer.Selected.Data)^;
  dwRet:= uSANDeployServerApi.DeleteStaticClient(0, kh);
  if dwRet <> 0 then
    Application.MessageBox('Deleting client failed!', nil, MB_OK or MB_ICONWARNING);
  BootServer_Refresh.Click;
end;

procedure TfMain.ListView_TargetSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  Panel13.Caption := '';

  if Item <> nil then
  begin
    if Selected then
    begin
      Panel13.Caption := '  '+Item.Caption;
      TargetClient_Refresh.Click;
    end;
  end
  else
  begin
    ClearData(ListView_SubTarget);
    ListView_SubTarget.Clear;
  end;
end;

procedure TfMain.ListView_VolumeDeletion(Sender: TObject; Item: TListItem);
var
  p: PInt64;
begin
  if Item = nil then
    Exit;
  p:= Item.Data;
  if p <> nil then
    Dispose(p);
end;

procedure TfMain.BitBtn42Click(Sender: TObject);
var
  IsConnected: Boolean;
begin
  // Connect to another server
  fConnectToServer := TfConnectToServer.Create(Self);
  try
    fConnectToServer.Tag := 200; // Connect to another server
    fConnectToServer.ShowModal;
    IsConnected := fConnectToServer.IsConnect;
  finally
    FreeAndNil(fConnectToServer);
  end;

{
  if IsConnected then
  begin
    // Work
  end else
  begin
    // Work
  end;
}
end;

procedure TfMain.BitBtn43Click(Sender: TObject);
begin
  // SmartDisk iSCSI Attribute
  fSmartDiskAttribute := TfSmartDiskAttribute.Create(Self);
  try
    fSmartDiskAttribute.Tag := 0; // SmartDisk iSCSI Attribute
    fSmartDiskAttribute.ShowModal;
  finally
    FreeAndNil(fSmartDiskAttribute);
  end;
end;

procedure TfMain.User_RefreshClick(Sender: TObject);
var
  I: Integer;
  List: TStringList;
  Item: TListItem;
begin
  ListView_Users.Items.BeginUpdate();
  List:= TStringList.Create;
  try
    ListView_Users.Items.Clear;
    if GetUserList(List) then
      for I := 0 to List.Count - 1 do
      begin
        Item:= ListView_Users.Items.Add();
        Item.Caption:= List.Names[I];
        Item.Data:= Pointer(List.Objects[I]);
        Item.SubItems.Add(List.ValueFromIndex[I]);
      end;
  finally
    List.Free;  
    ListView_Users.Items.EndUpdate();
  end;
end;

procedure TfMain.Group_RefreshClick(Sender: TObject);
var
  I: Integer;
  List: TStrings;
  Item: TListItem;
begin
  // Refresh Groups

  // Sample
  List:= TStringList.Create;
  ListView_Groups.Items.BeginUpdate;
  try
    ListView_Groups.Clear;
    if GetGroupList(List) then
      for I:= 0 to List.Count-1 do
      begin
        Item:= ListView_Groups.Items.Add();
        Item.Caption:= List.Names[I];
        Item.Data:= Pointer(List.Objects[I]);
        Item.SubItems.Add(List.ValueFromIndex[I]);
      end;
  finally
    ListView_Groups.Items.EndUpdate;
  end;
end;

procedure TfMain.Volume_DeleteClick(Sender: TObject);
var
  dwRet: Longword;
begin
  Volume_Delete.Enabled:= False;
  try
    if ListView_Volume.Selected = nil then
    begin
      Application.MessageBox('Please select a volume first!', nil, MB_OK or MB_ICONWARNING);
      Exit;
    end
    else if (Application.MessageBox('Are you sure to delete this volume?', nil, MB_YESNO or MB_ICONWARNING) = IDNO) then
      Exit;
    dwRet:= uSANDeployServerApi.DeleteTarget(PInt64(ListView_Volume.Selected.Data)^);
    if dwRet <> 0 then
      Application.MessageBox('Deleting volume failed!', nil, MB_OK or MB_ICONWARNING);
  finally
    Volume_Delete.Enabled:= True;
  end;
  Volume_Refresh.Click();
end;

procedure TfMain.Volume_OnlineClick(Sender: TObject);
var
  dwRet: Longword;
begin
  if ListView_Volume.Selected = nil then
  begin
    Application.MessageBox('Please select a volume first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  Volume_Online.Enabled:= False;
  try
    dwRet:= uSANDeployServerApi.SetTargetEnabled(PInt64(ListView_Volume.Selected.Data)^, TRUE);
    if dwRet <> 0 then
      Application.MessageBox('Volume online failed', nil, MB_OK or MB_ICONWARNING);
  finally
    Volume_Online.Enabled:= True;
  end;
  Volume_Refresh.Click();
end;

procedure TfMain.Volume_OfflineClick(Sender: TObject);
var
  dwRet: Longword;
begin
  if ListView_Volume.Selected = nil then
  begin
    Application.MessageBox('Please select a volume first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  dwRet:= uSANDeployServerApi.SetTargetEnabled(PInt64(ListView_Volume.Selected.Data)^, FALSE);
  Volume_Refresh.Click();
end;

procedure TfMain.Target_OnlineClick(Sender: TObject);
var
  kh: KHANDLE;
  dwRet: Longword;
begin
  // online Target
  if (ListView_Target.Selected = nil) or (ListView_Target.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a target first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  kh:= PInt64(ListView_Target.Selected.Data)^;
  dwRet:= uSANDeployServerApi.SetTargetEnabledEx(kh, TRUE);
  if dwRet <> 0 then
    Application.MessageBox('Target online failed!', nil, MB_OK or MB_ICONWARNING);

  Target_Refresh.Click;
end;

procedure TfMain.Target_OfflineClick(Sender: TObject);
var
  kh: KHANDLE;
  dwRet: Longword;
begin
  // online Target
  if (ListView_Target.Selected = nil) or (ListView_Target.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a target first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  kh:= PInt64(ListView_Target.Selected.Data)^;
  dwRet:= uSANDeployServerApi.SetTargetEnabledEx(kh, FALSE);
  if dwRet <> 0 then
    Application.MessageBox('Target offline failed!', nil, MB_OK or MB_ICONWARNING);
  Target_Refresh.Click;
end;

procedure TfMain.Target_DeleteClick(Sender: TObject);
var
  kh: KHANDLE;
  dwRet: Longword;
begin
  // Delete target
  if (ListView_Target.Selected = nil) or (ListView_Target.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a target first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end else if (Application.MessageBox('Are you sure to delete this target?', nil, MB_YESNO or MB_ICONWARNING) = IDNO) then
    Exit;

  kh:= PInt64(ListView_Target.Selected.Data)^;
  dwRet:= uSANDeployServerApi.DeleteTargetEx(kh);
  
  if dwRet <> 0 then
    Application.MessageBox('Deleting target failed!', nil, MB_OK or MB_ICONWARNING);

  Target_Refresh.Click;
end;

procedure TfMain.TargetClient_AddtoWorkstationsClick(Sender: TObject);
var
  hTarget, hClient: Int64;
  cc: TClientConfig;
  Modified: Boolean;
begin
  // Client of Selected Target - Add to Workstations
  if (ListView_Target.Selected = nil) or (ListView_Target.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a target first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  if (ListView_SubTarget.Selected = nil) or (ListView_SubTarget.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a client of the target!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  hTarget:= PInt64(ListView_Target.Selected.Data)^;
  hClient:= PInt64(ListView_SubTarget.Selected.Data)^;
  if uSANDeployServerApi.GetClientConfigEx(hTarget, hClient, cc) <> 0 then
  begin
    Application.MessageBox('Can''t get the config of the client!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  Modified:= False;
   // Client of Selected Target - Refresh
  TargetClient_AddtoWorkstations.Enabled:= False;
  fAddWorkstation := TfAddWorkstation.Create(Self);
  try
    fAddWorkstation.TargetHandle:= hTarget;
    fAddWorkstation.ClientHandle:= hClient;
    fAddWorkstation.ClientConfig:= cc;
    fAddWorkstation.FillConfig;
    fAddWorkstation.ShowModal;
    Modified:= fAddWorkstation.IsAddOrEdit;
  finally
    TargetClient_AddtoWorkstations.Enabled:= True;
    FreeAndNil(fAddWorkstation);
  end;
  if Modified then
    TargetClient_Refresh.Click;
end;

procedure TfMain.TargetClient_RemoveClick(Sender: TObject);
var
  dwRet: Longword;
  hTarget, hClient: Int64;
begin
  if (ListView_SubTarget.Selected = nil) or (ListView_SubTarget.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a workstation first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  hTarget:= PInt64(ListView_Target.Selected.Data)^;
  hClient:= PInt64(ListView_SubTarget.Selected.Data)^;
  dwRet:= uSANDeployServerApi.DeleteStaticClient(hTarget, hClient);
  if dwRet <> 0 then
    Application.MessageBox('Deleting workstation failed!', nil, MB_OK or MB_ICONWARNING);
  TargetClient_Refresh.Click;
end;

procedure TfMain.TargetClient_SetCommitClick(Sender: TObject);
var
  dwRet: Longword;
  hTarget, hClient: Int64;
begin
  if (ListView_SubTarget.Selected = nil) or (ListView_SubTarget.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a workstation first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  hTarget:= PInt64(ListView_Target.Selected.Data)^;
  hClient:= PInt64(ListView_SubTarget.Selected.Data)^;
  dwRet:= uSANDeployServerApi.SetClientCommitEx(hTarget, hClient, True);
  if dwRet <> 0 then
    Application.MessageBox('Committing workstation failed!', nil, MB_OK or MB_ICONWARNING);
  TargetClient_Refresh.Click;
end;

function AccessPermission(bAccess: Byte): string;
begin
  case bAccess of
    DSCSI_CLIENT_ACCESS_ALL: Result:= 'Operator';
  else
    Result:= 'Normal';
  end;
end;

procedure TfMain.TargetClient_RefreshClick(Sender: TObject);
var
  khStartClient, khFindClient, hTarget: KHANDLE;
  cc: TClientConfig;
  dwRet: Longword;
  addr: TInAddr;
  item: TListItem;
  p: PInt64;
begin
  if (ListView_Target.Selected = nil) or (ListView_Target.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a target first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
   // Client of Selected Target - Refresh
  TargetClient_Refresh.Enabled:= False;
  hTarget:= PInt64(ListView_Target.Selected.Data)^;
  khStartClient:= 0;
  ListView_SubTarget.Items.BeginUpdate;
  try
    ClearData(ListView_SubTarget);
    ListView_SubTarget.Clear;
    repeat
      khFindClient:= 0;
      dwRet:= uSANDeployServerApi.FindNextClientEx(hTarget, khStartClient, khFindClient);
      if (dwRet = 0) and (khFindClient <> 0) then
      begin
        if uSANDeployServerApi.GetClientConfigEx(hTarget, khFindClient, cc) = 0 then
        begin
          item:= ListView_SubTarget.Items.Add();
          item.Caption:= StrPas(cc.pcName);
          addr.S_addr:= cc.ClientAddress;
          item.SubItems.Add(StrPas(inet_ntoa(addr)));
          item.SubItems.Add(Format('%.2x-%.2x-%.2x-%.2x-%.2x-%.2x', [cc.MacAddress[0], cc.MacAddress[1],
            cc.MacAddress[2], cc.MacAddress[3], cc.MacAddress[4], cc.MacAddress[5]]));
          item.SubItems.Add(Format('%.2f', [cc.DataIn.QuadPart/(1024*1024)]));
          item.SubItems.Add(Format('%.2f', [cc.DataOut.QuadPart/(1024*1024)]));
          item.SubItems.Add(StrPas(@cc.ChapName[0]));
          item.SubItems.Add(StrPas(@cc.InitiatorName[0]));
          item.SubItems.Add(AccessPermission(cc.bAccess));
          New(p);
          p^:= khFindClient;
          item.Data:= p;
        end
        else
          Break;
        khStartClient:= khFindClient;
      end;
    until (dwRet <> 0) or (khFindClient = 0);
  finally
    ListView_SubTarget.Items.EndUpdate;
    TargetClient_Refresh.Enabled:= True;
  end;
end;

procedure TfMain.BootServer_RefreshClick(Sender: TObject);
var
  khStartClient, khFindClient, hTarget: KHANDLE;
  dwRet0, dwRet1: Longword;
  addr: TInAddr;
  cc: TClientConfig;
  item: TListItem;
  p: PInt64;
begin
  // Refresh bootserver
  BootServer_Refresh.Enabled:= False;
  hTarget:= PInt64(ListView_Target.Selected.Data)^;
  khStartClient:= 0;
  khFindClient:= 0;
  ListView_BootServer.Items.BeginUpdate;
  try
    ClearData(ListView_BootServer);
    ListView_BootServer.Clear;
    repeat
      khFindClient:= 0;
      dwRet0:= uSANDeployServerApi.FindNextStaticClient(0, khStartClient, khFindClient);
      if (dwRet0 = 0) and (khFindClient <> 0) then
      begin
        dwRet1:= uSANDeployServerApi.GetStaticClientConfig(0, khFindClient, cc);
        if dwRet1 = 0 then
        begin
          item:= ListView_BootServer.Items.Add();
          item.Caption:= StrPas(cc.pcName);
          addr.S_addr:= cc.ClientAddress;
          item.SubItems.Add(StrPas(inet_ntoa(addr)));
          addr.S_addr:= cc.IPMask;
          item.SubItems.Add(StrPas(inet_ntoa(addr)));
          item.SubItems.Add(Format('%.2x-%.2x-%.2x-%.2x-%.2x-%.2x', [cc.MacAddress[0], cc.MacAddress[1],
            cc.MacAddress[2], cc.MacAddress[3], cc.MacAddress[4], cc.MacAddress[5]]));
          item.SubItems.Add(AccessPermission(cc.bAccess));
          item.SubItems.Add(StrPas(@cc.TargetName[0]));
          New(p);
          p^:= khFindClient;
          item.Data:= p;
        end
        else
          Break;
        khStartClient:= khFindClient;
      end;
    until (dwRet0 <> 0) or (khFindClient = 0) ;
  finally
    ListView_BootServer.Items.EndUpdate;
    BootServer_Refresh.Enabled:= True;
  end;
end;

procedure TfMain.BootServer_WakeupAllClick(Sender: TObject);
var
  khStartClient, khFindClient: KHANDLE;
  cc: TClientConfig;
  dwRet0, dwRet1: Longword;
begin
  khStartClient:= 0;
  khFindClient:= 0;
  repeat
    dwRet0:= uSANDeployServerApi.FindNextStaticClient(0, khStartClient, khFindClient);
    if (dwRet0 = 0) and (khFindClient <> 0) then
    begin
      dwRet1:= uSANDeployServerApi.GetStaticClientConfig(0, khFindClient, cc);
      if dwRet1 = 0 then
        uSANDeployServerApi.WakeUp(@cc.MacAddress[0])
      else
        Break;
      khStartClient:= khFindClient;
    end;
  until (dwRet0 <> 0) or (khFindClient = 0);
end;

function TfMain.GetGroupList(List: TStrings): Boolean;
var
  I, dwGroupCount, dwUserCount, dwRet: Longword;
  arrGroups: array[0..127] of Longword;
  arrUsers: array[0..4095] of Longword;
  pGroupName: PAnsiChar;
  strGroupName: string;
begin
  Result:= False;
  if List = nil then
    Exit;
  dwGroupCount:= SizeOf(arrGroups);
  dwRet:= uSANDeployServerApi.GetGroups(nil, @arrGroups[0], @dwGroupCount);
  if (dwRet = 0) then
  begin
    Result:= True;
    dwGroupCount:= dwGroupCount div SizeOf(Longword);
    if dwGroupCount = 0 then
      Exit;
    GetMem(pGroupName, 256);
    for I := 0 to dwGroupCount - 1 do
    begin
      FillChar(pGroupName^, 256, 0);
      dwRet:= uSANDeployServerApi.GetGroupName(arrGroups[I], pGroupName, 255);
      if dwRet = 0 then
      begin
//        strGroupName:= ;
        dwUserCount:= SizeOf(arrUsers);
        uSANDeployServerApi.GetUsers(pGroupName, @arrUsers, @dwUserCount);
        dwUserCount:= dwUserCount div SizeOf(Longword);
        strGroupName:= Format('%s=%d', [StrPas(pGroupName), dwUserCount]);
        List.AddObject(strGroupName, TObject(arrGroups[I]));
      end
      else
      begin
        Result:= False;
        Break;
      end;
    end;
    FreeMem(pGroupName);
  end;
end;

procedure TfMain.ClearData(ListView: TListView);
var
  I: Integer;
  P: PInt64;
begin
  if ListView = nil then
    Exit;
  for I:= 0 to ListView.Items.Count-1 do
  begin
    P:= ListView.Items[I].Data;
    if P <> nil then
    begin
      Dispose(P);
      ListView.Items[I].Data:= nil;
    end;
  end;
end;


procedure TfMain.ListView_VolumeDblClick(Sender: TObject);
begin
  Volume_Attribute.Click;
end;

end.
