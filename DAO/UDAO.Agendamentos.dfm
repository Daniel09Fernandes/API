object DtmAgendamentos: TDtmAgendamentos
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 282
  Width = 415
  object cdsAgendamentos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'prvAgendamentos'
    BeforePost = cdsAgendamentosBeforePost
    Left = 344
    Top = 56
    object cdsAgendamentosID_AGENDA: TIntegerField
      FieldName = 'ID_AGENDA'
      Required = True
    end
    object cdsAgendamentosID_PET: TIntegerField
      FieldName = 'ID_PET'
      Required = True
    end
    object cdsAgendamentosID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
      Required = True
    end
    object cdsAgendamentosMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Size = 8000
    end
    object cdsAgendamentosARQUIVO: TMemoField
      FieldName = 'ARQUIVO'
      BlobType = ftMemo
    end
    object cdsAgendamentosDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsAgendamentosHORA: TTimeField
      FieldName = 'HORA'
    end
    object cdsAgendamentosSTATUS: TWideStringField
      FieldName = 'STATUS'
      Size = 10
    end
    object cdsAgendamentosNOME: TStringField
      FieldName = 'NOME'
      ReadOnly = True
      Size = 60
    end
    object cdsAgendamentosCONTATO: TStringField
      FieldName = 'CONTATO'
      ReadOnly = True
      Size = 18
    end
    object cdsAgendamentosNOME_PET: TStringField
      FieldName = 'NOME_PET'
      ReadOnly = True
      Size = 60
    end
    object cdsAgendamentosESPECIE: TStringField
      FieldName = 'ESPECIE'
      ReadOnly = True
      Size = 30
    end
    object cdsAgendamentosRACA: TStringField
      FieldName = 'RACA'
      ReadOnly = True
      Size = 30
    end
    object cdsAgendamentosID_EMPRESA: TIntegerField
      FieldName = 'ID_EMPRESA'
    end
  end
  object prvAgendamentos: TDataSetProvider
    DataSet = QryAgendamentos
    Left = 241
    Top = 56
  end
  object QryAgendamentos: TFDQuery
    CachedUpdates = True
    Connection = dtmConexao.FDConexao
    Transaction = dtmConexao.FDTransactionPadrao
    SQL.Strings = (
      'select  first :limit skip :offset'
      ' cs.*,'
      ' cl.nome,'
      ' cl.contato,'
      ' pt.nome_pet,'
      ' pt.especie,'
      ' pt.raca'
      'from tb_consultas cs'
      '  inner join tb_clientes cl on cl.id_cliente = cs.id_cliente'
      
        '  left join tb_pet pt on pt.id_pet =  cs.id_pet and pt.cliente_i' +
        'd = cs.id_cliente'
      'Where cs.ID_EMPRESA = :ID_EMPRESA')
    Left = 145
    Top = 56
    ParamData = <
      item
        Name = 'LIMIT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1000
      end
      item
        Name = 'OFFSET'
        DataType = ftLargeint
        ParamType = ptInput
      end
      item
        Name = 'ID_EMPRESA'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object QryAgendamentosID_AGENDA: TIntegerField
      FieldName = 'ID_AGENDA'
      Origin = 'ID_AGENDA'
      Required = True
    end
    object QryAgendamentosID_PET: TIntegerField
      FieldName = 'ID_PET'
      Origin = 'ID_PET'
      Required = True
    end
    object QryAgendamentosID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
      Required = True
    end
    object QryAgendamentosMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Origin = 'MOTIVO'
      Size = 8000
    end
    object QryAgendamentosARQUIVO: TMemoField
      FieldName = 'ARQUIVO'
      Origin = 'ARQUIVO'
      BlobType = ftMemo
    end
    object QryAgendamentosDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object QryAgendamentosHORA: TTimeField
      FieldName = 'HORA'
      Origin = 'HORA'
    end
    object QryAgendamentosSTATUS: TWideStringField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Size = 10
    end
    object QryAgendamentosNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object QryAgendamentosCONTATO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CONTATO'
      Origin = 'CONTATO'
      ProviderFlags = []
      ReadOnly = True
      Size = 18
    end
    object QryAgendamentosNOME_PET: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_PET'
      Origin = 'NOME_PET'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object QryAgendamentosESPECIE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ESPECIE'
      Origin = 'ESPECIE'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object QryAgendamentosRACA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'RACA'
      Origin = 'RACA'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object QryAgendamentosID_EMPRESA: TIntegerField
      FieldName = 'ID_EMPRESA'
      Origin = 'ID_EMPRESA'
    end
  end
  object updAgendamentos: TFDUpdateSQL
    Connection = dtmConexao.FDConexao
    InsertSQL.Strings = (
      'INSERT INTO TB_CONSULTAS'
      '(ID_AGENDA, ID_PET, ID_CLIENTE, MOTIVO, ARQUIVO, '
      '  "DATA", HORA, STATUS)'
      
        'VALUES (:NEW_ID_AGENDA, :NEW_ID_PET, :NEW_ID_CLIENTE, :NEW_MOTIV' +
        'O, :NEW_ARQUIVO, '
      '  :NEW_DATA, :NEW_HORA, :NEW_STATUS)'
      'RETURNING STATUS')
    ModifySQL.Strings = (
      'UPDATE TB_CONSULTAS'
      
        'SET ID_AGENDA = :NEW_ID_AGENDA, ID_PET = :NEW_ID_PET, ID_CLIENTE' +
        ' = :NEW_ID_CLIENTE, '
      
        '  MOTIVO = :NEW_MOTIVO, ARQUIVO = :NEW_ARQUIVO, "DATA" = :NEW_DA' +
        'TA, '
      '  HORA = :NEW_HORA, STATUS = :NEW_STATUS'
      
        'WHERE ID_AGENDA = :OLD_ID_AGENDA AND ID_PET = :OLD_ID_PET AND ID' +
        '_CLIENTE = :OLD_ID_CLIENTE AND '
      
        '  MOTIVO = :OLD_MOTIVO AND "DATA" = :OLD_DATA AND HORA = :OLD_HO' +
        'RA AND '
      '  STATUS = :OLD_STATUS'
      'RETURNING STATUS')
    DeleteSQL.Strings = (
      'DELETE FROM TB_CONSULTAS'
      
        'WHERE ID_AGENDA = :OLD_ID_AGENDA AND ID_PET = :OLD_ID_PET AND ID' +
        '_CLIENTE = :OLD_ID_CLIENTE AND '
      
        '  MOTIVO = :OLD_MOTIVO AND "DATA" = :OLD_DATA AND HORA = :OLD_HO' +
        'RA AND '
      '  STATUS = :OLD_STATUS')
    FetchRowSQL.Strings = (
      
        'SELECT ID_AGENDA, ID_PET, ID_CLIENTE, MOTIVO, ARQUIVO, "DATA" AS' +
        ' "DATA", '
      '  HORA, STATUS'
      'FROM TB_CONSULTAS'
      
        'WHERE ID_AGENDA = :ID_AGENDA AND ID_PET = :ID_PET AND ID_CLIENTE' +
        ' = :ID_CLIENTE AND '
      '  MOTIVO = :MOTIVO AND "DATA" = :"DATA" AND HORA = :HORA AND '
      '  STATUS = :STATUS')
    Left = 40
    Top = 56
  end
  object qryAgendamentosCount: TFDQuery
    Connection = dtmConexao.FDConexao
    SQL.Strings = (
      ' select count(1)'
      'from tb_consultas cs'
      '  inner join tb_clientes cl on cl.id_cliente = cs.id_cliente'
      
        '  left join tb_pet pt on pt.id_pet =  cs.id_pet and pt.cliente_i' +
        'd = cs.id_cliente'
      'Where cs.ID_EMPRESA = :ID_EMPRESA')
    Left = 144
    Top = 120
    ParamData = <
      item
        Name = 'ID_EMPRESA'
        ParamType = ptInput
      end>
  end
end
