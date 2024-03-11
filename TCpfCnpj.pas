unit TCpfCnpj;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask;

type
  TTipoConteudo = (CPF, CNPJ);
  TValidarConteudo = (Sim, Nao);
  TMaskCpfCnpj = class(TMaskEdit)
  private
    FTipoConteudo:TTipoConteudo;
    FValidarConteudo:TValidarConteudo;
    procedure setTipoConteudo(value:TTipoConteudo);
    procedure setValidarConteudi(value:TValidarConteudo);
    procedure adicionaMascara(value:string);
  protected
    { Protected declarations }
  public
    constructor create(AOwner:TComponent);override;
  published
    property TipoConteudo:TTipoConteudo read FTipoConteudo write setTipoConteudo;
    property ValidarConteudo:TValidarConteudo read FValidarConteudo write setValidarConteudi;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Vinicius', [TMaskCpfCnpj]);
end;

procedure TMaskCpfCnpj.adicionaMascara(value:string);
begin
  if value = 'cpf' then
    self.EditMask := '999.999.999-99'
  else
  begin
    if value = 'cnpj'then
      self.EditMask := '99.999.9999/9999-99'
  end;
end;

constructor TMaskCpfCnpj.create(AOwner:TComponent);
begin
  inherited;
  adicionaMascara(FTipoConteudo);
end;

procedure TMaskCpfCnpj.setTipoConteudo(value:TTipoConteudo);
begin
  FTipoConteudo:= value;
end;

procedure TMaskCpfCnpj.setValidarConteudi(value:TValidarConteudo);
begin
  FValidarConteudo:= value;
end;

end.
