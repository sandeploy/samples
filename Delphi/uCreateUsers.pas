unit uCreateUsers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfCreateUsers = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Password: TEdit;
    ConfirmPassword: TEdit;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    UserName: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConfirmPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    IsAdd: Boolean;
    UserId: Longword;
  end;

var
  fCreateUsers: TfCreateUsers;

implementation

uses
  uSANDeployServerApi;
  
{$R *.dfm}

procedure TfCreateUsers.btnOKClick(Sender: TObject);
var
  dwRet: Longword;
begin
//  Case Tag of
//    // Create Users
//    100: begin
//           // Work...
//
//           IsAdd := True;
//           Close;
//         end;
//
//    // Set Password
//    200: begin
//           // Work...
//
//           IsAdd := True;
//           Close;
//         end;
//  end;
  if UserName.Text = '' then
  begin
    Application.MessageBox('Please enter the user name.', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  if Password.Text = '' then
  begin
    Application.MessageBox('Please enter the password.', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  if Password.Text <> ConfirmPassword.Text then
  begin
    Application.MessageBox('The confirm password you entered is not match! Please try again!', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;

  dwRet:= AddEditUser(UserId, PAnsiChar(UserName.Text), PAnsiChar(Password.Text), False, nil, 0);

  IsAdd := dwRet = 0;

  if not IsAdd then
    case Tag of //// Create Users
      0: Application.MessageBox('Create user failed', nil, MB_OK or MB_ICONWARNING);
      1: Application.MessageBox('set user password failed', nil, MB_OK or MB_ICONWARNING);
    end;
  Close;
end;

procedure TfCreateUsers.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfCreateUsers.FormCreate(Sender: TObject);
begin
  IsAdd := False;
end;

procedure TfCreateUsers.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TfCreateUsers.ConfirmPasswordKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnOK.Click;
end;

end.
