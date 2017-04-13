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

  Result.host_reg      := iniConfig.ReadString('MONGODB','HOST'     ,'');
  Result.porta_reg     := StrToIntDef(iniConfig.ReadString('MONGODB','PORTA'    ,''),0);
  Result.data_base_reg := iniConfig.ReadString('MONGODB','DATABASE' ,'');
  Result.user_name_reg := iniConfig.ReadString('MONGODB','USERNAME' ,'');
  Result.pass_word_reg := iniConfig.ReadString('MONGODB','PASSWORD' ,'');
  //SISTEMA
  Result.banco_reg     := iniConfig.ReadString('SISTEMA','BANCO' ,'');

  FreeAndNil(iniConfig);
end;

end.
