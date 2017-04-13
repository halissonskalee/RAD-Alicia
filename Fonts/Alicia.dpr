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
  AL.Cliente.Pessoa in 'AL.Cliente.Pessoa.pas' {FrmALClientePessoa};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmALClienteMenu, FrmALClienteMenu);
  Application.Run;
end.
