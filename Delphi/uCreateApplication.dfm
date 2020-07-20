object fCreateApplication: TfCreateApplication
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Create Sync'
  ClientHeight = 245
  ClientWidth = 296
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
  object btnOK: TButton
    Left = 64
    Top = 208
    Width = 72
    Height = 24
    Caption = 'OK'
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 168
    Top = 208
    Width = 72
    Height = 24
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object gbLocalTarget: TGroupBox
    Left = 0
    Top = 0
    Width = 296
    Height = 64
    Align = alTop
    Caption = 'Step 1: Select Local Target'
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 28
      Width = 63
      Height = 13
      Caption = 'Local Target:'
    end
    object cmbTarget: TComboBox
      Left = 88
      Top = 24
      Width = 192
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cmbTargetChange
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 64
    Width = 296
    Height = 64
    Align = alTop
    Caption = 'Step 2: Select Load-balance Server'
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 28
      Width = 67
      Height = 13
      Caption = 'Select Server:'
    end
    object cmbServer: TComboBox
      Left = 88
      Top = 24
      Width = 192
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cmbServerChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 128
    Width = 296
    Height = 64
    Align = alTop
    Caption = 'Step3: Select Remote Target'
    TabOrder = 4
    object Label3: TLabel
      Left = 8
      Top = 28
      Width = 74
      Height = 13
      Caption = 'Remote Target:'
    end
    object cmbRemoteTarget: TComboBox
      Left = 88
      Top = 24
      Width = 192
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cmbRemoteTargetChange
    end
  end
end
