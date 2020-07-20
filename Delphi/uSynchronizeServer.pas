unit uSynchronizeServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TfSynchronizeServer = class(TForm)
    Panel1: TPanel;
    bOk: TBitBtn;
    bCancal: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar: TProgressBar;
    ListView: TListView;
    procedure bOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSynchronizeServer: TfSynchronizeServer;

implementation

{$R *.dfm}

procedure TfSynchronizeServer.bOkClick(Sender: TObject);
begin
  // Work ...

  Close;
end;

end.
