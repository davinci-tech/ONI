const
     rez='rezultat.txt';
     eps=0.002;

type
    oferta=record
                 km,pret,castig:real;
                 indice:integer;
           end;
var
   a:array[1..101] of oferta;
   input,output,comisie:string;
   fin,fout,fcom:text;
   aux,cost,cost_c,n,tarif,km,c:real;
   nr,k:integer;

procedure citire;
begin
     assign(fin,input);
     reset(fin);
     readln(fin,n);
     readln(fin,tarif);
     while not seekeof(fin) do
      begin
           inc(nr);
           readln(fin,a[nr].km,a[nr].pret);
           a[nr].castig:=a[nr].pret/a[nr].km;
      end;
     close(fin);
end;

procedure error(msg:string);
var
   f:text;
begin
     assign(f,rez);
     rewrite(f);
     writeln(f,msg);
     close(f);
     halt;
end;

procedure citeste(var f:text;var nr:real);
begin
     {$i-}
     read(f,nr);
     {$i+}
     if ioresult<>0
        then error('Caractere ilegale !');
end;

procedure citesteln(var f:text;var nr:real);
begin
     {$i-}
     readln(f,nr);
     {$i+}
     if ioresult<>0
        then error('Caractere ilegale !');
end;

procedure verif;
var
   scost,scost_c:string;
begin
     assign(fcom,comisie);
     reset(fcom);
     readln(fcom,cost);
     close(fcom);
     assign(fout,output);
     reset(fout);
     citesteln(fout,cost_c);
     if abs(cost-cost_c)>eps
        then
            begin
{                 writeln('Dinamica: ',cost:0:5,'     Greedy:',cost_c:0:5);}
                 error('Cost incorect !  ');
            end;
     c:=0; km:=0;
     while not seekeoln(fout) do
           begin
                citeste(fout,aux);
                if aux>0
                   then
                       begin
                            k:=trunc(aux);
                            km:=km+a[k].km;
                            c:=c+a[k].pret;
                       end
                   else
                       begin
                            km:=km+abs(aux);
                            c:=c+tarif*abs(aux);
                       end;
           end;
     if abs(km-n)>0.01
        then error('Numar de km incorect !');
     if abs(c-cost_c)>0.001
        then error('Costul nu corespunde cu cel afisat');
     error('OK !!!');
     close(fout);
end;

begin
     input:=paramstr(1);
     output:=paramstr(2);
     comisie:=paramstr(3);
     citire;
     verif;
end.