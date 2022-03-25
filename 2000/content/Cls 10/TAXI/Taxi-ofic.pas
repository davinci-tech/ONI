{$b-,r-,q-,s-}
{$M 65000,0,655360}
type
    vector=array[0..10000] of byte;
var
   a:array[0..10000] of real;
   t:^vector;
   pret:array[1..101] of real;
   km:array[1..101] of longint;
   x,i,j,k,n,nr:longint;
   tarif,aux:real;
   f:text;

procedure citire;
begin
     assign(f,'taxi.in');
     reset(f);
     readln(f,aux); n:=round(aux*100);
     readln(f,tarif);
     tarif:=tarif/100;
     nr:=0;
     while not seekeof(f) do
           begin
                inc(nr);
                read(f,aux); km[nr]:=round(aux*100);
                readln(f,pret[nr]);
           end;
     inc(nr); km[nr]:=1; pret[nr]:=tarif;
     close(f);
end;

procedure dinamica;
begin
     fillchar(a,sizeof(a),0);
     new(t);
     for i:=1 to n do
         for j:=1 to nr do
             if (i>=km[j]) and ( (a[i-km[j]]<>0) or (i-km[j]=0) ) and ( (a[i]=0) or (a[i]>=a[i-km[j]]+pret[j]) )
                then
                    begin
                         a[i]:=a[i-km[j]]+pret[j];
                         t^[i]:=j;
                    end;
end;

procedure afisare;
begin
     assign(f,'taxi.out');
     rewrite(f);
     writeln(f,a[n]:0:3);
     while n>0 do
           begin
                x:=0;
                while (n>0) and (t^[n]=nr) do
                      begin
                           inc(x);
                           n:=n-km[t^[n]];
                      end;
                if x<>0
                   then write(f,'-',x/100:0:2,' ')
                   else
                       begin
                            write(f,t^[n],' ');
                            n:=n-km[t^[n]];
                       end;
           end;
     close(f);
end;

begin
     citire;
     dinamica;
     afisare;
end.