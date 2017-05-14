unit AL.Classe.Pessoa;

interface

uses AL.Classe.Padrao, REST.Json, FireDAC.Phys.MongoDBWrapper,
     AL.Persistencia, AL.Classe.Endereco, AL.Tipo;

type
  TPessoa = class(TPadrao)
  private
    F_id: integer;
    Fcpf_cnpj_pes: String;
    Frazao_social_pes: string;
    Ftipo_pes: String;
    Fdt_cadastro_pes: TDate;
    FGetConMongo: TALMongoConnection;
    FGetEnv: TALMongoEnv;
    FGetBanco: TALDataBase;
    Fendereco_principal: TEndereco;
    procedure Set_id(const Value: integer);
    procedure Setcpf_cnpj_pes(const Value: String);
    procedure Setrazao_social_pes(const Value: string);
    procedure Settipo_pes(const Value: String);
    procedure Setdt_cadastro_pes(const Value: TDate);
    procedure SetGetBanco(const Value: TALDataBase);
    procedure SetGetConMongo(const Value: TALMongoConnection);
    procedure SetGetEnv(const Value: TALMongoEnv);
    procedure Setendereco_principal(const Value: TEndereco);

  public
    function Insert    : Boolean;
    function Update    : Boolean;
    function GetTabela: string;

    constructor Create ;
    property _id              : integer read F_id write Set_id;
    property razao_social_pes : string read Frazao_social_pes write Setrazao_social_pes;
    property dt_cadastro_pes  : TDate read Fdt_cadastro_pes write Setdt_cadastro_pes;
    property tipo_pes         : String read Ftipo_pes write Settipo_pes;
    property cpf_cnpj_pes     : String read Fcpf_cnpj_pes write Setcpf_cnpj_pes;




    property endereco_principal : TEndereco read Fendereco_principal write Setendereco_principal;

  end;

implementation

uses
  FireDAC.Phys.MongoDBDataSet;

{ TPessoa }

constructor TPessoa.Create;
begin
  endereco_principal := TEndereco.Create;
end;

function TPessoa.GetTabela: string;
begin
  Result := 'PESSOA';
end;

procedure TPessoa.Setcpf_cnpj_pes(const Value: String);
begin
  Fcpf_cnpj_pes := Value;
end;

procedure TPessoa.Setdt_cadastro_pes(const Value: TDate);
begin
  Fdt_cadastro_pes := Value;
end;



procedure TPessoa.Setendereco_principal(const Value: TEndereco);
begin
  Fendereco_principal := Value;
end;

procedure TPessoa.SetGetBanco(const Value: TALDataBase);
begin
  FGetBanco := Value;
end;

procedure TPessoa.SetGetConMongo(const Value: TALMongoConnection);
begin
  FGetConMongo := Value;
end;

procedure TPessoa.SetGetEnv(const Value: TALMongoEnv);
begin
  FGetEnv := Value;
end;

{procedure TPessoa.Setendereco_principal(const Value: TEndereco);
begin
  Fendereco_principal := Value;
end;}

procedure TPessoa.Setrazao_social_pes(const Value: string);
begin
  Frazao_social_pes := Value;
end;


procedure TPessoa.Settipo_pes(const Value: String);
begin
  Ftipo_pes := Value;
end;

procedure TPessoa.Set_id(const Value: integer);
begin
  F_id := Value;
end;


function TPessoa.Insert: Boolean;
var
  oDoc : TMongoDocument;
begin
  oDoc := GetEnv.NewDoc;

  oDoc
    .Add('_id' , _id)
    .Add('razao_social_pes',razao_social_pes)
    .Add('dt_cadastro_pes',dt_cadastro_pes)
    .Add('tipo_pes', tipo_pes)
    .Add('cpf_cnpj_pes', cpf_cnpj_pes)
    .BeginObject('endereco_principal')
      .Add('uf_cep'           ,endereco_principal.uf_cep)
      .Add('codigo_cep'       ,endereco_principal.codigo_cep)
      .Add('cidade_codigo_cep',endereco_principal.cidade_codigo_cep)
      .Add('cidade_nome_cep'  ,endereco_principal.cidade_nome_cep)
      .Add('rua_cep'          ,endereco_principal.rua_cep)
      .Add('numero_cep'       ,endereco_principal.numero_cep)
      .Add('bairro_cep'       ,endereco_principal.bairro_cep)
      .Add('complemento_cep'  ,endereco_principal.complemento_cep)
    .EndObject;



  GetConMongo[GetBanco][GetTabela].Insert(oDoc);


end;


function TPessoa.Update: Boolean;
var
  oUpd : TMongoUpdate;
begin
  oUpd := TMongoUpdate.Create(GetEnv);

  oUpd
    .Match()
      .Add('_id',_id)
    .&End
    .Modify()
      .&Set()
        .Field('razao_social_pes',razao_social_pes)
        .Field('dt_cadastro_pes' ,dt_cadastro_pes)
        .Field('tipo_pes'        ,tipo_pes)
        .Field('cpf_cnpj_pes'    ,cpf_cnpj_pes)
        .Field('endereco_principal.uf_cep'           ,endereco_principal.uf_cep)
        .Field('endereco_principal.codigo_cep'       ,endereco_principal.codigo_cep)
        .Field('endereco_principal.cidade_codigo_cep',endereco_principal.cidade_codigo_cep)
        .Field('endereco_principal.cidade_nome_cep'  ,endereco_principal.cidade_nome_cep)
        .Field('endereco_principal.rua_cep'          ,endereco_principal.rua_cep)
        .Field('endereco_principal.numero_cep'       ,endereco_principal.numero_cep)
        .Field('endereco_principal.bairro_cep'       ,endereco_principal.bairro_cep)
        .Field('endereco_principal.complemento_cep'  ,endereco_principal.complemento_cep)
      .&End
    .&End;

 GetConMongo[GetBanco][GetTabela].Update(oUpd);
end;



end.
