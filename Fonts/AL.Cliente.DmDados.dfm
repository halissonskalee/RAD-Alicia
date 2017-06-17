object FrmALClienteDmDados: TFrmALClienteDmDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 364
  Width = 608
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Server='
      'Database=ALICIA'
      'DriverID=Mongo')
    ConnectedStoredUsage = [auRunTime]
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 64
    Top = 72
  end
  object FDPhysMongoDriverLink1: TFDPhysMongoDriverLink
    Left = 64
    Top = 120
  end
  object FDMongoQuery1: TFDMongoQuery
    FormatOptions.AssignedValues = [fvStrsTrim2Len]
    FormatOptions.StrsTrim2Len = True
    Connection = FDConnection1
    Left = 64
    Top = 168
  end
end
