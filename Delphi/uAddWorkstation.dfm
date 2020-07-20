object fAddWorkstation: TfAddWorkstation
  Left = 361
  Top = 90
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Add Workstation'
  ClientHeight = 314
  ClientWidth = 344
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 154
    Width = 88
    Height = 21
    AutoSize = False
    Caption = 'Mac Address:'
    Color = clRed
    ParentColor = False
    Transparent = True
    Layout = tlCenter
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 344
    Height = 314
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 16
      Top = 16
      Width = 305
      Height = 225
      Caption = ' Information '
      TabOrder = 0
      object Label14: TLabel
        Left = 16
        Top = 28
        Width = 88
        Height = 21
        AutoSize = False
        Caption = 'Host Name:'
        Color = clRed
        ParentColor = False
        Transparent = True
        Layout = tlCenter
      end
      object Label16: TLabel
        Left = 16
        Top = 54
        Width = 88
        Height = 21
        AutoSize = False
        Caption = 'IP Address:'
        Color = clRed
        ParentColor = False
        Transparent = True
        Layout = tlCenter
      end
      object Label17: TLabel
        Left = 16
        Top = 80
        Width = 88
        Height = 21
        AutoSize = False
        Caption = 'IP Mask:'
        Color = clRed
        ParentColor = False
        Transparent = True
        Layout = tlCenter
      end
      object Label18: TLabel
        Left = 16
        Top = 106
        Width = 88
        Height = 21
        AutoSize = False
        Caption = 'Mac Address:'
        Color = clRed
        ParentColor = False
        Transparent = True
        Layout = tlCenter
      end
      object Label19: TLabel
        Left = 16
        Top = 164
        Width = 88
        Height = 21
        AutoSize = False
        Caption = 'Target:'
        Color = clRed
        ParentColor = False
        Transparent = True
        Layout = tlCenter
      end
      object Label20: TLabel
        Left = 16
        Top = 190
        Width = 88
        Height = 21
        AutoSize = False
        Caption = 'Permission:'
        Color = clRed
        ParentColor = False
        Transparent = True
        Layout = tlCenter
      end
      object Label2: TLabel
        Left = 16
        Top = 138
        Width = 88
        Height = 21
        AutoSize = False
        Caption = 'Boot Server:'
        Color = clRed
        ParentColor = False
        Transparent = True
        Layout = tlCenter
      end
      object cmbHost: TComboBox
        Left = 103
        Top = 28
        Width = 176
        Height = 21
        ImeName = 'Microsoft IME 2010'
        ItemHeight = 13
        TabOrder = 0
      end
      object edMacAddr: TEdit
        Left = 103
        Top = 106
        Width = 176
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 3
      end
      object edIp: TEdit
        Left = 103
        Top = 54
        Width = 176
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 1
      end
      object edMask: TEdit
        Left = 103
        Top = 80
        Width = 176
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 2
      end
      object cmbTargets: TComboBox
        Left = 103
        Top = 164
        Width = 176
        Height = 21
        ImeName = 'Microsoft IME 2010'
        ItemHeight = 13
        TabOrder = 4
      end
      object cmbPermission: TComboBox
        Left = 103
        Top = 190
        Width = 176
        Height = 21
        Style = csDropDownList
        ImeName = 'Microsoft IME 2010'
        ItemHeight = 13
        TabOrder = 5
        Items.Strings = (
          'Normal'
          'Operator')
      end
    end
    object BitBtn_OK: TBitBtn
      Left = 173
      Top = 268
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 1
      OnClick = BitBtn_OKClick
    end
    object BitBtn_Cancel: TBitBtn
      Left = 253
      Top = 268
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = BitBtn_CancelClick
    end
    object chkSaveData: TCheckBox
      Left = 16
      Top = 248
      Width = 180
      Height = 17
      Caption = 'Persistent data for this client. '
      TabOrder = 3
    end
  end
  object edBootServer: TEdit
    Left = 119
    Top = 154
    Width = 176
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 1
  end
end
