//  Expressoes regulares
//  System.RegularExpressions
//  TRegEx.IsMatch()
unit AL.Cliente.Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  System.Actions, FMX.ActnList, FMX.ListBox, FMX.Layouts, FMX.Edit,
  FMX.SearchBox, FMX.DateTimeCtrls, System.Generics.Collections,
  AL.Cliente.Padrao, FMX.TabControl , System.RegularExpressions;

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
    lyCliente: TLayout;
    ListBoxItem2: TListBoxItem;
    StyleBook1: TStyleBook;
    ImageList1: TImageList;
    procedure actMenuExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
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

procedure TFrmALClienteMenu.ListBox1KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkEscape then
    mtvMenu.HideMaster;
end;

procedure TFrmALClienteMenu.ListBoxItem2Click(Sender: TObject);
begin
  mtvMenu.HideMaster;
  if Assigned(FrmALClientePessoa) then
    FrmALClientePessoa.Fechar;

  FrmALClientePessoa := TFrmALClientePessoa.Create(Self);
  lyCliente.AddObject(FrmALClientePessoa.lyCliente);

end;


end.
