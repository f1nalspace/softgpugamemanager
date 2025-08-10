object frmGameEditor: TfrmGameEditor
  Left = 195
  Top = 109
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Edit Game'
  ClientHeight = 298
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 13
    Caption = 'Executable:'
  end
  object lblExecutable: TLabel
    Left = 8
    Top = 24
    Width = 418
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = '[Exe]'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 418
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 56
      Height = 13
      Caption = 'DirectDraw:'
    end
    object Label3: TLabel
      Left = 144
      Top = 16
      Width = 54
      Height = 13
      Caption = 'Direct3D 8:'
    end
    object Label4: TLabel
      Left = 280
      Top = 16
      Width = 54
      Height = 13
      Caption = 'Direct3D 9:'
    end
    object Label5: TLabel
      Left = 8
      Top = 64
      Width = 68
      Height = 13
      Caption = 'Mesa Options:'
    end
    object Label6: TLabel
      Left = 216
      Top = 64
      Width = 92
      Height = 13
      Caption = 'OpenGlide Options:'
    end
    object cbDDraw: TComboBox
      Left = 8
      Top = 32
      Width = 130
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '-'
        'system'
        'wine')
    end
    object cbD3D8: TComboBox
      Left = 144
      Top = 32
      Width = 130
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        '-'
        'system'
        'wine')
    end
    object cbD3D9: TComboBox
      Left = 280
      Top = 32
      Width = 130
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        '-'
        'system'
        'wine'
        'custom')
    end
    object lvMesaOptions: TListView
      Left = 8
      Top = 80
      Width = 195
      Height = 129
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'Key'
          Width = 100
        end
        item
          Caption = 'Value'
          Width = 100
        end>
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 3
      ViewStyle = vsReport
    end
    object lvOpenGlideOptions: TListView
      Left = 216
      Top = 80
      Width = 195
      Height = 129
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'Key'
          Width = 100
        end
        item
          Caption = 'Value'
          Width = 100
        end>
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 4
      ViewStyle = vsReport
    end
  end
  object btnCancel: TButton
    Left = 8
    Top = 267
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 352
    Top = 266
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object popupMenuMesaOptions: TPopupMenu
    Left = 96
    Top = 264
    object Add1: TMenuItem
      Caption = 'Add...'
    end
    object Edit1: TMenuItem
      Caption = 'Edit...'
    end
    object Remove1: TMenuItem
      Caption = 'Remove'
    end
  end
end
