unit AL.Classe.Endereco;

interface

uses AL.Classe.Padrao, REST.Json, FireDAC.Phys.MongoDBWrapper, AL.Persistencia;

type
  TEndereco = class(TPadrao)
  private
    Frua_cep: String;
    Fbairro_cep: string;
    Fuf_cep: String;
    Fcidade_nome_cep: String;
    Fcodigo_cep: String;
    Fnumero_cep: String;
    Fcomplemento_cep: String;
    Fcidade_codigo_cep: String;
    procedure Setbairro_cep(const Value: string);
    procedure Setcidade_codigo_cep(const Value: String);
    procedure Setcidade_nome_cep(const Value: String);
    procedure Setcodigo_cep(const Value: String);
    procedure Setcomplemento_cep(const Value: String);
    procedure Setnumero_cep(const Value: String);
    procedure Setrua_cep(const Value: String);
    procedure Setuf_cep(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
  property uf_cep  :String read Fuf_cep write Setuf_cep;
  property codigo_cep :String read Fcodigo_cep write Setcodigo_cep;
  property cidade_codigo_cep :String read Fcidade_codigo_cep write Setcidade_codigo_cep;
  property cidade_nome_cep :String read Fcidade_nome_cep write Setcidade_nome_cep;
  property rua_cep :String read Frua_cep write Setrua_cep;
  property numero_cep :String read Fnumero_cep write Setnumero_cep;
  property bairro_cep :string read Fbairro_cep write Setbairro_cep;
  property complemento_cep :String read Fcomplemento_cep write Setcomplemento_cep;





end;

implementation

{ TEndereco }

procedure TEndereco.Setbairro_cep(const Value: string);
begin
  Fbairro_cep := Value;
end;

procedure TEndereco.Setcidade_codigo_cep(const Value: String);
begin
  Fcidade_codigo_cep := Value;
end;

procedure TEndereco.Setcidade_nome_cep(const Value: String);
begin
  Fcidade_nome_cep := Value;
end;

procedure TEndereco.Setcodigo_cep(const Value: String);
begin
  Fcodigo_cep := Value;
end;

procedure TEndereco.Setcomplemento_cep(const Value: String);
begin
  Fcomplemento_cep := Value;
end;

procedure TEndereco.Setnumero_cep(const Value: String);
begin
  Fnumero_cep := Value;
end;

procedure TEndereco.Setrua_cep(const Value: String);
begin
  Frua_cep := Value;
end;

procedure TEndereco.Setuf_cep(const Value: String);
begin
  Fuf_cep := Value;
end;

end.
