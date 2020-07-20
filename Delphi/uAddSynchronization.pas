unit uAddSynchronization;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uSANDeployServerApi;

type
  TfAddSynchronization = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edLocalPort: TEdit;
    cmbLocalTarget: TComboBox;
    cmbLocalPortal: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edRemotePort: TEdit;
    cmbSubServer: TComboBox;
    cmbRemotePortal: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    cmbRemoteTarget: TComboBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    bOK: TBitBtn;
    bCancel: TBitBtn;
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbLocalTargetChange(Sender: TObject);
    procedure cmbSubServerChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbRemoteTargetChange(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);
    procedure cmbLocalPortalChange(Sender: TObject);
    procedure cmbRemotePortalChange(Sender: TObject);
  private
    FIsTryConntectRemoteServer: Boolean;
    FIsOk: Boolean;
    FSubServer: ISCSI_SERVER;
    FLocalIP: Longword;
    FRemoteIP: Longword;
    FRemoteTargetName: string;
    FLocalTargetName: string;
    FLocalServerConfig: ISCSI_SERVER_CONFIG;
    FSubServerConfig: ISCSI_SERVER_CONFIG;
    FLocalPort: Word;
    FRemotePort: Word;
    FLocalTargetHandle: Int64;
    FRemoteTargetHandle: Int64;
    { Private declarations }
    procedure GetTargets(Strings: TStrings);
    procedure GetSubServers(Strings: TStrings);
    procedure GetPortal(const ServerConfig: ISCSI_SERVER_CONFIG; Strings: TStrings);
  public
    { Public declarations }
    property LocalTargetName: string read FLocalTargetName;
    property RemoteTargetName: string read FRemoteTargetName;
    property IsOk: Boolean read FIsOk;
    property IsTryConntectRemoteServer: Boolean read FIsTryConntectRemoteServer;
    property LocalIP: Longword read FLocalIP;
    property LocalPort: Word read FLocalPort;
    property LocalTargetHandle: Int64 read FLocalTargetHandle;
    property LocalServerConfig: ISCSI_SERVER_CONFIG read FLocalServerConfig write FLocalServerConfig;
    property RemoteIP: Longword read FRemoteIP;
    property RemotePort: Word read FRemotePort;
    property RemoteTargetHandle: Int64 read FRemoteTargetHandle;
    property SubServer: ISCSI_SERVER read FSubServer;
    property SubServerConfig: ISCSI_SERVER_CONFIG read FSubServerConfig;
  end;

var
  fAddSynchronization: TfAddSynchronization;

implementation

uses
  WinSock;

{$R *.dfm}

procedure TfAddSynchronization.bOKClick(Sender: TObject);
begin
  FIsOk:= True;
  Close;
end;

procedure TfAddSynchronization.bCancelClick(Sender: TObject);
begin
  FLocalTargetName:= '';
  FRemoteTargetName:= '';
  Close;
end;

procedure TfAddSynchronization.GetSubServers(Strings: TStrings);
var
  hFirst, hFind: KHANDLE;
  dwRet: Longword;
  ss: ISCSI_SERVER;
  ph: PInt64;
  bState: LongBool;
begin
  if Strings = nil then
    Exit;
  Strings.BeginUpdate();
  try
    Strings.Clear;
    hFirst:= 0;
    hFind:= 0;
    dwRet:= uSANDeployServerApi.FindFirstSubServer(hFirst);
    if (dwRet = 0) and (hFirst <> 0) then
    begin
      if (uSANDeployServerApi.GetSubServerConfig(hFirst, ss) <> 0)
        or (uSANDeployServerApi.GetSubServerState(hFirst, bState) <> 0) then
        Exit;
      if bState then//在线
      begin
        New(ph);
        ph^:= hFirst;
        Strings.AddObject(StrPas(@ss.ServerName[0]), TObject(ph));
      end;
      repeat
        hFind:= 0;
        dwRet:= FindNextSubServer(hFirst, hFind);
        if (dwRet = 0) and (hFind <> 0) then
        begin
          if (uSANDeployServerApi.GetSubServerConfig(hFind, ss) <> 0)
            or (uSANDeployServerApi.GetSubServerState(hFind, bState) <> 0) then
            Exit;
          if bState then//在线
          begin
            New(ph);
            ph^:= hFind;
            Strings.AddObject(StrPas(@ss.ServerName[0]), TObject(ph));
          end;
          hFirst:= hFind;
        end;
      until
        (dwRet <> 0) or (hFind = 0);
    end;
  finally
    Strings.EndUpdate();
  end;
end;

procedure TfAddSynchronization.GetTargets(Strings: TStrings);
var
  dwRet: Longword;
  khStartTarget, khFindTarget: KHANDLE;
  ste: TIScsiTargetEx;
  ph: PInt64;
begin
  if Strings = nil then
    Exit;
  khStartTarget:= 0;
  khFindTarget:= 0;
  Strings.BeginUpdate;
  try
    Strings.Clear;
    repeat
      dwRet:= uSANDeployServerApi.FindNextTargetEx(khStartTarget, khFindTarget);
      if (dwRet = 0) and (khFindTarget <> 0) then
      begin
        if uSANDeployServerApi.GetTargetConfigEx(khFindTarget, ste) = 0 then
        begin
          New(ph);
          ph^:= khFindTarget;
          Strings.AddObject(StrPas(@ste.TargetName[0]), TObject(ph));
        end
        else
          Break;
        khStartTarget:= khFindTarget;
      end;
    until (dwRet <> 0) or (khFindTarget = 0);
  finally
    Strings.EndUpdate;
  end;
end;

procedure TfAddSynchronization.FormShow(Sender: TObject);
begin
  cmbLocalTarget.OnChange:= nil;
  GetTargets(cmbLocalTarget.Items);
  cmbLocalTarget.ItemIndex:= -1;
  cmbLocalTarget.OnChange:= cmbLocalTargetChange;
  cmbLocalPortal.OnChange:= nil;
  GetPortal(FLocalServerConfig, cmbLocalPortal.Items);
  cmbLocalPortal.ItemIndex:= -1;
  cmbLocalPortal.OnChange:= cmbLocalPortalChange;
  edLocalPort.Text:= IntToStr(FLocalServerConfig.usPort);
  FLocalPort:= FLocalServerConfig.usPort;
  cmbSubServer.OnChange:= nil;
  GetSubServers(cmbSubServer.Items);
  cmbSubServer.ItemIndex:= -1;
  cmbSubServer.OnChange:= cmbSubServerChange;
end;

procedure TfAddSynchronization.cmbLocalTargetChange(Sender: TObject);
var
  ph: PInt64;
begin
  FLocalTargetName:= cmbLocalTarget.Text;
  ph:= PInt64(cmbLocalTarget.Items.Objects[cmbLocalTarget.ItemIndex]);
  if ph <> nil then
    FLocalTargetHandle:= ph^;
end;

procedure TfAddSynchronization.cmbSubServerChange(Sender: TObject);
var
  ph: PInt64;
begin
  cmbRemoteTarget.Clear;
  Screen.Cursor:= crHourGlass;
  try
    ph:= PInt64(cmbSubServer.Items.Objects[cmbSubServer.ItemIndex]);
    if (ph <> nil) and (uSANDeployServerApi.GetSubServerConfig(ph^, FSubServer) = 0)
      and (uSANDeployServerApi.ConnectTo(@FSubServer.ServerName[0], FSubServer.Port,
        @FSubServer.UserName[0], @FSubServer.Password[0]) = 0)
      and (uSANDeployServerApi.GetServerConfig(FSubServerConfig) = 0) then
    begin
      FIsTryConntectRemoteServer:= True;
      GetTargets(cmbRemoteTarget.Items);
      cmbRemoteTarget.ItemIndex:= -1;
      cmbRemotePortal.OnChange:= nil;
      GetPortal(FSubServerConfig, cmbRemotePortal.Items);
      cmbRemotePortal.ItemIndex:= -1;
      cmbRemotePortal.OnChange:= cmbRemotePortalChange;
      edRemotePort.Text:= IntToStr(FSubServerConfig.usPort);
      FRemotePort:= FSubServerConfig.usPort;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfAddSynchronization.GetPortal(
  const ServerConfig: ISCSI_SERVER_CONFIG; Strings: TStrings);
var
  I: Integer;
  addr: TInAddr;
begin
  if Strings = nil then
    Exit;
  Strings.Clear;
  for I:= Low(ServerConfig.Portal) to High(ServerConfig.Portal) do
  begin
    addr.S_addr:= ServerConfig.Portal[I].ulNatAddress;
    if addr.S_addr = 0 then
      Continue;
    Strings.Add(StrPas(inet_ntoa(addr)));
  end;
end;

procedure TfAddSynchronization.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TfAddSynchronization.cmbRemoteTargetChange(Sender: TObject);
  var
  ph: PInt64;
begin
  FRemoteTargetName:= cmbRemoteTarget.Text;

  ph:= PInt64(cmbRemoteTarget.Items.Objects[cmbRemoteTarget.ItemIndex]);
  if ph <> nil then
    FRemoteTargetHandle:= ph^;

end;

procedure TfAddSynchronization.RadioButtonClick(Sender: TObject);
begin
  Tag:= TControl(Sender).Tag;
end;

procedure TfAddSynchronization.cmbLocalPortalChange(Sender: TObject);
begin
  if cmbLocalPortal.ItemIndex > -1 then
  begin
    FLocalIP:= WinSock.inet_addr(PAnsiChar(cmbLocalPortal.Text));
    FLocalPort:= FLocalServerConfig.usPort;
  end;
end;

procedure TfAddSynchronization.cmbRemotePortalChange(Sender: TObject);
begin
  if cmbRemotePortal.ItemIndex > -1 then
  begin
    FRemoteIP:= WinSock.inet_addr(PAnsiChar(cmbRemotePortal.Text));
  end;
end;

end.
