unit uAddWorkstation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uSANDeployServerApi;

type
  TfAddWorkstation = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    BitBtn_OK: TBitBtn;
    BitBtn_Cancel: TBitBtn;
    Label14: TLabel;
    cmbHost: TComboBox;
    edMacAddr: TEdit;
    edIp: TEdit;
    edMask: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    cmbTargets: TComboBox;
    cmbPermission: TComboBox;
    chkSaveData: TCheckBox;
    edBootServer: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn_OKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn_CancelClick(Sender: TObject);
  private
    { Private declarations }
    FTargetHandleList: TList;
    FIsAddOrEdit: Boolean;
    FTargetHandle: Int64;
    FClientHandle: Int64;
    FClientConfig: TClientConfig;
    Id:Integer;
    function GetTargets(aList: TStrings): Integer;
  public
    { Public declarations }
    procedure FillConfig;
    property ClientHandle: Int64 read FClientHandle write FClientHandle;
    property IsAddOrEdit: Boolean read FIsAddOrEdit;
    property TargetHandle: Int64 read FTargetHandle write FTargetHandle;
    property ClientConfig: TClientConfig read FClientConfig write FClientConfig;
  end;

var
  fAddWorkstation: TfAddWorkstation;

implementation

uses
  WinSock, Math;

{$R *.dfm}

procedure ConvertMacAddrStrToBytes(const strMacAddr: string; pBytes: PByte; nBytes: Byte);
var
  I, L: Integer;
  sl: TStrings;
begin
  sl:= TStringList.Create;
  try
    sl.Delimiter:= '-';
    sl.DelimitedText:= strMacAddr;
    if sl.Count < 6 then
      Exit;
    ZeroMemory(pBytes, nBytes);
    L:= Min(nBytes, sl.Count);
    for I:= 0 to L-1 do
    begin
      HexToBin(PAnsiChar(sl[I]), PAnsiChar(pBytes), 1);
      Inc(pBytes);
    end;
  finally
    sl.Free;
  end;
end;

procedure TfAddWorkstation.FormCreate(Sender: TObject);
var
  idx: Integer;
begin
  FIsAddOrEdit := False;
  FTargetHandleList:= TList.Create;
  idx:= GetTargets(cmbTargets.Items);
  cmbTargets.ItemIndex:= idx;
end;

procedure TfAddWorkstation.BitBtn_OKClick(Sender: TObject);
var
  dwRet: Longword;
  strIp, strMask: string;
begin
  FillChar(FClientConfig, SizeOf(FClientConfig), 0);

  FClientConfig.ID := Id;
  
  if cmbHost.Text <> '' then
  begin
    FClientConfig.bHasName:= 1;
    StrPCopy(@FClientConfig.pcName[0], cmbHost.Text);
  end;


  strIp:= edIP.Text; // Format('%s.%s.%s.%s', [edIp0.Text, edIp1.Text, edIp2.Text, edIp3.Text]);

  FClientConfig.ClientAddress:= inet_addr(PAnsiChar(strIp));


  strMask:= edMask.Text;// Format('%s.%s.%s.%s', [edMask0.Text, edMask1.Text, edMask2.Text, edMask3.Text]);

  FClientConfig.IPMask:= inet_addr(PAnsiChar(strMask));
  StrPCopy(@FClientConfig.TargetName[0], cmbTargets.Text);
  //mac 地址输入格式
  ConvertMacAddrStrToBytes(edMacAddr.Text, @FClientConfig.MacAddress[0], SizeOf(FClientConfig.MacAddress));
  //FClientConfig.MacAddress
  //operator 对应的 access_mode 的值
  FClientConfig.bAccess:= Byte(not Boolean(cmbPermission.ItemIndex));

  if(edBootServer.Text <> '') then
    FClientConfig.BootServer := inet_addr(PAnsiChar(edBootServer.Text))
  else
    FClientConfig.BootServer := 0;



  if chkSaveData.Checked then
    FClientConfig.Flags := ISCSI_CLIENT_FLAG_SAVE_DATA
  else
    FClientConfig.Flags := 0;

  if Boolean(Tag) then//Edit
    dwRet:= uSANDeployServerApi.SetStaticClientConfig(0, FClientHandle, FClientConfig)
  else//Add
    dwRet:= uSANDeployServerApi.AddStaticClient(0, FClientConfig);

  FIsAddOrEdit := dwRet = 0;
  Close;
end;

function TfAddWorkstation.GetTargets(aList: TStrings): Integer;
var
  hStartTarget, hFindTarget: KHANDLE;
  dwRet: Longword;
  iste: TIScsiTargetEx;
  ph: PInt64;
begin
  Result:= -1;
  if aList = nil then
    Exit;
  aList.Clear;
  hStartTarget:= 0;
  repeat
    dwRet:= uSANDeployServerApi.FindNextTargetEx(hStartTarget, hFindTarget);
    if dwRet = 0 then
    begin
      if uSANDeployServerApi.GetTargetConfigEx(hFindTarget, iste) = 0 then
      begin
        New(ph);
        ph^:= hFindTarget;
        FTargetHandleList.Add(ph);
        if hFindTarget = TargetHandle then
          Result:= aList.AddObject(StrPas(iste.TargetName), TObject(ph))
        else
          aList.AddObject(StrPas(iste.TargetName), TObject(ph));
      end
      else
        Break;
      hStartTarget:= hFindTarget;
    end;
  until dwRet <> 0;
end;

procedure TfAddWorkstation.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  for I:= 0 to FTargetHandleList.Count-1 do
    if FTargetHandleList.Items[I] <> nil then
      Dispose(PInt64(FTargetHandleList.Items[I]));
  FTargetHandleList.Free;
end;

procedure TfAddWorkstation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TfAddWorkstation.FillConfig;
var
  addr: TInAddr;
begin
  Id:= FClientConfig.ID;

  cmbHost.Text:= StrPas(@FClientConfig.pcName[0]);
  addr.S_addr:= FClientConfig.ClientAddress;

  edIp.Text:= StrPas(inet_ntoa(addr));

  cmbTargets.Text:= StrPas(@FClientConfig.TargetName[0]);

  if FClientConfig.IPMask <> 0 then
  begin
    addr.S_addr:= FClientConfig.IPMask;
    edMask.Text:= StrPas(inet_ntoa(addr));
  end
  else
    edMask.Text:= '255.255.255.0';



  edMacAddr.Text:= Format('%.2x-%.2x-%.2x-%.2x-%.2x-%.2x', [FClientConfig.MacAddress[0],
    FClientConfig.MacAddress[1], FClientConfig.MacAddress[2], FClientConfig.MacAddress[3],
    FClientConfig.MacAddress[4], FClientConfig.MacAddress[5]]);

  cmbPermission.ItemIndex:= Integer(not Boolean(FClientConfig.bAccess));

  addr.S_addr:= FClientConfig.BootServer;
  edBootServer.Text:= StrPas(inet_ntoa(addr));

  if FClientConfig.Flags and ISCSI_CLIENT_FLAG_SAVE_DATA <> 0 then
  begin
  chkSaveData.Checked := true;
  end
  else
  chkSaveData.Checked := false;
end;

procedure TfAddWorkstation.BitBtn_CancelClick(Sender: TObject);
begin
  Close;
end;

end.
