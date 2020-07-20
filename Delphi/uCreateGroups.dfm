object fCreateGroups: TfCreateGroups
  Left = 289
  Top = 85
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Create / Edit Group'
  ClientHeight = 386
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 386
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 100
      Height = 21
      AutoSize = False
      Caption = 'Group Name:'
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 100
      Height = 21
      AutoSize = False
      Caption = 'Members:'
      Layout = tlCenter
    end
    object GroupName: TEdit
      Left = 112
      Top = 16
      Width = 161
      Height = 21
      TabOrder = 0
    end
    object ListBox: TListBox
      Left = 16
      Top = 72
      Width = 257
      Height = 217
      ImeName = 'Microsoft IME 2010'
      ItemHeight = 13
      TabOrder = 1
    end
    object btnOK: TBitBtn
      Left = 117
      Top = 346
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 2
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 197
      Top = 346
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 3
      OnClick = btnCancelClick
    end
    object btnAdd: TBitBtn
      Left = 16
      Top = 296
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 4
      OnClick = btnAddClick
    end
    object btnRemove: TBitBtn
      Left = 96
      Top = 296
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 5
      OnClick = btnRemoveClick
    end
    object Panel2: TPanel
      Left = 16
      Top = 328
      Width = 257
      Height = 2
      TabOrder = 6
    end
  end
end
