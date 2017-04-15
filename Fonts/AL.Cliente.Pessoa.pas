unit AL.Cliente.Pessoa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  AL.Cliente.Padrao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.MongoDBDataSet, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Edit, FMX.SearchBox, FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation,
  FMX.DateTimeCtrls , AL.Classe.Pessoa;

type
  TFrmALClientePessoa = class(TFrmALClientePadrao)
    Label1: TLabel;
    edt_id: TEdit;
    Label2: TLabel;
    edtrazao_social_pes: TEdit;
    edtdt_cadastro_pes: TDateEdit;
    Cadastro: TLabel;
    cmbvtipo_pes: TComboBox;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Pessoa : TPessoa;
  public
    function SalvarBefore: Boolean; override;
    function Salvar: Boolean; override;
    { Public declarations }

  end;

var
  FrmALClientePessoa: TFrmALClientePessoa;

implementation

{$R *.fmx}


procedure TFrmALClientePessoa.FormCreate(Sender: TObject);
begin
  inherited;
  Pessoa := TPessoa.Create;
end;

function TFrmALClientePessoa.Salvar: Boolean;
begin
  Pessoa._id              := StrToIntDef(edt_id.Text,0) ;
  Pessoa.razao_social_pes := edtrazao_social_pes.Text;
  Pessoa.dt_cadastro_pes  := FormatDateTime('dd/mm/yyyy',edtdt_cadastro_pes.Date);
  Pessoa.tipo_pes         := cmbvtipo_pes.ItemIndex.ToString;


  Persistencia.Tabela := 'PESSOA';
  Persistencia.JSON   := Pessoa.AsJSON;
  Persistencia.Insert;

  Result := True;

end;

function TFrmALClientePessoa.SalvarBefore: Boolean;
begin
  Result := True;
end;

end.
