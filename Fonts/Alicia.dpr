program Alicia;

uses
  System.StartUpCopy,
  FMX.Forms,
  AL.Cliente.Menu in 'AL.Cliente.Menu.pas' {FrmALClienteMenu},
  AL.Cliente.DmDados in 'AL.Cliente.DmDados.pas' {FrmALClienteDmDados: TDataModule},
  AL.Cliente.Registro in 'AL.Cliente.Registro.pas',
  AL.Cliente.Padrao in 'AL.Cliente.Padrao.pas' {FrmALClientePadrao},
  AL.Cliente.Modelo in 'AL.Cliente.Modelo.pas' {FrmALClienteModelo},
  AL.Classe.Registro in 'AL.Classe.Registro.pas',
  AL.Persistencia in 'AL.Persistencia.pas',
  AL.Classe.Pessoa in 'AL.Classe.Pessoa.pas',
  AL.Cliente.Pessoa in 'AL.Cliente.Pessoa.pas' {FrmALClientePessoa},
  AL.Classe.Endereco in 'AL.Classe.Endereco.pas',
  AL.Classe.Padrao in 'AL.Classe.Padrao.pas',
  AL.Tipo in 'AL.Tipo.pas',
  AL.Cliente.CEP in 'AL.Cliente.CEP.pas' {FrmALClienteCEP: TDataModule},
  AL.Helper.Edit in 'AL.Helper.Edit.pas',
  AL.Classe.Geradore in 'AL.Classe.Geradore.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmALClienteMenu, FrmALClienteMenu);
  Application.Run;
end.
