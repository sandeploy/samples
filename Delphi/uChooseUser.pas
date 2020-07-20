unit uChooseUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfChooseUser = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    ListBox: TListBox;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBoxDblClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FUserName: string;
    { Private declarations }
    function GetUserList(List: TStrings): Boolean;
  public
    { Public declarations }
    property UserName: string read FUserName write FUserName;
  end;

var
  fChooseUser: TfChooseUser;

implementation

uses
  uSANDeployServerApi;

{$R *.dfm}

procedure TfChooseUser.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfChooseUser.btnOKClick(Sender: TObject);
begin
  if ListBox.ItemIndex > -1 then
  begin
    FUserName:= ListBox.Items[ListBox.ItemIndex];
    Close;
  end;
end;

procedure TfChooseUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TfChooseUser.FormShow(Sender: TObject);
var
  sl: TStringList;
begin
  // Work... (Load data)
  sl:= TStringList.Create;
  ListBox.Items.BeginUpdate();
  try
    if GetUserList(sl) then
      ListBox.Items.Assign(sl);
  finally
    ListBox.Items.EndUpdate();
    sl.Free;
  end;
end;

function TfChooseUser.GetUserList(List: TStrings): Boolean;
var
  arrUsers: array[0..4095] of Longword;
  I, dwRet, dwUserCount: Longword;
  pUserName: PAnsiChar;
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
      List.Add(StrPas(pUserName));
    end;
    FreeMem(pUserName);
  end;
end;


procedure TfChooseUser.ListBoxDblClick(Sender: TObject);
begin
  btnOK.Click();
end;

end.
