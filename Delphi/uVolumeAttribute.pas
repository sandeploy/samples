unit uVolumeAttribute;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Buttons, ComCtrls, ExtCtrls, ImgList, uSANDeployServerApi;

type
  TfVolumeAttribute = class(TForm)
    Panel1: TPanel;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    bConfirm: TBitBtn;
    bCancel: TBitBtn;
    bApply: TBitBtn;
    GroupBox3: TGroupBox;
    General_Description: TMemo;
    Cache_EnableHigh: TCheckBox;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Cache_Size: TSpinEdit;
    Cache_Time: TSpinEdit;
    WriteBack_EnableWriteback: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label15: TLabel;
    WriteBack_QuotaSize: TSpinEdit;
    WriteBack_TempPath: TEdit;
    WriteBack_BlackSize: TComboBox;
    WriteBack_bPath: TBitBtn;
    TabSheet4: TTabSheet;
    Snapshot_TreeView: TTreeView;
    ImageList1: TImageList;
    Snapshot_Goto: TBitBtn;
    Snapshot_Delete: TBitBtn;
    Snapshot_New: TBitBtn;
    Snapshot_Edit: TBitBtn;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    lbHddSn: TLabel;
    Label41: TLabel;
    SpinEdit7: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bConfirmClick(Sender: TObject);
    procedure Snapshot_TreeViewDeletion(Sender: TObject; Node: TTreeNode);
    procedure Snapshot_DeleteClick(Sender: TObject);
    procedure Snapshot_NewClick(Sender: TObject);
    procedure Snapshot_EditClick(Sender: TObject);
    procedure Snapshot_GotoClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure bApplyClick(Sender: TObject);
  private
    { Private declarations }
    FTargetConfig: TIScsiTarget;
    function CreateIndicateNode(ParentNode: TTreeNode): TTreeNode;
    function GetAndFillConfig: Boolean;
    procedure GetSnapshots;
    function GetParentSnapshotHandle: Int64;
    procedure Refresh();
    function Save(): Boolean;
  public
    { Public declarations }
    IsAdd: Boolean;
    VolumeHandle: KHANDLE;
  end;

var
  fVolumeAttribute: TfVolumeAttribute;

implementation

uses
  uAddEditSnapShot;

{$R *.dfm}

procedure TfVolumeAttribute.FormCreate(Sender: TObject);
begin
  IsAdd := False;
end;

procedure TfVolumeAttribute.FormShow(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  if not GetAndFillConfig() then
  begin
    Application.MessageBox('Can''t get the volume attributes configuration!', nil, MB_OK or MB_ICONWARNING);
    Close;
  end;
  Refresh;
end;

procedure TfVolumeAttribute.bConfirmClick(Sender: TObject);
begin
  IsAdd:= Save();
  if IsAdd then
    Application.MessageBox('Volume attributes saved successfully!', nil, MB_OK or MB_ICONINFORMATION)
  else
    Application.MessageBox('Volume attributes saved failed!', nil, MB_OK or MB_ICONWARNING);
  Close;
end;

function ConvertBlockSizeToBlockIndex(BlockSize: Integer): Integer;
begin
  Result:= -1;
  case BlockSize of
    2048: Result:= 0;
    4096: Result:= 1;
    8192: Result:= 2;
    16384: Result:= 3;
    32768: Result:= 4;
    65536: Result:= 5;
  end;
end;

function ConvertBlockIndexToBlockSize(BlockIndex: Integer): Integer;
begin
  Result:= -1;
  case BlockIndex of
    0: Result:= 2048;
    1: Result:= 4096;
    2: Result:= 8192;
    3: Result:= 16384;
    4: Result:= 32768;
    5: Result:= 65536;
  end;
end;

function TfVolumeAttribute.GetAndFillConfig: Boolean;
begin
  Result:= uSANDeployServerApi.GetTargetConfig(VolumeHandle, FTargetConfig) = 0;
  if Result then
  begin
    General_Description.Text:= StrPas(@FTargetConfig.TargetName[0]);
    Cache_EnableHigh.Checked:= FTargetConfig.Cache.EnableCache;
    if FTargetConfig.Cache.EnableCache then
    begin
      Cache_Size.Value:= FTargetConfig.Cache.CacheSize.QuadPart div (1024 * 1024);
      Cache_Time.Value:= FTargetConfig.Cache.RefreshTime;
    end
    else
    begin
      Cache_Size.Value:= 0;
      Cache_Time.Value:= 0;
    end;

    with FTargetConfig do
      lbHddSn.Caption:= Format('%.2x%.2x%.2x%.2x%.2x%.2x%.2x%.2x',
        [HardSerial[0], HardSerial[1], HardSerial[2], HardSerial[3],
        HardSerial[4], HardSerial[5], HardSerial[6], HardSerial[7]]);

    WriteBack_EnableWriteback.Checked:= (FTargetConfig.VirtualWrite.VirtualWriteMode and 3) <> 0;   //

    WriteBack_TempPath.Text:= StrPas(FTargetConfig.VirtualWrite.VirtualWritePath);
    WriteBack_QuotaSize.Value:= FTargetConfig.VirtualWrite.VirtualWriteQuota.QuadPart div (1024 * 1024);
    WriteBack_BlackSize.ItemIndex:= ConvertBlockSizeToBlockIndex(FTargetConfig.StartOffset.QuadPart);

    SpinEdit7.Value := FTargetConfig.VirtualWrite.VirtualWriteMode shr 2;   //
  end;
end;

procedure TfVolumeAttribute.GetSnapshots;

var
  hCurrentSnapshot: Int64;
  IndicateNode: TTreeNode;

  function RecursiveGetSnapshotsToTreeViewNode(hParentSnapshot: KHANDLE; ParentNode: TTreeNode): Boolean;
  var
    pSnapshotInfos: PByte;
    p: PSnapshotInfo;
    dwRet, dwSnapshotSize, I: Longword;
    Node: TTreeNode;
    ph: PInt64;
  begin
    Result:= True;
    dwSnapshotSize:= 0;//SizeOf(TSnapshotInfo) * (dwSnapShotCount + 1);
    dwRet:= uSANDeployServerApi.GetSnapshots(VolumeHandle, hParentSnapshot, nil, dwSnapshotSize);
    if dwSnapshotSize = 0 then
      Exit;
    pSnapshotInfos:= AllocMem(dwSnapshotSize);
    dwRet:= uSANDeployServerApi.GetSnapshots(VolumeHandle, hParentSnapshot, PSnapshotInfo(pSnapshotInfos), dwSnapshotSize);
    Result:= dwRet = 0;
    if Result then
    begin
      dwSnapshotSize:= dwSnapshotSize div SizeOf(TSnapshotInfo);
      if dwSnapshotSize > 0 then
        for I:= 0 to dwSnapshotSize-1 do
        begin
          p:= PSnapshotInfo(Longword(pSnapshotInfos) + I * SizeOf(TSnapshotInfo));
          New(ph);
          ph^:= p^.Handle;
          Node:= Snapshot_TreeView.Items.AddChildObject(ParentNode, StrPas(@p^.Name[0]), ph);
          if (hCurrentSnapshot <> 0) and (hCurrentSnapshot = ph^) then
            IndicateNode:= CreateIndicateNode(Node);
          RecursiveGetSnapshotsToTreeViewNode(ph^, Node);
        end;
    end;
    FreeMem(pSnapshotInfos);
  end;

begin
  hCurrentSnapshot:= 0;
  IndicateNode:= nil;
  uSANDeployServerApi.GetCurrentSnapshot(VolumeHandle, hCurrentSnapshot);
  RecursiveGetSnapshotsToTreeViewNode(0, Snapshot_TreeView.Items.GetFirstNode());
  if IndicateNode = nil then
    CreateIndicateNode(Snapshot_TreeView.Items.GetFirstNode());
end;

procedure TfVolumeAttribute.Snapshot_TreeViewDeletion(Sender: TObject;
  Node: TTreeNode);
begin
  if (Node <> nil) and (Node.Data <> nil) then
  begin
    Dispose(PInt64(Node.Data));
    Node.Data:= nil;
  end;
end;

procedure TfVolumeAttribute.Snapshot_DeleteClick(Sender: TObject);
var
  ph: PInt64;
  dwRet: Longword;
begin
  if (Snapshot_TreeView.Selected = nil) or (Snapshot_TreeView.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a snapshot first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  ph:= Snapshot_TreeView.Selected.Data;
  dwRet:= uSANDeployServerApi.DeleteSnapshot(VolumeHandle, ph^);
  if (dwRet = 0) then
    Refresh;
end;

procedure TfVolumeAttribute.Snapshot_NewClick(Sender: TObject);
var
  fNewEditSnapShot: TfNewEditSnapShot;
  Node: TTreeNode;
  bAdded: Boolean;
begin
  fNewEditSnapShot:= TfNewEditSnapShot.Create(Self);
  try
    fNewEditSnapShot.Tag:= 0;
    fNewEditSnapShot.VolumeHandle:= VolumeHandle;
    fNewEditSnapShot.SnapshotHandle:= GetParentSnapshotHandle();
    fNewEditSnapShot.ShowModal;
    bAdded:= fNewEditSnapShot.IsAdd;
  finally
    FreeAndNil(fNewEditSnapShot);
  end;

  if bAdded then
    Refresh;
end;

function TfVolumeAttribute.GetParentSnapshotHandle: Int64;
begin
  Result:= -1;
  if (Snapshot_TreeView.Selected <> nil) then
    if (Snapshot_TreeView.Selected.Data <> nil) then
      Result:= PInt64(Snapshot_TreeView.Selected.Data)^
    else if (Snapshot_TreeView.Selected.Parent <> nil) and (Snapshot_TreeView.Selected.Parent.Data <> nil) then
      Result:= PInt64(Snapshot_TreeView.Selected.Parent.Data)^
end;

procedure TfVolumeAttribute.Snapshot_EditClick(Sender: TObject);
var
  fNewEditSnapShot: TfNewEditSnapShot;
begin
  if (Snapshot_TreeView.Selected = nil) or (Snapshot_TreeView.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a snapshot first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  fNewEditSnapShot:= TfNewEditSnapShot.Create(Self);
  try
    fNewEditSnapShot.Tag:= 0;
    fNewEditSnapShot.VolumeHandle:= VolumeHandle;
    fNewEditSnapShot.SnapshotHandle:= PInt64(Snapshot_TreeView.Selected.Data)^;
    fNewEditSnapShot.ShowModal;
  finally
    FreeAndNil(fNewEditSnapShot);
  end;
end;

procedure TfVolumeAttribute.Snapshot_GotoClick(Sender: TObject);
var
  hSnapshot: Int64;
  dwRet: Longword;
begin
  if (Snapshot_TreeView.Selected = nil) or (Snapshot_TreeView.Selected.Data = nil) then
  begin
    Application.MessageBox('Please select a snapshot first!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  hSnapshot:= PInt64(Snapshot_TreeView.Selected.Data)^;
  dwRet:= uSANDeployServerApi.SetCurrentSnapshot(VolumeHandle, hSnapshot);
  if dwRet <> 0 then
    Application.MessageBox('Can''t go to this snapshot!', nil, MB_OK or MB_ICONWARNING);
end;

procedure TfVolumeAttribute.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfVolumeAttribute.Refresh;
var
  Node: TTreeNode;
begin
  Snapshot_TreeView.Items.BeginUpdate;
  try
    Snapshot_TreeView.Items.Clear;
    //root node
    Node:= Snapshot_TreeView.Items.AddChildFirst(nil, 'Root');
    Node.ImageIndex:= 0;
    GetSnapshots();
    Snapshot_TreeView.FullExpand;
  finally
    Snapshot_TreeView.Items.EndUpdate;
  end;
end;

function TfVolumeAttribute.CreateIndicateNode(ParentNode: TTreeNode): TTreeNode;
begin
//indicate node
  Result:= Snapshot_TreeView.Items.AddChild(ParentNode, 'You are here');
  Result.ImageIndex:= 1;
  Result.Selected:= True;
end;

function TfVolumeAttribute.Save: Boolean;
begin
  StrPCopy(@FTargetConfig.TargetName[0], General_Description.Text);
  FTargetConfig.Cache.EnableCache:= Cache_EnableHigh.Checked;
  if FTargetConfig.Cache.EnableCache then
  begin
    FTargetConfig.Cache.CacheSize.QuadPart:= Int64(Cache_Size.Value) * 1024 * 1024;
    FTargetConfig.Cache.RefreshTime:= Cache_Time.Value;
  end
  else
  begin
    FTargetConfig.Cache.CacheSize.QuadPart:= 0;
    FTargetConfig.Cache.RefreshTime:= 0;
  end;

  // FTargetConfig.VirtualWriteMode:= Integer(WriteBack_EnableWriteback.Checked);
 // FTargetConfig.VirtualWriteMode := (SpinEdit7.Value shl 2) + Integer(WriteBack_EnableWriteback.Checked);  ///

  StrPCopy(@FTargetConfig.VirtualWrite.VirtualWritePath[0], WriteBack_TempPath.Text);
  FTargetConfig.VirtualWrite.VirtualWriteQuota.QuadPart:= Int64(WriteBack_QuotaSize.Value) * 1024 * 1024;
  FTargetConfig.StartOffset.QuadPart:= ConvertBlockIndexToBlockSize(WriteBack_BlackSize.ItemIndex);
  Result:= uSANDeployServerApi.SetTargetConfig(VolumeHandle, FTargetConfig) = 0;
end;

procedure TfVolumeAttribute.bApplyClick(Sender: TObject);
begin
  IsAdd:= Save();
  if IsAdd then
    Application.MessageBox('Volume attributes saved successfully!', nil, MB_OK or MB_ICONINFORMATION)
  else
    Application.MessageBox('Volume attributes saved failed!', nil, MB_OK or MB_ICONWARNING);
end;

end.
