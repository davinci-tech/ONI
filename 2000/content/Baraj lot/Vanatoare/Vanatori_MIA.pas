{ Andreica Mugurel Ionut }
{$M 65000,0,200000}
{$S-,I-,R-,Q-}
Program La_Vanatoare;
const lim=170;
var f:text;
    tmp,tmp2,total,try,try2,max,poz,i,j,k,m,n,t1,t2:integer;
    t,l:integer;
    v1,v2,v1last,v2last,tata1,tata2:array[0..300] of integer;
    select:array[1..600] of boolean;
    sel1,sel2,sol1,sol2:array[1..600] of byte;
    pini,paux,asoc,lup,lup2,mis,v,aux:array[1..1500] of integer;
    comun:array[1..1500] of integer;
    nani,nact,nlup,nmis,nl2:integer;
    timp:longint absolute $0:$046c;
    tp2:longint;
    ok:boolean;

procedure print;forward;

procedure back;
var s1,s2:integer;
begin
if nact>nani then nani:=nact;
if (timp-tp2)>=lim then print;
for s1:=1 to nlup do
if (sel1[s1]=0) and (t1+lup[s1]<=t) then begin
sel1[s1]:=1;
t1:=t1+lup[s1];
inc(nact);
if nact>nani then nani:=nact;
if (timp-tp2)>=lim then print;
for s2:=1 to nmis do
if (sel2[s2]=0) and (t2+mis[s2]<=t) then begin
sel2[s2]:=2;
t2:=t2+mis[s2];
inc(nact);
back;
dec(nact);
t2:=t2-mis[s2];
sel2[s2]:=0;
                                         end;
if (timp-tp2)>=lim then print;
for s2:=1 to nlup do
if (sel1[s2]=0) and (t2+lup[s2]<=t) then begin
sel1[s2]:=1;
t2:=t2+lup[s2];
inc(nact);
back;
dec(nact);
t2:=t2-lup[s2];
sel1[s2]:=0;
                                         end;
dec(nact);
sel1[s1]:=0;
t1:=t1-lup[s1];
if (timp-tp2)>=lim then print;
                                         end;
if (timp-tp2)>=lim then print;
for s2:=1 to nmis do
if (sel2[s2]=0) and (t2+mis[s2]<=t) then begin
sel2[s2]:=2;
t2:=t2+mis[s2];
inc(nact);
back;
dec(nact);
t2:=t2-mis[s2];
sel2[s2]:=0;
                                         end;
if (timp-tp2)>=lim then print;
for s2:=1 to nlup do
if (sel1[s2]=0) and (t2+lup[s2]<=t) then begin
sel1[s2]:=1;
t2:=t2+lup[s2];
inc(nact);
back;
dec(nact);
t2:=t2-lup[s2];
sel1[s2]:=0;
                                         end;
end;


procedure print;
begin
assign(f,'vanatori.out');
rewrite(f);
writeln(f,nani);
close(f);
halt;
end;

procedure sorti(li,ls:integer);
begin
if (ls-li=1) then begin
if v[li]>v[ls] then begin
l:=v[li];
v[li]:=v[ls];
v[ls]:=l;
                    end;
                  end
else
if (ls-li>1) then begin
sorti(li,(li+ls) div 2);
sorti((li+ls) div 2+1,ls);
i:=li;
m:=(li+ls) div 2;
j:=m+1;
k:=li-1;

while (i<=m) and (j<=ls) do begin
inc(k);
if (v[i]<v[j]) then begin
aux[k]:=v[i];
inc(i);
                    end
else begin
aux[k]:=v[j];
inc(j);
     end;
                            end;

if (i<=m) then begin
for j:=i to m do begin
inc(k);
aux[k]:=v[j];
                 end;
               end
else
for i:=j to ls do begin
inc(k);
aux[k]:=v[i];
                  end;
for i:=li to ls do begin
v[i]:=aux[i];
                   end;
     end;
end;

begin
tp2:=timp;
assign(f,'vanatori.in');
reset(f);
readln(f,t);
readln(f,nlup,nmis);
total:=nlup+nmis;
for i:=1 to nlup do read(f,lup[i]);
readln(f);
for i:=1 to nmis do read(f,mis[i]);
close(f);

v:=lup;
sorti(1,nlup);
lup:=v;
v:=mis;
sorti(1,nmis);
mis:=v;

{ - Dinamica 1 - }

fillchar(v1,sizeof(v1),0);
fillchar(v2,sizeof(v2),0);
fillchar(v1last,sizeof(v1last),0);
fillchar(v2last,sizeof(v2last),0);
fillchar(select,sizeof(select),false);
fillchar(tata1,sizeof(tata1),0);
fillchar(sel1,sizeof(sel1),0);

for i:=1 to nlup do begin
if v1last[lup[i]]=0 then begin
v1[lup[i]]:=1;
tata1[lup[i]]:=i;
                         end;
for j:=0 to t-lup[i] do
if v1last[j]>0 then
if (v1last[j]+1>v1last[j+lup[i]]) then begin
v1[j+lup[i]]:=v1last[j]+1;
tata1[j+lup[i]]:=i;
                                      end;
v1last:=v1;
                    end;
max:=0;
poz:=0;

for i:=1 to t do if
v1[i]>max then begin
max:=v1[t];
poz:=t;
               end;
nani:=max;
k:=poz;
t1:=k;
while (k>0) do begin
if tata1[k]>0 then begin
select[tata1[k]]:=true;
sel1[tata1[k]]:=1;
                   end;
k:=k-lup[tata1[k]];
               end;

nl2:=0;
for i:=1 to nlup do
if not select[i] then begin
inc(nl2);
lup2[nl2]:=lup[i];
paux[nl2]:=i;
                      end;

{ Interclasare - Lupi ramasi + Mistreti }
i:=1;
j:=1;
k:=0;
while (i<=nl2) and (j<=nmis) do begin
inc(k);
if lup2[i]<mis[j] then begin
comun[k]:=lup2[i];
asoc[k]:=1;
pini[k]:=paux[i];
inc(i);
                       end
else begin
comun[k]:=mis[j];
asoc[k]:=2;
pini[k]:=j;
inc(j);
     end;
                                end;
if (i<=nl2) then begin
for j:=i to nl2 do begin
inc(k);
comun[k]:=lup2[j];
asoc[k]:=1;
pini[k]:=paux[j];
                   end;
                 end
else begin
for i:=j to nmis do begin
inc(k);
comun[k]:=mis[i];
pini[k]:=i;
asoc[k]:=2;
                    end;
     end;

{ - Dinamica 2 - }

fillchar(tata2,sizeof(tata2),0);
for i:=1 to nl2+nmis do begin
if v2last[comun[i]]=0 then begin
v2[comun[i]]:=1;
tata2[comun[i]]:=i;
                           end;
for j:=0 to t-comun[i] do
if v2last[j+comun[i]]<v2last[j]+1 then begin
v2[j+comun[i]]:=v2last[j]+1;
tata2[j+comun[i]]:=i;
                                       end;
v2last:=v2;
                        end;
max:=0;
poz:=0;
for i:=1 to t do
if v2[i]>max then begin
max:=v2[i];
poz:=i;
                  end;
nani:=nani+max;

k:=poz;
t2:=k;
while (k>0) do begin
if (tata2[k]>0) then begin
if asoc[tata2[k]]=1 then begin
sel1[pini[tata2[k]]]:=2;
                         end
else begin
sel2[pini[tata2[k]]]:=2;
     end;
                     end;
k:=k-comun[tata2[k]];
               end;

RandSeed:=997;
ok:=false;
nact:=nani;
t1:=0;
t2:=0;
fillchar(sel1,sizeof(sel1),0);
fillchar(sel2,sizeof(sel2),0);
nact:=0;
back;
print;
end.