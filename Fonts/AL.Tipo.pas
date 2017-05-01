unit AL.Tipo;

interface
uses AL.Classe.Padrao, REST.Json, FireDAC.Phys.MongoDBWrapper;

type TALMongoConnection = function :TMongoConnection of object;
type TALMongoEnv        = function :TMongoEnv of object;
type TALDataBase        = function :String of object;

implementation

end.
