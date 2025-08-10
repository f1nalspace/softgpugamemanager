unit gameditform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, gameentry, ComCtrls, Menus;

type
  TfrmGameEditor = class(TForm)
    Label1: TLabel;
    lblExecutable: TLabel;
    GroupBox1: TGroupBox;
    btnCancel: TButton;
    btnOK: TButton;
    Label2: TLabel;
    cbDDraw: TComboBox;
    Label3: TLabel;
    cbD3D8: TComboBox;
    Label4: TLabel;
    cbD3D9: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    lvMesaOptions: TListView;
    lvOpenGlideOptions: TListView;
    popupMenuMesaOptions: TPopupMenu;
    Add1: TMenuItem;
    Edit1: TMenuItem;
    Remove1: TMenuItem;
  private
    { Private-Deklarationen }
    FExecutable : string;
    procedure SetExecutable(AValue : string);
    procedure SetGame(Entry : TGameEntry);
    function GetDDrawOption : string;
    function GetD3D8Option : string;
    function GetD3D9Option : string;
  public
    { Public-Deklarationen }
    constructor Create(AOwner : TComponent); override;
  published
    property Executable : String read FExecutable write SetExecutable;
    property DDrawOption : string read GetDDrawOption;
    property D3D8Option : string read GetD3D8Option;
    property D3D9Option : string read GetD3D9Option;
    property Game : TGameEntry write SetGame;
  end;

var
  frmGameEditor: TfrmGameEditor;

implementation

{$R *.DFM}

uses
  utils;

constructor TfrmGameEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfrmGameEditor.SetExecutable(AValue : string);
begin
  FExecutable := AValue;
  lblExecutable.Caption := AValue;
end;

procedure TfrmGameEditor.SetGame(Entry : TGameEntry);
var
  I : Integer;
  Item : TListItem;
  Option : TGameOption;
begin
  FExecutable := Entry.Executable;
  lblExecutable.Caption := FExecutable;

  cbDDraw.Text := Entry.DDrawOption;
  cbDDraw.ItemIndex := cbDDraw.Items.IndexOf(Entry.DDrawOption);
  cbD3D8.Text := Entry.D3D8Option;
  cbD3D8.ItemIndex := cbD3D8.Items.IndexOf(Entry.D3D8Option);
  cbD3D9.Text := Entry.D3D9Option;
  cbD3D9.ItemIndex := cbD3D9.Items.IndexOf(Entry.D3D9Option);

  lvMesaOptions.Items.BeginUpdate;
  lvMesaOptions.Items.Clear;
  for I := 0 to Entry.MesaOptions.Count-1 do
  begin
    Option := Entry.MesaOptions.Options[i];
    Item := lvMesaOptions.Items.Add;
    Item.Caption := Option.Key;
    Item.SubItems.Add(Option.Value);
  end;
  lvMesaOptions.Items.EndUpdate;

  lvOpenGlideOptions.Items.BeginUpdate;
  lvOpenGlideOptions.Items.Clear;
  for I := 0 to Entry.OpenGlideOptions.Count-1 do
  begin
    Option := Entry.OpenGlideOptions.Options[i];
    Item := lvOpenGlideOptions.Items.Add;
    Item.Caption := Option.Key;
    Item.SubItems.Add(Option.Value);
  end;
  lvOpenGlideOptions.Items.EndUpdate;
end;

function TfrmGameEditor.GetDDrawOption : string;
begin
  Result := cbDDraw.Text;
end;

function TfrmGameEditor.GetD3D8Option : string;
begin
  Result := cbD3D8.Text;
end;

function TfrmGameEditor.GetD3D9Option : string;
begin
  Result := cbD3D9.Text;
end;

end.
