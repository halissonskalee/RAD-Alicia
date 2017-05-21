unit AL.Rotinas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  System.Actions, FMX.ActnList, FMX.ListBox, FMX.Layouts, FMX.Edit,
  FMX.SearchBox, FMX.DateTimeCtrls, System.Generics.Collections,
  AL.Cliente.Padrao, FMX.TabControl, System.RegularExpressions,
  AL.Componente.TEdit ;

function ValidarCpf(Value: string): boolean;
function RemoverNumeros (Value:String): String;

implementation

uses AL.Helper.Edit;

function ValidarCpf(Value: string): boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9: integer;
  d1, d2: integer;
  digitado, calculado, Temp: string;
begin
  Result := True;

  Temp := RemoverNumeros(Value);

  if Temp.IsEmpty then
    Exit;

  Result := False;
  if Temp.Length <> 11 then
    Exit;


  n1 := StrToInt(Temp[1]);
  n2 := StrToInt(Temp[2]);
  n3 := StrToInt(Temp[3]);
  n4 := StrToInt(Temp[4]);
  n5 := StrToInt(Temp[5]);
  n6 := StrToInt(Temp[6]);
  n7 := StrToInt(Temp[7]);
  n8 := StrToInt(Temp[8]);
  n9 := StrToInt(Temp[9]);
  d1 := n9 * 2 + n8 * 3 + n7 * 4 + n6 * 5 + n5 * 6 + n4 * 7 + n3 * 8 + n2 *
    9 + n1 * 10;
  d1 := 11 - (d1 mod 11);
  if d1 >= 10 then
    d1 := 0;
  d2 := d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3 * 9 +
    n2 * 10 + n1 * 11;
  d2 := 11 - (d2 mod 11);
  if d2 >= 10 then
    d2 := 0;
  calculado := inttostr(d1) + inttostr(d2);
  digitado := Temp[10] + Temp[11];
  if calculado = digitado then
    Result := true

end;


function RemoverNumeros (Value:String): String;
Var
   I: Integer;
begin
  Result := '';
  for I := 1 to Length(Value) do
    if Value[I] in ['0'..'9'] then
      Result := Result + Value[I];




{

function TForm2.Decript (str: string): string;
Var
  LChar_Str: Char;
  idx      : Integer;
begin
  result := '';
  for LChar_Str in str do
  begin
     idx := letras.IndexOf(LChar_Str);
     Inc(idx, 3);
     if idx > (Letras.Length - 1)  then
        idx :=  idx - Letras.Length;
     result := result + Letras.Chars[idx];
  end;
end;

function TForm2.encript (str: string): string;
Var
  LChar_Str: Char;
  idx : Integer;
begin
  result := '';
  for LChar_Str in str do
  begin
     idx := letras.IndexOf(LChar_Str);
     Dec(idx, 3);
     if idx < 0  then
        idx := idx + Letras.Length;
     result := result + Letras.Chars[idx];
  end;
end;﻿^}





end;


end.
