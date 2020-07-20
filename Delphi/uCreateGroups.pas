unit uCreateGroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfCreateGroups = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    GroupName: TEdit;
    Label2: TLabel;
    ListBox: TListBox;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnAdd: TBitBtn;
    btnRemove: TBitBtn;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FGroupName: string;
    procedure GetGroupUsers;
  public
    { Public declarations }
    IsAdd: Boolean;
    GroupId: Longword;
  end;

var
  fCreateGroups: TfCreateGroups;

implementation

uses uChooseUser, uSANDeployServerApi;

{$R *.dfm}

procedure TfCreateGroups.FormCreate(Sender: TObject);
begin
  IsAdd := False;
end;

procedure TfCreateGroups.FormShow(Sender: TObject);
begin
{
  if GroupId = Longword(-1) then// Create Groups
  begin
    GroupName.ReadOnly:= False;
    btnAdd.Enabled:= False;
    btnRemove.Enabled:= False;
    GroupName.ReadOnly:= False;
  end
  else
  begin
    GroupName.ReadOnly:= True;
    btnAdd.Enabled:= True;
    btnRemove.Enabled:= True;
    GroupName.ReadOnly:= True;
    GetGroupUsers();
  end;
}
end;

procedure TfCreateGroups.btnOKClick(Sender: TObject);
var
  dwRet: Longword;
begin
//  Case Tag of
//    // Create Groups
//    100: begin
//           // Work...
//
//           IsAdd := True;
//           Close;
//         end;
//
//    // Add to Group
//    200: begin
//           // Work...
//
//           IsAdd := True;
//           Close;
//         end;
//  end;
  if GroupName.Text = '' then
  begin
    Application.MessageBox('Please enter the group name.', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  dwRet:= uSANDeployServerApi.AddEditGroup(GroupId, PAnsiChar(GroupName.Text), 0);
  IsAdd := dwRet = 0;
  Close;
end;

procedure TfCreateGroups.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfCreateGroups.btnAddClick(Sender: TObject);
var
  dwRet: Longword;
begin
  if GroupId = Longword(-1) then
  begin
    if GroupName.Text = '' then
    begin
      Application.MessageBox('Please enter the group name.', nil, MB_OK or MB_ICONWARNING);
      Exit;
    end;
    dwRet:= uSANDeployServerApi.AddEditGroup(GroupId, PAnsiChar(GroupName.Text), 0);
    if dwRet <> 0 then
    begin
      Application.MessageBox(PChar(Format('Add Group %s failed', [GroupName.Text])), nil, MB_OK or MB_ICONWARNING);
      Exit;
    end;
    FGroupName:= GroupName.Text;
  end;

  fChooseUser := TfChooseUser.Create(Self);
  try
    fChooseUser.ShowModal;
    dwRet:= uSANDeployServerApi.LinkUserGroup(PAnsiChar(fChooseUser.UserName), PAnsiChar(GroupName.Text));
    if dwRet = 0 then
      GetGroupUsers
    else
      Application.MessageBox('Add user to group failed!', nil, MB_OK or MB_ICONWARNING);
  finally
    FreeAndNil(fChooseUser);
  end;
end;

procedure TfCreateGroups.btnRemoveClick(Sender: TObject);
var
  dwRet: Longword;
begin
  if GroupId = Longword(-1) then
  begin
    if GroupName.Text = '' then
    begin
      Application.MessageBox('Please enter the group name.', nil, MB_OK or MB_ICONWARNING);
      Exit;
    end;
    dwRet:= uSANDeployServerApi.AddEditGroup(GroupId, PAnsiChar(GroupName.Text), 0);
    if dwRet <> 0 then
    begin
      Application.MessageBox(PChar(Format('Add Group %s failed', [GroupName.Text])), nil, MB_OK or MB_ICONWARNING);
      Exit;
    end;
    GroupId:= 0;
  end;
  
  if (ListBox.ItemIndex > -1) then
  begin
    dwRet:= uSANDeployServerApi.UnlinkUserGroup(PAnsiChar(ListBox.Items[ListBox.ItemIndex]),
      PAnsiChar(GroupName.Text));
    if dwRet = 0 then
      GetGroupUsers
    else
      Application.MessageBox('Add user to group failed!', nil, MB_OK or MB_ICONWARNING);
  end
  else
    Application.MessageBox('Please select user to remove!', nil, MB_OK or MB_ICONWARNING);
end;

procedure TfCreateGroups.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TfCreateGroups.GetGroupUsers;
var
  dwRet, dwUserCount, I: Longword;
  pGroupName, pUserName: PAnsiChar;
  arrUsers: array[0..1023] of Longword;
begin
  pGroupName:= nil;
  ListBox.Items.Clear;
  dwRet:= 0;
  if GroupId = Longword(-1) then//create
    if FGroupName <> '' then
    begin
      pGroupName:= AllocMem(256);
      StrPCopy(pGroupName, FGroupName);
    end
  else
  begin
    pGroupName:= AllocMem(256);
    dwRet:= uSANDeployServerApi.GetGroupName(GroupId, pGroupName, 255);
  end;
  if dwRet = 0 then
  begin
    dwUserCount:= SizeOf(arrUsers);
    dwRet:= uSANDeployServerApi.GetUsers(pGroupName, @arrUsers[0], @dwUserCount);
    if dwRet = 0 then
    begin
      dwUserCount:= dwUserCount div SizeOf(Longword);
      if dwUserCount > 0 then
      begin
        ListBox.Items.BeginUpdate;
        try
          ListBox.Items.Clear;
          for I:= 0 to dwUserCount-1 do
          begin
            pUserName:= AllocMem(256);
            dwRet:= uSANDeployServerApi.GetUserNameFromID(arrUsers[I], pUserName, 255);
            if dwRet = 0 then
              ListBox.Items.Add(StrPas(pUserName));
            FreeMem(pUserName);
          end;
        finally
          ListBox.Items.EndUpdate;
        end;
      end;
    end;
  end;


  if pGroupName <> nil then
    FreeMem(pGroupName);
end;

end.
