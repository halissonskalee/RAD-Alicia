unit AL.Classe.Padrao;

interface

uses REST.Json, FireDAC.Phys.MongoDBWrapper, AL.Persistencia;

type
  TPadrao = class
  private

  protected
    FConMongo : TMongoConnection;
    FEnv      : TMongoEnv;
    FBanco    : String;
    oUpd      : TMongoUpdate;
    oDoc      : TMongoDocument;
  public
   function GetTabela :String; virtual;
   function SetPersistencia(Persistencia: TALPersistencia): Boolean;
end;



implementation

{ TPadrao }

function TPadrao.GetTabela: String;
begin

end;

function TPadrao.SetPersistencia(Persistencia: TALPersistencia): Boolean;
begin
  FConMongo  := Persistencia.ConMongo;
  FEnv       := Persistencia.Env;
  FBanco     := Persistencia.Banco;
end;

end.
