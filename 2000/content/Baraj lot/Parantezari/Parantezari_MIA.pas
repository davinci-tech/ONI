{ Andreica Mugurel Ionut }
{$M 30000,0,655360}
{$R-,I-,S-,Q-}
Program Parantezari;
type NumarMare=array[0..200] of integer;
const avans=10;
var f:text;
    nd,ni,i,j,k,m,n:integer;
    sir:array[1..60] of char;
    s:array[-1..30,-1..30] of ^NumarMare;
    nr:NumarMare;
    max:longint;

function maxim(a,b:longint):longint;
begin
if a>b then maxim:=a
else maxim:=b;
end;

begin
assign(f,'par.in');
reset(f);
readln(f,n);
for i:=1 to 2*n do read(f,sir[i]);
close(f);

for i:=-1 to n do
for j:=-1 to n do begin
new(s[i,j]);
fillchar(s[i,j]^,sizeof(s[i,j]^),0);
                 end;

s[1,0]^[1]:=1;
s[1,1]^[1]:=1;
s[1,0]^[0]:=1;
s[1,1]^[0]:=1;
for i:=2 to n do
for j:=0 to i do
begin
{
s[i,j]:=s[i-1,j]+s[i,j-1];
}
max:=maxim(s[i-1,j]^[0],s[i,j-1]^[0]);
for k:=1 to max do
s[i,j]^[k]:=s[i-1,j]^[k]+s[i,j-1]^[k];
for k:=1 to max+avans do
if s[i,j]^[k] div 10>0 then begin
s[i,j]^[k+1]:=s[i,j]^[k+1]+s[i,j]^[k] div 10;
s[i,j]^[k]:=s[i,j]^[k] mod 10;
                            end;
for k:=max to max+avans do
if s[i,j]^[k]>0 then s[i,j]^[0]:=k;
end;

Nr[1]:=1;
Nr[0]:=1;
nd:=0;
ni:=0;
for i:=1 to 2*n do begin
case sir[i] of
'(':begin
inc(nd);
    end;
')':begin
inc(ni);
{
nr:=nr+s[n-ni+1,n-nd-1];
}
max:=maxim(nr[0],s[n-ni+1,n-nd-1]^[0]);
for k:=1 to max do
nr[k]:=nr[k]+s[n-ni+1,n-nd-1]^[k];
for k:=1 to max+avans do
if nr[k] div 10>0 then
begin
nr[k+1]:=nr[k+1]+nr[k] div 10;
nr[k]:=nr[k] mod 10;
end;
for k:=max to max+avans do
if Nr[k]>0 then Nr[0]:=k;
    end;
end;
                 end;

assign(f,'par.out');
rewrite(f);
for i:=nr[0] downto 1 do
write(f,Nr[i]);
close(f);

end.