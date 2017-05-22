unit AL.Cliente.Senha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit,
  AL.Componente.TEdit;

type
  TFrmALClienteSenha = class(TForm)
    lySenha: TLayout;
    edtSenha: TALEdit;
    edtUsuario: TALEdit;
    pFundo: TPanel;
    btnEntra: TButton;
    btnSair: TButton;
    recSenha: TRectangle;
    AniIndicator1: TAniIndicator;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEntraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmALClienteSenha: TFrmALClienteSenha;

implementation

{$R *.fmx}

uses AL.Cliente.Menu, System.Threading, AL.Cliente.DmDados, AL.Cliente.CEP;

procedure TFrmALClienteSenha.btnEntraClick(Sender: TObject);
begin
  AniIndicator1.Visible := True;
  AniIndicator1.Enabled := True;



  FrmALClienteCEP     := TFrmALClienteCEP.Create(Self);
  FrmALClienteDmDados := TFrmALClienteDmDados.Create(Self);
  FrmALClienteMenu.lyMenssagem.RemoveObject(lySenha);
  FreeAndNil(FrmALClienteSenha);




  AniIndicator1.Visible := False;
  AniIndicator1.Enabled := False;
end;

procedure TFrmALClienteSenha.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmALClienteSenha.FormCreate(Sender: TObject);
var
  Task : Itask;
begin
  Task := TTask.Create(
  procedure
  begin
    Sleep(300);
    edtUsuario.SetFocus;
  end);
  Task.Start;

end;

end.
