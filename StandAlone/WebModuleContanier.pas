unit WebModuleContanier;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Datasnap.DSAuth, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP, Datasnap.DSProxyJavaScript, Datasnap.DSClientMetadata, Datasnap.DSMetadata, Datasnap.DSServerMetadata;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServer1: TDSServer;
    DSServerAgendamentos: TDSServerClass;
    DSServerClassEmpresa: TDSServerClass;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    DSProxyGenerator1: TDSProxyGenerator;
    procedure DSServerAgendamentosGetClass(DSServerClass: TDSServerClass;var PersistentClass: TPersistentClass);
    procedure WebModule1DefaultHandlerAction(Sender: TObject;Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure DSServerClassEmpresaGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
  private

  public

  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{$R *.dfm}

uses Web.WebReq, funcoesComum, uLogPadrao, SMController.Agendamentos, SMController.Empresas, Data.DBXPlatform;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := '<html>' + '<head><title>DataSnap Server</title></head>' +
    '<body>DataSnap Server</body>' + '</html>';
end;

procedure TWebModule1.DSServerAgendamentosGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := SMController.Agendamentos.TsmAgendamentos;
end;

procedure TWebModule1.DSServerClassEmpresaGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := SMController.Empresas.TsmEmpresas;
end;

initialization

finalization

Web.WebReq.FreeWebModules;

end.
