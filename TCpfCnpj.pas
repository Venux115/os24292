unit TCpfCnpj;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, Dialogs;

type
  TTipoConteudo = (CPF, CNPJ);
  TValidarConteudo = (Sim, Nao);
  TMaskCpfCnpj = class(TMaskEdit)
  private
    FTipoConteudo:TTipoConteudo;
    FValidarConteudo:TValidarConteudo;
    procedure setTipoConteudo(value:TTipoConteudo);
    procedure setValidarConteudi(value:TValidarConteudo);
    procedure adicionaMascara(value:TTipoConteudo);

  protected
    procedure DoExit; override;
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

procedure TMaskCpfCnpj.adicionaMascara(value:TTipoConteudo);
begin
  if value = CPF then
    self.EditMask := '999.999.999-99'
  else
  begin
    if value = CNPJ then
      self.EditMask := '99.999.999  /9999-99'
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
  adicionaMascara(value);
end;

procedure TMaskCpfCnpj.setValidarConteudi(value:TValidarConteudo);
begin
  FValidarConteudo:= value;
end;

function calculaDigito1Cpf(cpf:string):integer;
var
soma, multiplicador, i,resto :integer;
cpfNum:string;
begin
    soma := 0;
    multiplicador:=10;
    for i:=1 to length(cpf)do
    begin
      if (cpf[i] = '0') or (cpf[i] = '1') or (cpf[i] = '2') or (cpf[i] = '3') or (cpf[i] = '4') or (cpf[i] = '5') or (cpf[i] = '6') or (cpf[i] = '7') or (cpf[i] = '8') or(cpf[i] = '9') then
      begin
        cpfNum:= cpfNum + cpf[i];
      end;
    end;
    //cpfNum:=strtointDef(cpf,0);


    for i:=1 to length(cpfNum) - 2 do
    begin
      soma := soma + (strtointDef(cpfNum[i], 0) *multiplicador);
      multiplicador := multiplicador - 1;
    end;

    resto := (soma*10) mod 11;
    if resto = 10 then
      Result := 0
   else
     Result := resto;
end;

function CalculaDigito2Cpf(cpf: string): Integer;
var
  soma, multiplicador, i, resto: Integer;
  cpfNum:string;
begin
  soma := 0;
  multiplicador := 11;
  for i:=1 to length(cpf)do
    begin
      if (cpf[i] = '0') or (cpf[i] = '1') or (cpf[i] = '2') or (cpf[i] = '3') or (cpf[i] = '4') or (cpf[i] = '5') or (cpf[i] = '6') or (cpf[i] = '7') or (cpf[i] = '8') or(cpf[i] = '9') then
      begin
        cpfNum:= cpfNum + cpf[i];
      end;
    end;

  for i := 1 to Length(cpfNum) - 1 do
  begin
    soma := soma + (strtoint(cpfNum[i]) * multiplicador);
    multiplicador := multiplicador - 1;
  end;

  resto := soma*10 mod 11;
  if resto = 10 then
    Result := 0
  else
    Result := resto;
end;

function ValidaCpf(cpf: string): Boolean;
var
  digito1, digito2, i: Integer;
  cpfNum: string;
begin
  for i := 1 to Length(cpf) do
    begin
      if (cpf[i] in ['0'..'9']) then
        cpfNum := cpfNum + cpf[i];
    end;
  if Length(cpfNum) <> 11 then
    Result := False
  else
  begin


    digito1 := CalculaDigito1Cpf(cpfNum);
    digito2 := CalculaDigito2Cpf(cpfNum);

    if (digito1 = StrToInt(cpfNum[10])) and (digito2 = StrToInt(cpfNum[11])) then
      Result := True
    else
      Result := False;
  end;
end;


function CalculaDigito1Cnpj(cnpj:string):Integer;
var
soma, multiplicador, i, resto: Integer;
cnpjNum:string;
begin
soma := 0;
  multiplicador := 5;
 for i:=1 to length(cnpj)do
    begin
      if (cnpj[i] = '0') or (cnpj[i] = '1') or (cnpj[i] = '2') or (cnpj[i] = '3') or (cnpj[i] = '4') or (cnpj[i] = '5') or (cnpj[i] = '6') or (cnpj[i] = '7') or (cnpj[i] = '8') or(cnpj[i] = '9') then
      begin
        cnpjNum:= cnpjNum + cnpj[i];
      end;
    end;

  for i := 1 to Length(cnpj) - 2 do
  begin

    soma := soma + (StrToInt(cnpj[i]) * multiplicador);
    multiplicador := multiplicador - 1;
    if multiplicador = 1 then
      multiplicador := 9;
  end;

   resto := soma mod 11;
  if resto < 2 then
    Result := 0
  else
    Result := 11 - resto;
end;

function CalculaDigito2Cnpj(cnpj: string): Integer;
var
  soma, multiplicador, i, resto: Integer;
  cnpjNum:string;
begin
  soma := 0;
  multiplicador := 6;
   for i:=1 to length(cnpj)do
    begin
      if (cnpj[i] = '0') or (cnpj[i] = '1') or (cnpj[i] = '2') or (cnpj[i] = '3') or (cnpj[i] = '4') or (cnpj[i] = '5') or (cnpj[i] = '6') or (cnpj[i] = '7') or (cnpj[i] = '8') or(cnpj[i] = '9') then
      begin
        cnpjNum:= cnpjNum + cnpj[i];
      end;
    end;

  for i := 1 to Length(cnpj) - 2 do
  begin
    soma := soma + (StrToInt(cnpj[i]) * multiplicador);
    multiplicador := multiplicador - 1;
    if multiplicador < 2 then
      multiplicador := 9; // Reinicia o multiplicador para a segunda parte da f�rmula
  end;

  resto := soma mod 11;
  if resto < 2 then
    Result := 0
  else
    Result := 11 - resto;
end;

function ValidaCnpj(cnpj: string): Boolean;
var
  digito1, digito2,i: Integer;
  cnpjNum:string;
begin
  for i := 1 to Length(cnpj) do
    begin
      if (cnpj[i] in ['0'..'9']) then
        cnpjNum := cnpjNum + cnpj[i];
    end;
  if Length(cnpjNum) <> 14 then
    Result := False
  else



  begin
    digito1 := CalculaDigito1Cnpj(cnpjNum);
    digito2 := CalculaDigito2Cnpj(cnpjNum);

    if (digito1 = StrToInt(cnpjNum[13])) and (digito2 = StrToInt(cnpjNum[14])) then
      Result := True
    else
      Result := False;
  end;
end;

procedure TMaskCpfCnpj.DoExit;
var
validacao:boolean;
begin
  if FValidarConteudo = Sim then
  begin
    if FTipoConteudo = CPF then
    begin
      validacao:=ValidaCpf(Self.Text);
      if validacao = false then
      begin
        self.Clear;
        self.SetFocus;
        showmessage('CPF inv�lido');
      end;
    end
    else
    begin
      validacao :=ValidaCNPJ(self.Text);
      if validacao = false then
      begin
        self.Clear;
        self.SetFocus;
        showmessage('CNPJ inv�lido');
      end;
    end;
  end;
end;

end.
