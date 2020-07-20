unit uConnectToServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfConnectToServer = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ServerPort: TEdit;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    Panel2: TPanel;
    ServerAddress: TComboBox;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    UserName: TEdit;
    Label5: TLabel;
    Password: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function ConnectToServer: Boolean;
  public
    { Public declarations }
    IsConnect: Boolean; // Value for confirm connection to the server. Default is false.
  end;

var
  fConnectToServer: TfConnectToServer;

implementation

{$R *.dfm}

uses
  uSANDeployServerApi;

procedure TfConnectToServer.btnOKClick(Sender: TObject);
begin
  Case Tag of
         // Login
    100: begin
           if ConnectToServer() then
           begin
             IsConnect := True;
             Close;
           end
           else
             Application.MessageBox('Error in connectting server, please check the server address, port and password you entered!', nil, MB_OK or MB_ICONERROR);
         end;

         // Click Root in TreeView] Connect to another server
    200: begin
           // Work...
           IsConnect := True;
           Close;
         end;

         // SmartDisk iSCSI Attribute -> Load Balance -> Add Server
    300: begin
           // Work...    
           IsConnect := True;
           Close;
         end;
  end;
end;

function TfConnectToServer.ConnectToServer: Boolean;
var
  dwRet: Longword;
  Port: Integer;
begin
  Result := False;
  Port:= StrToIntDef(ServerPort.Text, -1);
  if (Port < 0) or (Port > High(Word)) then
  begin
    Application.MessageBox('Please enter a valid port number: 0..65535.', nil, MB_OK or MB_ICONWARNING);
    Exit;
  end;
  dwRet:= uSANDeployServerApi.ConnectTo(PAnsiChar(ServerAddress.Text), Port,
    PAnsiChar(UserName.Text), PAnsiChar(Password.Text));

  // Work...

  // if successful, the connection to the server,
  // Result is True.

  // if fails, the connection to the server,
  // Displays the reason for the failure.
  // Result is False.

  Result := dwRet = 0;
end;

procedure TfConnectToServer.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfConnectToServer.FormShow(Sender: TObject);
begin
  Case Tag of
    100: begin end; // Login
    200: begin end; // Click Root in TreeView] Connect to another server
    300: begin end; // SmartDisk iSCSI Attribute -> Load Balance -> Add Server
  end;
end;

procedure TfConnectToServer.PasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnOK.Click();
end;

procedure TfConnectToServer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

end.
