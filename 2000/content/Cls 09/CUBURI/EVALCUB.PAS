var f,g,h:text;
    a,b,c,d,x,y,z:integer;
    ae,be,ce,de,xe,ye,ze:integer;
    t:string;
    ok:boolean;
function citeste(var a:integer;var f:text):boolean;
begin
     {$I- } REad(f,a); {$I+}
     citeste:=ioresult=0;
end;
begin
     t:=paramstr(1);
     assign(f,'cuburi.out');
     assign(g,t);
     assign(h,'cuburi.rez');
     rewrite(h);
     reset(f);
     reset(g);
     read(g,a);
     ok:=false;
     if a<>0 then
             begin
             readln(g,b,c,d);
             x:=0;
             end
             else
             begin
             read(g,x);
             if x<>0 then readln(g,y,z);
             end;
     if seekeof(f) then writeln(h,'PCT=0 fisierul tau este vid')
        else
     if  citeste(ae,f) then
               begin
               if ae=0 then
                   if not seekeoln(f) then writeln(h,'PCT=0 linia 1 contine si alte valori in afara de 0')
                                      else
                       if ae<>a then writeln(h,'PCT=0 succesiunea ta este valida, in realitate nu este valida')
                               else
                                   if not eof(f) then
                                   begin
                                    readln(f);
                                    ok:=true;
                                    end
                                    else writeln(h,'PCT=0 fisierul tau nu contine a doua linie')
                  else
                  if ae<>a then
                         if a=0 then writeln(h,'PCT=0 succesiunea ta este invalida, in realitate este valida')
                                else writeln(h,'PCT=0 cub nou incorect')
                            else
                               if seekeoln(f)  then writeln(h,'PCT=0 date insuficiente in fisierul de iesire')
                                         else
                                     if citeste(be,f) then
                                         if be<>b then writeln(h, 'PCT=0 cub pe care se lipeste incorect')
                                                  else
                                                 if seekeoln(f) then writeln(h,'PCT=0 date insuficiente in fisierul de iesire')
                                                           else
                                                    if citeste(ce,f) then
                                         if ce<>c then writeln(h, 'PCT=0 fata incorecta')
                                         else
                               if seekeoln(f) then writeln(h,'PCT=0 date insuficiente in fisierul de iesire')
                                     else
                                     if citeste(de,f) then
                                         if de<>d then writeln(h, 'PCT=0 cod de eroare incorect ',de,' in loc de ',d)
                                           else
                               if seekeoln(f) then
                                   begin
                                    readln(f);
                                    ok:=true;
                                    end
                                    else writeln(h,'PCT=0 fisierul tau contine mai mult de 4 valori pe prima linie');
   if ok then
     if seekeof(f) then writeln(h,'PCT=0 linia a doua din fisierul tau este vida')
                  else
               if  citeste(xe,f) then
                if xe=0 then
                  if not seekeoln(f) then writeln(h,'PCT=0 linia 2 contine si alte valori in afara de 0')
                      else
                      if xe<>x then writeln(h,'PCT=0 obiectul tau nu e paralelipiped, corect este de dim: ',x,' ',y,' ',z)
                               else writeln(h,'PCT=5  raspuns corect')
                      else
                      if xe<>x then
                               if x=0 then writeln(h,'PCT=0 nu este paralelipiped, valoare nenula')
                          else writeln(h,'PCT=0 prima dimensiune a paralelipipedului ',xe,' incorecta, corect ',x)
                                else
                               if seekeoln(f) then writeln(h,'PCT=0 date insuficiente in fisierul de iesire')
                                     else
                                     if citeste(ye,f) then
         if ye<>y then writeln(h, 'PCT=0 a doua dimensiune a paralelipipedului ',ye,' incorecta, corect ',y)
                                            else
                               if seekeoln(f) then writeln(h,'PCT=0 date insuficiente in fisierul de iesire')
                                     else
                                     if citeste(ze,f) then
                if ze<>z then writeln(h, 'PCT=0 a treia dimensiune a paralelipipedului ',ze,' incorecta, corect ',z)
                                         else
                               if not seekeof(f) then writeln(h,'PCT=0 linia 2 contine si alte valori ')
                                         else writeln(h,'PCT=5  raspuns corect');
   end;
close(f);
close(g);
close(h);
end.
