program eval_permanent;
{
  Parametrii :
   1 - fisier iesire comisie
   2 - fisier iesire concurent
   3 - rezultate evaluare
}

var pt:real;
    s1,s2:string;
    s3,s4:longint;
    fe,fc:text;
    i:1..2;

procedure eroare(s:string; p:real);
var f:text;
 begin
  assign(f,paramstr(3)); rewrite(f);
  writeln(f,s);
  close(f);
  halt;
 end;

procedure citire_concurent;
var i:integer;
    gasit:boolean;
    c:char;
    s:string;
begin
  assign(fe,paramstr(2));
  {$I-}
  reset(fe);
  {$I+}
  if ioresult<>0 then eroare('Fisier de iesire inexistent!', 0);
  {$I-}
      readln(fe, s1);
  {$I+}
  if ioresult<>0 then eroare('Fisier de iesire cu format incorect!', 0);
end;

procedure citire_comisie;
var   x,y,z:integer;
begin
  assign(fc, paramstr(1)); reset(fc);
  readln(fc, s2);
end;

begin
  citire_comisie;
  citire_concurent;
  for i:=1 to 2 do s2[i]:=upcase(s2[i]);
  if s1<>s2 then eroare('Gresit!!!', 0)
  else
  begin
    ReadLn(fc, s3);
    if seekeof(fe) then Eroare('Fisier incomplet!!! ',0)
    else
      begin
       ReadLn(fe, s4);
       if s3=s4 then Eroare('Numar corect!!!', 10)
       else eroare('Numar gresit!!!', 0);
       close(fe);
      end;
    close(fc)
  end;
end.