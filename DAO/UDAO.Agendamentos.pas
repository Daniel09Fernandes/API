unit UDAO.Agendamentos;

interface

uses
  System.SysUtils, System.Classes, UConexaoPadrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.Provider, Data.DB,
  Datasnap.DBClient;

type

  TWhereTipos = (twSemWhere, twPeriodo, twCliente, TwID);
  TWTipos     =  set of TWhereTipos;

  TDtmAgendamentos = class(TDataModule)
    cdsAgendamentos: TClientDataSet;
    prvAgendamentos: TDataSetProvider;
    QryAgendamentos: TFDQuery;
    updAgendamentos: TFDUpdateSQL;
    QryAgendamentosID_AGENDA: TIntegerField;
    QryAgendamentosID_PET: TIntegerField;
    QryAgendamentosID_CLIENTE: TIntegerField;
    QryAgendamentosMOTIVO: TStringField;
    QryAgendamentosARQUIVO: TMemoField;
    QryAgendamentosDATA: TDateField;
    QryAgendamentosHORA: TTimeField;
    QryAgendamentosSTATUS: TWideStringField;
    QryAgendamentosNOME: TStringField;
    QryAgendamentosCONTATO: TStringField;
    QryAgendamentosNOME_PET: TStringField;
    QryAgendamentosESPECIE: TStringField;
    QryAgendamentosRACA: TStringField;
    cdsAgendamentosID_AGENDA: TIntegerField;
    cdsAgendamentosID_PET: TIntegerField;
    cdsAgendamentosID_CLIENTE: TIntegerField;
    cdsAgendamentosMOTIVO: TStringField;
    cdsAgendamentosARQUIVO: TMemoField;
    cdsAgendamentosDATA: TDateField;
    cdsAgendamentosHORA: TTimeField;
    cdsAgendamentosSTATUS: TWideStringField;
    cdsAgendamentosNOME: TStringField;
    cdsAgendamentosCONTATO: TStringField;
    cdsAgendamentosNOME_PET: TStringField;
    cdsAgendamentosESPECIE: TStringField;
    cdsAgendamentosRACA: TStringField;
    qryAgendamentosCount: TFDQuery;
    cdsAgendamentosID_EMPRESA: TIntegerField;
    QryAgendamentosID_EMPRESA: TIntegerField;
    procedure cdsAgendamentosBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    FinInsert          : boolean;
    FtipoWhere         : TWTipos;
    FIDEmpresa         : Integer;

  public
    procedure montarWhere(Qry: TFDQuery);

    property inInsert  : boolean  read FinInsert  write FinInsert;
    property tipoWhere : TWTipos  read FtipoWhere write FtipoWhere;
    property IDEmpresa  : Integer read FIDEmpresa write FIDEmpresa;


  end;

var
  DtmAgendamentos: TDtmAgendamentos;

implementation

{$R *.dfm}

procedure TDtmAgendamentos.cdsAgendamentosBeforePost(DataSet: TDataSet);
begin
  inherited;
  if inInsert then
  begin
    cdsAgendamentosID_AGENDA.AsInteger  := dtmConexao.genID('gen_tb_consultas_id');
    cdsAgendamentosID_EMPRESA.AsInteger := IDEmpresa
  end;
end;

procedure TDtmAgendamentos.DataModuleCreate(Sender: TObject);
begin
  if not Assigned(dtmConexao) then
    dtmConexao := TdtmConexao.Create(self);
end;

procedure TDtmAgendamentos.montarWhere(Qry: TFDQuery);
var SLwhere : TStringList;
begin
  if tipoWhere <> [twSemWhere] then
  begin
    SLwhere := TStringList.Create;
    try
      SLwhere.Add(' AND');

      if tipoWhere = [twID] then
        SLwhere.Add(' cs.id_agenda = :id_agenda');

      if tipoWhere = [twCliente] then
        SLwhere.Add(' cs.id_cliente = :id_cliente');

      if tipoWhere = [twPeriodo] then
        SLwhere.Add(' cs.DATA BETWEEN :Data_inicio and :Data_Fim ');

      if tipoWhere = [twPeriodo, twCliente] then
      begin
        SLwhere.Add(' cs.DATA BETWEEN :Data_inicio and :Data_Fim ');
        SLwhere.Add(' AND cs.id_cliente = :id_cliente ');
      end;

      Qry.SQL.AddStrings(SLwhere);

    finally
      FreeAndNil(SLwhere);
    end;
  end;
end;

end.
