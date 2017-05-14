unit AL.Tipo;

interface
uses REST.Json, FireDAC.Phys.MongoDBWrapper;

type TALMongoConnection = function :TMongoConnection of object;
type TALMongoEnv        = function :TMongoEnv of object;
type TALDataBase        = function :String of object;

implementation

end.
