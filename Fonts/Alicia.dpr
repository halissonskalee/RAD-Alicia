program Alicia;

uses
  System.StartUpCopy,
  FMX.Forms,
  AL.Cliente.Menu in 'AL.Cliente.Menu.pas' {FrmALClienteMenu},
  AL.Cliente.DmDados in 'AL.Cliente.DmDados.pas' {FrmALClienteDmDados: TDataModule},
  AL.Cliente.Registro in 'AL.Cliente.Registro.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmALClienteMenu, FrmALClienteMenu);
  Application.Run;
end.
