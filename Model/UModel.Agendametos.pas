//Não destruir a controller de login, elá e instaciada e destruida pela webModule, e  guarda o ID da empresa Durante a sessão
unit UModel.Agendametos;

interface

uses UDAO.Agendamentos, Datasnap.DBClient, System.Classes, System.JSON,
  FireDAC.Comp.Client,UModel.Agenda;

type

  TModelAgendamentos = class(TmodelAgenda)
  private
    FDaoAgendamentos: TDtmAgendamentos;
    FID_Agenda: integer;
    FID_Cliente: integer;
    FDataIni: TDate;
    FDataFim: TDate;

    procedure DefinirTipoDaBusca(qry: TFDQuery);
  public
    constructor Create;
    destructor Destroy;

    function getRegistros: TClientDataSet;
    function postRegistros(Aparam: TJsonObject): boolean;
    function deleteRegistros: boolean;
    function putRegistros(Aparam: TJsonObject): boolean;

    //Filtros
    property ID_Agenda: integer read FID_Agenda write FID_Agenda;// Passar zero para não procurar
    property ID_Cliente: integer read FID_Cliente write FID_Cliente;// Passar zero para não procurar
    property DataIni: TDate read FDataIni write FDataIni;
    property DataFim: TDate read FDataFim write FDataFim;

  end;

implementation

uses
  System.SysUtils, Data.DB, UHelper.Services, Controller.Token;

{ TModelAgendamentos }

constructor TModelAgendamentos.Create;
begin
  Inherited;
  if not Assigned(FDaoAgendamentos) then
  begin
    FDaoAgendamentos := TDtmAgendamentos.Create(nil);
  end;
end;

function TModelAgendamentos.deleteRegistros: boolean;
begin
  FDaoAgendamentos.QryAgendamentos.Close;
  Result := false;
  try
    try
      DefinirTipoDaBusca(FDaoAgendamentos.QryAgendamentos);
      FDaoAgendamentos.cdsAgendamentos.Open;
      FDaoAgendamentos.cdsAgendamentos.Delete;
      FDaoAgendamentos.cdsAgendamentos.ApplyUpdates(0);
      Result := true;
    Except
      on E: Exception do
        raise Exception.Create('Erro ao deletar: ' + E.Message);
    end;
  finally
    FDaoAgendamentos.cdsAgendamentos.Close;
  end;
end;

destructor TModelAgendamentos.Destroy;
begin
  if Assigned(FDaoAgendamentos) then
    FreeAndNil(FDaoAgendamentos);
end;

procedure TModelAgendamentos.DefinirTipoDaBusca(qry: TFDQuery);
begin

  qry.ParamByName('ID_EMPRESA').AsInteger := ControllerToken.user_ID.ToInteger; //Sempre passar o ID da empresa
  if ID_Agenda > 0 then
  begin
    FDaoAgendamentos.tipoWhere := [twID];
    FDaoAgendamentos.montarWhere(qry);

    qry.ParamByName('ID_AGENDA').AsInteger := ID_Agenda;
    exit;
  end;

  if (ID_Cliente > 0) and (DataIni > 0) then
  begin
    FDaoAgendamentos.tipoWhere :=  [twPeriodo , twCliente];
    FDaoAgendamentos.montarWhere(qry);

    qry.ParamByName('ID_CLIENTE').AsInteger := ID_Cliente;
    qry.ParamByName('Data_inicio').AsDate   := DataIni;
    qry.ParamByName('Data_fim').AsDate      := DataFim;
    exit;
  end;

  if ID_Cliente > 0 then
  begin
    FDaoAgendamentos.tipoWhere := [twCliente];
    FDaoAgendamentos.montarWhere(qry);

    qry.ParamByName('ID_CLIENTE').AsInteger := ID_Cliente;
    exit;
  end;

   if (DataIni > 0) then
  begin
    FDaoAgendamentos.tipoWhere := [twPeriodo];
    FDaoAgendamentos.montarWhere(qry);

    qry.ParamByName('Data_inicio').AsDate   := DataIni;
    qry.ParamByName('Data_fim').AsDate      := DataFim;
  end;
end;


function TModelAgendamentos.getRegistros: TClientDataSet;
begin
  FDaoAgendamentos.QryAgendamentos.Close;
  try
    try
      DefinirTipoDaBusca(FDaoAgendamentos.QryAgendamentos);
      DefinirTipoDaBusca(FDaoAgendamentos.qryAgendamentosCount);

      if (countRegistro(FDaoAgendamentos.qryAgendamentosCount, 'ID_AGENDA',ID_Agenda) > 1000) or (limit > 0) then
        paginado := FDaoAgendamentos.QryAgendamentos.paginar(limit, NumPagina);

      FDaoAgendamentos.cdsAgendamentos.Open;

      Result := FDaoAgendamentos.cdsAgendamentos;
    except
      on E: Exception do
        raise Exception.Create('Erro ao buscar registros: '+ E.Message);
    end;
  finally
    FDaoAgendamentos.QryAgendamentos.Close;
  end;
end;

function TModelAgendamentos.putRegistros(Aparam: TJsonObject): boolean;
var
  i: integer;
  JsValue: TJSONValue;
begin
  Result := false;
  FDaoAgendamentos.QryAgendamentos.Close;
  try
    DefinirTipoDaBusca(FDaoAgendamentos.QryAgendamentos);
    FDaoAgendamentos.cdsAgendamentos.Open;

    try
    FDaoAgendamentos.cdsAgendamentos.Edit;
      for i := 0 to Aparam.Count do
      begin
        if Aparam.TryGetValue(FDaoAgendamentos.cdsAgendamentos.Fields[i].FieldName, JsValue) then
          FDaoAgendamentos.cdsAgendamentos.Fields[i].Value := JsValue.Value;
      end;
      FDaoAgendamentos.cdsAgendamentos.post;
    Except
      on E: Exception  do
        raise Exception.Create('Erro ao atualizar: '+ E.Message);
    end;

    FDaoAgendamentos.cdsAgendamentos.ApplyUpdates(0);
    Result := true;
  finally
    FDaoAgendamentos.cdsAgendamentos.Close;
  end;
end;

function TModelAgendamentos.postRegistros(Aparam: TJsonObject): boolean;
var
  i: integer;
  JsValue: TJSONValue;
begin
  Result := false;
  if FDaoAgendamentos.cdsAgendamentos.State = dsInactive then
  begin
    FDaoAgendamentos.cdsAgendamentos.PacketRecords := 1;
    FDaoAgendamentos.IDEmpresa := ControllerToken.user_ID.ToInteger;
    // para não carregar todos os registros na inclusão
    FDaoAgendamentos.cdsAgendamentos.Open;
  end;

  try
    try
      FDaoAgendamentos.cdsAgendamentos.Append;
      FDaoAgendamentos.inInsert := true;

      for i := 0 to Aparam.Count do
      begin
        if Aparam.TryGetValue(FDaoAgendamentos.cdsAgendamentos.Fields[i].FieldName, JsValue) then
          FDaoAgendamentos.cdsAgendamentos.Fields[i].Value := JsValue.Value;
      end;

      FDaoAgendamentos.cdsAgendamentos.post;
      FDaoAgendamentos.cdsAgendamentos.ApplyUpdates(0);
      Result := true;
    Except
      on E: Exception do
        raise Exception.Create('Erro ao inserir: ' + E.Message);
    end;
  finally
    FDaoAgendamentos.cdsAgendamentos.Close;
    FDaoAgendamentos.cdsAgendamentos.PacketRecords := -1;
    FDaoAgendamentos.inInsert := false;
  end;
end;

end.
