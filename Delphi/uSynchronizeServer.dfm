object fSynchronizeServer: TfSynchronizeServer
  Left = 339
  Top = 336
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Synchronize Server'
  ClientHeight = 339
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Default'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 421
    Height = 339
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 220
      Height = 13
      Caption = 'Select the following information to synchronize:'
    end
    object Label2: TLabel
      Left = 16
      Top = 232
      Width = 44
      Height = 13
      Caption = 'Progress:'
    end
    object bOk: TBitBtn
      Left = 245
      Top = 292
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 0
      OnClick = bOkClick
    end
    object bCancal: TBitBtn
      Left = 325
      Top = 292
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
    end
    object ProgressBar: TProgressBar
      Left = 16
      Top = 256
      Width = 385
      Height = 17
      TabOrder = 2
    end
    object ListView: TListView
      Left = 16
      Top = 40
      Width = 385
      Height = 169
      Checkboxes = True
      Columns = <
        item
          Width = 300
        end>
      GridLines = True
      Items.Data = {
        B20000000500000000000000FFFFFFFFFFFFFFFF000000000000000014434841
        50207573657220616E642067726F75707300000000FFFFFFFFFFFFFFFF000000
        00000000000C576F726B73746174696F6E7300000000FFFFFFFFFFFFFFFF0000
        00000000000013505845207365727665722073657474696E677300000000FFFF
        FFFFFFFFFFFF000000000000000007566F6C756D657300000000FFFFFFFFFFFF
        FFFF00000000000000000754617267657473}
      ReadOnly = True
      RowSelect = True
      ShowColumnHeaders = False
      TabOrder = 3
      ViewStyle = vsReport
    end
  end
end
