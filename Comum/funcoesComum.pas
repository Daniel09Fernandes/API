unit funcoesComum;

interface

uses
  System.SysUtils, System.Types, System.UITypes,math,
  System.Variants, System.Math.Vectors, System.JSON, System.DateUtils;

function Crypt(Action, Src: string): string;
function isAnoBisexto(ano: TDate): Boolean;
function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
function retornaMsgJson(par, valor: string): TJSONObject;
function getAppName(RetornaExtencaoOriginal: Boolean = false; AlterarExtencao: string = ''; ApenasOCaminho: Boolean = false; ApenasONome : boolean = false): string;
function JsonDateToDate(jsonDate : string) : TDate;
function removeMascara(arrayCaractersMascara : array of string; value: string): string;

implementation

uses
  System.Classes;

function Crypt(Action, Src: string): string;
var
  KeyLen: Integer;
  KeyPos: Integer;
  OffSet: Integer;
  Dest, Key: string;
  SrcPos: Integer;
  SrcAsc: Integer;
  TmpSrcAsc: Integer;
  Range: Integer;
begin
  if (Src = '') then
  begin
    Result := '';
    Exit
  end;
  Key := 'YUQL23KL23DF90WI5E1JAS467NMCXXL6JAOAUWWMCL0AOMM4A4VZYW9KHJUI2347EJHJKDF3424SKL K3LAKDJSL9RTIKJ';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  SrcPos := 0;
  SrcAsc := 0;
  Range := 256;
  if (Action = UpperCase('C')) then
  begin
    Randomize;
    OffSet := Random(Range);
    Dest := Format('%1.2x', [OffSet]);
    for SrcPos := 1 to Length(Src) do
    begin
      // Application.ProcessMessages;
      SrcAsc := (Ord(Src[SrcPos]) + OffSet) mod 255;
      if KeyPos < KeyLen then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      SrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x', [SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  else if (Action = UpperCase('D')) then
  begin
    OffSet := StrToInt('$' + copy(Src, 1, 2));
    SrcPos := 3;
    repeat
      SrcAsc := StrToInt('$' + copy(Src, SrcPos, 2));
      if (KeyPos < KeyLen) then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= OffSet then
        TmpSrcAsc := 255 + TmpSrcAsc - OffSet
      else
        TmpSrcAsc := TmpSrcAsc - OffSet;
      Dest := Dest + Chr(TmpSrcAsc);
      OffSet := SrcAsc;
      SrcPos := SrcPos + 2;
    until (SrcPos >= Length(Src));
  end;
  Result := Dest;
end;

function isAnoBisexto(ano: TDate): Boolean;
begin
  Result := IsLeapYear(DateTimeToFileDate(ano));
end;

function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
begin
  if Expressao then
    Result := ParteTRUE
  else
    Result := ParteFALSE;
end;

function retornaMsgJson(par, valor: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair(par, valor);
end;

function getAppName(RetornaExtencaoOriginal: Boolean = false; AlterarExtencao: string = ''; ApenasOCaminho: Boolean = false; ApenasONome : boolean = false): string;
var
  i: Integer;
  filename: string;
begin
  filename := ParamStr(0);

  if (not ApenasOCaminho) and (not ApenasONome) then
  begin
    if (not RetornaExtencaoOriginal) or (not AlterarExtencao.trim.isEmpty) then
      filename := copy(filename, 0, Length(filename) - ifthen((AlterarExtencao.trim.isEmpty),4,3)) + AlterarExtencao  //Retorna o nome e pode mudar a extenção
    else
      filename := filename;  //Retorna o caminho com a extenção
  end
  else
  begin
    for i := Length(filename) downto 0 do
    begin
      if filename[i] = '\' then
      begin
        if ApenasOCaminho then
        begin
          filename := copy(filename, 0, i);
          break;
        end;

        filename := copy(filename, i);
        if ApenasONome then
          filename := copy(filename, 2, Length(filename)-5);

        break;
      end;
    end;
  end;
  Result := filename; // Apenas o caminho  ou apenas o nome

end;

function JsonDateToDate(jsonDate : string) : TDate;
var ano, mes, dia, data : string;
begin
  ano := copy(jsonDate,0,4);
  mes := copy(jsonDate,6,2);
  dia := copy(jsonDate,9);

  if ano.trim.isEmpty then
    exit(0);

  data :=dia+'/'+mes+'/'+ano;

  if not (Length(data) = 10) then
    exit(0);

  Result := StrToDate(data);
end;

function removeMascara(arrayCaractersMascara : array of string; value: string): string;
var i:integer;
begin
  for I := 0 to High(arrayCaractersMascara) do
    value := StringReplace(value,arrayCaractersMascara[i],'',[rfReplaceAll]);

  result := value;
end;

end.
