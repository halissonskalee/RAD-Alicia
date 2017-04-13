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
  FMX.Dialogs, AL.Persistencia, AL.Classe.Registro;

type
  TFrmALClienteDmDados = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMongoDriverLink1: TFDPhysMongoDriverLink;
    FDMongoQuery1: TFDMongoQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure Teste;
    { Private declarations }
  public
    { Public declarations }
    FConMongo : TMongoConnection;
    FEnv      : TMongoEnv;
    vRegistro : TRegistro;
    procedure executaSQL(Banco, Collection, SQL: String);
    function CriarPersistencia : TALPersistencia;
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
  Result.ConMongo := FConMongo;
  Result.Env      := FEnv;
  Result.Banco    := vRegistro.Banco;
  Result.Tabela   := '';
end;

procedure TFrmALClienteDmDados.DataModuleCreate(Sender: TObject);
begin
  vRegistro := funRegistro;

  if vRegistro.Host.IsEmpty then
    raise Exception.Create('MongoDB n�o configurado, verifique o arquivo de configura��o');

  if vRegistro.Banco.IsEmpty then
    raise Exception.Create('MongoDB n�o configurado, verifique o arquivo de configura��o, O Banco n�o foi informado');

  try
    FDConnection1.Params.Values['Server']  := vRegistro.Host;
    FDConnection1.Params.Values['DriverID']:= 'Mongo';
    FDConnection1.Connected := true;
  except on E: Exception do
    ShowMessage('MongoDB, n�o foi possivel contar no host' + vRegistro.Host + ' na porta ' + vRegistro.Porta.ToString+ sLineBreak +
                'Verifique as configura��es do arquivo .ini ou do servidor');    
  end;
    
  FConMongo := TMongoConnection(FDConnection1.CliObj);
  FEnv      := FConMongo.Env;

  //dmDados.FConMongo.Env.Monitor.Tracing := false;
  Teste;
end;

procedure TFrmALClienteDmDados.Teste;
var
  vRegistro     : TRegistro;
  vPersistencia : TALPersistencia;
begin
  vRegistro := funRegistro;

  vPersistencia        := CriarPersistencia;
  vPersistencia.Tabela := 'REGISTRO';
  vPersistencia.JSON   := vRegistro.AsJSON;
  vPersistencia.Insert;

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



end.
