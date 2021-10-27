unit uHelper.Services;

interface

uses  System.JSON, System.Classes, FireDAC.Comp.Client,
  System.Generics.Collections;

type
  TPaginarQuery = class helper for TFDQuery
    function paginar(limit, NumPagina : integer) : Boolean;
  end;

  TParamsList = class helper for TStrings
    function FindParam(const param : array of string): TDictionary<string,integer>;
  end;

  THelperServicesAgenda = class helper for TJSONObject
    procedure MontarRetornoJson(metodo, msg: string);
    procedure InfoPaginacaoJson(QtdRegistros,Pagina_Atual,TotalPagina: integer; ConsultaPaginada: boolean);
  end;

implementation

{ THelperServicesAgenda }
uses uLogPadrao, System.SysUtils;

procedure THelperServicesAgenda.InfoPaginacaoJson(QtdRegistros, Pagina_Atual, TotalPagina: integer; ConsultaPaginada: boolean);
begin
  self.AddPair('qtdRegistros', TJSONNumber.Create(QtdRegistros));
  self.AddPair('pagina_Atual',TJSONNumber.Create(Pagina_Atual));
  self.AddPair('consultaPaginada',TJSONBool.Create(ConsultaPaginada));
  self.AddPair('totalPagina',TJSONNumber.Create(TotalPagina));
end;

procedure THelperServicesAgenda.MontarRetornoJson(metodo, msg: string);
var log: Ilog;
begin
  log := Tlog.Create;
  if Assigned(Self) then
  begin
    Self.AddPair('method', metodo);

    if not msg.Trim.IsEmpty then
      Self.AddPair('message', msg);

    log.addLog( 'method: '+ metodo + '; message: ' + msg  );
  end;
end;

{ TParamsList }

function TParamsList.FindParam(const param : array of string):  TDictionary<string,integer>;
var i,p: integer;
begin
  //Liberar o result da memoria, no metodo de consumo da function
  Result :=  TDictionary<string,integer>.Create;
  for i := 0 to pred(self.Count) do
  begin
    for p := 0 to High(param) do
    begin
      if copy(self[i],0,pos('=',self[i])-1) = param[p] then
      begin
        Result.Add(param[p], copy(self[i],pos('=',self[i])+1).ToInteger) ;
        Continue;
      end;
    end;
  end;
end;

{ TPaginarQuery }

function TPaginarQuery.paginar(limit, NumPagina: integer): boolean;
var Ioffset : integer;
begin
  result := false;

  if limit <=0 then
    exit;

  if NumPagina < 0 then
    Exit;

  if limit > 1000 then
    limit := 1000;

  Ioffset := limit * NumPagina;

  self.Close;
  self.ParamByName('limit').AsInteger   := limit;
  self.ParamByName('offset').AsInteger  := Ioffset;

  result := true;
end;

end.
