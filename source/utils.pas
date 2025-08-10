unit utils;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus;

function ContainsGameInRegistry(Executable: string) : Boolean;
function AddGameToRegistry(Executable : string) : string;
function RemoveGameFromRegistry(Executable : string) : Boolean;
function BuildTextFromValues(const BaseKey, Executable, SubName : string) : string;

implementation

uses
  Registry, constants;

function ContainsGameInRegistry(Executable: string) : Boolean;
var
  r : TRegistry;
begin
  Result := False;
  r := TRegistry.Create(KEY_READ);
  r.RootKey := HKEY_LOCAL_MACHINE;
  if r.OpenKey(vmdisp9xBaseKey, False) then
  begin
    Result := r.KeyExists( Executable);
    r.CloseKey;
  end;
  r.Free;
end;

function AddGameToRegistry(Executable : string) : string;
var
  r : TRegistry;
begin
  Result := '';
  r := TRegistry.Create(KEY_READ);
  r.RootKey := HKEY_LOCAL_MACHINE;
  if r.OpenKey(vmdisp9xBaseKey, true) then
  begin
    r.CreateKey(Executable);
    Result := IncludeTrailingBackslash(vmdisp9xBaseKey) + Executable;
  end;
  r.Free;
end;

function RemoveGameFromRegistry(Executable : string) : Boolean;
var
  r : TRegistry;
begin
  Result := False;
  r := TRegistry.Create(KEY_ALL_ACCESS);
  r.RootKey := HKEY_LOCAL_MACHINE;
  if r.OpenKey(vmdisp9xBaseKey, False) then
  begin
    if r.KeyExists(Executable) then
    begin
      r.DeleteKey('Executable');
      Result := True;
    end;
    r.CloseKey;
  end;
  r.Free;
end;

function BuildTextFromValues(const BaseKey, Executable, SubName : string) : string;
var
  r : TRegistry;
  Path, ValueName : string;
  Lst : TStrings;
  I : Integer;
begin
  SetLength(Result, 0);
  Path := IncludeTrailingBackslash(baseKey) + IncludeTrailingBackslash(executable) + SubName;
  r := TRegistry.Create(KEY_READ);
  r.RootKey := HKEY_LOCAL_MACHINE;
  if r.OpenKey(Path, false) then
  begin
    Lst := TStringList.Create;
    try
      r.GetValueNames(Lst);
      for I := 0 to Lst.Count - 1 do
      begin
        ValueName := Lst[I];
        if Length(Result) > 0 then
          Result := Result + ', ';
        Result := Result + ValueName;
      end;
    finally
      Lst.Free;
    end;
    r.CloseKey();
  end;
  r.Free;
end;

end.
