object fChooseUser: TfChooseUser
  Left = 841
  Top = 202
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Choose User'
  ClientHeight = 268
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 268
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 16
      Width = 100
      Height = 21
      AutoSize = False
      Caption = 'Members:'
      Layout = tlCenter
    end
    object ListBox: TListBox
      Left = 16
      Top = 40
      Width = 257
      Height = 173
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = ListBoxDblClick
    end
    object btnOK: TBitBtn
      Left = 117
      Top = 228
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 197
      Top = 228
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
end
