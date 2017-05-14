unit AL.Classe.Padrao;

interface

uses REST.Json, FireDAC.Phys.MongoDBWrapper, AL.Persistencia, AL.Tipo;

type
  TPadrao = class
  private
    FGetConMongo: TALMongoConnection;
    FGetEnv: TALMongoEnv;
    FGetBanco: TALDataBase;
    FGetFDCon: TALFDConnection;
    procedure SetGetBanco(const Value: TALDataBase);
    procedure SetGetConMongo(const Value: TALMongoConnection);
    procedure SetGetEnv(const Value: TALMongoEnv);
    procedure SetGetFDCon(const Value: TALFDConnection);

  protected

  public
    function GetTabela: string; virtual;
    property GetEnv           : TALMongoEnv  read FGetEnv write SetGetEnv;
    property GetConMongo      : TALMongoConnection read FGetConMongo write SetGetConMongo;
    property GetBanco         : TALDataBase read FGetBanco write SetGetBanco;
    property GetFDCon         : TALFDConnection  read FGetFDCon write SetGetFDCon;

end;



implementation

{ TPadrao }




{ TPadrao }

function TPadrao.GetTabela: string;
begin

end;

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

procedure TPadrao.SetGetFDCon(const Value: TALFDConnection);
begin
  FGetFDCon := Value;
end;

end.
