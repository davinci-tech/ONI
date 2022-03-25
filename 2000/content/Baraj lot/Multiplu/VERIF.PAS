program verificator;
{$I PUNCTAJ.INC}
{
  Parametrii :
   1 - fisier de intrare
   2 - fisier iesire comisie
   3 - fisier iesire concurent
   4 - numarul testului
}
var f,g:text;
    C,cm:char;
    cod:boolean;

procedure eroare(s:string;p:integer);
 begin
  writeln(s);
  punctaj(paramstr(4),p);
  halt;
 end;

begin
 assign(g,paramstr(2));{SOL AUTOR, AUTOR.SOL}
 reset(g);
 assign(f,paramstr(3));
 {$I-}
 reset(f);
 {$I+}
 if ioresult<>0 then eroare('Fisier de iesire inexistent',0);
 {$I-}
   cod:=true;
   while not seekeof(f) and not seekeof(g) and cod do
     begin
     read(f,c);
     read(g,cm);
     if c<>cm then cod:=false ;
     end;
 {$I+}
 if cod and seekeof(f) and seekeof(g) then eroare('Corect',1)
        else eroare('Rezultat incorect. De la caracterul tau: '+c+' secventa incorecta!',0);
 close(f);
 close(g);

end.