object dtmEmpresas: TdtmEmpresas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 352
  Width = 457
  object qryEmpresas: TFDQuery
    CachedUpdates = True
    Connection = dtmConexao.FDConexao
    Transaction = dtmConexao.FDTransactionPadrao
    SQL.Strings = (
      'select first :limit skip :offset'
      
        '   case when em.MATRIZ_ID is null then '#39'Matriz'#39' else '#39'Filial'#39' en' +
        'd as Tipo ,'
      '  em.*,'
      '  ra.NOME as DESCRICAO_ATIVIDADE'
      'from TB_EMPRESA em'
      '  left join TB_RAMO_ATIVIDADE ra'
      '    on ra.ID = em.RAMO_ATIVIDADE'
      'where'
      
        '   CASE WHEN      (:ID_EMPRESA = 0)  then 1 = 1 else  em.ID = :I' +
        'D_EMPRESA or (em.MATRIZ_ID = :ID_EMPRESA)  end'
      
        '  AND CASE WHEN  (:MATRIZ_ID = 0)   then 1 = 1 else  em.MATRIZ_I' +
        'D = :MATRIZ_ID end')
    Left = 104
    Top = 40
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
      end
      item
        Name = 'MATRIZ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
    object qryEmpresasID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
    end
    object qryEmpresasNOME_FANTASIA: TStringField
      FieldName = 'NOME_FANTASIA'
      Origin = 'NOME_FANTASIA'
      Size = 100
    end
    object qryEmpresasRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Origin = 'RAZAO_SOCIAL'
      Size = 200
    end
    object qryEmpresasTELEFONE1: TWideStringField
      FieldName = 'TELEFONE1'
      Origin = 'TELEFONE1'
      Size = 12
    end
    object qryEmpresasTELEFONE2: TWideStringField
      FieldName = 'TELEFONE2'
      Origin = 'TELEFONE2'
      Size = 12
    end
    object qryEmpresasENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 100
    end
    object qryEmpresasBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 100
    end
    object qryEmpresasNUMERO: TIntegerField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
    end
    object qryEmpresasCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 50
    end
    object qryEmpresasCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 15
    end
    object qryEmpresasRAMO_ATIVIDADE: TIntegerField
      FieldName = 'RAMO_ATIVIDADE'
      Origin = 'RAMO_ATIVIDADE'
    end
    object qryEmpresasCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 15
    end
    object qryEmpresasDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Origin = 'DATA_CADASTRO'
    end
    object qryEmpresasDESCRICAO_ATIVIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO_ATIVIDADE'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qryEmpresasATIVA: TWideStringField
      FieldName = 'ATIVA'
      Origin = 'ATIVA'
      FixedChar = True
      Size = 1
    end
    object qryEmpresasUSER_ID: TWideStringField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      Size = 10
    end
    object qryEmpresasTIPO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TIPO'
      Origin = 'TIPO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 6
    end
    object qryEmpresasMATRIZ_ID: TIntegerField
      FieldName = 'MATRIZ_ID'
      Origin = 'MATRIZ_ID'
      Visible = False
    end
  end
  object dspEmpresas: TDataSetProvider
    DataSet = qryEmpresas
    Left = 184
    Top = 40
  end
  object cdsEmpresas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEmpresas'
    BeforePost = cdsEmpresasBeforePost
    Left = 264
    Top = 40
    object cdsEmpresasTIPO: TStringField
      FieldName = 'TIPO'
      ReadOnly = True
      FixedChar = True
      Size = 6
    end
    object cdsEmpresasID: TIntegerField
      FieldName = 'ID'
    end
    object cdsEmpresasNOME_FANTASIA: TStringField
      FieldName = 'NOME_FANTASIA'
      Size = 100
    end
    object cdsEmpresasRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 200
    end
    object cdsEmpresasTELEFONE1: TWideStringField
      FieldName = 'TELEFONE1'
      Size = 12
    end
    object cdsEmpresasTELEFONE2: TWideStringField
      FieldName = 'TELEFONE2'
      Size = 12
    end
    object cdsEmpresasENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 100
    end
    object cdsEmpresasBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object cdsEmpresasNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
    object cdsEmpresasCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 50
    end
    object cdsEmpresasCEP: TStringField
      FieldName = 'CEP'
      Size = 15
    end
    object cdsEmpresasRAMO_ATIVIDADE: TIntegerField
      FieldName = 'RAMO_ATIVIDADE'
    end
    object cdsEmpresasCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 15
    end
    object cdsEmpresasDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsEmpresasDESCRICAO_ATIVIDADE: TStringField
      FieldName = 'DESCRICAO_ATIVIDADE'
      ReadOnly = True
      Size = 50
    end
    object cdsEmpresasATIVA: TWideStringField
      FieldName = 'ATIVA'
      FixedChar = True
      Size = 1
    end
    object cdsEmpresasUSER_ID: TWideStringField
      FieldName = 'USER_ID'
      Size = 10
    end
    object cdsEmpresasMATRIZ_ID: TIntegerField
      FieldName = 'MATRIZ_ID'
      Visible = False
    end
  end
  object updEmpresas: TFDUpdateSQL
    Connection = dtmConexao.FDConexao
    InsertSQL.Strings = (
      'INSERT INTO TB_EMPRESA'
      '(ID, NOME_FANTASIA, RAZAO_SOCIAL, TELEFONE1, '
      '  TELEFONE2, ENDERECO, BAIRRO, NUMERO, '
      '  CIDADE, CEP, RAMO_ATIVIDADE, CNPJ, DATA_CADASTRO)'
      
        'VALUES (:NEW_ID, :NEW_NOME_FANTASIA, :NEW_RAZAO_SOCIAL, :NEW_TEL' +
        'EFONE1, '
      '  :NEW_TELEFONE2, :NEW_ENDERECO, :NEW_BAIRRO, :NEW_NUMERO, '
      
        '  :NEW_CIDADE, :NEW_CEP, :NEW_RAMO_ATIVIDADE, :NEW_CNPJ, :NEW_DA' +
        'TA_CADASTRO)')
    ModifySQL.Strings = (
      'UPDATE TB_EMPRESA'
      
        'SET ID = :NEW_ID, NOME_FANTASIA = :NEW_NOME_FANTASIA, RAZAO_SOCI' +
        'AL = :NEW_RAZAO_SOCIAL, '
      '  TELEFONE1 = :NEW_TELEFONE1, TELEFONE2 = :NEW_TELEFONE2, '
      
        '  ENDERECO = :NEW_ENDERECO, BAIRRO = :NEW_BAIRRO, NUMERO = :NEW_' +
        'NUMERO, '
      
        '  CIDADE = :NEW_CIDADE, CEP = :NEW_CEP, RAMO_ATIVIDADE = :NEW_RA' +
        'MO_ATIVIDADE, '
      '  CNPJ = :NEW_CNPJ, DATA_CADASTRO = :NEW_DATA_CADASTRO'
      
        'WHERE ID = :OLD_ID AND NOME_FANTASIA = :OLD_NOME_FANTASIA AND RA' +
        'ZAO_SOCIAL = :OLD_RAZAO_SOCIAL AND '
      '  TELEFONE1 = :OLD_TELEFONE1 AND TELEFONE2 = :OLD_TELEFONE2 AND '
      
        '  ENDERECO = :OLD_ENDERECO AND BAIRRO = :OLD_BAIRRO AND NUMERO =' +
        ' :OLD_NUMERO AND '
      
        '  CIDADE = :OLD_CIDADE AND CEP = :OLD_CEP AND RAMO_ATIVIDADE = :' +
        'OLD_RAMO_ATIVIDADE AND '
      '  CNPJ = :OLD_CNPJ AND DATA_CADASTRO = :OLD_DATA_CADASTRO')
    DeleteSQL.Strings = (
      'DELETE FROM TB_EMPRESA'
      
        'WHERE ID = :OLD_ID AND NOME_FANTASIA = :OLD_NOME_FANTASIA AND RA' +
        'ZAO_SOCIAL = :OLD_RAZAO_SOCIAL AND '
      '  TELEFONE1 = :OLD_TELEFONE1 AND TELEFONE2 = :OLD_TELEFONE2 AND '
      
        '  ENDERECO = :OLD_ENDERECO AND BAIRRO = :OLD_BAIRRO AND NUMERO =' +
        ' :OLD_NUMERO AND '
      
        '  CIDADE = :OLD_CIDADE AND CEP = :OLD_CEP AND RAMO_ATIVIDADE = :' +
        'OLD_RAMO_ATIVIDADE AND '
      '  CNPJ = :OLD_CNPJ AND DATA_CADASTRO = :OLD_DATA_CADASTRO')
    FetchRowSQL.Strings = (
      
        'SELECT ID, NOME_FANTASIA, RAZAO_SOCIAL, TELEFONE1, TELEFONE2, EN' +
        'DERECO, '
      
        '  BAIRRO, NUMERO, CIDADE, CEP, RAMO_ATIVIDADE, CNPJ, DATA_CADAST' +
        'RO'
      'FROM TB_EMPRESA'
      
        'WHERE ID = :ID AND NOME_FANTASIA = :NOME_FANTASIA AND RAZAO_SOCI' +
        'AL = :RAZAO_SOCIAL AND '
      
        '  TELEFONE1 = :TELEFONE1 AND TELEFONE2 = :TELEFONE2 AND ENDERECO' +
        ' = :ENDERECO AND '
      
        '  BAIRRO = :BAIRRO AND NUMERO = :NUMERO AND CIDADE = :CIDADE AND' +
        ' '
      
        '  CEP = :CEP AND RAMO_ATIVIDADE = :RAMO_ATIVIDADE AND CNPJ = :CN' +
        'PJ AND '
      '  DATA_CADASTRO = :DATA_CADASTRO')
    Left = 32
    Top = 40
  end
  object qryEmpresasCount: TFDQuery
    CachedUpdates = True
    Connection = dtmConexao.FDConexao
    Transaction = dtmConexao.FDTransactionPadrao
    SQL.Strings = (
      'select Count(1)'
      'from TB_EMPRESA em'
      '  left join TB_RAMO_ATIVIDADE ra'
      '    on ra.ID = em.RAMO_ATIVIDADE'
      'where'
      
        '   CASE WHEN      (:ID_EMPRESA = 0)  then 1 = 1 else  em.ID = :I' +
        'D_EMPRESA or (em.MATRIZ_ID = :ID_EMPRESA)  end'
      
        '  AND CASE WHEN  (:MATRIZ_ID = 0)   then 1 = 1 else  em.MATRIZ_I' +
        'D = :MATRIZ_ID end')
    Left = 104
    Top = 104
    ParamData = <
      item
        Name = 'ID_EMPRESA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MATRIZ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
  end
end
