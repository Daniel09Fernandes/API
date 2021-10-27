unit UServices.Empresas;

{Daniel Fernandes:  Não instaciar com create() esta classe, utilizar a factory NewInstace
por convesão de uso generico executeGetRequest(arrayParams), nesta classe fica com os valores ?
  arrayParams[0] = AId_Empresa
  arrayParams[1] = ANomeFantasia
  arrayParams[2] = ACNPJ
}

interface

uses
  System.JSON, DataSet.Serialize, uHelper.Services, UServices.Interf,
  DBXPlatform, UModel.Empresas, System.Generics.Collections;

type
  TServicesEmpresas = class(TInterfacedObject, IServices<TModelEmpresas>)
  private
    procedure PaginarConsulta(var TModel: TModelEmpresas);
  public

    function executeGetRequest(arrayParams : array of string): TjsonObject;
    function executePutRequest(AParams: TjsonObject = nil): TjsonObject;
    function executePostRequest(AParams: TjsonObject = nil): TjsonObject;
    function executeDeleteRequest(AID: string): TjsonObject;

    function NewInstance: IServices<TModelEmpresas>;
  end;

implementation

uses
  System.SysUtils;

{ TServicesEmpresas }

function TServicesEmpresas.executeDeleteRequest(AID: string): TjsonObject;
var ModelEmpresas : TModelEmpresas;
    data              : TJSONArray;
begin
  ModelEmpresas := TModelEmpresas.Create;
  Result := TJSONObject.Create;
  try
    begin
      try
        if not AID.Trim.IsEmpty then
        begin
          ModelEmpresas.ID_Matriz := AID.ToInteger;

          if ModelEmpresas.deleteRegistros then
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
    FreeAndNil(ModelEmpresas);
  end;
end;

function TServicesEmpresas.executeGetRequest(arrayParams : array of string): TjsonObject;
var ModelEmpresas : TModelEmpresas;
    JsonOBJ       : TJSONObject;
    data          : TJSONArray;
    PairName      : String;
begin
   ModelEmpresas := TModelEmpresas.Create;
   try
     begin
       try

         if not arrayParams[0].Trim.IsEmpty then
           ModelEmpresas.ID_Matriz := arrayParams[0].ToInteger;

         if not arrayParams[1].Trim.IsEmpty then
           ModelEmpresas.NOME_FANTASIA := arrayParams[1];

         if not arrayParams[2].Trim.IsEmpty then
           ModelEmpresas.CNPJ := arrayParams[2];

         PaginarConsulta(ModelEmpresas);

         Result  := TjsonObject.Create;
         JsonOBJ := TjsonObject.Create;

         data    :=  ModelEmpresas.getRegistros.ToJSONArray;

         Result.MontarRetornoJson('Get_Empresas','Busca realizada com sucesso.');
         Result.InfoPaginacaoJson(ModelEmpresas.qtdReg, ModelEmpresas.NumPagina,ModelEmpresas.TotalPaginas, ModelEmpresas.paginado);
         Result.AddPair('data', data);
       except
         on E: Exception do
           Result.MontarRetornoJson('Get_Empresas', E.Message);
       end;
     end;
   finally
     FreeAndNil(ModelEmpresas);
   end;
 end;


function TServicesEmpresas.executePostRequest(AParams: TjsonObject): TjsonObject;
var ModelEmpresas : TModelEmpresas;
    data              : TJSONArray;
begin
  ModelEmpresas := TModelEmpresas.Create;
  Result := TJSONObject.Create;
  try
    begin
      try
        if AParams.Count > 0 then
        begin

          if ModelEmpresas.PostRegistros(AParams) then
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
    FreeAndNil(ModelEmpresas);
  end;
end;

function TServicesEmpresas.executePutRequest(AParams: TjsonObject): TjsonObject;
var ModelEmpresas : TModelEmpresas;
    data              : TJSONArray;
    JSvalue           : TJSONValue;
begin
  ModelEmpresas := TModelEmpresas.Create;
  Result := TjsonObject.Create;
  try
    begin
      try
      if AParams.TryGetValue('ID_empresa', JSvalue) then
        begin
          ModelEmpresas.ID_Matriz := JSvalue.Value.ToInteger;
          if ModelEmpresas.putRegistros(AParams) then
            Result.MontarRetornoJson('Put_Empresas', 'Atualização realizada com sucesso.');
        end
        else
          Result.MontarRetornoJson('Put_Empresas', 'Não encontrado os parametros para Atualização.');
      except
        on E: Exception do
          Result.MontarRetornoJson('Put_Empresas', E.Message)
      end;
    end;
  finally
    FreeAndNil(ModelEmpresas);
  end;
end;

function TServicesEmpresas.NewInstance: IServices<TModelEmpresas>;
begin
  if not Assigned(Result) then
    Result :=  TServicesEmpresas.Create;
end;

procedure TServicesEmpresas.PaginarConsulta(var TModel: TModelEmpresas);
var paramsList : TDictionary<string,Integer>;
    value: integer;
begin
  if GetInvocationMetadata().QueryParams.Count > 0 then
  begin
    paramsList := GetInvocationMetadata.QueryParams.findParam(['limit', 'NumPagina']);

    if paramsList.TryGetValue('limit', value) then
      TModel.limit := value;

    if paramsList.TryGetValue('NumPagina', value) then
      TModel.NumPagina := value;

    FreeAndNil(paramsList);
  end;
end;

end.
