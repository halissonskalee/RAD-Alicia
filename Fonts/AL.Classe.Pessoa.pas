unit AL.Classe.Pessoa;

interface

uses REST.Json;

type
  TPessoa = class
  private
    F_id: integer;


    Fcpf_cnpj_pes: String;
    Frazao_social_pes: string;
    Ftipo_pes: String;
    Fdt_cadastro_pes: String;

    procedure Set_id(const Value: integer);
    procedure Setcpf_cnpj_pes(const Value: String);

    procedure Setrazao_social_pes(const Value: string);
    procedure Settipo_pes(const Value: String);
    procedure Setdt_cadastro_pes(const Value: String);


    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function AsJSON: String;

    property _id: integer read F_id write Set_id;
    property razao_social_pes : string read Frazao_social_pes write Setrazao_social_pes;
    property dt_cadastro_pes  : String read Fdt_cadastro_pes write Setdt_cadastro_pes;
    property tipo_pes         : String  read Ftipo_pes write Settipo_pes;
    property cpf_cnpj_pes     : String read Fcpf_cnpj_pes write Setcpf_cnpj_pes;


  end;

implementation

{ TPessoa }


function TPessoa.AsJSON: String;
begin
  Result := TJson.ObjectToJsonString(Self,[]);
end;

procedure TPessoa.Setcpf_cnpj_pes(const Value: String);
begin
  Fcpf_cnpj_pes := Value;
end;

procedure TPessoa.Setdt_cadastro_pes(const Value: String);
begin
  Fdt_cadastro_pes := Value;
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

end.
