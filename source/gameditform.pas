unit gameditform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, gameentry;

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
  private
    { Private-Deklarationen }
    FExecutable : string;
    procedure SetExecutable(AValue : string);
    procedure SetGame(Entry : TGameEntry);
  public
    { Public-Deklarationen }
    constructor Create(AOwner : TComponent); override;
  published
    property Executable : String read FExecutable write SetExecutable;
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
begin
  FExecutable := Entry.Executable;
  lblExecutable.Caption := FExecutable;
  cbDDraw.Text := Entry.DDrawOption;
  cbDDraw.ItemIndex := cbDDraw.Items.IndexOf(Entry.DDrawOption);
  cbD3D8.Text := Entry.D3D8Option;
  cbD3D8.ItemIndex := cbD3D8.Items.IndexOf(Entry.D3D8Option);
  cbD3D9.Text := Entry.D3D9Option;
  cbD3D9.ItemIndex := cbD3D9.Items.IndexOf(Entry.D3D9Option);
end;

end.
