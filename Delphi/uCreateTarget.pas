unit uCreateTarget;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, uSANDeployServerApi;

type
  TfCreateTarget = class(TForm)
    Panel5: TPanel;
    bBack: TBitBtn;
    bNext: TBitBtn;
    bCancel: TBitBtn;
    Panel4: TPanel;
    Notebook: TNotebook;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Panel3: TPanel;
    Panel6: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Image2: TImage;
    Panel13: TPanel;
    Panel17: TPanel;
    Panel20: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Image6: TImage;
    Panel21: TPanel;
    Panel22: TPanel;
    Label25: TLabel;
    edTargetName: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    lbAvailGroups: TListBox;
    lbSelGroups: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    lbAvailVol: TListBox;
    lbSelVols: TListBox;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bNextClick(Sender: TObject);
    procedure bBackClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
  private
    { Private declarations }
    FVolumeList: TList;
    FTargetEx: TIScsiTargetEx;
    function GetDefaultTargetName: string;
    function CreateTarget: Boolean;
    procedure ClearVolumes;
    procedure GetAllVolumes;
//    function GetSelectedVolumeIndex(pst: PIScsiTarget): Integer;
  public
    { Public declarations }
    TargetHandle: KHANDLE;
    IsAdd: Boolean;
  end;

var
  fCreateTarget: TfCreateTarget;

implementation

const
  cAnonymous = 'Anonymous';

{$R *.dfm}

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

procedure TfCreateTarget.FormCreate(Sender: TObject);
begin
  IsAdd := False;
  FVolumeList:= TList.Create;
end;

procedure TfCreateTarget.FormShow(Sender: TObject);
begin
  bBack.Enabled := False;
  Notebook.PageIndex := 0;
  GetAllVolumes();
  GetAllGroupNames(lbAvailGroups.Items);
end;

procedure TfCreateTarget.bNextClick(Sender: TObject);
begin
  Case Notebook.PageIndex of
    // 1. Select LUN
    0:
    begin
      if lbSelVols.Count <= 0 then
      begin
        Application.MessageBox('Plese select the volumes!', nil, MB_OK or MB_ICONWARNING);
        Exit;
      end;
    
      bBack.Enabled := True;
      Notebook.PageIndex := 1;
    end;

    // 2. Set iSCSI Target Authorization
    1:
    begin
    {
      if lbSelGroups.Count <= 0 then
      begin
        Application.MessageBox('Plese select the group for the target!', nil, MB_OK or MB_ICONWARNING);
        Exit;
      end;
    }
      edTargetName.Text:= GetDefaultTargetName();
      Notebook.PageIndex := 2;
      bNext.Caption := 'Finish';
    end;

    // 2. Finish
    2:
    begin
      IsAdd:= CreateTarget();
      if not IsAdd then
        Application.MessageBox('Create target failed!', nil, MB_OK or MB_ICONWARNING);
      Close;
    end;
  end;
end;

procedure TfCreateTarget.bBackClick(Sender: TObject);
begin
  Case Notebook.PageIndex of
    // 1. Select LUN
    0: begin
       end;

    // 2. Set iSCSI Target Authorization
    1: begin
         bBack.Enabled := False;
         Notebook.PageIndex := 0;
       end;

    // 2. Finish
    2: begin
         bNext.Caption := 'Next >';
         Notebook.PageIndex := 1;
       end;
  end;
end;

procedure TfCreateTarget.GetAllVolumes;
var
  khStartTarget, khFindTarget: KHANDLE;
  dwRet, l: Longword;
  ist: TIScsiTarget;
  pst: PIScsiTarget;
begin
  // Refresh Volumes
  khStartTarget:= 0;
  lbAvailVol.Items.BeginUpdate;
  try
    lbAvailVol.Clear;
    lbSelVols.Clear;
    ClearVolumes();
    while True do
    begin
      dwRet:= uSANDeployServerApi.FindNextTarget(khStartTarget, khFindTarget);
      if (dwRet = 0) and (khFindTarget <> 0) then
      begin
        khStartTarget:= khFindTarget;
        l:= uSANDeployServerApi.GetTargetConfig(khFindTarget, ist);
        if l=0 then
        begin
          New(pst);
          pst^:= ist;
          FVolumeList.Add(pst);
          lbAvailVol.Items.AddObject(StrPas(ist.TargetName), TObject(pst));
        end
        else
          Continue;
      end
      else
        Break;
    end;
  finally
    lbAvailVol.Items.EndUpdate;
  end;
end;

function TfCreateTarget.GetDefaultTargetName: string;
const
  cTargetNameFormat = 'iqn.%.4d-%.2d.com.smatdisk.SAN%.2d%.2d%.2d%.2d';
var
  st: TSystemTime;
begin
  Result:= '';
  try
    GetLocalTime(st);
    Result:= Format(cTargetNameFormat, [st.wYear, st.wMonth, st.wDay, st.wHour, st.wMinute, st.wSecond]);
  except

  end;
end;

procedure TfCreateTarget.ClearVolumes;
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

procedure TfCreateTarget.BitBtn5Click(Sender: TObject);
var
  pst: PIScsiTarget;
begin
  if lbAvailVol.ItemIndex < 0 then
    Exit;
  pst:= PIScsiTarget(lbAvailVol.Items.Objects[lbAvailVol.ItemIndex]);
  if pst <> nil then
  begin
    lbSelVols.AddItem(StrPas(pst^.TargetName), TObject(pst));
    lbAvailVol.Items.Delete(lbAvailVol.ItemIndex);
  end;
end;

{
function TfCreateTarget.GetSelectedVolumeIndex(pst: PIScsiTarget): Integer;
var
  I: Integer;
  p: PIScsiTarget;
begin
  Result:= -1;
  if pst = nil then
    Exit;
  for I:= 0 to lbSelVols.Items.Count-1 do
  begin
    p:= PIScsiTarget(lbSelVols.Items.Objects[I]);
    if p = pst then
    begin
      Result:= i;
      Break;
    end;
  end;
end;
}

procedure TfCreateTarget.BitBtn7Click(Sender: TObject);
var
  i: Integer;
  pst: PIScsiTarget;
begin
  for i:= 0 to lbAvailVol.Items.Count-1 do
  begin
    pst:= PIScsiTarget(lbAvailVol.Items.Objects[i]);
    if pst <> nil then
      lbSelVols.AddItem(StrPas(pst^.TargetName), TObject(pst));
  end;
  lbAvailVol.Clear;
end;

procedure TfCreateTarget.BitBtn6Click(Sender: TObject);
var
  pst: PIScsiTarget;
begin
  if lbSelVols.ItemIndex < 0 then
    Exit;
  pst:= PIScsiTarget(lbSelVols.Items.Objects[lbSelVols.ItemIndex]);
  if pst <> nil then
  begin
    lbAvailVol.AddItem(StrPas(pst^.TargetName), TObject(pst));
    lbSelVols.Items.Delete(lbSelVols.ItemIndex);
  end;
end;

procedure TfCreateTarget.BitBtn8Click(Sender: TObject);
var
  i: Integer;
  pst: PIScsiTarget;
begin
  for i:= 0 to lbSelVols.Items.Count-1 do
  begin
    pst:= PIScsiTarget(lbSelVols.Items.Objects[i]);
    if pst <> nil then
      lbAvailVol.AddItem(StrPas(pst^.TargetName), TObject(pst));
  end;
  lbSelVols.Clear;
end;

procedure TfCreateTarget.FormDestroy(Sender: TObject);
begin
  lbAvailVol.Clear;
  lbSelVols.Clear;
  ClearVolumes();
  FVolumeList.Free;
end;

procedure TfCreateTarget.BitBtn1Click(Sender: TObject);
begin
  if lbAvailGroups.ItemIndex < 0 then
    Exit;
  lbSelGroups.AddItem(lbAvailGroups.Items[lbAvailGroups.ItemIndex], nil);
  lbAvailGroups.DeleteSelected;
end;

procedure TfCreateTarget.BitBtn2Click(Sender: TObject);
begin
  if lbSelGroups.ItemIndex < 0 then
    Exit;
  lbAvailGroups.AddItem(lbSelGroups.Items[lbSelGroups.ItemIndex], nil);
  lbSelGroups.DeleteSelected;
end;

procedure TfCreateTarget.BitBtn3Click(Sender: TObject);
var
  I: Integer;
begin
  for I:= 0 to lbAvailGroups.Count-1 do
    lbSelGroups.AddItem(lbAvailGroups.Items[I], nil);
  lbAvailGroups.Clear;
end;

procedure TfCreateTarget.BitBtn4Click(Sender: TObject);
var
  I: Integer;
begin
  for I:= 0 to lbSelGroups.Count-1 do
    lbAvailGroups.AddItem(lbSelGroups.Items[I], nil);
  lbSelGroups.Clear;
end;

function TfCreateTarget.CreateTarget: Boolean;
var
  I: Integer;
begin
  FillChar(FTargetEx, SizeOf(FTargetEx), 0);
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
      FTargetEx.Volumes[I]:= PIScsiTarget(lbSelVols.Items.Objects[I]);
      FTargetEx.LunCount:= I+1;
    end
    else
      Break;
  end;
  FTargetEx.ulAuthMode:= ISCSI_AUTH_MODE_OR;
  FTargetEx.Enabled:= True;
  FTargetEx.InheritAuthorization := True; // fix
  FTargetEx.InheritTargetPortal := True; // fix
  Result:= uSANDeployServerApi.AddTargetEx(TargetHandle, FTargetEx) = 0;
end;

procedure TfCreateTarget.bCancelClick(Sender: TObject);
begin
  Close;
end;

end.
