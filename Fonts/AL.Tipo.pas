unit AL.Tipo;

interface
uses REST.Json, FireDAC.Phys.MongoDBWrapper, FireDAC.Comp.Client;


type TALTipo            = (Nada,Pessoa,Cep,Valor,Inteiro,Telefone);
type TALMongoConnection = function :TMongoConnection of object;
type TALMongoEnv        = function :TMongoEnv of object;
type TALDataBase        = function :String of object;
type TALFDConnection    = function :TFDConnection of object;


implementation

end.
