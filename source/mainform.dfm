object frmMain: TfrmMain
  Left = 192
  Top = 107
  Width = 535
  Height = 372
  Caption = 'SoftGPU Game Manager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lvGames: TListView
    Left = 8
    Top = 40
    Width = 513
    Height = 297
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = 'Game Executable'
        Width = 200
      end
      item
        Caption = 'DDraw'
      end
      item
        Caption = 'D3D8'
      end
      item
        Caption = 'D3D9'
      end
      item
        Caption = 'Mesa'
        Width = 100
      end
      item
        Caption = 'Open Glide'
        Width = 100
      end>
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = lvGamesDblClick
    OnSelectItem = lvGamesSelectItem
  end
  object btnRefresh: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Refresh'
    TabOrder = 1
    OnClick = btnRefreshClick
  end
  object btnAdd: TButton
    Left = 88
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Add...'
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btnRemove: TButton
    Left = 168
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Remove'
    Enabled = False
    TabOrder = 3
    OnClick = btnRemoveClick
  end
  object btnEdit: TButton
    Left = 248
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Edit...'
    Enabled = False
    TabOrder = 4
    OnClick = btnEditClick
  end
  object dlgAddGameExecutable: TOpenDialog
    DefaultExt = '.exe'
    Filter = 'Game Executable *.exe|*.exe'
    FilterIndex = 0
    Title = 'Add game executable'
    Left = 16
    Top = 296
  end
  object popmnuList: TPopupMenu
    Left = 48
    Top = 296
    object miAddGame: TMenuItem
      Caption = 'Add Game...'
      OnClick = miAddGameClick
    end
  end
end
