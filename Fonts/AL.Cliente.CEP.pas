unit AL.Cliente.CEP;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.Dialogs,
  AL.Classe.Endereco;


type
  TFrmALClienteCEP = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
  private
    { Private declarations }
  public
    { Public declarations }

    function BuscarCEP(sCEP: String): TEndereco;

  end;

var
  FrmALClienteCEP: TFrmALClienteCEP;

implementation

uses
  REST.Json;

{ %CLASSGROUP 'FMX.Controls.TControl' }

{$R *.dfm}

function TFrmALClienteCEP.BuscarCEP(sCEP: String): TEndereco;
begin
  if sCEP.IsEmpty then
    raise Exception.Create('CEP esta em banco, informe um numero de CEP');
  try
    RESTClient1.BaseURL := 'http://viacep.com.br/ws/' + sCEP + '/json';
    RESTRequest1.Execute;
  except on E: Exception do
    raise E.Create('CEP invalido, ou voce esta sdem internet no momento');
  end;
  // Estrutura de retorno.
  {
      "cep": "01001-000",
      "logradouro": "Praça da Sé",
      "complemento": "lado ímpar",
      "bairro": "Sé",
      "localidade": "São Paulo",
      "uf": "SP",
      "unidade": "",
      "ibge": "3550308",
      "gia": "1004"
  }

  try
    Result := TEndereco.Create;
    Result.codigo_cep       := RESTResponse1.JSONValue.GetValue<String>('cep');
    Result.rua_cep          := RESTResponse1.JSONValue.GetValue<String>('logradouro');
    Result.complemento_cep  := RESTResponse1.JSONValue.GetValue<String>('complemento');
    Result.bairro_cep       := RESTResponse1.JSONValue.GetValue<String>('bairro');
    Result.uf_cep           := RESTResponse1.JSONValue.GetValue<String>('uf');
    Result.cidade_codigo_cep:= RESTResponse1.JSONValue.GetValue<String>('ibge');
    Result.cidade_nome_cep  := RESTResponse1.JSONValue.GetValue<String>('localidade');
  except on E: Exception do
    ShowMessage( 'Não foi possivel consultar o CEP, pode ser um problema de internet');
  end;

end;

end.
