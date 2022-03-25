const
     NMAX=5000;
type
    vector=array[0..NMAX] of boolean;
    ivector=array[0..NMAX] of integer;
    matrice=array[0..100,0..100] of integer;
    obiectiv=record
                   o1,o2,o3,o4,c1,c2,c3,c4:integer;
             end;
    muchie=array[1..3] of integer;
    muchii=array[1..10000] of muchie;
var
   a,c:matrice;
   n,nr,select,mm,x,y,xmin,xmax,ymin,ymax:integer;
   f:text;
   o:array[1..NMAX] of ^obiectiv;
   v:^vector;
   m:^muchii;
   indici,disj:^ivector;

procedure citire;
var
   i:integer;
begin
     assign(f,'ob.in');
     reset(f);
     for i:=1 to NMAX do
         new(o[i]);
     n:=0;mm:=0;
     new(m);
     while not seekeof(f) do
           begin
                inc(n);
                read(f,nr);
                readln(f,o[nr]^.o1,o[nr]^.c1,o[nr]^.o2,o[nr]^.c2,o[nr]^.o3,o[nr]^.c3,o[nr]^.o4,o[nr]^.c4);
                if o[nr]^.o1<>0
                   then
                       begin
                            inc(mm);
                            m^[mm,1]:=nr;
                            m^[mm,2]:=o[nr]^.o1;
                            m^[mm,3]:=o[nr]^.c1;
                       end;
                if o[nr]^.o3<>0
                   then
                       begin
                            inc(mm);
                            m^[mm,1]:=nr;
                            m^[mm,2]:=o[nr]^.o3;
                            m^[mm,3]:=o[nr]^.c3;
                       end;
           end;
     close(f);
end;

procedure rec(k:integer);
begin
     if k=0
        then exit;
     v^[k]:=true;
     if not v^[o[k]^.o1]  { nord }
        then
            begin
                 x:=x-1;
                 rec(o[k]^.o1);
                 x:=x+1;
            end;
     if not v^[o[k]^.o2]  { sud }
        then
            begin
                 x:=x+1;
                 rec(o[k]^.o2);
                 x:=x-1;
            end;
     if not v^[o[k]^.o3]  { est }
        then
            begin
                 y:=y+1;
                 rec(o[k]^.o3);
                 y:=y-1;
            end;
     if not v^[o[k]^.o4]  { vest }
        then
            begin
                 y:=y-1;
                 rec(o[k]^.o4);
                 y:=y+1;
            end;
     if x<xmin
        then xmin:=x;
     if x>xmax
        then xmax:=x;
     if y<ymin
        then ymin:=y;
     if y>ymax
        then ymax:=y;
     a[x,y]:=k;
end;

procedure scrie(i,j:integer);
var
   rez:integer;
begin
     rez:=0;
     if (a[i-1,j-1]<>0) and (o[a[i-1,j-1]]^.o3<>0)
        then inc(rez,8); { nord }
     if (a[i,j]<>0) and (o[a[i,j]]^.o4<>0)
        then inc(rez,4); { sud }
     if (a[i,j]<>0) and (o[a[i,j]]^.o1<>0)
        then inc(rez,2); { est }
     if (a[i-1,j-1]<>0) and (o[a[i-1,j-1]]^.o2<>0)
        then inc(rez,1); { vest }
     write(f,rez,' ');
end;

procedure prelucrare1;
var
   i,j:integer;
begin
     { Constructie matrice }
     new(v);
     fillchar(v^,sizeof(v^),false);
     x:=50; y:=50;
     xmin:=50; ymin:=50; xmax:=50; ymax:=50;
     rec(1);
     {--}
     assign(f,'ob1.out');
     rewrite(f);
     writeln(f,xmax-xmin,' ',ymax-ymin);
     for i:=xmin+1 to xmax do
         begin
              for j:=ymin+1 to ymax do
                  scrie(i,j);
              writeln(f);
         end;
     close(f);
end;

{procedure qsort2(li,ls:integer);
var i,j:integer;
begin
     i:=li;
     j:=ls;
     med:=c^[(li+ls) shr 1];
     repeat
           while c^[i]<med do i:=i+1;
           while c^[j]>med do j:=j-1;
           if i<=j then begin
             aux:=a^[i];
             a^[i]:=a^[j];
             a^[j]:=aux;
             aux:=b^[i];
             b^[i]:=b^[j];
             b^[j]:=aux;
             aux:=t^[i];
             t^[i]:=t^[j];
             t^[j]:=aux;
             i:=i+1;
             j:=j-1;
                        end;
     until i>j;
     if li<j then qsort(c,li,j);
     if i<ls then qsort(c,i,ls);
end;}

procedure qsort(li,ls:integer);
var
   i,j,elem:integer;
   aux:muchie;
begin
     elem:=m^[(li+ls) div 2][3];
     i:=li;
     j:=ls;
     while i<j do
           begin
                while m^[i][3]<elem do
                      inc(i);
                while m^[j][3]>elem do
                      dec(j);
                if i<=j
                   then
                       begin
                            aux:=m^[i];
                            m^[i]:=m^[j];
                            m^[j]:=aux;
                            inc(i);
                            dec(j);
                       end;
           end;
     if li<j
        then qsort(li,j);
     if i<ls
        then qsort(i,ls);
end;

procedure init_disj;
var
   i:integer;
begin
     new(disj);
     for i:=1 to n do
         disj^[i]:=-1;
end;

function mult(k:integer):integer;
begin
     while disj^[k]>0 do
           k:=disj^[k];
     mult:=k;
end;

procedure reun(a,b:integer);
begin
     while disj^[a]>0 do
           a:=disj^[a];

     while disj^[b]>0 do
           b:=disj^[b];

     if abs(disj^[a])<abs(disj^[b])
        then
            begin
                 disj^[b]:=disj^[a]+disj^[b];
                 disj^[a]:=b;
            end
        else
            begin
                 disj^[a]:=disj^[a]+disj^[b];
                 disj^[b]:=a;
            end
end;

procedure verif_sort;
var
   i:integer;
begin
     for i:=1 to mm-1 do
         if m^[i][3]>m^[i+1][3]
            then
                begin
                     writeln('GRESIT !!!');
                     halt;
                end;
end;

procedure prelucrare2;
var
   k:integer;
   cost:longint;
begin
     new(indici);
     qsort(1,mm);
     verif_sort;
     init_disj;
     select:=0;
     k:=0;
     assign(f,'ob2.out');
     rewrite(f);
{     writeln(f,mm-1);}
     cost:=0;
     while select<n-1 do
           begin
                inc(k);
                if mult(m^[k][1])<>mult(m^[k][2])
                   then
                       begin
                            inc(select);
{                            writeln(f,m^[k][1],' ',m^[k][2]);}
                            inc(cost,m^[k][3]);
                            reun(m^[k][1],m^[k][2]);
                            indici^[select]:=k;
                       end;
           end;
     writeln(f,cost);
     for k:=1 to n-1 do
         writeln(f,m^[indici^[k]][1],' ',m^[indici^[k]][2]);
     close(f);
end;

begin
     citire;
{     prelucrare1;}
     prelucrare2;
end.