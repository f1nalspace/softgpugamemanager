unit mainform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus;

type
  TfrmMain = class(TForm)
    lvGames: TListView;
    btnRefresh: TButton;
    btnAdd: TButton;
    dlgAddGameExecutable: TOpenDialog;
    btnRemove: TButton;
    popmnuList: TPopupMenu;
    miAddGame: TMenuItem;
    btnEdit: TButton;
    procedure lvGamesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure miAddGameClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvGamesDblClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure AddGameDialog(Sender: TObject);
    procedure EditGameDialog(Sender: TObject);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

uses
  Registry,
  utils, gameentry, gameditform;

function ContainsGameInList(ALV : TListView; AExecutable: string) : Boolean;
var
  I : Integer;
  Item : TListItem;
  Entry : TGameEntry;
begin
  Result := false;
  for I := 0 to ALV.Items.Count - 1 do
  begin
    Item := ALV.Items[I];
    Entry := TGameEntry(Item.Data);
    if CompareText(Entry.Executable, AExecutable) = 0 then
    begin
      Result := True;
      break;
    end; 
  end;
end;

function AddGameToList(ALV : TListView; AExecutable : string) : TGameEntry;
var
  item : TListItem;
begin
  Result := TGameEntry.Create(AExecutable);
  item := ALV.Items.Add();
  item.Data := Result;
  item.Caption := AExecutable;
end;

procedure RemoveGameFromList(LV : TListView; Item : TListItem);
var
  Entry : TGameEntry;
begin
  Entry := TGameEntry(Item.Data);
  Entry.Free;
  Item.Delete();
end;

procedure ClearGameList(LV : TListView);
var
  I : Integer;
  Entry : TGameEntry;
begin
  LV.Items.BeginUpdate();
  for i := 0 to LV.Items.Count - 1 do
  begin
    Entry := LV.Items[i].Data;
    Entry.Free;
  end;
  LV.Items.Clear();
  LV.Items.EndUpdate();
end;

procedure RefreshGameList(LV : TListView);
const
  baseKey : string = 'Software\vmdisp9x\apps\exe\';
var
  r : TRegistry;
  keyList : TStrings;
  i : integer;
  item : TListItem;
  keyName  : String;
  mesa, openGlide : string;
  Entry : TGameEntry;
begin
  ClearGameList(LV);

  r := TRegistry.Create(KEY_READ);
  r.RootKey := HKEY_LOCAL_MACHINE;
  if r.OpenKeyReadOnly(baseKey) then
  begin
    keyList := TStringList.Create;
    r.GetKeyNames(keyList);
    r.CloseKey();

    LV.Items.BeginUpdate();
    for i := 0 to keyList.Count - 1 do
    begin
      keyName := keyList[i];

      Entry := TGameEntry.Create(keyName);

      r.OpenKeyReadOnly(IncludeTrailingBackslash(baseKey) + keyName);

      Entry.DDrawOption := r.ReadString('ddraw');
      Entry.D3D8Option := r.ReadString('d3d8');
      Entry.D3D9Option := r.ReadString('d3d9');

      item := LV.Items.Add();
      item.Data := Entry;
      item.Caption := Entry.Executable;

      mesa := BuildTextFromValues(baseKey, keyName, 'mesa');
      openGlide := BuildTextFromValues(baseKey, keyName, 'openglide');
      
      item.SubItems.Add(Entry.DDrawOption);
      item.SubItems.Add(Entry.D3D8Option);
      item.SubItems.Add(Entry.D3D9Option);
      item.SubItems.Add(mesa);
      item.SubItems.Add(openGlide);

      r.CloseKey();
    end;
    LV.Items.EndUpdate();

    keyList.Free;
  end;
  r.Free;
end;

procedure TfrmMain.AddGameDialog(Sender: TObject);
var
  NewExecutable : string;
  FileName : string;
  EditDialog : TfrmGameEditor;
begin
  if dlgAddGameExecutable.Execute() then
  begin
    FileName := dlgAddGameExecutable.FileName;
    NewExecutable := ExtractFileName(FileName);
    if ContainsGameInList(lvGames, NewExecutable) then
    begin
      MessageDlg('Game "'+NewExecutable+'" is already in the list', mtWarning, [mbOK], 0);
      exit;
    end;

    EditDialog := TfrmGameEditor.Create(Self);
    EditDialog.Executable := NewExecutable;
    if EditDialog.ShowModal() = mrOk then
    begin
      AddGameToList(lvGames, NewExecutable);
      AddGameToRegistry(NewExecutable);
    end;

  end;
end;

procedure TfrmMain.lvGamesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  btnRemove.Enabled := (lvGames.Items.Count > 0) and (Selected);
  btnEdit.Enabled := (lvGames.Items.Count > 0) and (Selected);
end;

procedure TfrmMain.btnRemoveClick(Sender: TObject);
var
  Item : TListItem;
begin
  Item := lvGames.Selected;
  if Item = nil then Exit;
  RemoveGameFromList(lvGames, Item);
end;

procedure TfrmMain.btnRefreshClick(Sender: TObject);
begin
  RefreshGameList(lvGames);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  RefreshGameList(lvGames);
end;

procedure TfrmMain.btnAddClick(Sender: TObject);
begin
  AddGameDialog(Sender);
end;

procedure TfrmMain.miAddGameClick(Sender: TObject);
begin
  AddGameDialog(Sender);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  ClearGameList(lvGames);
end;

procedure TfrmMain.EditGameDialog(Sender: TObject);
var
  EditDialog : TfrmGameEditor;
  Item : TListItem;
  Entry : TGameEntry;
begin
  Item := lvGames.Selected;
  if Item = nil then Exit;
  Entry := TGameEntry(Item.Data);

  EditDialog := TfrmGameEditor.Create(Self);
  EditDialog.Game := Entry;
  if EditDialog.ShowModal() = mrOk then
  begin
  end;
end;

procedure TfrmMain.lvGamesDblClick(Sender: TObject);
begin
  if lvGames.Selected = nil then
    Exit;
  EditGameDialog(Sender);
end;

procedure TfrmMain.btnEditClick(Sender: TObject);
begin
  EditGameDialog(Sender);
end;

end.
