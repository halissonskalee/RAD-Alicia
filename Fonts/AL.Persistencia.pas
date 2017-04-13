unit AL.Persistencia;

interface

Uses REST.Json,FireDAC.Phys.MongoDBWrapper , FMX.Dialogs;

type
  TALPersistencia = class
  private
    FBanco: String;
    FTabela: String;
    FEnv: TMongoEnv;
    FConMongo: TMongoConnection;
    FDoc: TMongoDocument;
    FJSON: String;
    procedure SetBanco(const Value: String);
    procedure SetConMongo(const Value: TMongoConnection);
    procedure SetDoc(const Value: TMongoDocument);
    procedure SetEnv(const Value: TMongoEnv);
    procedure SetTabela(const Value: String);
    procedure SetJSON(const Value: String);
  protected
  public
    property ConMongo : TMongoConnection read FConMongo write SetConMongo;
    property Env      : TMongoEnv read FEnv write SetEnv;
    property Doc      : TMongoDocument read FDoc write SetDoc;
    property Tabela   : String read FTabela write SetTabela;
    property Banco    : String read FBanco write SetBanco;
    property JSON     : String read FJSON write SetJSON;


    function Insert : Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TALPersistenciaModelo }



{ TALPersistenciaModelo }

function TALPersistencia.Insert: Boolean;
begin
  try
      Doc         := FEnv.NewDoc;
      Doc.AsJSON  := JSON;
      ConMongo[Banco][Tabela].Insert(Doc);

  except on E: Exception do

    ShowMessage('ERRRO. não foi possivel incluir' +sLineBreak +
                'Banco :' + Banco+ sLineBreak +
                'Tabela:' + Tabela + sLineBreak+
                'Objeto:' + JSON + sLineBreak +
                'MsgErro:' + E.Message)
  end;
end;

procedure TALPersistencia.SetBanco(const Value: String);
begin
  FBanco := Value;
end;

procedure TALPersistencia.SetConMongo(const Value: TMongoConnection);
begin
  FConMongo := Value;
end;

procedure TALPersistencia.SetDoc(const Value: TMongoDocument);
begin
  FDoc := Value;
end;

procedure TALPersistencia.SetEnv(const Value: TMongoEnv);
begin
  FEnv := Value;
end;

procedure TALPersistencia.SetJSON(const Value: String);
begin
  FJSON := Value;
end;

procedure TALPersistencia.SetTabela(const Value: String);
begin
  FTabela := Value;
end;

end.
