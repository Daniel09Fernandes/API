unit UServices.Agendamentos;
{Daniel Fernandes:  Não instaciar com create() esta classe, utilizar a factory NewInstace
por convesão de uso generico executeGetRequest arrayParams nesta classe fica com os valores ?
  arrayParams[0] = id_agenda
  arrayParams[1] = id_cliente
  arrayParams[2] = dataInicio
  arrayParams[3] = datafim
}


interface

uses
  System.JSON, DataSet.Serialize, uHelper.Services, UServices.Interf,
  DBXPlatform, UModel.Agendametos, System.Generics.Collections;

type
  TServicesAgendamentos = class(TInterfacedObject,IServices<TModelAgendamentos>)
  private
    procedure PaginarConsulta(var TModel: TModelAgendamentos);
  public
    function executeGetRequest(arrayParams : array of string): TjsonObject;
    function executePutRequest(AParams: TjsonObject = nil): TjsonObject;
    function executePostRequest(AParams: TjsonObject = nil): TjsonObject;
    function executeDeleteRequest(id_Agenda: string): TjsonObject;

    function NewInstance: IServices<TModelAgendamentos>;
  end;

implementation

{ TServicesAgendamentos }

uses   System.Classes, System.SysUtils,funcoesComum;


function TServicesAgendamentos.executeDeleteRequest(id_Agenda : string): TjsonObject;
var ModelAgendamentos : TModelAgendamentos;
    data              : TJSONArray;
begin
  ModelAgendamentos := TModelAgendamentos.Create;
  Result := TJSONObject.Create;
  try
    begin
      try
        if not id_Agenda.Trim.IsEmpty then
        begin
          ModelAgendamentos.ID_Agenda := id_Agenda.ToInteger;

          if ModelAgendamentos.deleteRegistros then
            Result.MontarRetornoJson('Delete_Agendamentos', 'Exclusao realizada com sucesso.');
        end
        else
           Result.MontarRetornoJson('Delete_Agendamentos', 'Não encontrado os parametros para inclusão.');
      except
        on E: Exception do
          Result.MontarRetornoJson('Delete_Agendamentos',E.Message );
      end;
    end;
  finally
    FreeAndNil(ModelAgendamentos);
  end;
end;

function TServicesAgendamentos.executeGetRequest(arrayParams : array of string): TjsonObject;
var ModelAgendamentos : TModelAgendamentos;
    data              : TJSONArray;
begin
  ModelAgendamentos := TModelAgendamentos.Create;
  try
    begin
      try
        if not arrayParams[0].Trim.IsEmpty then
          ModelAgendamentos.ID_Agenda := arrayParams[0].ToInteger;

        if not arrayParams[1].Trim.IsEmpty then
          ModelAgendamentos.ID_Cliente := arrayParams[1].ToInteger;

        if not arrayParams[2].Trim.IsEmpty then
          ModelAgendamentos.DataIni := JsonDateToDate(arrayParams[2]);

        if not arrayParams[3].Trim.IsEmpty then
          ModelAgendamentos.DataFim := JsonDateToDate(arrayParams[3]);

        PaginarConsulta(ModelAgendamentos);

        data := ModelAgendamentos.getRegistros.ToJSONArray;
        Result := TJSONObject.Create;

         Result.MontarRetornoJson('Get_Agendamentos', 'Busca realizada com sucesso.');
         Result.InfoPaginacaoJson(ModelAgendamentos.qtdReg,ModelAgendamentos.NumPagina,ModelAgendamentos.TotalPaginas,ModelAgendamentos.paginado);
         Result.AddPair('data', data);
      except
        on E:Exception do
          Result.MontarRetornoJson('Get_Agendamentos', E.Message);
      end;
    end;
  finally
    FreeAndNil(ModelAgendamentos);
  end;
end;

function TServicesAgendamentos.executePutRequest(AParams: TJSONObject): TjsonObject;
var ModelAgendamentos : TModelAgendamentos;
    data              : TJSONArray;
    JSvalue           : TJSONValue;
begin
  ModelAgendamentos := TModelAgendamentos.Create;
  Result := TjsonObject.Create;
  try
    begin
      try
        if AParams.TryGetValue('ID_AGENDA', JSvalue) then
        begin
          ModelAgendamentos.ID_Agenda := JSvalue.Value.ToInteger;

          if ModelAgendamentos.putRegistros(AParams) then
            Result.MontarRetornoJson('Put_Agendamentos', 'Atualização realizada com sucesso.');
        end
        else
          Result.MontarRetornoJson('Put_Agendamentos', 'Não encontrado os parametros para Atualização.');
      except
        on E: Exception do
          Result.MontarRetornoJson('Put_Agendamentos', E.Message)
      end;
    end;
  finally
    FreeAndNil(ModelAgendamentos);
  end;
end;

function TServicesAgendamentos.executePostRequest(AParams: TJSONObject): TjsonObject;
var ModelAgendamentos : TModelAgendamentos;
    data              : TJSONArray;
begin
  ModelAgendamentos := TModelAgendamentos.Create;
  Result := TJSONObject.Create;
  try
    begin
      try
        if AParams.Count > 0 then
        begin

          if ModelAgendamentos.PostRegistros(AParams) then
            Result.MontarRetornoJson('Post_Agendamentos', 'Inclusão realizada com sucesso.');
        end
        else
           Result.MontarRetornoJson('Post_Agendamentos', 'Não encontrado os parametros para inclusão.');
      except
        on E: Exception do
          Result.MontarRetornoJson('Post_Agendamentos', E.Message);
      end;
    end;
  finally
    FreeAndNil(ModelAgendamentos);
  end;
end;

function TServicesAgendamentos.NewInstance: IServices<TModelAgendamentos>;
begin
  if not Assigned(Result) then
    Result :=  TServicesAgendamentos.Create;
end;

procedure TServicesAgendamentos.PaginarConsulta(var TModel: TModelAgendamentos);
var paramsList : TDictionary<string,Integer>;
    value: integer;
begin
  if GetInvocationMetadata().QueryParams.Count > 0 then
  begin
    paramsList := GetInvocationMetadata.QueryParams.findParam(['limit', 'NumPagina']);

    if paramsList.TryGetValue('limit', Value) then
      TModel.limit := Value;

    if paramsList.TryGetValue('NumPagina', Value) then
      TModel.NumPagina := Value;

    FreeAndNil(paramsList);
  end;
end;

end.
