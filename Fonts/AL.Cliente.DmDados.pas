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
  FireDAC.Comp.DataSet, FireDAC.Phys.SQLiteVDataSet, FireDAC.Phys.MongoDBDataSet, FMX.Dialogs;

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
    procedure executaSQL(Banco, Collection, SQL: String);
  end;

var
  FrmALClienteDmDados: TFrmALClienteDmDados;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses AL.Cliente.Registro, AL.Cliente.Menu;

{$R *.dfm}


procedure TFrmALClienteDmDados.DataModuleCreate(Sender: TObject);
var
  vRegistro : TRegistro;
begin
  vRegistro := funRegistro;


  if vRegistro.Host.IsEmpty then
    Exception.Create('MongoDB não configurado, verifique o arquivo de configuração');


  try
    FDConnection1.Params.Values['Server']  := vRegistro.Host;
    FDConnection1.Params.Values['DriverID']:= 'Mongo';
    FDConnection1.Connected := true;    
  except on E: Exception do
    ShowMessage('MongoDB, não foi possivel contar no host' + vRegistro.Host + ' na porta ' + vRegistro.Porta.ToString+ sLineBreak +
                'Verifique as configurações do arquivo .ini ou do servidor');    
  end;
    
  FConMongo := TMongoConnection(FDConnection1.CliObj);
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

end.
