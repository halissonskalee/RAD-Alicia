unit AL.Cliente.Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  System.Actions, FMX.ActnList, FMX.ListBox, FMX.Layouts, FMX.Edit,
  FMX.SearchBox, FMX.DateTimeCtrls, System.Generics.Collections,
  AL.Cliente.Padrao, FMX.TabControl;

type
  TFrmALClienteMenu = class(TForm)
    mtvMenu: TMultiView;
    ToolBar1: TToolBar;
    btnMenu: TButton;
    ActionList1: TActionList;
    actMenu: TAction;
    btnConfigurar: TButton;
    actSair: TAction;
    btnSair: TButton;
    actConfigurar: TAction;
    ListBox1: TListBox;
    SearchBox1: TSearchBox;
    ListBoxItem1: TListBoxItem;
    lyCliente: TLayout;
    ListBoxItem2: TListBoxItem;
    StyleBook1: TStyleBook;
    ImageList1: TImageList;
    procedure actMenuExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmALClienteMenu: TFrmALClienteMenu;

implementation

{$R *.fmx}

uses AL.Cliente.DmDados, AL.Cliente.Pessoa;

procedure TFrmALClienteMenu.actMenuExecute(Sender: TObject);
begin
  //
end;

procedure TFrmALClienteMenu.actSairExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmALClienteMenu.FormCreate(Sender: TObject);
begin
  FrmALClienteDmDados := TFrmALClienteDmDados.Create(Self);
  mtvMenu.Mode        := TMultiViewMode.Drawer;
end;

procedure TFrmALClienteMenu.ListBoxItem1Click(Sender: TObject);
begin
  FrmALClientePadrao := TFrmALClientePadrao.Create(Self);
  lyCliente.AddObject(FrmALClientePadrao.lyCliente);
end;

procedure TFrmALClienteMenu.ListBoxItem2Click(Sender: TObject);
begin
  mtvMenu.HideMaster;
  FrmALClientePessoa := TFrmALClientePessoa.Create(Self);
  lyCliente.AddObject(FrmALClientePessoa.lyCliente);
end;


end.
