{ Andreica Mugurel Ionut }
{$M 20000,0,655360}
{$S-,R-,I-,Q-,N+}
Program Mostenire;
type mare=comp;
     linie=array[1..200] of mare;
     matr=array[1..200,1..200] of byte;
var p,i,j,k,m,n:integer;
    f:text;
    post:array[1..200,1..200] of byte;
    grad,npost,npred:array[1..200] of byte;
    topo:array[1..200] of byte;
    select:array[1..200] of boolean;
    nmost:array[1..200] of ^linie;
    a:^matr;
    ntotal:mare;

begin
assign(f,'most.in');
reset(f);
readln(f,n);
fillchar(npred,sizeof(npred),0);
fillchar(post,sizeof(post),0);
fillchar(topo,sizeof(topo),0);

new(a);
fillchar(a^,sizeof(a^),0);

for i:=1 to n do begin
read(f,k);
while (k>0) do begin
inc(npred[i]);
inc(npost[k]);
post[k,npost[k]]:=i;
a^[k,i]:=1;
read(f,k);
               end;
readln(f);
                 end;
close(f);

{ Sortare Topologica }
grad:=npred;
fillchar(select,sizeof(select),false);
for p:=1 to n do begin
for i:=1 to n do
if (npred[i]=0) and (not select[i])
then begin
topo[p]:=i;
select[i]:=true;
for j:=1 to npost[i] do
dec(npred[post[i,j]]);
break;
     end;
                 end;

for i:=1 to n do begin
new(nmost[i]);
fillchar(nmost[i]^,sizeof(nmost[i]^),0);
if (grad[i]=0) then begin
nmost[i]^[i]:=1;
                    end;
                 end;

for i:=1 to n do
for j:=1 to i-1 do
if (a^[topo[j],topo[i]]=1)
then begin
for k:=1 to n do
begin
nmost[topo[i]]^[k]:=nmost[topo[i]]^[k]+nmost[topo[j]]^[k];
end;
     end;


ntotal:=0;
for i:=1 to n do
if npost[i]=0 then
for k:=1 to n do
if (nmost[i]^[k]>1) then
ntotal:=ntotal+trunc((nmost[i]^[k]*(nmost[i]^[k]-1))/2);

assign(f,'most.out');
rewrite(f);
writeln(f,ntotal:0:0);
close(f);
end.