unit AL.Cliente.DmDados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MongoDB,
  FireDAC.Phys.MongoDBDef, System.Rtti, System.JSON.Types, System.JSON.Readers,
  System.JSON.BSON, System.JSON.Builders, FireDAC.Phys.MongoDBWrapper,
  FireDAC.FMXUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.SQLiteVDataSet, FireDAC.Phys.MongoDBDataSet,
  FMX.Dialogs, AL.Persistencia, AL.Classe.Registro, AL.Tipo;

type
  TFrmALClienteDmDados = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMongoDriverLink1: TFDPhysMongoDriverLink;
    FDMongoQuery1: TFDMongoQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FConMongo : TMongoConnection;
    FEnv      : TMongoEnv;
    vRegistro : TRegistro;
    procedure executaSQL(Banco, Collection, SQL: String);
    function CriarPersistencia : TALPersistencia;
    function GetBanco    : String;
    function GetConMongo : TMongoConnection;
    function GetEnv      : TMongoEnv;
  end;


var
  FrmALClienteDmDados: TFrmALClienteDmDados;





implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses AL.Cliente.Registro, AL.Cliente.Menu ;

{$R *.dfm}


function TFrmALClienteDmDados.CriarPersistencia: TALPersistencia;
begin
  Result := TALPersistencia.Create;
  Result.ConMongo := FrmALClienteDmDados.FConMongo;
  Result.Env      := FrmALClienteDmDados.FEnv;
  Result.Banco    := vRegistro.banco_reg;
  Result.Tabela   := '';
end;

procedure TFrmALClienteDmDados.DataModuleCreate(Sender: TObject);
begin
  vRegistro := funRegistro;

  if vRegistro.host_reg.IsEmpty then
    raise Exception.Create('MongoDB não configurado, verifique o arquivo de configuração');

  if vRegistro.banco_reg.IsEmpty then
    raise Exception.Create('MongoDB não configurado, verifique o arquivo de configuração, O Banco não foi informado');



  try
    FDConnection1.Params.Values['Server']  := vRegistro.host_reg;
    FDConnection1.Params.Values['DriverID']:= 'Mongo';
    FDConnection1.Connected := true;
  except on E: Exception do
      ShowMessage('MongoDB, não foi possivel contar no host' + vRegistro.host_reg + ' na porta ' + vRegistro.porta_reg.ToString+ sLineBreak +
                  'Verifique as configurações do arquivo .ini ou do servidor');
  end;
    
  FConMongo := TMongoConnection(FDConnection1.CliObj);
  FEnv      := FConMongo.Env;

  //dmDados.FConMongo.Env.Monitor.Tracing := false;



end;

procedure TFrmALClienteDmDados.DataModuleDestroy(Sender: TObject);
begin
  //FConMongo.Env.Monitor.Tracing := false;
end;

procedure TFrmALClienteDmDados.executaSQL(Banco, Collection, SQL: String);
begin
  FDMongoQuery1.Close;
  FDMongoQuery1.FieldDefs.Clear;

  FDMongoQuery1.DatabaseName := Banco;
  FDMongoQuery1.CollectionName := Collection;
  FDMongoQuery1.Open;

end;







function TFrmALClienteDmDados.GetBanco: String;
begin
  Result :=vRegistro.banco_reg;
end;

function TFrmALClienteDmDados.GetConMongo: TMongoConnection;
begin
  Result := FConMongo;
end;

function TFrmALClienteDmDados.GetEnv: TMongoEnv;
begin
  Result := FEnv;
end;

end.
