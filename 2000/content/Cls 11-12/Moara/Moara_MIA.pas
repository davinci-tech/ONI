{ Andreica Mugurel Ionut - Bucuresti }
{ !!! Sursa de +100 de puncte !!! }

{$M 10000,0,100000}
{$S-,I-,R-,Q-}

Program Moara_M_I_A;

type vect=array[1..10000] of integer;

var f,temp:text;
    poznr,npepoz:vect;
    poznrini,npepozini:^vect;
    g:array[1..10000] of integer;
    sus,jos,ef,pozsc,ini,next,min,nmut,i,j,k,m,n,psc:longint;
    e:longint;
    s:string;
    fin:boolean;

begin
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
sus:=psc;
jos:=psc;
repeat
fin:=true;
for i:=jos downto 1 do
if (npepoz[i]<>i) then begin
k:=i;
fin:=false;
jos:=i;
break;
                       end;

if fin then
for i:=sus to n do
if (npepoz[i]<>i) then begin
k:=i;
fin:=false;
sus:=i;
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
                 end;
psc:=pozsc;
for i:=1 to n do begin
poznr[i]:=poznrini^[i];
npepoz[i]:=npepozini^[i];
                 end;
                end
else begin
psc:=1;
min:=abs(npepoz[1]-1);
for i:=2 to n do
if abs(npepoz[i]-i)<min then begin
min:=abs(npepoz[i]-i);
psc:=i;
                             end;
     end;


assign(temp,'moara.tmp');
rewrite(temp);
nmut:=0;
e:=0;
sus:=psc;
jos:=psc;

repeat
fin:=true;
for i:=jos downto 1 do
if (npepoz[i]<>i) then begin
k:=i;
fin:=false;
jos:=i;
break;
                       end;

if fin then
for i:=sus to n do
if (npepoz[i]<>i) then begin
k:=i;
fin:=false;
sus:=i;
break;
                       end;

if not fin then begin
writeln(temp,'0 ',k);
e:=e+abs(k-psc)*g[npepoz[k]];
inc(nmut);
next:=k;
ini:=npepoz[k];
while (next<>ini) do begin
writeln(temp,next,' ',poznr[next]);
inc(nmut);
e:=e+abs(next-poznr[next])*g[next];
npepoz[next]:=next;
i:=next;
next:=poznr[next];
poznr[i]:=i;
                          end;
writeln(temp,ini,' ',0);
inc(nmut);
e:=e+abs(psc-ini)*g[ini];
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

end.
