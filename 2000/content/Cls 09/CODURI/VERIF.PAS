program eval_permanent;
{
  Parametrii :
   1 - fisier de intrare
   2 - fisier iesire comisie
   3 - fisier iesire concurent
   4 - numarul testului
}

var pt:real;
    s1,s2:string;


procedure eroare(s:string;p:real);
var f:text;
 begin
  assign(f,paramstr(4));
  rewrite(f);
  writeln(f,s);
  close(f);
  halt;
 end;

procedure citire_concurent;
var f:text;
    i:integer;
    gasit:boolean;
    c:char;
    s:string;
begin
  assign(f,paramstr(3));
  {$I-}
  reset(f);
  {$I+}
  if ioresult<>0 then eroare('Fisier de iesire inexistent!',0);
  {$I-}
      readln(f,s1);
  {$I+}
  if ioresult<>0 then eroare('Fisier de iesire cu format incorect!',0);
end;

procedure citire_comisie;
var f:text;
    x,y,z:integer;
begin
  assign(f,paramstr(2));
  reset(f);
  readln(f,s2);
  close(f);
end;

begin
  citire_comisie;
  citire_concurent;
  if s1=s2 then Eroare('Corect!!!', 5)
           else eroare('Gresit!!!', 0);
end.