{ Andreica Mugurel Ionut }
{ !!! Sursa de 100 de puncte !!! }

{$M 65000,0,655360}
{$S-,R-,I-,Q-}
Program SICN;
type muchie=record
            c1,c2:byte;
            end;
     stmuc=array[1..22900] of muchie;
     linie=array[0..150] of boolean;

var f:text;
    n0,i,j,k,m,n,nst,nbi,maxim:integer;
    critic:array[0..150] of boolean;
    maxdf,nrdf,tat:array[-1..150] of integer;
    a:array[0..150,0..150] of shortint;
    vizit:array[0..150] of boolean;
    stiva:^stmuc;
    instiva:array[0..150,0..150] of boolean;
    biconex:array[1..151] of ^linie;
    mcrit:array[0..150] of ^linie;
    nterm:array[0..150] of boolean;
    nel:array[1..151] of integer;
    ok:boolean;

procedure DF(nod,tata:integer);
var s:integer;
begin
nrdf[nod]:=nrdf[tata]+1;
tat[nod]:=tata;
maxdf[nod]:=nrdf[nod];
vizit[nod]:=true;

nterm[nod]:=true;
for s:=0 to n do
if a[nod,s]=1 then begin
if (not instiva[nod,s]) then begin
inc(nst);
stiva^[nst].c1:=nod;
stiva^[nst].c2:=s;
instiva[nod,s]:=true;
instiva[s,nod]:=true;
                             end;

if (vizit[s]) and (s<>tat[nod]) and (nrdf[s]<maxdf[nod])
then maxdf[nod]:=nrdf[s];
if (not vizit[s]) then begin
nterm[nod]:=false;
df(s,nod);

                       end;

if tat[s]=nod then begin
if maxdf[s]>=nrdf[nod] then begin
mcrit[s]^[nod]:=true;
mcrit[nod]^[s]:=true;
critic[nod]:=true;
{
if (not (nterm[s])) and (maxdf[s]>nrdf[nod])
then critic[s]:=true;
}
                            end;
if (maxdf[s]=nrdf[nod]) or
((maxdf[s]>maxdf[nod]) and (mcrit[nod]^[s]))
then begin
inc(nbi);
while ((stiva^[nst].c1<>nod) or (stiva^[nst].c2<>s))
and ((stiva^[nst].c1<>s) or (stiva^[nst].c2<>nod))
do begin
biconex[nbi]^[stiva^[nst].c1]:=true;
biconex[nbi]^[stiva^[nst].c2]:=true;
{
instiva[stiva^[nst].c1,stiva^[nst].c2]:=false;
instiva[stiva^[nst].c2,stiva^[nst].c1]:=false;
}
dec(nst);
   end;
biconex[nbi]^[s]:=true;
biconex[nbi]^[nod]:=true;
dec(nst);
                  end
else if maxdf[s]<maxdf[nod] then maxdf[nod]:=maxdf[s];
if (nod=0) and (critic[nod]) then begin
ok:=false;
n0:=0;
for i:=1 to n do
if tat[i]=-1 then ok:=true
else if tat[i]=0 then inc(n0);
if n0>1 then ok:=true;
if not ok then critic[nod]:=false;
                                  end;
                   end;
                   end;
{
if (nterm[nod]) then begin
inc(nbi);
biconex[nbi]^[nod]:=true;
                    end;
}
end;

begin
assign(f,'sicn.in');
reset(f);
readln(f,n);
fillchar(a,sizeof(a),0);
while not seekeof(f) do begin
readln(f,i,j);
a[i,j]:=1;
a[j,i]:=1;
                        end;
close(f);

fillchar(maxdf,sizeof(maxdf),0);
fillchar(nrdf,sizeof(nrdf),0);
fillchar(vizit,sizeof(vizit),false);
for i:=1 to n do tat[i]:=-1;

fillchar(instiva,sizeof(instiva),false);
fillchar(nterm,sizeof(nterm),false);
fillchar(critic,sizeof(critic),false);

new(stiva);
for i:=1 to (n+1)*(n+1) do begin
stiva^[i].c1:=0;
stiva^[i].c2:=0;
                           end;
nst:=0;
nbi:=0;

for i:=0 to n do begin
new(mcrit[i]);
for j:=0 to n do mcrit[i]^[j]:=false;
                 end;


for i:=0 to n do begin
new(biconex[i]);
for j:=0 to n do biconex[i]^[j]:=false;
                 end;

nrdf[-1]:=0;
df(0,-1);

assign(f,'sicn.out');
rewrite(f);
if nbi=1 then writeln(f,'FORTE')
else begin

writeln(f,'NEFORTE');
for i:=0 to n do
if critic[i] then begin
write(f,i);
break;

                   end;
for i:=i+1 to n do
if critic[i] then write(f,' ',i);
writeln(f);
writeln(f,nbi);
nst:=0;
for i:=1 to nbi do
begin
inc(nst);
if nst>1 then writeln(f);
for j:=0 to n do if biconex[i]^[j] then begin
write(f,j);
break;
                                        end;
for j:=j+1 to n do if biconex[i]^[j] then begin
if biconex[i]^[j] then write(f,' ',j);

                                          end;
                   end;
     end;
close(f);
end.