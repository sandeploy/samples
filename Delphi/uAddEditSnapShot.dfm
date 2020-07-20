object fNewEditSnapShot: TfNewEditSnapShot
  Left = 192
  Top = 107
  BorderStyle = bsSingle
  Caption = 'New / Edit snapshot'
  ClientHeight = 262
  ClientWidth = 257
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 28
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 16
    Top = 80
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object edName: TEdit
    Left = 16
    Top = 32
    Width = 225
    Height = 21
    MaxLength = 30
    TabOrder = 0
  end
  object mmDesc: TMemo
    Left = 16
    Top = 104
    Width = 225
    Height = 96
    MaxLength = 250
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 96
    Top = 224
    Width = 64
    Height = 24
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 176
    Top = 224
    Width = 64
    Height = 24
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
