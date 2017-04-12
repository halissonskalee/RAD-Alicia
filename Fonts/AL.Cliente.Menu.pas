unit AL.Cliente.Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  System.Actions, FMX.ActnList;

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
    procedure actMenuExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmALClienteMenu: TFrmALClienteMenu;

implementation

{$R *.fmx}

uses AL.Cliente.DmDados;

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
end;

end.
