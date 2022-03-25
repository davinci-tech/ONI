{ Andreica Mugurel Ionut }
{ !!! Sursa de 100 de puncte !!! } 

{$M 32000,0,655360}
{$S-,R-,I-}
Program arbore;
type linie=array[1..100] of boolean;
     list=array[1..100] of integer;
     ant=record
         nod:byte;
         {
         vallst:integer;
         }
         end;
     lst=array[1..100] of ant;
var f:text;
    i,j,k,m,n,p,q:integer;
    v,tata:array[0..100] of integer;
    nivel:array[0..100] of integer;
    ok:array[0..1000] of ^linie;
    obt:array[0..1000] of ^list;
    nel:array[1..100] of integer;
    asoc,aux,asocaux:array[1..100] of integer;
    par:array[1..1000] of ^lst;
    suma:integer;

procedure print(nod:byte;cant:integer);
var found:integer;
begin
if (par[cant]^[nod].nod=0) then begin
writeln(f,nod);
                            end
else begin
for found:=1 to cant do
if (ok[found]^[nod]) and
(ok[cant-found]^[par[cant]^[nod].nod])
then break;


print(nod,{par[cant]^[nod].vallst}found);
print(par[cant]^[nod].nod,cant-{par[cant]^[nod].vallst}found);
     end;

end;


procedure parc(nod,tat:integer);
var s:integer;
begin
nivel[nod]:=nivel[tat]+1;
asoc[nod]:=nod;
for s:=1 to n do
if tata[s]=nod then parc(s,nod);
end;

procedure sorti(li,ls:integer);
begin
if (ls-li=1) then begin
{ interschimba }
if (nivel[li]<nivel[ls]) then begin
m:=nivel[li];
nivel[li]:=nivel[ls];
nivel[ls]:=m;
m:=asoc[li];
asoc[li]:=asoc[ls];
asoc[ls]:=m;
                              end;
                  end
else
if (ls-li>1) then begin
sorti(li,(li+ls) div 2);
sorti((li+ls) div 2 +1,ls);
p:=li-1;
i:=li;
m:=(li+ls) div 2;
j:=m+1;

while (i<=m) and (j<=ls) do begin
inc(p);
if nivel[i]>nivel[j] then begin
aux[p]:=nivel[i];
asocaux[p]:=asoc[i];
inc(i);
                          end
else begin
aux[p]:=nivel[j];
asocaux[p]:=asoc[j];
inc(j);
     end;
                            end;
if (i<=m) then begin
for j:=i to m do begin
inc(p);
aux[p]:=nivel[j];
asocaux[p]:=asoc[j];
                 end;
               end
else begin
for i:=j to ls do begin
inc(p);
aux[p]:=nivel[i];
asocaux[p]:=asoc[i];
                  end;
     end;
for i:=li to ls do begin
nivel[i]:=aux[i];
asoc[i]:=asocaux[i];
                   end;
                  end;
end;


begin
assign(f,'arbore.in');
reset(f);
readln(f,n,k);
nivel[0]:=0;
tata[1]:=0;
nel[1]:=0;
readln(f,v[1]);
for i:=2 to n do begin
readln(f,tata[i],v[i]);
nel[i]:=0;
                   end;
close(f);

parc(1,0);
for i:=0 to k do begin

new(ok[i]);
fillchar(ok[i]^,sizeof(ok[i]^),false);

new(obt[i]);
fillchar(obt[i]^,sizeof(obt[i]^),0);
new(par[i]);
fillchar(par[i]^,sizeof(par[i]^),0);
                 end;

assign(f,'arbore.out');
rewrite(f);

sorti(1,n);
for i:=1 to n do begin
ok[v[asoc[i]]]^[asoc[i]]:=true;
nel[asoc[i]]:=1;
obt[1]^[asoc[i]]:=v[asoc[i]];
par[v[asoc[i]]]^[asoc[i]].nod:=0;


if v[asoc[i]]=k then begin
writeln(f,asoc[i]);
close(f);
halt;
		     end;

for j:=1 to i-1 do
if tata[asoc[j]]=asoc[i] then begin
m:=nel[asoc[i]];
for p:=1 to nel[asoc[j]] do
for q:=1 to m do begin
if (not ok[obt[p]^[asoc[j]]+obt[q]^[asoc[i]]]^[asoc[i]])
and (obt[p]^[asoc[j]]+obt[q]^[asoc[i]]<=k)
then begin
inc(nel[asoc[i]]);
obt[nel[asoc[i]]]^[asoc[i]]:=obt[p]^[asoc[j]]+obt[q]^[asoc[i]];
ok[obt[nel[asoc[i]]]^[asoc[i]]]^[asoc[i]]:=true;
suma:=obt[nel[asoc[i]]]^[asoc[i]];
par[suma]^[asoc[i]].nod:=asoc[j];
{
par[suma]^[asoc[i]].vallst:=obt[p]^[asoc[j]];
}
if suma=k then begin
print(asoc[i],suma);
close(f);
halt;
               end;
end;
                 end;
                  end;
                 end;
writeln(f,'-1');
close(f);


end.