object FrmALClienteCEP: TFrmALClienteCEP
  OldCreateOrder = False
  Height = 471
  Width = 749
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://viacep.com.br/ws/01001000/json'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 240
    Top = 56
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 240
    Top = 144
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 240
    Top = 96
  end
end
