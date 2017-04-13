unit AL.Cliente.Registro;

interface

Uses AL.Classe.Registro,System.IniFiles, System.SysUtils;

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

    iniConfig.WriteString('SISTEMA', 'BANCO', '');


    iniConfig.UpdateFile;
  end;

  Result := TRegistro.Create;

  Result.Host     := iniConfig.ReadString('MONGODB','HOST'     ,'');
  Result.Porta    := StrToIntDef(iniConfig.ReadString('MONGODB','PORTA'    ,''),0);
  Result.DataBase := iniConfig.ReadString('MONGODB','DATABASE' ,'');
  Result.UserName := iniConfig.ReadString('MONGODB','USERNAME' ,'');
  Result.PassWord := iniConfig.ReadString('MONGODB','PASSWORD' ,'');

  Result.Banco    := iniConfig.ReadString('SISTEMA','BANCO' ,'');

  FreeAndNil(iniConfig);
end;

end.
