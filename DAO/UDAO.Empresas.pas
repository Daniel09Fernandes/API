unit UDAO.Empresas;

interface

uses
  System.SysUtils, System.Classes,UConexaoPadrao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient,
  Datasnap.Provider;

type

  TWhereTipos = (twSemWhere, TwID, twNomeFantasia, TwCNPJ);
  TWTipos     =  set of TWhereTipos;

  TdtmEmpresas = class(TDataModule)
    qryEmpresas: TFDQuery;
    dspEmpresas: TDataSetProvider;
    qryEmpresasID: TIntegerField;
    qryEmpresasNOME_FANTASIA: TStringField;
    qryEmpresasRAZAO_SOCIAL: TStringField;
    qryEmpresasTELEFONE1: TWideStringField;
    qryEmpresasTELEFONE2: TWideStringField;
    qryEmpresasENDERECO: TStringField;
    qryEmpresasBAIRRO: TStringField;
    qryEmpresasNUMERO: TIntegerField;
    qryEmpresasCIDADE: TStringField;
    qryEmpresasCEP: TStringField;
    qryEmpresasRAMO_ATIVIDADE: TIntegerField;
    qryEmpresasCNPJ: TStringField;
    qryEmpresasDATA_CADASTRO: TDateField;
    qryEmpresasDESCRICAO_ATIVIDADE: TStringField;
    cdsEmpresas: TClientDataSet;
    cdsEmpresasID: TIntegerField;
    cdsEmpresasNOME_FANTASIA: TStringField;
    cdsEmpresasRAZAO_SOCIAL: TStringField;
    cdsEmpresasTELEFONE1: TWideStringField;
    cdsEmpresasTELEFONE2: TWideStringField;
    cdsEmpresasENDERECO: TStringField;
    cdsEmpresasBAIRRO: TStringField;
    cdsEmpresasNUMERO: TIntegerField;
    cdsEmpresasCIDADE: TStringField;
    cdsEmpresasCEP: TStringField;
    cdsEmpresasRAMO_ATIVIDADE: TIntegerField;
    cdsEmpresasCNPJ: TStringField;
    cdsEmpresasDATA_CADASTRO: TDateField;
    cdsEmpresasDESCRICAO_ATIVIDADE: TStringField;
    qryEmpresasATIVA: TWideStringField;
    qryEmpresasUSER_ID: TWideStringField;
    cdsEmpresasATIVA: TWideStringField;
    cdsEmpresasUSER_ID: TWideStringField;
    updEmpresas: TFDUpdateSQL;
    qryEmpresasCount: TFDQuery;
    qryEmpresasTIPO: TStringField;
    qryEmpresasMATRIZ_ID: TIntegerField;
    cdsEmpresasTIPO: TStringField;
    cdsEmpresasMATRIZ_ID: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsEmpresasBeforePost(DataSet: TDataSet);
  private
    FinInsert: boolean;
    FtipoWhere: TWTipos;
    FIDEmpresa: Integer;
    FIsMatriz: Boolean;
    FID_empresa: Integer;
    FCarregarMatriz: Boolean;

  public
    procedure montarWhere(Qry: TFDQuery);

    property ID_empresa_Matriz : Integer read FID_empresa     write FID_empresa;
    property CarregarFilial    : Boolean read FCarregarMatriz write FCarregarMatriz;
    property inInsert          : boolean read FinInsert       write FinInsert;
    property tipoWhere         : TWTipos read FtipoWhere      write FtipoWhere;

end;

var
  dtmEmpresas: TdtmEmpresas;

implementation

{$R *.dfm}

procedure TdtmEmpresas.cdsEmpresasBeforePost(DataSet: TDataSet);
begin
  if inInsert then
  begin
    cdsEmpresasID.AsInteger             := dtmConexao.genID('GEN_TB_EMPRESA_ID');
    cdsEmpresasMATRIZ_ID.AsInteger      := ID_empresa_Matriz;
    cdsEmpresasDATA_CADASTRO.AsDateTime := now;
  end;
end;

procedure TdtmEmpresas.DataModuleCreate(Sender: TObject);
begin
   if not Assigned(dtmConexao) then
     dtmConexao := TdtmConexao.Create(self);
end;

procedure TdtmEmpresas.montarWhere(Qry: TFDQuery);
var SLwhere : TStringList;
begin

  if tipoWhere <> [twSemWhere] then
  begin
    SLwhere := TStringList.Create;
    try
      SLwhere.Add(' AND ');

      if tipoWhere = [twNomeFantasia] then
        SLwhere.Add('  em.NOME_FANTASIA like :Nome_Fant_empresa||''%'' ');

      if tipoWhere = [TwCNPJ] then
        SLwhere.Add('  em.CNPJ = :CNPJ ');

      Qry.SQL.AddStrings(SLwhere);

    finally
      FreeAndNil(SLwhere);
    end;
  end;
end;

end.



