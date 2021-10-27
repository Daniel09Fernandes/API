unit SMController.Empresas;

interface

uses
  System.SysUtils, System.Classes, System.Json, UServices.interf,
  UServices.Empresas,
  Datasnap.DSServer, Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter;

type
{$METHODINFO ON}
  TsmEmpresas = class(TDSServerModule)
  private
    ServicesEmpresas: TServicesEmpresas;
  public
    function Empresas(AId_Empresa, ANomeFantasia, CNPJ: string): TJSONObject;
    function AcceptEmpresas(AParams: TJSONObject = nil): TJSONObject;
    function CancelEmpresas(AId_Empresa: string): TJSONObject;
    function UpdateEmpresas(AParams: TJSONObject = nil): TJSONObject;
  end;
{$METHODINFO OFF}

implementation

uses System.StrUtils;

{$R *.dfm}

function TsmEmpresas.AcceptEmpresas(AParams: TJSONObject): TJSONObject;
begin
  Result := ServicesEmpresas.NewInstance.executeputRequest(AParams);
end;

function TsmEmpresas.Empresas(AId_Empresa, ANomeFantasia, CNPJ: string): TJSONObject;
begin
  Result := ServicesEmpresas.NewInstance.executeGetRequest([AId_Empresa,ANomeFantasia,CNPJ]);
end;

function TsmEmpresas.CancelEmpresas(AId_Empresa: string): TJSONObject;
begin
  Result := ServicesEmpresas.NewInstance.executeDeleteRequest(AId_Empresa);
end;

function TsmEmpresas.UpdateEmpresas(AParams: TJSONObject): TJSONObject;
begin
  Result := ServicesEmpresas.NewInstance.executepostRequest(AParams);
end;

end.
