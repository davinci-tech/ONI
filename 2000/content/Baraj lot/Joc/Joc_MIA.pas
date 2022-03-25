{ Andreica Mugurel Ionut }
{$S-,R-,I-,Q-}
Program JOC;
type punct=record
           x,y:real;
           end;
     segm=record
     x1,y1,x2,y2:real;
         end;
     retea=array[0..201,0..201] of byte;

var f:text;
    nseg,p,i,j,m,n,k,left:integer;
    pct,aux:array[1..200] of punct;
    select,used:array[1..200] of boolean;
    cap,flux:^retea;
    smn:shortint;
    seg:array[1..100] of segm;
    st:array[1..200] of integer;
    a,b,c:real;

function equal(a,b:real):boolean;
begin
equal:=(abs(a-b)<0.0001);
end;

function semn(a,b,c,x,y:real):shortint;
var r:real;
begin
r:=a*x+b*y+c;
if equal(r,0) then semn:=0
else if r>0 then semn:=1
else semn:=-1;
end;

function intre(p1,p2,p3:real):boolean;
var p11,p21:real;
begin
if p2<p3 then begin
p11:=p2;
p21:=p3;
              end
else begin
p11:=p3;
p21:=p2;
     end;
intre:=((p1>=p11) and (p1<=p21));

end;

function intersect(x1,y1,x2,y2,x3,y3,x4,y4:real):boolean;
var x,y,a1,b1,c1,a2,b2,c2:real;
begin
a1:=y1-y2;
b1:=x2-x1;
c1:=x1*y2-x2*y1;

a2:=y3-y4;
b2:=x4-x3;
c2:=x3*y4-x4*y3;

if equal(a2*b1-a1*b2,0) then
begin
intersect:=false;
exit;
end;

x:=(b2*c1-b1*c2)/(a2*b1-a1*b2);
y:=(a1*c2-a2*c1)/(a2*b1-a1*b2);

intersect:=(intre(x,x1,x2) and intre(x,x3,x4) and intre(y,y1,y2) and
intre(y,y3,y4));

end;


procedure sorti(li,ls:integer);
begin
if (ls-li=1) then begin
if pct[li].x>pct[ls].x then begin
aux[ls]:=pct[ls];
pct[ls]:=pct[li];
pct[li]:=aux[ls];
                            end
else if (equal(pct[li].x,pct[ls].x) and (pct[li].y>pct[ls].y))
then begin
aux[ls]:=pct[ls];
pct[ls]:=pct[li];
pct[li]:=aux[ls];
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
if (pct[i].x<pct[j].x) then begin
aux[k]:=pct[i];
inc(i);
                            end
else if (equal(pct[i].x,pct[j].x) and (pct[i].y<pct[j].y))
then begin
aux[k]:=pct[i];
inc(i);
     end
else begin
aux[k]:=pct[j];
inc(j);
     end;
                            end;

if (i<=m) then begin
for j:=i to m do begin
inc(k);
aux[k]:=pct[j];
                 end;
               end
else
for i:=j to ls do begin
inc(k);
aux[k]:=pct[i];
                  end;
for i:=li to ls do begin
pct[i]:=aux[i];
                   end;
     end;
end;


begin
assign(f,'joc.in');
reset(f);
readln(f,n);
for i:=1 to n do
readln(f,pct[i].x,pct[i].y);
close(f);

sorti(1,n);
fillchar(select,sizeof(select),false);
fillchar(used,sizeof(used),false);

left:=n;
nseg:=0;

while (left>=3) do begin
select:=used;
j:=0;
repeat
inc(j);
until not select[j];
st[1]:=j;
repeat
inc(j);
until not select[j];
st[2]:=j;
select[j]:=true;
i:=2;

for p:=j+1 to n do
if not select[p] then begin
repeat
if (i=1) then begin
smn:=0;
              end
else begin
a:=pct[st[i-1]].y-pct[st[i]].y;
b:=pct[st[i]].x-pct[st[i-1]].x;
c:=pct[st[i-1]].x*pct[st[i]].y-pct[st[i]].x*pct[st[i-1]].y;
smn:=semn(a,b,c,pct[p].x,pct[p].y);
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

for p:=n downto 1 do begin
if not select[p] then begin
repeat
if (i=1) then begin
smn:=0;
              end
else begin
a:=pct[st[i-1]].y-pct[st[i]].y;
b:=pct[st[i]].x-pct[st[i-1]].x;
c:=pct[st[i-1]].x*pct[st[i]].y-pct[st[i]].x*pct[st[i-1]].y;
smn:=semn(a,b,c,pct[p].x,pct[p].y);
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
                     end;
inc(nseg);
seg[nseg].x1:=pct[st[1]].x;
seg[nseg].y1:=pct[st[1]].y;
seg[nseg].x2:=pct[st[2]].x;
seg[nseg].y2:=pct[st[2]].y;
dec(left,2);
used[st[1]]:=true;
used[st[2]]:=true;
                   end;
if (left=2) then begin
for i:=1 to n do
if not used[i] then begin
inc(nseg);
seg[nseg].x1:=pct[i].x;
seg[nseg].y1:=pct[i].y;
dec(left);
break;
                    end;
for i:=i+1 to n do
if not used[i] then begin
seg[nseg].x2:=pct[i].x;
seg[nseg].y2:=pct[i].y;
dec(left);
break;
                    end;
end;


assign(f,'joc.out');
rewrite(f);
writeln(f,left);
writeln(f,nseg);
for i:=1 to nseg do
writeln(f,seg[i].x1:0:2,' ',seg[i].y1:0:2,' ',seg[i].x2:0:2,' ',
seg[i].y2:0:2);

close(f);

end.