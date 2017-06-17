// Expressoes regulares
// System.RegularExpressions
// TRegEx.IsMatch()

unit AL.Cliente.Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  System.Actions, FMX.ActnList, FMX.ListBox, FMX.Layouts, FMX.Edit,
  FMX.SearchBox, FMX.DateTimeCtrls, System.Generics.Collections,
  AL.Cliente.Padrao, FMX.TabControl, System.RegularExpressions,
  AL.Componente.TEdit, FMX.Objects, AL.Componente.TComboBox, FMX.ScrollBox,
  FMX.Memo, AL.Componente.TLabel;

type
  TFrmALClienteMenu = class(TForm)
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    actMenu: TAction;
    actSair: TAction;
    actConfigurar: TAction;
    lySistema: TLayout;
    StyleBook1: TStyleBook;
    lyMenssagem: TLayout;
    lyCliente: TLayout;
    btnMenu: TButton;
    Panel7: TPanel;
    ALLabel5: TALLabel;
    Image5: TImage;
    btnConfigurar: TButton;
    Panel1: TPanel;
    ALLabel1: TALLabel;
    Image1: TImage;
    btnSair: TButton;
    Panel2: TPanel;
    ALLabel2: TALLabel;
    Image2: TImage;
    actPessoa: TAction;
    FlowLayout1: TFlowLayout;
    btnPessoa: TButton;
    ALLabel3: TALLabel;
    Image3: TImage;
    Panel3: TPanel;
    procedure actSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ALEdit1ALOnValidate(Sender: TObject; var Text: string);
    procedure ALEdit1ALOnValidating(Sender: TObject; var Text: string);
    procedure actMenuExecute(Sender: TObject);
    procedure actPessoaExecute(Sender: TObject);

  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmALClienteMenu: TFrmALClienteMenu;

implementation

{$R *.fmx}

uses AL.Cliente.DmDados, AL.Cliente.Pessoa, AL.Cliente.CEP,
     AL.Rotinas, AL.Cliente.Senha, FireDAC.Phys.MongoDBWrapper;

procedure TFrmALClienteMenu.actMenuExecute(Sender: TObject);
begin
//
end;

procedure TFrmALClienteMenu.actPessoaExecute(Sender: TObject);
begin
  if Assigned(FrmALClientePessoa) then
    FrmALClientePessoa.Fechar;

  FrmALClientePessoa := TFrmALClientePessoa.Create(Self);
  lyCliente.AddObject(FrmALClientePessoa.lyCliente);

end;

procedure TFrmALClienteMenu.actSairExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmALClienteMenu.ALEdit1ALOnValidate(Sender: TObject;
  var Text: string);
begin
  //
end;

procedure TFrmALClienteMenu.ALEdit1ALOnValidating(Sender: TObject;
  var Text: string);
begin
  Sleep(10);
end;

procedure TFrmALClienteMenu.FormCreate(Sender: TObject);
begin
  FrmALClienteSenha   := TFrmALClienteSenha.Create(self);
  lyMenssagem.AddObject(FrmALClienteSenha.lySenha);
end;

end.
