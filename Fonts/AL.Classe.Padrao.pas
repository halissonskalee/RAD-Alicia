unit AL.Classe.Padrao;

interface

uses REST.Json, FireDAC.Phys.MongoDBWrapper, AL.Persistencia, AL.Tipo;

type
  TPadrao = class
  private
    FGetConMongo: TALMongoConnection;
    FGetEnv: TALMongoEnv;
    FGetBanco: TALDataBase;
    procedure SetGetBanco(const Value: TALDataBase);
    procedure SetGetConMongo(const Value: TALMongoConnection);
    procedure SetGetEnv(const Value: TALMongoEnv);

  protected

  public
    property GetEnv           : TALMongoEnv  read FGetEnv write SetGetEnv;
    property GetConMongo      : TALMongoConnection read FGetConMongo write SetGetConMongo;
    property GetBanco         : TALDataBase read FGetBanco write SetGetBanco;

end;



implementation

{ TPadrao }




{ TPadrao }

procedure TPadrao.SetGetBanco(const Value: TALDataBase);
begin
  FGetBanco := Value;
end;

procedure TPadrao.SetGetConMongo(const Value: TALMongoConnection);
begin
  FGetConMongo := Value;
end;

procedure TPadrao.SetGetEnv(const Value: TALMongoEnv);
begin
  FGetEnv := Value;
end;

end.
