unit UModel.Empresas;

interface

uses UModel.Agenda, UDAO.Empresas, System.Classes, System.JSON,
  Datasnap.DBClient,FireDAC.Comp.Client;

type

  TModelEmpresas = class(TmodelAgenda)
  private
    FDaoEmpresas   : TdtmEmpresas;
    FCNPJ: string;
    FNOME_FANTASIA: string;
    FID_empresa: integer;
    FCarregarFilial: Boolean;

    procedure DefinirTipoDaBusca(qry: TFDQuery);
    function isFilial: boolean;

  public
    constructor Create;
    destructor Destroy;

    function getRegistros(CarregarFiliais : boolean = true): TClientDataSet;
    function putRegistros(Aparam: TJsonObject): boolean;
    function deleteRegistros: boolean;
    function postRegistros(Aparam: TJsonObject): boolean;

    //Filtros
    property CarregarFilial : Boolean   read FCarregarFilial;
    property ID_Matriz      : integer   read FID_empresa         write FID_empresa;
    property NOME_FANTASIA  : string    read FNOME_FANTASIA      write FNOME_FANTASIA;
    property CNPJ           : string    read FCNPJ               write FCNPJ;
  end;

implementation

uses
  UHelper.Services, System.SysUtils, Data.DB, controller.Token;

{ TModelEmpresas }

constructor TModelEmpresas.Create;
begin
  Inherited;
  if not Assigned(FDaoEmpresas) then
  begin
    FDaoEmpresas := TdtmEmpresas.Create(nil);
  end;
end;

destructor TModelEmpresas.Destroy;
begin
  if Assigned(FDaoEmpresas) then
  begin
    FreeAndNil(FDaoEmpresas);
  end;
end;

procedure TModelEmpresas.DefinirTipoDaBusca(qry: TFDQuery);
begin
  if ID_Matriz <= 0 then
    ID_Matriz :=  ControllerToken.user_ID.ToInteger;

  qry.ParamByName('ID_EMPRESA').AsInteger := ID_Matriz;

  if isFilial then
    qry.ParamByName('Matriz_id').AsInteger := ControllerToken.user_ID.ToInteger;

  if not NOME_FANTASIA.Trim.IsEmpty then
  begin
    FDaoEmpresas.tipoWhere :=  [twNomeFantasia];
    FDaoEmpresas.montarWhere(qry);

    qry.ParamByName('Nome_Fant_empresa').AsString  := NOME_FANTASIA;
    exit;
  end;

  if not CNPJ.Trim.IsEmpty then
  begin
    FDaoEmpresas.tipoWhere := [TwCNPJ];
    FDaoEmpresas.montarWhere(qry);

    qry.ParamByName('CNPJ').AsString := CNPJ;
    exit;
  end;
end;

function TModelEmpresas.deleteRegistros: boolean;
begin
  FDaoEmpresas.QryEmpresas.Close;
  Result := false;
  try
    try
      FDaoEmpresas.QryEmpresas.Close;

      DefinirTipoDaBusca(FDaoEmpresas.QryEmpresas);
      FDaoEmpresas.CDSEmpresas.Open;
      FDaoEmpresas.CDSEmpresas.Delete;
      FDaoEmpresas.CDSEmpresas.ApplyUpdates(0);
      Result := true;
    except
      on E: Exception do
        raise Exception.Create('Error ao deleter: ' + E.Message);
    end;
  finally
    FDaoEmpresas.CDSEmpresas.Close;
  end;
end;

function TModelEmpresas.getRegistros(CarregarFiliais : boolean = true) : TClientDataSet;
begin

  FDaoEmpresas.qryEmpresas.Close;
  FDaoEmpresas.CarregarFilial := CarregarFiliais;
  try
    try
      DefinirTipoDaBusca(FDaoEmpresas.QryEmpresas);
      DefinirTipoDaBusca(FDaoEmpresas.qryEmpresasCount);

      if (countRegistro(FDaoEmpresas.qryEmpresasCount, 'ID_EMPRESA', ID_Matriz) > 1000) or (limit > 0) then
        paginado := FDaoEmpresas.QryEmpresas.paginar(limit, NumPagina);

      FDaoEmpresas.CDSEmpresas.Open;

      Result := FDaoEmpresas.CDSEmpresas;
    Except
      on E: Exception do
        raise Exception.Create('Error ao buscar: ' + E.Message);
    end;
  finally
    FDaoEmpresas.qryEmpresas.Close;
  end;
end;

function TModelEmpresas.isFilial: boolean;
begin
  Result :=  ControllerToken.user_ID.ToInteger <> ID_Matriz;
end;

function TModelEmpresas.postRegistros(Aparam: TJsonObject): boolean;
var
  i: integer;
  JsValue: TJSONValue;
begin
  Result := false;
  if FDaoEmpresas.cdsEmpresas.State = dsInactive then
  begin
    FDaoEmpresas.cdsEmpresas.PacketRecords := 1;
    // para não carregar todos os registros na inclusão

    FDaoEmpresas.ID_empresa_Matriz := ControllerToken.user_ID.ToInteger; //Matriz

    FDaoEmpresas.cdsEmpresas.Open;
  end;

  try
    try
      FDaoEmpresas.CDSEmpresas.Append;
      FDaoEmpresas.inInsert := true;

      for i := 0 to pred(FDaoEmpresas.CDSEmpresas.Fields.Count) do
      begin
        if Aparam.TryGetValue(FDaoEmpresas.CDSEmpresas.Fields[i].FieldName,JsValue) then
          FDaoEmpresas.CDSEmpresas.Fields[i].Value := JsValue.Value;
      end;

      FDaoEmpresas.CDSEmpresas.post;
      FDaoEmpresas.CDSEmpresas.ApplyUpdates(0);
      Result := true;
    Except
      on E: Exception do
        raise Exception.Create('Error ao incluir: ' + E.Message);
    end;
  finally
    FDaoEmpresas.cdsEmpresas.Close;
    FDaoEmpresas.cdsEmpresas.PacketRecords := -1;
    FDaoEmpresas.inInsert := false;
  end;
end;

function TModelEmpresas.putRegistros(Aparam: TJsonObject): boolean;
var
  i: integer;
  JsValue: TJSONValue;
begin
  Result := false;
  try
    try
    FDaoEmpresas.CarregarFilial := true;

    FDaoEmpresas.qryEmpresas.Close;
    DefinirTipoDaBusca(FDaoEmpresas.qryEmpresas);
    FDaoEmpresas.cdsEmpresas.Open;

    if FDaoEmpresas.cdsEmpresas.RecordCount > 0 then
    begin
      FDaoEmpresas.cdsEmpresas.Edit;
      for i := 0 to Aparam.Count do
      begin
        if Aparam.TryGetValue(FDaoEmpresas.cdsEmpresas.Fields[i].FieldName,JsValue) then
          FDaoEmpresas.cdsEmpresas.Fields[i].Value := JsValue.Value;
      end;
      FDaoEmpresas.cdsEmpresas.post;
    end else
      raise Exception.Create('"Registro não encontrado" ');


    FDaoEmpresas.cdsEmpresas.ApplyUpdates(0);
    Result := true;
    Except
      on E: Exception do
        raise Exception.Create('Error ao atualizar: ' + E.Message);
    end;
  finally
    FDaoEmpresas.cdsEmpresas.Close;
  end;
end;

end.
