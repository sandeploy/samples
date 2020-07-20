unit uAddEditSnapShot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uSANDeployServerApi;

type
  TfNewEditSnapShot = class(TForm)
    Label1: TLabel;
    edName: TEdit;
    Label2: TLabel;
    mmDesc: TMemo;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FSnapshotInfo: TSnapshotInfo;
  public
    { Public declarations }
    SnapshotHandle: Int64;
    VolumeHandle: Int64;
    IsAdd: Boolean;
  end;

var
  fNewEditSnapShot: TfNewEditSnapShot;

implementation

{$R *.dfm}

procedure TfNewEditSnapShot.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfNewEditSnapShot.btnOKClick(Sender: TObject);
var
  dwRet: Longword;
begin
  dwRet:= 0;
  case Tag of
    0://create
    begin
      dwRet:= uSANDeployServerApi.CreateSnapshot(VolumeHandle, SnapshotHandle,
        PAnsiChar(edName.Text), PAnsiChar(mmDesc.Text), True);
      if dwRet <> 0 then
        Application.MessageBox('Creating snapshot failed!', nil, MB_OK or MB_ICONWARNING);
    end;
    1://edit
    begin
      if edName.Text = '' then
      begin
        Application.MessageBox('Please enter the name of the snapshot!', nil, MB_OK or MB_ICONWARNING);
        Exit;
      end;
      StrPCopy(@FSnapshotInfo.Name[0], edName.Text);
      StrPCopy(@FSnapshotInfo.Desp[0], mmDesc.Text);
      dwRet:= uSANDeployServerApi.SetSnapshotInfo(VolumeHandle, SnapshotHandle, FSnapshotInfo);
      if dwRet <> 0 then
        Application.MessageBox('Snapshot information modified failed!', nil, MB_OK or MB_ICONWARNING);
    end;
  end;
  IsAdd:= dwRet = 0;
  Close;
end;

procedure TfNewEditSnapShot.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TfNewEditSnapShot.FormShow(Sender: TObject);
var
  dwRet: Longword;
begin
  if Tag = 1 then
  begin
    dwRet:= uSANDeployServerApi.GetSnapshot(VolumeHandle, SnapshotHandle, FSnapshotInfo);
    if dwRet = 0 then
    begin
      edName.Text:= StrPas(@FSnapshotInfo.Name[0]);
      mmDesc.Text:= StrPas(@FSnapshotInfo.Desp[0]);
    end
    else
    begin
      Application.MessageBox('Can''t get the snapshot information', nil, MB_OK or MB_ICONWARNING);
      Close;
    end;
  end;
end;

end.
