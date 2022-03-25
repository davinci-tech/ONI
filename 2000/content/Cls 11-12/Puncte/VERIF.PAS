program verificator;
{$I PUNCTAJ.INC}
{
  Parametrii :
   1 - fisier de intrare
   2 - fisier iesire comisie
   3 - fisier iesire concurent
   4 - numarul testului
}
type mu=set of byte;
var f,g:text;
    swf,swg,n:integer;
    i,nr,sw,l,j,k,mf:integer;
    x,y:array[1..3001]of integer;
    w:mu;
procedure eroare(s:string;p:integer);
 begin
  writeln(s);
  punctaj(paramstr(4),p);
  halt;
 end;
function nr_el_mu(m:mu):byte;
var i,nr:byte;
begin
 nr:=0;
 for i:=0 to 255 do
  if i in m then inc(nr);
 nr_el_mu:=nr;
end;

function nr_el_mul(i1,i2,i3,i4,i5,i6:integer):integer;
 var k:integer;
begin
 k:=6;
 if (i2=i1) then dec(k);
 if (i3=i1) or (i3=i2) then dec(k);
 if (i4=i1) or (i4=i2) or (i4=i3) then dec(k);
 if (i5=i1) or (i5=i2) or (i5=i3) or (i5=i4) then dec(k);
 if (i6=i1) or (i6=i2) or (i6=i3) or (i6=i4) or (i6=i5) then dec(k);
 nr_el_mul:=k;
end;

begin
 assign(f,paramstr(1));
 reset(f);
 readln(f,n);readln(f,k);
 close(f);
 assign(g,paramstr(2));
 reset(g);
 assign(f,paramstr(3));
 {$I-}
 reset(f);
 {$I+}
 if ioresult<>0 then eroare('Fisier de iesire inexistent',0);
  begin
   {$I-}
    readln(f,swf);
    mf:=0;
    while not seekeof(f) do
     begin inc(mf);readln(f,x[mf],y[mf]);end;
   {$I+}
   if ioresult<>0 then eroare('Fisier de iesire cu format incorect!',0);
   readln(g,swg);
   if swg<>swf then eroare('Raspuns gresit',0)
            else
    if swg=1 then
     begin
      if mf<>k then eroare('Numarul de segmente este diferit de k.',0);
      for i:=1 to mf do
       if (x[i]<1)or(x[i]>n)or(y[i]<1)or(y[i]>n) then
             eroare('Indici de puncte in afara multimii {1,...,n}',0);
      for i:=1 to mf do
      begin
         if nr_el_mul(x[i],y[i],x[i],y[i],x[i],y[i])<=1 then
           eroare('Exista perechi de numere care nu reprezinta este segmente!',0);
       for j:=i+1 to mf do
       begin
         if nr_el_mul(x[i],y[i],x[j],y[j],x[j],y[j])<=2 then
           eroare('Segment dublat!',0);
        for l:=j+1 to mf do
         begin
{          w:=[x[i],y[i],x[j],y[j],x[l],y[l]];
          if nr_el_mu(w)=3 then eroare('Exista triunghiuri!',0)}
          if (nr_el_mul(x[i],y[i],x[j],y[j],x[l],y[l])=3) then
             eroare('Exista triunghiuri!',0)
         end;
      end;
      end;
     end;
  end;

 close(f);
 close(g);
 eroare('Corect',10);
end.