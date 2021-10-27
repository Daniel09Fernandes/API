object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end>
  Height = 345
  Width = 415
  object DSServer1: TDSServer
    Left = 48
    Top = 11
  end
  object DSHTTPWebDispatcher1: TDSHTTPWebDispatcher
    DSContext = 'api/'
    RESTContext = 'v1/'
    Server = DSServer1
    Filters = <>
    WebDispatch.PathInfo = 'api*'
    Left = 56
    Top = 83
  end
  object DSServerAgendamentos: TDSServerClass
    OnGetClass = DSServerAgendamentosGetClass
    Server = DSServer1
    Left = 200
    Top = 11
  end
  object DSServerClassEmpresa: TDSServerClass
    OnGetClass = DSServerClassEmpresaGetClass
    Server = DSServer1
    Left = 200
    Top = 75
  end
  object DSServerMetaDataProvider1: TDSServerMetaDataProvider
    Server = DSServer1
    Left = 208
    Top = 248
  end
  object DSProxyGenerator1: TDSProxyGenerator
    ExcludeClasses = 'DSMetadata'
    MetaDataProvider = DSServerMetaDataProvider1
    Writer = 'Java Script REST'
    Left = 48
    Top = 248
  end
end
