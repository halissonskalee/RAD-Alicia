unit AL.Classe.Pessoa;

interface

uses REST.Json, FireDAC.Phys.MongoDBWrapper, AL.Persistencia;

type
  TPessoa = class
  private
    F_id: integer;


    Fcpf_cnpj_pes: String;
    Frazao_social_pes: string;
    Ftipo_pes: String;
    Fdt_cadastro_pes: TDate;


    procedure Set_id(const Value: integer);
    procedure Setcpf_cnpj_pes(const Value: String);

    procedure Setrazao_social_pes(const Value: string);
    procedure Settipo_pes(const Value: String);
    procedure Setdt_cadastro_pes(const Value: TDate);



    { private declarations }
    constructor InternalCreate(const Value : String);


  protected
    { protected declarations }
    FConMongo : TMongoConnection;
    FEnv      : TMongoEnv;
    FBanco    : String;
  public
    { public declarations }
    function GetTabela :String ;
    function AsJSON: String;
    class function FromJSON(const Value : String) : TPessoa;



    function Insert: Boolean;
    function Update : Boolean;
    function SetPersistencia(Persistencia: TALPersistencia): Boolean;

    property _id: integer read F_id write Set_id;
    property razao_social_pes : string read Frazao_social_pes write Setrazao_social_pes;
    property dt_cadastro_pes  : TDate read Fdt_cadastro_pes write Setdt_cadastro_pes;
    property tipo_pes         : String read Ftipo_pes write Settipo_pes;
    property cpf_cnpj_pes     : String read Fcpf_cnpj_pes write Setcpf_cnpj_pes;




  end;

implementation

{ TPessoa }


function TPessoa.AsJSON: String;
begin
  Result := TJson.ObjectToJsonString(Self,[]);
end;

class function TPessoa.FromJSON(const Value: String): TPessoa;
begin
  Result := InternalCreate(Value);
end;

function TPessoa.GetTabela: String;
begin
  Result := 'PESSOA';
end;

constructor TPessoa.InternalCreate(const Value: String);
begin
  Create;
  Self := TJson.JsonToObject<TPessoa>(Value);
end;

procedure TPessoa.Setcpf_cnpj_pes(const Value: String);
begin
  Fcpf_cnpj_pes := Value;
end;

procedure TPessoa.Setdt_cadastro_pes(const Value: TDate);
begin
  Fdt_cadastro_pes := Value;
end;


function TPessoa.SetPersistencia(Persistencia: TALPersistencia): Boolean;
begin
  FConMongo  := Persistencia.ConMongo;
  FEnv       := Persistencia.Env;
  FBanco     := Persistencia.Banco;
end;

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
  oDoc: TMongoDocument;
begin
  oDoc := FEnv.NewDoc;

  oDoc
    .Add('_id' , _id)
    .Add('razao_social_pes',razao_social_pes)
    .Add('dt_cadastro_pes',dt_cadastro_pes)
    .Add('tipo_pes', tipo_pes)
    .Add('cpf_cnpj_pes', cpf_cnpj_pes);

  FConMongo[FBanco][GetTabela].Insert(oDoc);
end;


function TPessoa.Update: Boolean;
var
  MongoUpdate : TMongoUpdate;
begin
  MongoUpdate := TMongoUpdate.Create(FEnv);

  MongoUpdate
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

 FConMongo[FBanco][GetTabela].Update(MongoUpdate);
end;



end.
