program APIAgenda_Std;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Web.HTTPApp,
  FormUnit1 in 'FormUnit1.pas' {Form1},
  WebModuleContanier in 'WebModuleContanier.pas' {WebModule1: TWebModule},
  SMController.Agendamentos in '..\Controller\SMController.Agendamentos.pas' {smAgendamentos: TDSServerModule},
  UServices.Agendamentos in '..\Services\UServices.Agendamentos.pas',
  UConexaoPadrao in '..\..\..\ConexaoPadrao\UConexaoPadrao.pas' {dtmConexao: TDataModule},
  UDAO.Agendamentos in '..\DAO\UDAO.Agendamentos.pas' {DtmAgendamentos: TDataModule},
  UModel.Agendametos in '..\Model\UModel.Agendametos.pas',
  UServices.Interf in '..\Services\UServices.Interf.pas',
  funcoesComum in '..\..\..\Comum\funcoesComum.pas',
  uLogPadrao in '..\..\..\ConexaoPadrao\uLogPadrao.pas',
  uHelper.Services in '..\Helper\uHelper.Services.pas',
  UDAO.Empresas in '..\DAO\UDAO.Empresas.pas' {dtmEmpresas: TDataModule},
  UModel.Agenda in '..\Model\UModel.Agenda.pas',
  UModel.Empresas in '..\Model\UModel.Empresas.pas',
  UServices.Empresas in '..\Services\UServices.Empresas.pas',
  SMController.Empresas in '..\Controller\SMController.Empresas.pas' {smEmpresas: TDataModule},
  UServices.token in '..\Services\UServices.token.pas',
  Controller.Token in '..\Controller\Controller.Token.pas';

{$R *.res}

begin

  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;

  Application.Initialize;

  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdtmConexao, dtmConexao);
  Application.Run;

end.
