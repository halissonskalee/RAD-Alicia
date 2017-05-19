unit AL.Componente.TLabel;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TALLabel = class(TLabel)
  private
    { Private declarations }
  protected
    procedure SetName(const Value: TComponentName); override;
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('AL', [TALLabel]);
end;

{ TALLabel }

procedure TALLabel.SetName(const Value: TComponentName);
begin
  AutoSize := False;
  inherited;
  AutoSize := True;
end;

end.
