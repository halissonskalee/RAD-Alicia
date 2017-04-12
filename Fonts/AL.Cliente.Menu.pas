unit AL.Cliente.Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  System.Actions, FMX.ActnList;

type
  TForm2 = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.actMenuExecute(Sender: TObject);
begin
  //
end;

end.
