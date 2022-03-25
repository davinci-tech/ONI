{ Andreica Mugurel Ionut }
{ !!! Sursa de 50/100 de puncte !!! }

{$M 20000,0,655360}
{$S-,R-,I-,Q-}
Program Puncte;
type linie=array[1..300] of shortint;
var f:text;
    i,j,k,n,p,q:integer;
    cupl:array[1..300] of ^linie;
    sol:boolean;
    nseg:integer;

begin
assign(f,'puncte.in');
reset(f);
readln(f,n);
readln(f,k);
close(f);

assign(f,'puncte.out');
rewrite(f);

for i:=1 to n do
for j:=1 to n do
if (i*j>=n) and (i*(j-1)<n)
then begin
nseg:=2*i*j-i-j;
if (i>2) and (j>1) then nseg:=nseg+2*(i-2)*(j-1);
if (i>1) and (j>2) then nseg:=nseg+2*(i-1)*(j-2);
if nseg>=k then begin
writeln(f,'1');
nseg:=0;
for p:=1 to i-1 do
for q:=1 to j do
if ((q-1)*i+p<=n) and ((q-1)*i+p+1<=n) then
begin
writeln(f,(q-1)*i+p,' ',(q-1)*i+p+1);
inc(nseg);
if nseg=k then begin
close(f);
halt;
               end;
end;

for q:=1 to j-1 do
for p:=1 to i do
if ((i*(q-1)+p<=n) and (i*q+p<=n)) then
begin
writeln(f,i*(q-1)+p,' ',i*q+p);
inc(nseg);
if nseg=k then begin
close(f);
halt;
               end;
end;

for q:=2 to j do
for p:=1 to i-2 do
if ((q-1)*i+p+2<=n) and (q*i+p<=n) then
begin
writeln(f,(q-1)*i+p+2,' ',q*i+p);
inc(nseg);
if nseg=k then begin
close(f);
halt;
               end;
end;

for p:=2 to i do
for q:=3 to j do
if ((q-3)*i+p<=n) and ((q-1)*i+p-1<=n) then
begin
writeln(f,(q-3)*i+p,' ',(q-1)*i+p-1);
inc(nseg);
if nseg=k then begin
close(f);
halt;
               end;
end;


for p:=1 to i-1 do
for q:=1 to j-2 do
if ((q-1)*i+p<=n) and ((q+1)*i+p+1<=n) then
begin
writeln(f,(q-1)*i+p,' ',(q+1)*i+p+1);
inc(nseg);
if nseg=k then begin
close(f);
halt;
               end;
end;

for p:=1 to i-2 do
for q:=1 to j-1 do
if ((q-1)*i+p<=n) and ((q+1)*i+p+2<=n) then
begin
writeln(f,(q-1)*i+p,' ',(q+1)*i+p+2);
inc(nseg);
if nseg=k then begin
close(f);
halt;
               end;
end;





if nseg<k then rewrite(f);
                end;
     end;

writeln(f,'0');
close(f);
end.
