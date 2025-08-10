unit gameentry;

interface

uses
  Classes;

type
  TGameOption = record
    Key, Value : string;
  end;

  TGameOptions = class
  private
    FOptions : array of TGameOption;
    FCount, FCapacity : Integer;
    procedure ResizeIfNeeded;
    function GetOption(AIndex : Integer) : TGameOption;
    function BuildDisplayName : string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(AKey, AValue : string);
    function IndexOf(AKey : string) : Integer;
    function Remove(AKey : string) : Boolean;
    function Contains(AKey : string) : Boolean;
    property Options[Index : Integer] : TGameOption read GetOption;
  published
    property Count : Integer read FCount;
    property DisplayName : string read BuildDisplayName;
  end;

  TGameEntry = class
  private
    FRegKey : string;
    FExecutable : string;
    FMesaOptions : TGameOptions;
    FOpenGlideOptions : TGameOptions;
    FDDrawOption : string;
    FD3D8Option : string;
    FD3D9Option : string;
  public
    constructor Create(ARegKey, AExecutable : string; ADDrawOption : string = ''; AD3D8Option : string = ''; AD3D9Option : string = '');
    destructor Destroy; override;
    procedure ReadFromRegistry;
  published
    property Executable : string read FExecutable;
    property DDrawOption : string read FDDrawOption write FDDrawOption;
    property D3D8Option : string read FD3D8Option write FD3D8Option;
    property D3D9Option : string read FD3D9Option write FD3D9Option;
    property MesaOptions : TGameOptions read FMesaOptions;
    property OpenGlideOptions : TGameOptions read FOpenGlideOptions;
  end;

implementation

uses
  Registry, Windows, SysUtils;

constructor TGameOptions.Create;
begin
  inherited;
  FCount := 0;
  FCapacity := 2;
  SetLength(FOptions, FCapacity);
end;

destructor TGameOptions.Destroy;
begin
  SetLength(FOptions, 0);
  FCount := 0;
  FCapacity := 0;
  inherited;
end;

procedure TGameOptions.ResizeIfNeeded;
var
  NewCapacity : Integer;
begin
  if FCount = FCapacity then
  begin
    Assert(FCapacity > 1);
    NewCapacity := FCapacity * 2;
    SetLength(FOptions, NewCapacity);
    FCapacity := NewCapacity;
  end;
end;

procedure TGameOptions.Clear;
begin
  SetLength(FOptions, 0);
  FCapacity := 2;
  FCount := 0;
  SetLength(FOptions, FCapacity);
end;

procedure TGameOptions.Add(AKey, AValue : string);
var
  R : TGameOption;
begin
  ResizeIfNeeded;
  Assert(FCount < FCapacity);
  R.Key := AKey;
  R.Value := AValue;
  FOptions[FCount] := R;
  Inc(FCount);
end;

function TGameOptions.IndexOf(AKey : string) : Integer;
var I : Integer;
begin
  Result := -1;
  For I := 0 to FCount-1 do
  begin
    if FOptions[i].Key = AKey then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

function TGameOptions.Contains(AKey : string) : Boolean;
begin
  Result := IndexOf(AKey) <> -1;
end;

function TGameOptions.Remove(AKey : string) : Boolean;
var
  I, J, Index, OldCount : Integer;
  OldItems : array of TGameOption;
begin
  Index := IndexOf(AKey);
  if Index = -1 then
  begin
    Result := False;
    Exit;
  end;

  OldCount := FCount;

  Assert(OldCount > 0);

  SetLength(OldItems, OldCount);
  for I := 0 to OldCount-1 do
    OldItems[i] := FOptions[i];

  Dec(FCount);
  SetLength(FOptions, FCount);
  J := 0;
  for I := 0 to OldCount-1 do
  begin
    if I = Index then
      Continue;
    FOptions[J] := FOptions[I];
    Inc(J);
  end;

  Result := True;
end;

function TGameOptions.GetOption(AIndex : Integer) : TGameOption;
begin
  Result := FOptions[AIndex];
end;

function TGameOptions.BuildDisplayName : string;
var
  I : Integer;
begin
  Result := '';
  For I := 0 to FCount-1 do
  begin
    if I > 0 then
      Result := ', ';
    Result := Result + FOptions[I].Key;
  end;
end;

constructor TGameEntry.Create(ARegKey, AExecutable : string; ADDrawOption : string = ''; AD3D8Option : string = ''; AD3D9Option : string = '');
begin
  inherited Create;
  FRegKey := ARegKey;
  FExecutable := AExecutable;
  FMesaOptions := TGameOptions.Create;
  FOpenGlideOptions := TGameOptions.Create;
  FDDrawOption := ADDrawOption;
  FD3D8Option := AD3D8Option;
  FD3D9Option := AD3D9Option;
end;

destructor TGameEntry.Destroy;
begin
  FOpenGlideOptions.Free;
  FMesaOptions.Free;
  inherited;
end;

procedure TGameEntry.ReadFromRegistry;

  procedure ReadOptions(ASubName : string; var AOptions : TGameOptions);
  var
    r : TRegistry;
    Lst : TStrings;
    I : Integer;
    Key, Value : string;
  begin
    r := TRegistry.Create(KEY_READ);
    r.RootKey := HKEY_LOCAL_MACHINE;
    if r.OpenKeyReadOnly(IncludeTrailingBackslash(FRegKey) + ASubName) then
    begin
      Lst := TStringList.Create;
      try
        r.GetValueNames(Lst);
        for I := 0 to Lst.Count -1 do
        begin
          Key := Lst[i];
          Value := r.ReadString(Key);
          AOptions.Add(Key, Value);
        end;
      finally
        Lst.Free;
      end;
      r.CloseKey;
    end;
    r.Free;
  end;

var
  r : TRegistry;
begin
  Assert(Length(FRegKey) > 0);
  r := TRegistry.Create(KEY_READ);
  r.RootKey := HKEY_LOCAL_MACHINE;
  if r.OpenKeyReadOnly(FRegKey) then
  begin
    FDDrawOption := r.ReadString('ddraw');
    FD3D8Option := r.ReadString('d3d8');
    FD3D9Option := r.ReadString('d3d9');
    r.CloseKey;

    FMesaOptions.Clear;
    ReadOptions('mesa', FMesaOptions);

    FOpenGlideOptions.Clear;
    ReadOptions('openglide', FOpenGlideOptions);
  end;
  r.Free;
end;

end.
