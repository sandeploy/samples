unit uCreateApplication;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uSANDeployServerApi;

type
  TfCreateApplication = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbLocalTarget: TGroupBox;
    Label1: TLabel;
    cmbTarget: TComboBox;
    GroupBox1: TGroupBox;
    cmbServer: TComboBox;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    cmbRemoteTarget: TComboBox;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cmbServerChange(Sender: TObject);
    procedure cmbTargetChange(Sender: TObject);
    procedure cmbRemoteTargetChange(Sender: TObject);
  private
    { Private declarations }
    FIsOk: Boolean;
    FIsTryConntectRemoteServer: Boolean;
    FLocalTargetName: string;
    FRemoteTargetName: string;
    FSubServer: ISCSI_SERVER;
    procedure GetTargets(Strings: TStrings);
    procedure GetSubServers(Strings: TStrings);
  public
    { Public declarations }
    property LocalTargetName: string read FLocalTargetName;
    property RemoteTargetName: string read FRemoteTargetName;
    property IsOk: Boolean read FIsOk;
    property IsTryConntectRemoteServer: Boolean read FIsTryConntectRemoteServer;
    property SubServer: ISCSI_SERVER read FSubServer;
  end;

var
  fCreateApplication: TfCreateApplication;

implementation

{$R *.dfm}

procedure TfCreateApplication.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TfCreateApplication.FormShow(Sender: TObject);
begin
  GetTargets(cmbTarget.Items);
  cmbTarget.ItemIndex:= -1;
  cmbTarget.OnChange:= cmbTargetChange;
  GetSubServers(cmbServer.Items);
  cmbServer.ItemIndex:= -1;
  cmbServer.OnChange:= cmbServerChange;
end;

procedure TfCreateApplication.GetTargets(Strings: TStrings);
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

procedure TfCreateApplication.btnOKClick(Sender: TObject);
begin
  FIsOk:= True;
  //FTargetName:= cmbTarget.Text;
  Close;
end;

procedure TfCreateApplication.btnCancelClick(Sender: TObject);
begin
  FLocalTargetName:= '';
  FRemoteTargetName:= '';
  Close;
end;

procedure TfCreateApplication.GetSubServers(Strings: TStrings);
const
  ConnMsg: array[Boolean] of string = ('Yes', 'No');
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

procedure TfCreateApplication.cmbServerChange(Sender: TObject);
var
  ph: PInt64;
begin
  cmbRemoteTarget.Clear;
  if cmbServer.ItemIndex < 0 then
    Exit;
  Screen.Cursor:= crHourGlass;
  try
    ph:= PInt64(cmbServer.Items.Objects[cmbServer.ItemIndex]);
    if (ph <> nil) and (uSANDeployServerApi.GetSubServerConfig(ph^, FSubServer) = 0)
      and (uSANDeployServerApi.ConnectTo(@FSubServer.ServerName[0], FSubServer.Port,
        @FSubServer.UserName[0], @FSubServer.Password[0]) = 0) then
    begin
      FIsTryConntectRemoteServer:= True;
      GetTargets(cmbRemoteTarget.Items);
      cmbRemoteTarget.ItemIndex:= -1;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfCreateApplication.cmbTargetChange(Sender: TObject);
begin
  FLocalTargetName:= cmbTarget.Text;
end;

procedure TfCreateApplication.cmbRemoteTargetChange(Sender: TObject);
begin
  FRemoteTargetName:= cmbRemoteTarget.Text;
end;

end.
