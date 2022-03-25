program tezaur;
type ve=array [1..100] of real;
var
   f:text;
   t1,t2,x1,y1,x2,y2,x,y,a:ve;
   n,i,j,m,k,l,o,p:longint;
   a1,b1,c1,a2,b2,c2,auxx,auxy,aux,minx,miny,m1,m2:real;
   sw:boolean;
   n1,i1:longint;
   ar:real;

function min(a,b:real):real;
begin
     if a>b then min:=b else min:=a;
end;

function max(a,b:real):real;
begin
     if a>b then max:=a else max:=b;
end;

function arie_tri(x1,y1,x2,y2,x3,y3:real):real;
begin
arie_tri:=0.5*abs(x1*y2+x2*y3+x3*y1-x3*y2-x1*y3-x2*y1)
end;

function arie_poli(x,y:ve;d:integer):real;
var i:integer;arie:real;
begin
arie:=0;
for i:=2 to d-1 do
  arie:=arie+arie_tri(x[1],y[1],x[i],y[i],x[i+1],y[i+1]);
arie_poli:=arie;
end;


begin
     {Citirea datelor}
     assign(f,'tezaur.in');
     reset(f);
     readln(f,n1);
     readln(f,n);
     for i:=1 to n do read(f,x1[i],y1[i]);
     readln(f);
     x1[n+1]:=x1[1];
     y1[n+1]:=y1[1];
     x1[n+2]:=x1[2];
     y1[n+2]:=y1[2];

for i1:=2 to n1 do
 begin
     readln(f,m);
     for i:=1 to m do read(f,x2[i],y2[i]);
     readln(f);
     p:=0;
     x2[m+1]:=x2[1];
     y2[m+1]:=y2[1];
     x2[m+2]:=x2[2];
     y2[m+2]:=y2[2];
     for i:=1 to n do
         for j:=1 to m do
             begin
                  a1:=y1[i+1]-y1[i];
                  b1:=x1[i]-x1[i+1];
                  c1:=y1[i]*x1[i+1]-y1[i+1]*x1[i];
                  if (a1*x2[j]+b1*y2[j]+c1)*(a1*x2[j+1]+b1*y2[j+1]+c1)<=0 then
                     begin
                          if x1[i+1]=x1[i] then m1:=0
                          else if y1[i+1]=y1[i] then m1:=30000000
                          else m1:=(y1[i+1]-y1[i])/(x1[i+1]-x1[i]);
                          if x2[j+1]=x2[j] then m2:=0
                          else if y2[j+1]=y2[j] then m2:=30000000
                          else m2:=(y2[j+1]-y2[j])/(x2[j+1]-x2[j]);
                          if abs(m1)=abs(m2) then
                             begin
                             end
                          else
                              begin
                                   a2:=y2[j+1]-y2[j];
                                   b2:=x2[j]-x2[j+1];
                                   c2:=y2[j]*x2[j+1]-y2[j+1]*x2[j];
                                   if a1=0 then
                                      begin
                                           auxy:=-c1/b1;
                                           auxx:=(-c2-b2*auxy)/a2;
                                      end
                                   else if a2=0 then
                                        begin
                                             auxy:=-c2/b2;
                                             auxx:=(-c1-b1*auxy)/a1;
                                        end
                                   else if b1=0 then
                                        begin
                                             auxx:=-c1/a1;
                                             auxy:=(-c2-a2*auxx)/b2;
                                        end
                                   else if b2=0 then
                                        begin
                                             auxx:=-c2/a2;
                                             auxy:=(-c1-a1*auxx)/b1;
                                        end
                                   else
                                       begin
                                            auxx:=((b2/b1)*c1-c2)/(a2-a1*(b2/b1));
                                            auxy:=(-c1-a1*auxx)/b1;
                                       end;
                                   if (auxx>=min(x1[i],x1[i+1])) and
                                      (auxx<=max(x1[i],x1[i+1])) and
                                      (auxy>=min(y1[i],y1[i+1])) and
                                      (auxy<=max(y1[i],y1[i+1])) then
                                      begin
                                           p:=p+1;
                                           x[p]:=auxx;
                                           y[p]:=auxy;
                                      end;
                              end;
                     end;
             end;
     for j:=1 to m do
         begin
              sw:=true;
              for i:=1 to n do
                  if ((y1[i+2]-y1[i])*(x1[i+1]-x1[i])-
                     (x1[i+2]-x1[i])*(y1[i+1]-y1[i]))*
                     ((y2[j]-y1[i])*(x1[i+1]-x1[i])-
                     (x2[j]-x1[i])*(y1[i+1]-y1[i]))<=0 then sw:=false;
                  if sw then
                     begin
                          p:=p+1;
                          x[p]:=x2[j];
                          y[p]:=y2[j];
                     end;
         end;
     for j:=1 to n do
         begin
              sw:=true;
              for i:=1 to m do
                  if ((y2[i+2]-y2[i])*(x2[i+1]-x2[i])-
                     (x2[i+2]-x2[i])*(y2[i+1]-y2[i]))*
                     ((y1[j]-y2[i])*(x2[i+1]-x2[i])-
                     (x1[j]-x2[i])*(y2[i+1]-y2[i]))<=0 then sw:=false;
                  if sw then
                     begin
                          p:=p+1;
                          x[p]:=x1[j];
                          y[p]:=y1[j];
                     end;
         end;
     minx:=30000000;
     for i:=1 to p do if x[i]<minx then
         begin
              j:=i;
              minx:=x[i];
         end;
     miny:=30000000;
     for i:=1 to p do
         if (x[i]=minx) and (y[i]<miny) then
            begin
                 j:=i;
                 miny:=y[i];
            end;
     for i:=1 to p do
         if i<>j then
            begin
                 if x[i]=x[j] then a[i]:=30000000
                 else a[i]:=(y[i]-y[j])/(x[i]-x[j]);
            end;
     a[j]:=-30000000;
     for i:=1 to p do
         for j:=1 to p do
             if (i<>j) and (x[i]=x[j]) and (y[i]=y[j]) then
                begin
                     x[j]:=-30000000;
                     y[j]:=-30000000;
                end;
     sw:=true;
     while sw do
           begin
                sw:=false;
                for i:=1 to p-1 do
                    if a[i]>a[i+1] then
                       begin
                            aux:=a[i];
                            a[i]:=a[i+1];
                            a[i+1]:=aux;
                            aux:=x[i];
                            x[i]:=x[i+1];
                            x[i+1]:=aux;
                            aux:=y[i];
                            y[i]:=y[i+1];
                            y[i+1]:=aux;
                            sw:=true;
                       end;
           end;
     {Afisarea}
     n:=0;
     for i:=1 to p do
         if (x[i]<>-30000000) and (y[i]<>-30000000) then
            begin
             inc(n);
             x1[n]:=x[i];
             y1[n]:=y[i];
            end;
     x1[n+1]:=x1[1];
     y1[n+1]:=y1[1];
     x1[n+2]:=x1[2];
     y1[n+2]:=y1[2];
  end;
close(f);
assign(f,'tezaur.out');
rewrite(f);
ar:=arie_poli(x1,y1,n);
write(f,ar:10:2);
close(f);
end.