unit AL.Cliente.Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  System.Actions, FMX.ActnList, FMX.ListBox, FMX.Layouts, FMX.Edit,
  FMX.SearchBox ;

type
  TFrmALClienteMenu = class(TForm)
    mtvMenu: TMultiView;
    ToolBar1: TToolBar;
    StyleBook1: TStyleBook;
    btnMenu: TButton;
    ActionList1: TActionList;
    actMenu: TAction;
    ImageList1: TImageList;
    btnConfigurar: TButton;
    actSair: TAction;
    btnSair: TButton;
    actConfigurar: TAction;
    ListBox1: TListBox;
    SearchBox1: TSearchBox;
    ListBoxItem1: TListBoxItem;
    lyCliente: TLayout;
    procedure actMenuExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmALClienteMenu: TFrmALClienteMenu;

implementation

{$R *.fmx}

uses AL.Cliente.DmDados, AL.Cliente.Padrao;

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
  FrmALClientePadrao.Show;
  lyCliente.AddObject(FrmALClientePadrao);
end;

end.
