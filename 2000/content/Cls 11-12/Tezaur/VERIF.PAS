program verificator;
{
  Parametrii :
   1 - fisier de intrare
   2 - fisier iesire comisie
   3 - fisier iesire concurent
   4 - fisier eroare
}
var f,g,e:text;
    i,sw:longint;
    n,nr:real;

procedure eroare(s:string;p:integer);
 begin
  writeln(e,s);
  close(e);
  close(f);
  close(g);
  halt;
 end;

begin
{ assign(f,paramstr(1));
 reset(f);
 readln(f,n);
 close(f); }
 assign(g,paramstr(2));
 reset(g);
 assign(e,paramstr(4));
 rewrite(e);
 assign(f,paramstr(3));
 {$I-}
 reset(f);
 {$I+}
 if ioresult<>0 then eroare('Iesire inexistent!',0);

  begin
   {$I-}
    readln(f,nr);
   {$I+}
   if ioresult<>0 then eroare('Caractere nepermise!',0);
   readln(g,n);
   if abs(n-nr)>0.1 then eroare('Raspuns gresit!',0)

  end;

 eroare('Corect!',10);
end.