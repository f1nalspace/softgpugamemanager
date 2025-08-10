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
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(AKey, AValue : string);
    function IndexOf(AKey : string) : Integer;
    function Remove(AKey : string) : Boolean;
    function Contains(AKey : string) : Boolean;
  published
    property Count : Integer read FCount;
  end;

  TGameEntry = class
  private
    FExecutable : string;
    FMesaOptions : TGameOptions;
    FOpenGlideOptions : TGameOptions;
    FDDrawOption : string;
    FD3D8Option : string;
    FD3D9Option : string;
  public
    constructor Create(AExecutable : string; ADDrawOption : string = ''; AD3D8Option : string = ''; AD3D9Option : string = '');
    destructor Destroy; override;
  published
    property Executable : string read FExecutable;
    property DDrawOption : string read FDDrawOption write FDDrawOption;
    property D3D8Option : string read FD3D8Option write FD3D8Option;
    property D3D9Option : string read FD3D9Option write FD3D9Option;
    property MesaOptions : TGameOptions read FMesaOptions;
    property OpenGlideOptions : TGameOptions read FOpenGlideOptions;
  end;

implementation

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

constructor TGameEntry.Create(AExecutable : string; ADDrawOption : string = ''; AD3D8Option : string = ''; AD3D9Option : string = '');
begin
  inherited Create;
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

end.
