object fCreateUsers: TfCreateUsers
  Left = 523
  Top = 292
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Create / Edit User'
  ClientHeight = 168
  ClientWidth = 289
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 168
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 100
      Height = 21
      AutoSize = False
      Caption = 'User Name:'
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 100
      Height = 21
      AutoSize = False
      Caption = 'PassWord:'
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 16
      Top = 80
      Width = 100
      Height = 21
      AutoSize = False
      Caption = 'Confirm password:'
      Layout = tlCenter
    end
    object Password: TEdit
      Left = 112
      Top = 48
      Width = 161
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object ConfirmPassword: TEdit
      Left = 112
      Top = 80
      Width = 161
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
      OnKeyDown = ConfirmPasswordKeyDown
    end
    object btnOK: TBitBtn
      Left = 117
      Top = 128
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 3
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 197
      Top = 128
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 4
      OnClick = btnCancelClick
    end
    object UserName: TEdit
      Left = 112
      Top = 16
      Width = 161
      Height = 21
      TabOrder = 0
    end
  end
end
