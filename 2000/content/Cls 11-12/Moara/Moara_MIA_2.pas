{ Andreica Mugurel Ionut }
{ !!! Sursa de +100 de puncte !!! }
{ --- Varianta 2 --- }

{$M 30000,0,655360}
{$S-,I-,R-,Q-}

Program Moara_M_I_A;
label finish;
type vect=array[1..10000] of integer;
     vdif=array[1..10000] of longint;
     mrk=array[1..10000] of boolean;

const CMAX=500000;
      timelim=18;

var f,temp:text;
    poznr,npepoz:vect;
    poznrini,npepozini,asoc,asocaux:^vect;
    dif,aux:^vdif;
    g:array[1..10000] of integer;
    mark:^mrk;
    sus,jos,ef,pozsc,ini,next,min,nmut,i,j,k,m,n,psc:longint;
    i1,j1,m1,k1:integer;
    e:longint;
    s:string;
    fin:boolean;
    t2:longint absolute $0:$046c;
    t1:longint;

procedure sorti(li,ls:integer);
begin
if (ls-li=1) then begin
if dif^[li]>dif^[ls] then begin
sus:=dif^[li];
dif^[li]:=dif^[ls];
dif^[ls]:=sus;
sus:=asoc^[li];
asoc^[li]:=asoc^[ls];
asoc^[ls]:=sus;
                          end;
                  end
else
if (ls-li>1) then begin
sorti(li,(li+ls) div 2);
sorti((li+ls) div 2+1,ls);
k1:=li-1;
i1:=li;
m1:=(li+ls) div 2;
j1:=m1+1;

while (i1<=m1) and (j1<=ls) do begin
inc(k1);
if (dif^[i1]<dif^[j1]) then begin
aux^[k1]:=dif^[i1];
asocaux^[k1]:=asoc^[i1];
inc(i1);
                            end
else begin
aux^[k1]:=dif^[j1];
asocaux^[k1]:=asoc^[j1];
inc(j1);
     end;
                              end;
if (i1<=m1) then begin
for j1:=i1 to m1 do begin
inc(k1);
aux^[k1]:=dif^[j1];
asocaux^[k1]:=asoc^[j1];
                    end;
                end
else
for i1:=j1 to ls do begin
inc(k1);
aux^[k1]:=dif^[i1];
asocaux^[k1]:=asoc^[i1];
                    end;
for i1:=li to ls do begin
dif^[i1]:=aux^[i1];
asoc^[i1]:=asocaux^[i1];
                    end;
                  end;
end;

begin
t1:=t2;
assign(f,'moara.in');
reset(f);
readln(f,n);
for i:=1 to n do begin
read(f,npepoz[i]);
poznr[npepoz[i]]:=i;
                 end;
for i:=1 to n do read(f,g[i]);
close(f);


new(poznrini);
new(npepozini);
for i:=1 to n do begin
poznrini^[i]:=poznr[i];
npepozini^[i]:=npepoz[i];
                 end;

new(dif);
new(aux);
new(asoc);
new(asocaux);
new(mark);

if n<=1000 then begin
pozsc:=0;
ef:=maxlongint;
for m:=1 to n do begin
nmut:=0;
psc:=m;
e:=0;

for i:=1 to n do begin
poznr[i]:=poznrini^[i];
npepoz[i]:=npepozini^[i];
                 end;

for i:=1 to n do begin
dif^[i]:=abs(psc-poznr[i])*g[i]+abs(psc-i)*g[i]
-abs(poznr[i]-i)*g[i];
asoc^[i]:=i;
                 end;
sorti(1,n);

jos:=1;

repeat
fin:=true;

for i:=jos to n do
if (poznr[asoc^[i]]<>asoc^[i]) then
begin
fin:=false;
jos:=i+1;
k:=poznr[asoc^[i]];
break;
end;

if not fin then begin
e:=e+abs(k-psc)*g[npepoz[k]];
inc(nmut);
next:=k;
ini:=npepoz[k];
while (next<>ini) do begin
inc(nmut);
e:=e+abs(next-poznr[next])*g[next];
npepoz[next]:=next;
i:=next;
next:=poznr[next];
poznr[i]:=i;
                          end;
inc(nmut);
e:=e+abs(psc-ini)*g[ini];
poznr[ini]:=ini;
npepoz[ini]:=ini;
                end;
until fin;

if e<ef then begin
pozsc:=psc;
ef:=e;
             end;
if (t2-t1)>=timelim then goto finish;
                 end;
psc:=pozsc;
                end
else begin
fillchar(mark^,sizeof(mark^),false);
ef:=maxlongint;
pozsc:=0;

for m:=1 to CMAX div n do begin
case m of
1:begin
psc:=1;
min:=abs(npepoz[1]-1);
for i:=2 to n do
if abs(npepoz[i]-i)<min then begin
min:=abs(npepoz[i]-i);
psc:=i;
                             end;
mark^[psc]:=true;
  end;
2:begin
psc:=1;
min:=abs(npepoz[1]-1);
for i:=2 to n do
if abs(npepoz[i]-i)>min then begin
min:=abs(npepoz[i]-i);
psc:=i;
                             end;
mark^[psc]:=true;
  end;
3:begin
psc:=0;
min:=10000;
for i:=1 to n do
if ((abs(npepoz[i]-i)<min)
and (abs(npepoz[i]-i)>0))
then begin
min:=abs(npepoz[i]-i);
psc:=i;
     end;
mark^[psc]:=true;
end
else begin
repeat
psc:=random(n)+1;
until (not mark^[psc]);
      end;
end;
{ -- }

nmut:=0;
e:=0;

for i:=1 to n do begin
poznr[i]:=poznrini^[i];
npepoz[i]:=npepozini^[i];
                 end;

for i:=1 to n do begin
dif^[i]:=abs(psc-poznr[i])*g[i]+abs(psc-i)*g[i]
-abs(poznr[i]-i)*g[i];
asoc^[i]:=i;
                 end;
sorti(1,n);

jos:=1;

repeat
fin:=true;

for i:=jos to n do
if (poznr[asoc^[i]]<>asoc^[i]) then
begin
fin:=false;
jos:=i+1;
k:=poznr[asoc^[i]];
break;
end;

if not fin then begin
e:=e+abs(k-psc)*g[npepoz[k]];
inc(nmut);
next:=k;
ini:=npepoz[k];
while (next<>ini) do begin
inc(nmut);
e:=e+abs(next-poznr[next])*g[next];
npepoz[next]:=next;
i:=next;
next:=poznr[next];
poznr[i]:=i;
                          end;
inc(nmut);
e:=e+abs(psc-ini)*g[ini];
poznr[ini]:=ini;
npepoz[ini]:=ini;
                end;
until fin;

if (e<ef) then begin
ef:=e;
pozsc:=psc;
               end;
if (t2-t1)>=timelim then goto finish;
{ -- }
                           end;
psc:=pozsc;
     end;


finish:
for i:=1 to n do begin
poznr[i]:=poznrini^[i];
npepoz[i]:=npepozini^[i];
                 end;

assign(temp,'moara.tmp');
rewrite(temp);
nmut:=0;
e:=0;
jos:=1;

for i:=1 to n do begin
dif^[i]:=abs(psc-poznr[i])*g[i]+abs(psc-i)*g[i]
-abs(poznr[i]-i)*g[i];
asoc^[i]:=i;
                 end;
sorti(1,n);

repeat
fin:=true;

for i:=jos to n do
if (poznr[asoc^[i]]<>asoc^[i]) then
begin
fin:=false;
jos:=i+1;
k:=poznr[asoc^[i]];
break;
end;

if not fin then begin
writeln(temp,'0 ',k);
e:=e+longint(abs(k-psc)*g[npepoz[k]]);
inc(nmut);
next:=k;
ini:=npepoz[k];
while (next<>ini) do begin
writeln(temp,next,' ',poznr[next]);
inc(nmut);
e:=e+longint(abs(next-poznr[next])*g[next]);
npepoz[next]:=next;
i:=next;
next:=poznr[next];
poznr[i]:=i;
                          end;
writeln(temp,ini,' ',0);
inc(nmut);
e:=e+longint(abs(psc-ini)*g[ini]);
poznr[ini]:=ini;
npepoz[ini]:=ini;
                end;
until fin;

close(temp);


reset(temp);
assign(f,'moara.out');
rewrite(f);
writeln(f,psc,' ',nmut,' ',e);
while not seekeof(temp) do begin
readln(temp,s);
writeln(f,s);
                           end;
close(f);
erase(temp);

writeln((t2-t1)/18:0:3);
end.
