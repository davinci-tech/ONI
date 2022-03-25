Program Coduri;
const MaxN=100;
var cod,urm:string;
    nr,n,i:Word;
    fi,fo:Text;

procedure calcul;
var nr_lit:array['a'..'z'] of Word;
    i:Word;
    x:Char;
    ok:Boolean;
begin
  for x:='a' to 'z' do nr_lit[x]:=0;
  i:=n;
  ok:=False;
  while i>0 do
  begin
    Inc(nr_lit[cod[i]]);
    for x:=Succ(cod[i]) to 'z' do
      if nr_lit[x]>0
      then begin ok:=true; Break end;
    if ok then Break;
    Dec(i)
  end;

  if i=0
  then urm:='Este ultimul cod.'
  else
  begin
    Dec(nr_lit[x]);
    cod[i]:=x;
    for x:='a' to 'z' do
    begin
      while nr_lit[x]>0 do
      begin
        Inc(i);
        cod[i]:=x;
        Dec(nr_lit[x])
      end
    end;
    urm:=cod
  end
end;

Begin
  Assign(fi,'COD.IN'); Reset(fi);
  Assign(fo,'COD.OUT'); Rewrite(fo);
    Readln(fi,cod);
    n:=Length(cod);
    calcul;
    Writeln(fo,urm);
  Close(fi);
  Close(fo)
End.