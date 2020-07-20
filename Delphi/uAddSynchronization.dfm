object fAddSynchronization: TfAddSynchronization
  Left = 632
  Top = 157
  Width = 504
  Height = 493
  Caption = 'Add Synchronization'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 488
    Height = 455
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 16
      Top = 16
      Width = 457
      Height = 105
      Caption = ' First Server '
      TabOrder = 0
      object Label1: TLabel
        Left = 24
        Top = 40
        Width = 89
        Height = 21
        AutoSize = False
        Caption = 'Target Name:'
        Layout = tlCenter
      end
      object Label2: TLabel
        Left = 24
        Top = 64
        Width = 69
        Height = 21
        AutoSize = False
        Caption = 'Interface:'
        Layout = tlCenter
      end
      object Label3: TLabel
        Left = 272
        Top = 64
        Width = 69
        Height = 21
        AutoSize = False
        Caption = 'Port:'
        Layout = tlCenter
      end
      object edLocalPort: TEdit
        Left = 328
        Top = 64
        Width = 120
        Height = 21
        TabOrder = 0
        Text = '3260'
      end
      object cmbLocalTarget: TComboBox
        Left = 112
        Top = 40
        Width = 336
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cmbLocalTargetChange
      end
      object cmbLocalPortal: TComboBox
        Left = 112
        Top = 64
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnChange = cmbLocalPortalChange
      end
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 136
      Width = 457
      Height = 137
      Caption = ' Second Server '
      TabOrder = 1
      object Label4: TLabel
        Left = 24
        Top = 40
        Width = 89
        Height = 21
        AutoSize = False
        Caption = 'Server:'
        Layout = tlCenter
      end
      object Label5: TLabel
        Left = 24
        Top = 88
        Width = 69
        Height = 21
        AutoSize = False
        Caption = 'Interface:'
        Layout = tlCenter
      end
      object Label6: TLabel
        Left = 272
        Top = 88
        Width = 69
        Height = 21
        AutoSize = False
        Caption = 'Port:'
        Layout = tlCenter
      end
      object Label7: TLabel
        Left = 24
        Top = 64
        Width = 89
        Height = 21
        AutoSize = False
        Caption = 'Target Name:'
        Layout = tlCenter
      end
      object edRemotePort: TEdit
        Left = 328
        Top = 88
        Width = 120
        Height = 21
        TabOrder = 0
        Text = '3260'
      end
      object cmbSubServer: TComboBox
        Left = 112
        Top = 40
        Width = 336
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cmbSubServerChange
      end
      object cmbRemotePortal: TComboBox
        Left = 112
        Top = 88
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnChange = cmbRemotePortalChange
      end
      object cmbRemoteTarget: TComboBox
        Left = 112
        Top = 64
        Width = 336
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        OnChange = cmbRemoteTargetChange
      end
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 288
      Width = 457
      Height = 121
      Caption = ' Synchronize Data '
      TabOrder = 2
      object RadioButton1: TRadioButton
        Left = 16
        Top = 40
        Width = 320
        Height = 17
        Caption = 'Synchronize data from the first server to the second server'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = RadioButtonClick
      end
      object RadioButton2: TRadioButton
        Tag = 1
        Left = 16
        Top = 64
        Width = 320
        Height = 17
        Caption = 'Synchronize data from the second server to the first server'
        TabOrder = 1
        OnClick = RadioButtonClick
      end
      object RadioButton3: TRadioButton
        Tag = 2
        Left = 16
        Top = 88
        Width = 320
        Height = 17
        Caption = 'Do not synchronize data'
        TabOrder = 2
        OnClick = RadioButtonClick
      end
    end
    object bOK: TBitBtn
      Left = 317
      Top = 420
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 3
      OnClick = bOKClick
    end
    object bCancel: TBitBtn
      Left = 397
      Top = 420
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 4
      OnClick = bCancelClick
    end
  end
end
