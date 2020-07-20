unit uSANDeployServerApi;

interface

uses
  Windows;

const
  MAX_TARGET_NAME_LEN = 256;
  PASSWORD_LENGTH = 24;
  MAX_PORTAL_ADDRESS = 16;
  MAX_SNAPSHOT_NAME_LEN = 32;
  MAX_SNAPSHOT_DESP_LEN = 1024;

  MAX_PASSWORD_LEN = 256;
  MAX_NAME_LEN = 256;

  ISCSI_CLIENT_FLAG_SAVE_DATA      = 1;
  ISCSI_PXE_FLAG_AUTO_LOADBANLANCE = 2;

  ISCSI_CREATE_FLAG_IMG_ENCRYPTED = $00000002;
  ISCSI_CREATE_FLAG_IMG_COMPRESSED = $00000004;
  ISCSI_CREATE_FLAG_IMG_FILLZERO = $00000008;

  ISCSI_AUTH_MODE_ANONYMOUS = 0; {//anonymous full access}
  ISCSI_AUTH_MODE_CHAP = 1; {//CHAP}
  ISCSI_AUTH_MODE_IPFILTER = 2; {//IP FILTERS}
  ISCSI_AUTH_MODE_BOTH = 3; {//ISCSI_AUTH_MODE_CHAP|ISCSI_AUTH_MODE_IPFILTER}
  ISCSI_AUTH_MODE_OR = 4; {//ISCSI_AUTH_MODE_CHAP OR ISCSI_AUTH_MODE_IPFILTER}

  DSCSI_CLIENT_ACCESS_ALL = 0;
  DSCSI_CLIENT_ACCESS_VIRTUAL_WRITE = 1;
  DSCSI_CLIENT_ACCESS_READ_ONLY = 2;
  DSCSI_CLIENT_ACCESS_REFUSE = 3;

  ISCSI_APPLICATION_TYPE_MIRROR = 0;
  ISCSI_APPLICATION_TYPE_CLUSTER = 1;
  ISCSI_APPLICATION_TYPE_VIRTUAL_WRITE = 2;

  TARGET_PORTAL_DYNAMIC  = 0;
  TARGET_PORTAL_STATIC	 = 1;
  TARGET_PORTAL_DISABLED = 2;

type
  KHANDLE = Int64;

  TClientConfig = record
    ID: Longword;
    ClientAddress: Longword;
    IPMask: Longword;
    BootServer: Longword;
    bAccess: UCHAR;
    bStatus: UCHAR;
    bHasName: UCHAR;
    Reserved: UCHAR;
    SeatNO: Longword;
    Flags: Longword;
    socket: Integer;
    Quota: Longword;
    DataIn: ULARGE_INTEGER;
    DataOut: ULARGE_INTEGER;
    ReadSpeed: Longword;
    WriteSpeed: Longword;
    ConnectTime: ULARGE_INTEGER;
    MacAddress: array[0..8-1] of Byte;
    pcName: array[0..128-1] of AnsiChar;
    InitiatorName: array[0..256-1] of AnsiChar;
    ChapName: array[0..256-1] of AnsiChar;
    TargetName: array[0..256-1] of AnsiChar;
    PxeName: array[0..128-1] of AnsiChar;
  end {_CLIENTCONFIG};
  
  ISCSI_TARGET_MEDIA_TYPES = (
    ISCSI_TARGET_MEDIA_TYPE_MEMORY = $00010000,
		ISCSI_TARGET_MEDIA_TYPE_FILE_IAMGE = $00010001,
		ISCSI_TARGET_MEDIA_TYPE_FILE_INDIVIDUAL_IAMGE = $00010002,
		ISCSI_TARGET_MEDIA_TYPE_DRIVE_PARTITION = $00010003,
		ISCSI_TARGET_MEDIA_TYPE_DISK = $00010004,
		ISCSI_TARGET_MEDIA_TYPE_CDROM = $00010005,
		ISCSI_TARGET_MEDIA_TYPE_SCSI = $00010006,
		ISCSI_TARGET_MEDIA_TYPE_MIRROR = $00010007,
		ISCSI_TARGET_MEDIA_TYPE_VHD = $00010008,
		ISCSI_TARGET_MEDIA_TYPE_VMDK = $00010009,
		ISCSI_TARGET_MEDIA_TYPE_TAPE = $0001000A
  );

  ISCSI_TARGET_DEVICE_TYPES = (
		ISCSI_TARGET_TYPE_DISK = 0,
		ISCSI_TARGET_TYPE_TAPE = 1,
		ISCSI_TARGET_TYPE_CDROM = 5,
		ISCSI_TARGET_TYPE_SCSI	= $FF
  );

  STORAGE_BUS_TYPE = (
    BusTypeUnknown      = $00,
    BusTypeScsi         = $01,
    BusTypeAtapi        = $02,
    BusTypeAta          = $03,
    BusType1394         = $04,
    BusTypeSsa          = $05,
    BusTypeFibre        = $06,
    BusTypeUsb          = $07,
    BusTypeRAID         = $08,
    BusTypeiSCSI        = $09,
    BusTypeSas          = $0A,
    BusTypeSata         = $0B,
    BusTypeMaxReserved  = $7F
  );
    
  ISCSI_TARGET_PORTAL = record
    ulNatAddress: Longword;
    ulType: Longword;
    ulNatPort: Word;
    ulGateway: Longword;
    ulMask: Longword;
    ulDns: Longword;
  end {_ISCSI_TARGET_PORTAL};

  ISCSI_CACHE = record
    EnableCache: Bool;
    Granularity: Longword;
    RefreshTime: Longword;
    Flags: Longword;
    CacheSize: LARGE_INTEGER;
  end {_ISCSI_CACHE};

{///ensure 8 bytes align }
  ISCSI_TARGET_FILE_SYSTEM = (
    ISCSI_TARGET_FS_UNKNOW,
    ISCSI_TARGET_FS_FAT,
    ISCSI_TARGET_FS_FAT32  );
    
  TImageFile = record
    FileSystem: ISCSI_TARGET_FILE_SYSTEM;
    CreateNew: Bool;
    UseSparse: Bool;
    CreateFlags: LongInt;
    Password: array[0..32-1] of Byte;
  end;

  TIndividualImage = record
    FileSystem: ISCSI_TARGET_FILE_SYSTEM;
    Encrypted: Bool;
    UseSparse: Bool;
  end {IndividualImage};

  TPartitionToDisk = record
    MakeBootRecordFlags: LongInt;
    ExclusiveAccess: Bool;
  end {PartitionToDisk};

  TPhysicalDisk = record
    Reserved: LongInt;
    ExclusiveAccess: Bool;
  end {PhysicalDisk};

  TMemorySpace = record
    bLoadAndSave: Bool;
    bCreateNew: Bool;
  end {MemorySpace};
  
  TTargetParams = record
    case integer of
      0:(ImageFile: TImageFile);
      1:(IndividualImage: TIndividualImage);
      2:(PartitionToDisk: TPartitionToDisk);
      3:(PhysicalDisk: TPhysicalDisk);
      4:(MemorySpace: TMemorySpace);
  end;

  TVirtualWrite = record
      VirtualWriteMode: LongInt;
      VirtualWriteDeleteTime: LongInt;
      VirtualWriteQuota: LARGE_INTEGER;
      VirtualWriteQuota2: LARGE_INTEGER;
      VirtualWritePath: array[0..MAX_PATH-1] of AnsiChar;
      VirtualWritePath2: array[0..MAX_PATH-1] of AnsiChar;
  end;

  TSSDCache = record
    EnableCache: Bool;
    CacheSize: LARGE_INTEGER;
    CachePath: array[0..MAX_PATH-1] of AnsiChar;
  end;
  
  PIScsiTarget = ^TIScsiTarget;
  TIScsiTarget = record
    TargetName: array[0..MAX_TARGET_NAME_LEN-1] of AnsiChar;
    ID: Longword;
    bEnable: Bool;
    Password: array[0..PASSWORD_LENGTH-1] of Byte;
    ManagePassword: array[0..PASSWORD_LENGTH-1] of Byte;
    iScsiTargetMediaType: ISCSI_TARGET_MEDIA_TYPES;
    iScsiTargetDeviceType: ISCSI_TARGET_DEVICE_TYPES;
    ulAuthMode: Longword;
    bLockVolume: Bool;
    bMultipleInitiator: Bool;
    bReportReadonly: Bool;
    HardSerial: array[0..8-1] of Byte;
    DeviceSize: LARGE_INTEGER;
    StartOffset: LARGE_INTEGER;
    InheritAuthorization: Bool;
    InheritTargetPortal: Bool;
    Portal: array[0..MAX_PORTAL_ADDRESS-1] of ISCSI_TARGET_PORTAL;
    FileName: array[0..MAX_PATH-1] of AnsiChar;
    Cache: ISCSI_CACHE;
    SSDcache: TSSDCache;
    VirtualWrite: TVirtualWrite;
    Params: TTargetParams;
  end {_ISCSI_TARGET};

  TIScsiTargetEx = record
    ID: Longword;
    TargetName: array[0..MAX_TARGET_NAME_LEN-1] of AnsiChar;
    Enabled: Bool;
    bMultipleInitiator: Bool;
    VolumeNames: array[0..16-1] of array[0..256-1] of AnsiChar;
    Groups: array[0..16-1] of array[0..256-1] of AnsiChar;
    Volumes: array[0..16-1] of PIScsiTarget;
    Reserved1 : Longword;
    Reserved2: array[0..16-1] of Longword;
    LunCount: Longword;
    ulAuthMode: Longword;
    InheritAuthorization: Bool;
    InheritTargetPortal: Bool;
    Portal: array[0..MAX_PORTAL_ADDRESS-1] of ISCSI_TARGET_PORTAL;
    VirtualWriteMode: Longword;
    VirtualWriteQuota: Longword;
    VirtualWritePath: array[0..MAX_PATH-1] of AnsiChar;
    Reserved3: Longword;
  end {TIScsiTargetEx};
  PIScsiTargetEx = ^TIScsiTargetEx;
  
  PSnapshotInfo = ^TSnapshotInfo;
  TSnapshotInfo = record
    Handle: KHANDLE;
    Name: array[0..MAX_SNAPSHOT_NAME_LEN-1] of AnsiChar;
    Desp: array[0..MAX_SNAPSHOT_DESP_LEN-1] of AnsiChar;
  end {_SNAPSHOT_INFO};

  PSPTI_SCSI_DEVICE_DESP = ^SPTI_SCSI_DEVICE_DESP;
  SPTI_SCSI_DEVICE_DESP = record
    BusType: STORAGE_BUS_TYPE;
    DeviceType: Integer;
    DeviceName: array[0..MAX_PATH-1] of AnsiChar;
    Vendor: array[0..128-1] of AnsiChar;
    Description: array[0..128-1] of AnsiChar;
  end {_SPTI_SCSI_DEVICE_DESP};

type
  BOOT_MODE = (
    PXE_BOOT_MODE_ANONYMOUS_EXT_DHCP,
    PXE_BOOT_MODE_AUTO_ADD_EXT_DHCP,
    PXE_BOOT_MODE_AUTO_ADD_INT_DHCP, 
    PXE_BOOT_MODE_MANUAL_INT_DHCP  );

type
  ISCSI_PXE_NET_CONFIG = record
    StartIP: Longword;
    EndIP: Longword;
    Mask: Longword;
    Gateway: Longword;
    Dns: Longword;
  end {_ISCSI_PXE_NET_CONFIG};
  PISCSI_PXE_NET_CONFIG = ^ISCSI_PXE_NET_CONFIG;

type
  ISCSI_PXE_CONFIG = record
    Start: Bool;
    BootMode: Longword;
    HostPerfix: array[0..128-1] of AnsiChar;
    HostIDLen: Longword;
    ActiceNetConfig: Longword;
    Flags: Longword;
    NetConfig: array[0..MAX_PORTAL_ADDRESS-1] of ISCSI_PXE_NET_CONFIG;
    DefaultIQN: array[0..256-1] of AnsiChar;
  end {_ISCSI_PXE_CONFIG};
  PISCSI_PXE_CONFIG = ^ISCSI_PXE_CONFIG;

type
  REMOTE_CONTROL = record
    IPAddress: Longword;
    Port: Word;
    UserName: array[0..MAX_PASSWORD_LEN-1] of AnsiChar;
    Password: array[0..MAX_NAME_LEN-1] of AnsiChar;
  end;
  PREMOTE_CONTROL = ^REMOTE_CONTROL;

type
  TServerConfigParams = record
    case Integer of
      0:(Pxe: ISCSI_PXE_CONFIG);
  end;

  ISCSI_SERVER_CONFIG = record
    ulAddress: Longword;
    usPort: Word;
    ControlPassword: array[0..PASSWORD_LENGTH-1] of Byte;
    bStarted: LongInt;
    Params: TServerConfigParams;
    RemoteControl: REMOTE_CONTROL;
    Portal: array[0..MAX_PORTAL_ADDRESS-1] of ISCSI_TARGET_PORTAL;
  end {_ISCSI_SERVER_CONFIG};

  ISCSI_SERVER = record
    Id: Longword;
    ServerName: array[0..255] of AnsiChar;
    UserName: array[0..255] of AnsiChar;
    Password: array[0..255] of AnsiChar;
    Port: Word;
  end;

  {
  ISCSI_APPLICATION_TYPE = (
    ISCSI_APPLICATION_TYPE_MIRROR,
    ISCSI_APPLICATION_TYPE_CLUSTER,
    ISCSI_APPLICATION_TYPE_VIRTUAL_WRITE
    );
  }

	ISCSI_APPLICATION_STATUS = (
		ISCSI_APPLICATION_STATUS_FAIL,
		ISCSI_APPLICATION_STATUS_PENDING,
		ISCSI_APPLICATION_STATUS_WORKING,
		ISCSI_APPLICATION_STATUS_FAILOVERING
    );

  TFileMirror = record
    FileName: array[0..MAX_PATH-1] of AnsiChar;
  end;

  TSCSI0 = record
    Host: Longword;
    Port: Longword;
    TargetName: array[0..MAX_TARGET_NAME_LEN-1] of AnsiChar;
    IsChap: BOOL;
    UserName: array[0..255] of AnsiChar;
    Password: array[0..255] of AnsiChar;
  end;

  TMirrorDrive = record
    DeviceSize: LARGE_INTEGER;
    Reserved: Longword;
    CreateNew: Boolean;
    m_bISCSI: BOOL;
    case Integer of
      0: (FileMirror: TFileMirror);
      1: (iSCSI: TSCSI0);
  end;

  TSCSI1 = record
    Host: Longword;
    Port: Longword;
    TargetName: array[0..MAX_TARGET_NAME_LEN-1] of AnsiChar;
    IsChap: BOOL;
    UserName: array[0..255] of AnsiChar;
    Password: array[0..255] of AnsiChar;
    LocalPortal: Longword;
    LocalPort: Longword;
  end;

  TFailOver = record
    DeviceSize: LARGE_INTEGER;
    Reserved: Longword;
    CreateNew: Boolean;
    iSCSI: TSCSI1;
    WorkPath: array[0..MAX_PATH-1] of AnsiChar;
  end;

  TAppParams = record
    case Integer of
    0: (MirrorDrive: TMirrorDrive);
    1: (FailOver: TFailOver);
  end;
  
  ISCSI_APPLICATION = record
    Id: Longword;
    AppType: Longword;//ISCSI_APPLICATION_TYPE;
    TargetName: array[0..MAX_PATH-1] of AnsiChar;
    Params: TAppParams;
    Status: Longword;
  end;

function ConnectTo(HostName: PAnsiChar; Port: Word;
  UserName, Password: PAnsiChar; bWait: BOOL = TRUE): Longword; stdcall;

function GetIP(): Longword; stdcall;

function GetPort(): Word; stdcall;

function AddEditUser(Id: Longword; UserName, Password: PAnsiChar; bMutual: BOOL;
  MutualPassword: PAnsiChar; AccessMode: Longword): Longword; stdcall;

function DeleteUser(Id: Longword): Longword; stdcall;

function GetGroups(UserName: PAnsiChar; Buffer, BufferLength: PLongword): Longword; stdcall;
function GetGroupName(Id: Longword; Name: PAnsiChar; Namelength: Longword): Longword; stdcall;

function GetUsers(GroupName: PAnsiChar; Buffer, BufferLength: PLongword): Longword; stdcall;

function GetUserNameFromID(Id: Longword; UserName: PAnsiChar;
  NameBufferLength: Longword; Mutual: PLongword = nil): Longword; stdcall;

function DeleteGroup(Id: Longword): Longword; stdcall;

function AddEditGroup(Id: Longword; GroupName: PAnsiChar; Access: Longword): Longword; stdcall;

function LinkUserGroup(UserName, GroupName: PAnsiChar): Longword; stdcall;

function UnlinkUserGroup(UserName, GroupName: PAnsiChar): Longword; stdcall;

function AddStaticClient(hTarget: KHANDLE; var ClientConfig: TClientConfig): Longword; stdcall;

function DeleteStaticClient(hTarget, hClient: KHANDLE): Longword; stdcall;

function SetStaticClientConfig(hTarget, hClient: KHANDLE; var ClientConfig: TClientConfig): Longword; stdcall;

function DeleteClientEx(hTarget, hClient: KHANDLE): Longword; stdcall;

function FindNextClientEx(hTarget, hStartClient: KHANDLE; var FindClient: KHANDLE): Longword; stdcall;

function GetClientConfigEx(hTarget, hClient: KHANDLE; var ClientConfig: TClientConfig): Longword; stdcall;

function SetClientCommitEx(hTarget, hClient: KHANDLE; bCommit: BOOL): Longword; stdcall;

function AddTarget(var hTarget: KHANDLE; var TargetConfig: TIScsiTarget): Longword; stdcall;

function AddTargetEx(var hTarget: KHANDLE; var TargetConfig: TIScsiTargetEx): Longword; stdcall;

function DeleteTarget(hTarget: KHANDLE): Longword stdcall;

function DeleteTargetEx(hTargetEx: KHANDLE): Longword stdcall;

function FindNextStaticClient(hTarget, hStartClient: KHANDLE; var FindClient: KHANDLE): Longword stdcall;

function FindNextTarget(StartTarget: KHANDLE; var FindTarget: KHANDLE): Longword stdcall;

function FindNextTargetEx(StartTarget: KHANDLE; var FindTarget: KHANDLE): Longword stdcall;

function GetStaticClientConfig(hTarget, hClient: KHANDLE; var ClientConfig: TClientConfig): Longword stdcall;

function GetTargetConfig(hTarget: KHANDLE; var TargetConfig: TIScsiTarget): Longword stdcall;

function GetTargetConfigEx(hTarget: KHANDLE; var TargetConfig: TIScsiTargetEx): Longword stdcall;

function SetTargetConfig(hTarget: KHANDLE; var TargetConfig: TIScsiTarget): Longword stdcall;

function SetTargetConfigEx(hTarget: KHANDLE; var TargetConfig: TIScsiTargetEx): Longword stdcall;

function SetTargetEnabled(hTarget: KHANDLE; bEnable: Bool): Longword stdcall;

function SetTargetEnabledEx(hTarget: KHANDLE; bEnable: Bool): Longword stdcall;

function CreateSnapshot(hTarget, hParent: KHANDLE; SnapshotName, SnapshotDesp: PAnsiChar; bGoto: Bool): Longword stdcall;

function GetSnapshot(hTarget, hSnapshot: KHANDLE; var SnapshotInfo: TSnapshotInfo): Longword stdcall;

function SetSnapshotInfo(hTarget, hSnapshot: KHANDLE; var SnapshotInfo: TSnapshotInfo): Longword stdcall;

function GetSnapshotCount(hTarget: KHANDLE; var dwCount: Longword): Longword; stdcall;

function GetSnapshots(hTarget, hParentSnap: KHANDLE; pSnapshots: PSnapshotInfo; var cbSize: Longword): Longword stdcall;

function GetCurrentSnapshot(hTarget: KHANDLE; var hSnapshot: KHANDLE): Longword stdcall;

function SetCurrentSnapshot(hTarget, hSnapshot: KHANDLE): Longword stdcall;

function CommitSnapshot(hTarget, hSnapshot: KHANDLE): Longword stdcall;

function RevertToSnapshot(hTarget: KHANDLE): Longword stdcall;

function DeleteSnapshot(hTarget, hSnapshot: KHANDLE): Longword stdcall;

function SnapshotCanBeDeleted(hTarget, hSnapshot: KHANDLE; var bCan: Bool): Longword stdcall;

function GetScsiDevices(var dwBufSize: Longword; var DeviceDesp: SPTI_SCSI_DEVICE_DESP): Longword; stdcall;

function GetDiskSize(DrivePath: PAnsiChar; pSize: PLargeInteger): Longword; stdcall;

function GetVolumeSize(DrivePath: PAnsiChar; pSize: PLargeInteger): Longword; stdcall;

function GetServerConfig(var ServiceConfig: ISCSI_SERVER_CONFIG): Longword; stdcall;

function SetServerConfig(var ServiceConfig: ISCSI_SERVER_CONFIG): Longword; stdcall;

function CreateApplication(var hApp: KHANDLE; TargetName: PAnsiChar;
  var Application: ISCSI_APPLICATION): Longword; stdcall;

function DeleteApplication(hTarget, hApplication: KHANDLE): Longword; stdcall;

function FindNextApplication(hTarget, hFirst: KHANDLE;
  var hNext: KHANDLE): Longword; stdcall;

function GetApplicationConfig(hTarget, hApp: KHANDLE;
  var pAppConfig: ISCSI_APPLICATION): Longword; stdcall;

function SetApplicationConfig(hTarget, hApp: KHANDLE;
  var pAppConfig: ISCSI_APPLICATION): Longword; stdcall;

function StartApplicationVerify(hTarget, hApp: KHANDLE): Longword; stdcall;

function StartApplicationSync(hTarget, hApp: KHANDLE; FullSync: Bool; Offset, Length: LARGE_INTEGER): Longword; stdcall;

function GetApplicationSyncProgress(hTarget, hApp: KHANDLE; var Progress: LongWord): Longword; stdcall;

function GetApplicationSyncResult(hTarget, hApp: KHANDLE; var Result: LongWord): Longword; stdcall;

function AddSubServer(var Server: ISCSI_SERVER): Longword; stdcall;

function DeleteSubServer(hServer: KHANDLE): Longword; stdcall;

function FindFirstSubServer(var hFind: KHANDLE): Longword; stdcall;

function FindNextSubServer(hFirst: KHANDLE; var hFind: KHANDLE): Longword; stdcall;

function GetSubServerConfig(hServer: KHANDLE; var Server: ISCSI_SERVER): Longword; stdcall;

function GetSubServerState(hServer: KHANDLE; var State: LongBool): Longword; stdcall;

function WakeUp(pMac: PByte; bInitWSA: BOOL = FALSE): Longword; stdcall;

implementation

function ConnectTo(HostName: PAnsiChar; Port: Word;
  UserName, Password: PAnsiChar; bWait: BOOL = TRUE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'ConnectTo';

function GetIP(): Longword; stdcall; external 'SANDeployServerApi.dll' name 'GetIP';

function GetPort(): Word; stdcall; external 'SANDeployServerApi.dll' name 'GetPort';

function AddEditUser(Id: Longword; UserName, Password: PAnsiChar; bMutual: BOOL;
  MutualPassword: PAnsiChar; AccessMode: Longword): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'AddEditUser';

function AddStaticClient(hTarget: KHANDLE; var ClientConfig: TClientConfig): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'AddStaticClient';

function DeleteStaticClient(hTarget, hClient: KHANDLE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'DeleteStaticClient';

function SetStaticClientConfig(hTarget, hClient: KHANDLE; var ClientConfig: TClientConfig): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'SetStaticClientConfig';

function DeleteClientEx(hTarget, hClient: KHANDLE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'DeleteClientEx';

function FindNextClientEx(hTarget, hStartClient: KHANDLE; var FindClient: KHANDLE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'FindNextClientEx';

function GetClientConfigEx(hTarget, hClient: KHANDLE; var ClientConfig: TClientConfig): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetClientConfigEx';

function SetClientCommitEx(hTarget, hClient: KHANDLE; bCommit: BOOL): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'SetClientCommitEx';

function DeleteUser(Id: Longword): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'DeleteUser';

function GetGroups(UserName: PAnsiChar; Buffer, BufferLength: PLongword): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetGroups';

function GetGroupName(Id: Longword; Name: PAnsiChar; Namelength: Longword): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetGroupName';

function GetUsers(GroupName: PAnsiChar; Buffer, BufferLength: PLongword): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetUsers';

function GetUserNameFromID(Id: Longword; UserName: PAnsiChar;
  NameBufferLength: Longword; Mutual: PLongword): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetUserNameFromID';

function DeleteGroup(Id: Longword): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'DeleteGroup';

function AddEditGroup(Id: Longword; GroupName: PAnsiChar; Access: Longword): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'AddEditGroup';

function LinkUserGroup(UserName, GroupName: PAnsiChar): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'LinkUserGroup';

function UnlinkUserGroup(UserName, GroupName: PAnsiChar): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'UnlinkUserGroup';

function AddTarget(var hTarget: KHANDLE; var TargetConfig: TIScsiTarget): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'AddTarget';

function AddTargetEx(var hTarget: KHANDLE; var TargetConfig: TIScsiTargetEx): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'AddTargetEx';

function DeleteTarget(hTarget: KHANDLE): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'DeleteTarget';

function DeleteTargetEx(hTargetEx: KHANDLE): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'DeleteTargetEx';

function FindNextStaticClient(hTarget, hStartClient: KHANDLE; var FindClient: KHANDLE): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'FindNextStaticClient';
  
function FindNextTarget(StartTarget: KHANDLE; var FindTarget: KHANDLE): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'FindNextTarget';

function FindNextTargetEx(StartTarget: KHANDLE; var FindTarget: KHANDLE): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'FindNextTargetEx';

function GetTargetConfigEx(hTarget: KHANDLE; var TargetConfig: TIScsiTargetEx): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'GetTargetConfigEx';

function SetTargetConfig(hTarget: KHANDLE; var TargetConfig: TIScsiTarget): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'SetTargetConfig';

function SetTargetConfigEx(hTarget: KHANDLE; var TargetConfig: TIScsiTargetEx): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'SetTargetConfigEx';

function GetStaticClientConfig(hTarget, hClient: KHANDLE; var ClientConfig: TClientConfig): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'GetStaticClientConfig';

function GetTargetConfig(hTarget: KHANDLE; var TargetConfig: TIScsiTarget): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'GetTargetConfig';

function SetTargetEnabled(hTarget: KHANDLE; bEnable: Bool): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'SetTargetEnabled';

function SetTargetEnabledEx(hTarget: KHANDLE; bEnable: Bool): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'SetTargetEnabledEx';

function CreateSnapshot(hTarget, hParent: KHANDLE; SnapshotName, SnapshotDesp: PAnsiChar; bGoto: Bool): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'CreateSnapshot';

function GetSnapshot(hTarget, hSnapshot: KHANDLE; var SnapshotInfo: TSnapshotInfo): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'GetSnapshot';

function SetSnapshotInfo(hTarget, hSnapshot: KHANDLE; var SnapshotInfo: TSnapshotInfo): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'SetSnapshotInfo';

function GetSnapshotCount(hTarget: KHANDLE; var dwCount: Longword): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetSnapshotCount';

function GetSnapshots(hTarget, hParentSnap: KHANDLE; pSnapshots: PSnapshotInfo; var cbSize: Longword): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'GetSnapshots';

function GetCurrentSnapshot(hTarget: KHANDLE; var hSnapshot: KHANDLE): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'GetCurrentSnapshot';

function SetCurrentSnapshot(hTarget, hSnapshot: KHANDLE): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'SetCurrentSnapshot';

function CommitSnapshot(hTarget, hSnapshot: KHANDLE): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'CommitSnapshot';

function RevertToSnapshot(hTarget: KHANDLE): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'RevertToSnapshot';

function DeleteSnapshot(hTarget, hSnapshot: KHANDLE): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'DeleteSnapshot';

function SnapshotCanBeDeleted(hTarget, hSnapshot: KHANDLE; var bCan: Bool): Longword stdcall;
  external 'SANDeployServerApi.dll' name 'SnapshotCanBeDeleted';

function GetScsiDevices(var dwBufSize: Longword; var DeviceDesp: SPTI_SCSI_DEVICE_DESP): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetScsiDevices';

function GetDiskSize(DrivePath: PAnsiChar; pSize: PLargeInteger): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetDiskSize';

function GetVolumeSize(DrivePath: PAnsiChar; pSize: PLargeInteger): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetVolumeSize';

function GetServerConfig(var ServiceConfig: ISCSI_SERVER_CONFIG): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetServerConfig';

function SetServerConfig(var ServiceConfig: ISCSI_SERVER_CONFIG): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'SetServerConfig';

function CreateApplication(var hApp: KHANDLE; TargetName: PAnsiChar;
  var Application: ISCSI_APPLICATION): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'CreateApplication';

function DeleteApplication(hTarget, hApplication: KHANDLE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'DeleteApplication';

function FindNextApplication(hTarget, hFirst: KHANDLE;
  var hNext: KHANDLE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'FindNextApplication';

function GetApplicationConfig(hTarget, hApp: KHANDLE;
  var pAppConfig: ISCSI_APPLICATION): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetApplicationConfig';

function SetApplicationConfig(hTarget, hApp: KHANDLE;
  var pAppConfig: ISCSI_APPLICATION): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'SetApplicationConfig';

function StartApplicationVerify(hTarget, hApp: KHANDLE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'StartApplicationVerify';

function StartApplicationSync(hTarget, hApp: KHANDLE; FullSync: Bool; Offset, Length: LARGE_INTEGER): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'StartApplicationSync';

  function GetApplicationSyncProgress(hTarget, hApp: KHANDLE; var Progress: LongWord): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetApplicationSyncProgress';

  function GetApplicationSyncResult(hTarget, hApp: KHANDLE; var Result: LongWord): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetApplicationSyncResult';

function AddSubServer(var Server: ISCSI_SERVER): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'AddSubServer';

function DeleteSubServer(hServer: KHANDLE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'DeleteSubServer';

function FindFirstSubServer(var hFind: KHANDLE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'FindFirstSubServer';

function FindNextSubServer(hFirst: KHANDLE; var hFind: KHANDLE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'FindNextSubServer';

function GetSubServerConfig(hServer: KHANDLE; var Server: ISCSI_SERVER): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetSubServerConfig';

function GetSubServerState(hServer: KHANDLE; var State: LongBool): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'GetSubServerState';

function WakeUp(pMac: PByte; bInitWSA: BOOL = FALSE): Longword; stdcall;
  external 'SANDeployServerApi.dll' name 'WakeUp';


end.
