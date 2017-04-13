unit AL.Classe.Registro;

interface

uses REST.Json;

type
  TRegistro = class
  private
    Fporta_reg: integer;
    F_id: Integer;
    Fbanco_reg: String;
    Fdata_base_reg: String;
    Fpass_word_reg: String;
    Fuser_name_reg: String;
    Fhost_reg: String;
    procedure Set_id(const Value: Integer);
    procedure Setbanco_reg(const Value: String);
    procedure Setdata_base_reg(const Value: String);
    procedure Sethost_reg(const Value: String);
    procedure Setpass_word_reg(const Value: String);
    procedure Setporta_reg(const Value: integer);
    procedure Setuser_name_reg(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }

    property host_reg      : String read Fhost_reg write Sethost_reg;
    property porta_reg     : integer read Fporta_reg write Setporta_reg;
    property data_base_reg : String read Fdata_base_reg write Setdata_base_reg;
    property user_name_reg : String read Fuser_name_reg write Setuser_name_reg;
    property pass_word_reg : String read Fpass_word_reg write Setpass_word_reg;
    property banco_reg     : String read Fbanco_reg write Setbanco_reg;
    property _id           : Integer read F_id write Set_id;

    function AsJSON :String;
end;

implementation

{ TRegistro }

function TRegistro.AsJSON: String;
begin
  Result := TJson.ObjectToJsonString(Self,[]);
end;





procedure TRegistro.Setbanco_reg(const Value: String);
begin
  Fbanco_reg := Value;
end;

procedure TRegistro.Setdata_base_reg(const Value: String);
begin
  Fdata_base_reg := Value;
end;

procedure TRegistro.Sethost_reg(const Value: String);
begin
  Fhost_reg := Value;
end;

procedure TRegistro.Setpass_word_reg(const Value: String);
begin
  Fpass_word_reg := Value;
end;

procedure TRegistro.Setporta_reg(const Value: integer);
begin
  Fporta_reg := Value;
end;

procedure TRegistro.Setuser_name_reg(const Value: String);
begin
  Fuser_name_reg := Value;
end;

procedure TRegistro.Set_id(const Value: Integer);
begin
  F_id := Value;
end;

end.
