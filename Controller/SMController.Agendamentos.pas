unit SMController.Agendamentos;

interface

uses System.SysUtils, System.Classes, System.Json, UServices.interf,UServices.Agendamentos,
  Datasnap.DSServer, Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter;

type

{$METHODINFO ON}
  TsmAgendamentos = class(TDSServerModule)
  private
    ServicesAgendamentos: TServicesAgendamentos;
  public
    function Agendamentos(id_Agenda, id_cliente,dataInicio, datafim: string): TJSONObject;
    function AcceptAgendamentos(AParams: TJSONObject = nil): TJSONObject;
    function CancelAgendamentos(id_Agenda: string): TJSONObject;
    function UpdateAgendamentos(AParams: TJSONObject = nil): TJSONObject;
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

uses System.StrUtils;

function TsmAgendamentos.AcceptAgendamentos(AParams: TJSONObject = nil): TJSONObject;
begin
  Result := ServicesAgendamentos.NewInstance.executePutRequest(AParams)
end;

function TsmAgendamentos.Agendamentos(id_Agenda, id_cliente, dataInicio, datafim: string): TJSONObject;
begin
  Result := ServicesAgendamentos.NewInstance.executeGetRequest([id_Agenda,id_cliente,dataInicio,datafim]);
end;

function TsmAgendamentos.CancelAgendamentos(id_Agenda: string): TJSONObject;
begin
  Result := ServicesAgendamentos.NewInstance.executeDeleteRequest(id_Agenda)
end;

function TsmAgendamentos.UpdateAgendamentos(AParams: TJSONObject): TJSONObject;
begin
  Result := ServicesAgendamentos.NewInstance.executePostRequest(AParams)

end;

end.
