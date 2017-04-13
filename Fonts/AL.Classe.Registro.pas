unit AL.Classe.Registro;

interface

uses REST.Json;

type
  TRegistro = class
  private
    FDataBase: String;
    FPassWord: String;
    FHost: String;
    FPorta: integer;
    FUserName: String;
    FBanco: String;


    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }


    property Host    : String   read FHost     write FHost;
    property Porta   : integer  read FPorta    write FPorta;
    property DataBase: String   read FDataBase write FDataBase;
    property UserName: String   read FUserName write FUserName;
    property PassWord: String   read FPassWord write FPassWord;
    property Banco   : String   read FBanco    write FBanco;

    function AsJSON :String;
end;

implementation

{ TRegistro }

function TRegistro.AsJSON: String;
begin
  Result := TJson.ObjectToJsonString(Self,[]);
end;

end.
