unit AL.Cliente.Registro;

interface

uses System.IniFiles, System.SysUtils;

type
  TRegistro = class
  private
    FDataBase: String;
    FPassWord: String;
    FHost: String;
    FPorta: integer;
    FUserName: String;
    procedure SetDataBase(const Value: String);
    procedure SetHost(const Value: String);
    procedure SetPassWord(const Value: String);
    procedure SetPorta(const Value: integer);
    procedure SetUserName(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property Host    : String read FHost write SetHost;
    property Porta   : integer read FPorta write SetPorta;
    property DataBase: String read FDataBase write SetDataBase;
    property UserName: String read FUserName write SetUserName;
    property PassWord: String read FPassWord write SetPassWord;
end;

function funRegistro: TRegistro;

implementation

function funRegistro: TRegistro;
var
  Arquivo   :String;
  iniConfig :TIniFile;
begin
  Arquivo :=  ExtractFilePath(ParamStr(0)) + '\Config.ini';
  iniConfig := TIniFile.Create(Arquivo);
  if not FileExists(Arquivo) then
  begin
    iniConfig.WriteString('MONGODB', 'HOST', '');
    iniConfig.WriteString('MONGODB', 'PORTA', '27017');
    iniConfig.WriteString('MONGODB', 'DATABASE', '');
    iniConfig.WriteString('MONGODB', 'USERNAME', '');
    iniConfig.WriteString('MONGODB', 'PASSWORD', '');
    iniConfig.UpdateFile;
  end;

  Result := TRegistro.Create;

  Result.Host     := iniConfig.ReadString('MONGODB','HOST'     ,'');
  Result.Porta    := StrToIntDef(iniConfig.ReadString('MONGODB','PORTA'    ,''),0);
  Result.DataBase := iniConfig.ReadString('MONGODB','DATABASE' ,'');
  Result.UserName := iniConfig.ReadString('MONGODB','USERNAME' ,'');
  Result.PassWord := iniConfig.ReadString('MONGODB','PASSWORD' ,'');

  FreeAndNil(iniConfig);
end;

{ TRegistro }

procedure TRegistro.SetDataBase(const Value: String);
begin
  FDataBase := Value;
end;

procedure TRegistro.SetHost(const Value: String);
begin
  FHost := Value;
end;

procedure TRegistro.SetPassWord(const Value: String);
begin
  FPassWord := Value;
end;

procedure TRegistro.SetPorta(const Value: integer);
begin
  FPorta := Value;
end;

procedure TRegistro.SetUserName(const Value: String);
begin
  FUserName := Value;
end;

end.
