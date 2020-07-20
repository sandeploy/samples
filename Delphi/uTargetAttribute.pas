unit uTargetAttribute;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, uSANDeployServerApi;

type
  TfTargetAttribute = class(TForm)
    Panel1: TPanel;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    bConfirm: TBitBtn;
    bCancel: TBitBtn;
    bApply: TBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    lbAvailVols: TListBox;
    lbSelVols: TListBox;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lbAvailGroups: TListBox;
    lbSelGroups: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label25: TLabel;
    edTargetName: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bConfirmClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bApplyClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
  private
    { Private declarations }
    FVolumeList: TList;
    FGroupList: TStrings;
    FTargetEx: TIScsiTargetEx;
    function SetTarget(): Boolean;
    function GetTargetConfig(var TargetEx: TIScsiTargetEx): Boolean;
    procedure ClearVolumes;
    procedure GetAllVolumes;
    procedure GetAvailAndSelVols;
    procedure GetAvailAndSelGroups;
  public
    { Public declarations }
    TargetHandle: KHANDLE;    
    IsAdd: Boolean;
  end;

var
  fTargetAttribute: TfTargetAttribute;

implementation

const
  cAnonymous = 'Anonymous';

function GetAllGroupNames(GroupNameList: TStrings): Boolean;
var
  I: Integer;
  dwRet, dwGroupCount: Longword;
  arrGroups: array[0..127] of Longword;
  pGroupName: PAnsiChar;
begin
  Result:= False;
  if GroupNameList = nil then
    Exit;
  GroupNameList.Clear;
  GroupNameList.Add(cAnonymous);
  GetMem(pGroupName, 256);
  dwGroupCount:= SizeOf(arrGroups);
  dwRet:= uSANDeployServerApi.GetGroups(nil, @arrGroups[0], @dwGroupCount);
  if dwRet = 0 then
  begin
    Result:= True;
    for I:= Low(arrGroups) to High(arrGroups) do
    begin
      ZeroMemory(pGroupName, 256);
      dwRet:= uSANDeployServerApi.GetGroupName(arrGroups[I], pGroupName, 256);
      if dwRet = 0 then
        GroupNameList.Add(StrPas(pGroupName))
      else
      begin
        Result:= False;
        Break;
      end;
    end;
  end;
  FreeMem(pGroupName);
end;


{$R *.dfm}

procedure TfTargetAttribute.FormCreate(Sender: TObject);
begin
  IsAdd := False;
  FVolumeList:= TList.Create;
  FGroupList:= TStringList.Create;
end;

procedure TfTargetAttribute.FormShow(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  // Work... Load data
  GetAllVolumes();
  GetAllGroupNames(FGroupList);
  if not GetTargetConfig(FTargetEx) then
  begin
    Application.MessageBox('Can''t get the target configuration!', nil, MB_OK or MB_ICONWARNING);
    Close;
    Exit;
  end;

  GetAvailAndSelVols();
  GetAvailAndSelGroups();

  edTargetName.Text:= StrPas(@FTargetEx.TargetName[0]);

  FillChar(FTargetEx.VolumeNames[0][0], SizeOf(FTargetEx.VolumeNames), 0);
  FillChar(FTargetEx.Groups[0][0], SizeOf(FTargetEx.Groups), 0);
  FillChar(FTargetEx.TargetName[0], SizeOf(FTargetEx.TargetName), 0);
end;

procedure TfTargetAttribute.bConfirmClick(Sender: TObject);
begin
  // Work ... Data save
  // if save data then IsAdd := True;
  if SetTarget() then
    Application.MessageBox('Modify target attributes ok!', nil, MB_OK or MB_ICONWARNING)
  else
    Application.MessageBox('Modify target attributes failed!', nil, MB_OK or MB_ICONWARNING);
  Close;
end;

procedure TfTargetAttribute.ClearVolumes;
var
  I: Integer;
  pst: PIScsiTarget;
begin
  for I:= 0 to FVolumeList.Count-1 do
  begin
    pst:= PIScsiTarget(FVolumeList.Items[I]);
    if pst <> nil then
      Dispose(pst);
  end;
  FVolumeList.Clear;
end;


function TfTargetAttribute.GetTargetConfig(
  var TargetEx: TIScsiTargetEx): Boolean;
begin
  Result:= uSANDeployServerApi.GetTargetConfigEx(TargetHandle, TargetEx) = 0;
end;

procedure TfTargetAttribute.GetAllVolumes();
var
  khStartTarget, khFindTarget: KHANDLE;
  dwRet: Longword;
  ist: TIScsiTarget;
  pst: PIScsiTarget;
begin
  // Refresh Volumes

  khStartTarget:= 0;
  ClearVolumes();
  repeat
    dwRet:= uSANDeployServerApi.FindNextTarget(khStartTarget, khFindTarget);
    if dwRet = 0 then
    begin
      if uSANDeployServerApi.GetTargetConfig(khFindTarget, ist) = 0 then
      begin
        New(pst);
        pst^:= ist;
        FVolumeList.Add(pst);
      end
      else
        Break;
      khStartTarget:= khFindTarget;
    end;
  until dwRet <> 0;
end;

procedure TfTargetAttribute.FormDestroy(Sender: TObject);
begin
  ClearVolumes();
  FVolumeList.Free;
  FGroupList.Free;
end;

procedure TfTargetAttribute.GetAvailAndSelVols;

  function GetVolumeByNameInTarget(const pszVolumeName: PAnsiChar): Boolean;
  var
    I: Integer;
  begin
    Result:= False;
    for I:= 0 to High(FTargetEx.VolumeNames) do
    begin
      if (StrComp(@FTargetEx.VolumeNames[I][0], pszVolumeName)=0) then
      begin
        Result:= True;
        Exit;
      end;
    end;
  end;


var
  I: Integer;
  pst: PIScsiTarget;
begin
  lbAvailVols.Clear;
  lbSelVols.Clear;
  for I:= 0 to FVolumeList.Count-1 do
  begin
    pst:= FVolumeList.Items[I];
    if pst = nil then
      Continue;
    if GetVolumeByNameInTarget(@pst^.TargetName[0]) then
      //selected
      lbSelVols.AddItem(StrPas(@pst^.TargetName[0]), TObject(pst))
    else //avail
      lbAvailVols.AddItem(StrPas(@pst^.TargetName[0]), TObject(pst));
  end;
end;

procedure TfTargetAttribute.GetAvailAndSelGroups;

  function GetGroupNameInTarget(const pszGroupName: PAnsiChar): Boolean;
  var
    I: Integer;
  begin
    Result:= False;
    for I:= 0 to High(FTargetEx.Groups) do
    begin
      if (StrComp(@FTargetEx.Groups[I][0], pszGroupName)=0) then
      begin
        Result:= True;
        Exit;
      end;
    end;
  end;

var
  I: Integer;
begin
  lbAvailGroups.Clear;
  lbSelGroups.Clear;
  for I:= 0 to FGroupList.Count-1 do
  begin
    if GetGroupNameInTarget(PAnsiChar(FGroupList[I])) then
      //selected
      lbSelGroups.AddItem(FGroupList[I], nil)
    else //avail
      lbAvailGroups.AddItem(FGroupList[I], nil);
  end;
end;


function TfTargetAttribute.SetTarget: Boolean;
var
  I: Integer;
begin
  StrPCopy(@FTargetEx.TargetName[0], edTargetName.Text);

  for I:=0 to lbSelGroups.Count-1 do
  begin
    if I < High(FTargetEx.Groups) then
      StrPCopy(@FTargetEx.Groups[I], lbSelGroups.Items[I])
    else
      Break;
  end;

  for I:=0 to lbSelVols.Count-1 do
  begin
    if I < High(FTargetEx.Volumes) then
    begin
      StrPCopy(@FTargetEx.VolumeNames[I][0], lbSelVols.Items[I]);
//      FTargetEx.Volumes[I]:= PIScsiTarget(lbSelVols.Items.Objects[I]);
      FTargetEx.LunCount:= I+1;
    end
    else
      Break;
  end;
//  FTargetEx.Enabled:= True;
  Result:= uSANDeployServerApi.SetTargetConfigEx(TargetHandle, FTargetEx) = 0;
end;

procedure TfTargetAttribute.bApplyClick(Sender: TObject);
begin
  if SetTarget() then
    Application.MessageBox('Modify target attributes ok!', nil, MB_OK or MB_ICONWARNING)
  else
    Application.MessageBox('Modify target attributes failed!', nil, MB_OK or MB_ICONWARNING);
end;

procedure TfTargetAttribute.BitBtn1Click(Sender: TObject);
begin
  if lbAvailGroups.ItemIndex < 0 then
    Exit;
  lbSelGroups.AddItem(lbAvailGroups.Items[lbAvailGroups.ItemIndex], nil);
  lbAvailGroups.DeleteSelected;
end;

procedure TfTargetAttribute.BitBtn2Click(Sender: TObject);
begin
  if lbSelGroups.ItemIndex < 0 then
    Exit;
  lbAvailGroups.AddItem(lbSelGroups.Items[lbSelGroups.ItemIndex], nil);
  lbSelGroups.DeleteSelected;
end;

procedure TfTargetAttribute.BitBtn3Click(Sender: TObject);
var
  I: Integer;
begin
  for I:= 0 to lbAvailGroups.Count-1 do
    lbSelGroups.AddItem(lbAvailGroups.Items[I], nil);
  lbAvailGroups.Clear;
end;

procedure TfTargetAttribute.BitBtn4Click(Sender: TObject);
var
  I: Integer;
begin
  for I:= 0 to lbSelGroups.Count-1 do
    lbAvailGroups.AddItem(lbSelGroups.Items[I], nil);
  lbSelGroups.Clear;
end;

procedure TfTargetAttribute.BitBtn5Click(Sender: TObject);
var
  pst: PIScsiTarget;
begin
  if lbAvailVols.ItemIndex < 0 then
    Exit;
  pst:= PIScsiTarget(lbAvailVols.Items.Objects[lbAvailVols.ItemIndex]);
  if pst <> nil then
  begin
    lbSelVols.AddItem(StrPas(pst^.TargetName), TObject(pst));
    lbAvailVols.Items.Delete(lbAvailVols.ItemIndex);
  end;
end;

procedure TfTargetAttribute.BitBtn6Click(Sender: TObject);
var
  pst: PIScsiTarget;
begin
  if lbSelVols.ItemIndex < 0 then
    Exit;
  pst:= PIScsiTarget(lbSelVols.Items.Objects[lbSelVols.ItemIndex]);
  if pst <> nil then
  begin
    lbAvailVols.AddItem(StrPas(pst^.TargetName), TObject(pst));
    lbSelVols.Items.Delete(lbSelVols.ItemIndex);
  end;
end;

procedure TfTargetAttribute.BitBtn7Click(Sender: TObject);
var
  i: Integer;
  pst: PIScsiTarget;
begin
  for i:= 0 to lbAvailVols.Items.Count-1 do
  begin
    pst:= PIScsiTarget(lbAvailVols.Items.Objects[i]);
    if pst <> nil then
      lbSelVols.AddItem(StrPas(pst^.TargetName), TObject(pst));
  end;
  lbAvailVols.Clear;
end;

procedure TfTargetAttribute.BitBtn8Click(Sender: TObject);
var
  i: Integer;
  pst: PIScsiTarget;
begin
  for i:= 0 to lbSelVols.Items.Count-1 do
  begin
    pst:= PIScsiTarget(lbSelVols.Items.Objects[i]);
    if pst <> nil then
      lbAvailVols.AddItem(StrPas(pst^.TargetName), TObject(pst));
  end;
  lbSelVols.Clear;
end;

end.
