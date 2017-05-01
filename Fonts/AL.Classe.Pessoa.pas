unit AL.Classe.Pessoa;

interface

uses AL.Classe.Padrao, REST.Json, FireDAC.Phys.MongoDBWrapper,
     AL.Persistencia, AL.Classe.Endereco, AL.Tipo;





type
  TPessoa = class
  private
    F_id: integer;
    Fcpf_cnpj_pes: String;
    Frazao_social_pes: string;
    Ftipo_pes: String;
    Fdt_cadastro_pes: TDate;
    FGetConMongo: TALMongoConnection;
    FGetEnv: TALMongoEnv;
    FGetBanco: TALDataBase;
    procedure Set_id(const Value: integer);
    procedure Setcpf_cnpj_pes(const Value: String);
    procedure Setrazao_social_pes(const Value: string);
    procedure Settipo_pes(const Value: String);
    procedure Setdt_cadastro_pes(const Value: TDate);
    procedure SetGetBanco(const Value: TALDataBase);
    procedure SetGetConMongo(const Value: TALMongoConnection);
    procedure SetGetEnv(const Value: TALMongoEnv);
  public
    function Insert    : Boolean;
    function Update    : Boolean;
    function GetTabela: string;


    property _id              : integer read F_id write Set_id;
    property razao_social_pes : string read Frazao_social_pes write Setrazao_social_pes;
    property dt_cadastro_pes  : TDate read Fdt_cadastro_pes write Setdt_cadastro_pes;
    property tipo_pes         : String read Ftipo_pes write Settipo_pes;
    property cpf_cnpj_pes     : String read Fcpf_cnpj_pes write Setcpf_cnpj_pes;
    property GetEnv           : TALMongoEnv  read FGetEnv write SetGetEnv;
    property GetConMongo      : TALMongoConnection read FGetConMongo write SetGetConMongo;
    property GetBanco         : TALDataBase read FGetBanco write SetGetBanco;


//    property endereco_principal : TEndereco read Fendereco_principal write Setendereco_principal;

  end;

implementation

uses
  FireDAC.Phys.MongoDBDataSet;

{ TPessoa }

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
    .Add('cpf_cnpj_pes', cpf_cnpj_pes);

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
      .&End
    .&End;

 GetConMongo[GetBanco][GetTabela].Update(oUpd);
end;



end.
