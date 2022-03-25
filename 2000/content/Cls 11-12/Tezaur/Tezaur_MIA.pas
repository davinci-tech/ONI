{ Andreica Mugurel Ionut }
{ !!! Sursa de 100 de puncte !!! }

{$S-,I-,R-,Q-}
Program Tezaur;
type punct=record
     x,y:real;
           end;
     poligon=record
     np:integer;
     co:array[1..21] of punct;
             end;
     poly=record
     np:integer;
     co:array[1..1000] of punct;
          end;
var f:text;
    p,i,j,k,co,m,n,iaux,jaux:integer;
    pol:array[1..30] of poligon;
    aux,pint,inters:poly;
    a,b,c,arie,xii,yii:real;
    smn,smn1:shortint;
    inside:boolean;
    select:array[1..1000] of boolean;
    pt:punct;
    st:array[1..1000] of integer;

function equal(a,b:real):boolean;
begin
if abs(a-b)<0.0001 then equal:=true
else equal:=false;
end;

function semn(a,b,c,x,y:real):shortint;
var r:real;
begin
r:=a*x+b*y+c;
if equal(r,0) then semn:=0
else if r>0 then semn:=1
else semn:=-1;
end;

function intre(x11,x22,xa:real):boolean;
var d1,d2,x111,x222:real;
begin
if (x11>x22) then begin
x111:=x22;
x222:=x11;
                    end
else begin
x111:=x11;
x222:=x22;
     end;

d1:=x111-xa;
d2:=x222-xa;

intre:=((d1<0) or equal(d1,0))
and ((d2>0) or equal(d2,0));
end;

function intersect(x1,y1,x2,y2,x3,y3,x4,y4:real;var xi,yi:real):boolean;
var a11,b11,c11,a22,b22,c22:real;
begin
a11:=y1-y2;
b11:=x2-x1;
c11:=x1*y2-x2*y1;
a22:=y3-y4;
b22:=x4-x3;
c22:=x3*y4-x4*y3;

if equal(a22*b11-a11*b22,0) then begin
intersect:=false;
exit;
                                 end
else begin
xi:=(b22*c11-b11*c22)/(a22*b11-a11*b22);
yi:=(a11*c22-a22*c11)/(a22*b11-a11*b22);
intersect:=intre(x1,x2,xi) and intre(x3,x4,xi) and
intre(y1,y2,yi) and intre(y3,y4,yi);
     end;
end;


procedure sorti(li,ls:integer);
begin
if (ls-li=1) then begin
if (pint.co[li].x>pint.co[ls].x) or
(equal(pint.co[li].x,pint.co[ls].x) and (pint.co[li].y>pint.co[ls].y))
then begin
pt:=pint.co[li];
pint.co[li]:=pint.co[ls];
pint.co[ls]:=pt;
     end;
                  end
else if (ls-li>1) then begin
sorti(li,(li+ls) div 2);
sorti((li+ls) div 2+1,ls);
i:=li;
m:=(li+ls) div 2;
j:=m+1;
co:=li-1;
while (i<=m) and (j<=ls) do begin
inc(co);
if (pint.co[i].x<pint.co[j].x) or
(equal(pint.co[i].x,pint.co[j].x) and (pint.co[i].y<pint.co[j].y))
then begin
aux.co[co]:=pint.co[i];
inc(i);
     end
else begin
aux.co[co]:=pint.co[j];
inc(j);
     end;

                            end;
if (i<=m) then begin
for j:=i to m do begin
inc(co);
aux.co[co]:=pint.co[j];
                 end;
               end
else begin
for i:=j to ls do begin
inc(co);
aux.co[co]:=pint.co[i];
                  end;
     end;
for i:=li to ls do pint.co[i]:=aux.co[i];
                       end;
end;

begin
assign(f,'tezaur.in');
reset(f);
readln(f,n);
for k:=1 to n do begin
readln(f,pol[k].np);
for i:=1 to pol[k].np do read(f,pol[k].co[i].x,pol[k].co[i].y);
pol[k].co[pol[k].np+1]:=pol[k].co[1];
                 end;
close(f);


inters.np:=pol[1].np;
for i:=1 to pol[1].np+1 do
inters.co[i]:=pol[1].co[i];


assign(f,'tezaur.out');
rewrite(f);

for k:=2 to n do begin
{ -------- }
pint.np:=0;


{ 1. Determina punctele de intersectie }

for i:=1 to pol[k].np do
for j:=1 to inters.np do
if intersect(pol[k].co[i].x,pol[k].co[i].y,pol[k].co[i+1].x,pol[k].co[i+1].y,
inters.co[j].x,inters.co[j].y,inters.co[j+1].x,inters.co[j+1].y,xii,yii)
then begin
inc(pint.np);
pint.co[pint.np].x:=xii;
pint.co[pint.np].y:=yii;
     end;

{ 2. Determina punctele din pol[k], care sunt in interiorul
     lui inters }
for i:=1 to pol[k].np do begin
inside:=true;
for j:=1 to inters.np do
if (inters.co[j].x<>inters.co[j+1].x)
or (inters.co[j].y<>inters.co[j+1].y)
then begin
iaux:=j+1;
a:=inters.co[j].y-inters.co[j+1].y;
b:=inters.co[j+1].x-inters.co[j].x;
c:=inters.co[j].x*inters.co[j+1].y-inters.co[j+1].x*inters.co[j].y;
repeat
inc(iaux);
if iaux>inters.np then iaux:=1;
smn:=semn(a,b,c,inters.co[iaux].x,inters.co[iaux].y);
until smn<>0;

smn1:=semn(a,b,c,pol[k].co[i].x,pol[k].co[i].y);
if smn1<>smn then begin
inside:=false;
break;
                  end;
                         end;
if inside then begin
inc(pint.np);
pint.co[pint.np]:=pol[k].co[i];
               end;
                         end;
{ 3. Determina punctele din inters, care sunt in interiorul
lui pol[k] }

for i:=1 to inters.np do begin
inside:=true;
for j:=1 to pol[k].np do
if (pol[k].co[j].x<>pol[j].co[j+1].x) or
(pol[k].co[j].y<>pol[k].co[j+1].y)
then begin
iaux:=j+1;
a:=pol[k].co[j].y-pol[k].co[j+1].y;
b:=pol[k].co[j+1].x-pol[k].co[j].x;
c:=pol[k].co[j].x*pol[k].co[j+1].y-pol[k].co[j+1].x*pol[k].co[j].y;
repeat
inc(iaux);
if iaux>pol[k].np then iaux:=1;
smn:=semn(a,b,c,pol[k].co[iaux].x,pol[k].co[iaux].y);
until smn<>0;

smn1:=semn(a,b,c,inters.co[i].x,inters.co[i].y);
if smn1<>smn then begin
inside:=false;
break;
                  end;
                         end;
if inside then begin
inc(pint.np);
pint.co[pint.np]:=inters.co[i];
               end;
                         end;

{ 4. Realizeaza infasuratoarea convexa a acestor puncte -> rezultatul
este trecut in poligonul inters }

sorti(1,pint.np);
fillchar(select,sizeof(select),false);
st[1]:=1;
st[2]:=2;
select[2]:=true;
i:=2;

for p:=3 to pint.np do
begin
repeat
if (i=1) then begin
smn:=1;
              end
else begin
a:=pint.co[st[i-1]].y-pint.co[st[i]].y;
b:=pint.co[st[i]].x-pint.co[st[i-1]].x;
c:=pint.co[st[i-1]].x*pint.co[st[i]].y-pint.co[st[i]].x*pint.co[st[i-1]].y;
smn:=semn(a,b,c,pint.co[p].x,pint.co[p].y);
if smn<0 then begin
select[st[i]]:=false;
dec(i);
              end;
     end;
until smn>=0;
inc(i);
st[i]:=p;
select[p]:=true;
end;

for p:=pint.np downto 1 do
if not select[p] then
begin
repeat
if (i=1) then begin
smn:=1;
              end
else begin
a:=pint.co[st[i-1]].y-pint.co[st[i]].y;
b:=pint.co[st[i]].x-pint.co[st[i-1]].x;
c:=pint.co[st[i-1]].x*pint.co[st[i]].y-pint.co[st[i]].x*pint.co[st[i-1]].y;
smn:=semn(a,b,c,pint.co[p].x,pint.co[p].y);
if smn<0 then begin
select[st[i]]:=false;
dec(i);
              end;
     end;
until smn>=0;
inc(i);
st[i]:=p;
select[p]:=true;
end;

if pint.np=0 then begin
writeln(f,0);
close(f);
halt;
                  end;

inters.np:=i-1;
for p:=1 to i do
inters.co[p]:=pint.co[st[p]];

{ -------- }
                 end;

arie:=0;

for i:=1 to inters.np do
arie:=arie+inters.co[i].x*inters.co[i+1].y-
inters.co[i+1].x*inters.co[i].y;

arie:=abs(arie)/2;

writeln(f,arie:0:2);
close(f);


end.