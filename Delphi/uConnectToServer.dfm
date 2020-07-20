object fConnectToServer: TfConnectToServer
  Left = 553
  Top = 259
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Connect To Server'
  ClientHeight = 320
  ClientWidth = 318
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Default'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 318
    Height = 320
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 64
      Width = 80
      Height = 21
      AutoSize = False
      Caption = 'Server:'
      Color = clRed
      ParentColor = False
      Transparent = True
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 16
      Top = 96
      Width = 80
      Height = 21
      AutoSize = False
      Caption = 'Port:'
      Color = clRed
      ParentColor = False
      Transparent = True
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 16
      Top = 16
      Width = 281
      Height = 41
      AutoSize = False
      Caption = 
        'Enter the host name or IP Address and port of the server which y' +
        'ou want to add, and enter user login credentils:'
      Color = clRed
      ParentColor = False
      Transparent = True
      WordWrap = True
    end
    object ServerPort: TEdit
      Left = 96
      Top = 96
      Width = 201
      Height = 21
      TabOrder = 1
      Text = '3261'
    end
    object btnOK: TBitBtn
      Left = 141
      Top = 274
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 3
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 221
      Top = 274
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 4
      OnClick = btnCancelClick
    end
    object Panel2: TPanel
      Left = 16
      Top = 256
      Width = 280
      Height = 1
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 5
    end
    object ServerAddress: TComboBox
      Left = 95
      Top = 64
      Width = 202
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = '127.0.0.1'
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 136
      Width = 281
      Height = 105
      Caption = ' User login credentials '
      TabOrder = 2
      object Label4: TLabel
        Left = 16
        Top = 28
        Width = 80
        Height = 21
        AutoSize = False
        Caption = 'User Name:'
        Color = clRed
        ParentColor = False
        Transparent = True
        Layout = tlCenter
      end
      object Label5: TLabel
        Left = 16
        Top = 60
        Width = 80
        Height = 21
        AutoSize = False
        Caption = 'Password:'
        Color = clRed
        ParentColor = False
        Transparent = True
        Layout = tlCenter
      end
      object UserName: TEdit
        Left = 96
        Top = 28
        Width = 161
        Height = 21
        TabOrder = 0
        Text = 'admin'
      end
      object Password: TEdit
        Left = 96
        Top = 60
        Width = 161
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
        Text = 'sandeploy'
        OnKeyDown = PasswordKeyDown
      end
    end
  end
end
