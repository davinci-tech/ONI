program euler;

const ni='castel.in';
      no='castel.out';
      nmax=5000;
      mmax=10000;
      normal='-';
      special='*';

type lista=^camp;
     camp=record
                inf:integer;
                tip:byte;
                leg:lista;
          end;
     vector_int=array [1..2*mmax+nmax] of integer;
     pvector_int=^vector_int;
     vector_byte=array [1..2*mmax+nmax] of byte;
     pvector_byte=^vector_byte;
     sir_int=array [1..mmax+1] of integer;
     psir_int=^sir_int;
     sir_byte=array [1..mmax+1] of byte;
     psir_byte=^sir_byte;

var f:text;
    a,b:pvector_int;
    s,t:pvector_byte;
    li,ls,g:array [1..nmax] of integer;
    spc:array [1..nmax] of byte;
    tmp:psir_int;
    fel:psir_byte;
    n,m,p,i,j,k,kk,start,nod,vecin,med,aux,lng,tip:integer;
    prim,prev,baza,last,crt,x:lista;
    ok:boolean;

procedure memorie;
begin
     new(a);
     new(b);
     new(t);
     new(s);
     new(tmp);
     new(fel);
end;

procedure load;
begin
     assign(f,ni);reset(f);
     readln(f,n);
     readln(f,m);
     for k:=1 to m do begin
        readln(f,i,j);
        a^[k]:=i;
        b^[k]:=j;
        t^[k]:=0;
        s^[k]:=0;
        a^[m+k]:=j;
        b^[m+k]:=i;
        t^[m+k]:=0;
        s^[m+k]:=0;
        g[i]:=g[i]+1;
        g[j]:=g[j]+1;
                      end;
     m:=2*m;
     for i:=1 to n do
        spc[i]:=0;
     readln(f,p);
     for i:=1 to p do begin
        read(f,j);
        spc[j]:=1;
                      end;
     close(f);
end;

procedure nu;
begin
     ok:=true;
     for i:=1 to n do
        if (g[i] and 1)=1 then
          if spc[i]=0 then ok:=false;
     if not ok then begin
       assign(f,no);rewrite(f);
       writeln(f,'NU');
       close(f);
       halt;
                    end;
end;

procedure adauga_muchii;
begin
     k:=1;
     repeat
           while (k<=n) and ((g[k] and 1)=0) do k:=k+1;
           if k<=n then begin
             kk:=k+1;
             while (g[kk] and 1)=0 do kk:=kk+1;
             m:=m+1;
             a^[m]:=k;
             b^[m]:=kk;
             t^[m]:=1;
             s^[m]:=0;
             m:=m+1;
             a^[m]:=kk;
             b^[m]:=k;
             t^[m]:=1;
             s^[m]:=0;
             g[k]:=g[k]+1;
             g[kk]:=g[kk]+1;
             k:=kk+1;
                        end;
     until k>n;
end;

procedure qsort(var c:pvector_int;li,ls:integer);
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
end;

procedure sort;
begin
     qsort(a,1,m);
     k:=1;
     repeat
           kk:=k;
           while (kk<=m) and (a^[kk]=a^[k]) do kk:=kk+1;
           li[a^[k]]:=k;
           ls[a^[k]]:=kk-1;
           qsort(b,k,kk-1);
           k:=kk;
     until k>m;
end;

function cauta(var ce:integer;li,ls:integer):integer;
begin
     med:=(li+ls) shr 1;
     if ce<b^[med] then cauta:=cauta(ce,li,med-1)
     else
         if ce=b^[med] then cauta:=med
         else cauta:=cauta(ce,med+1,ls);
end;

procedure ciclu(nod:integer);
begin
     tmp^[1]:=nod;
     lng:=1;
     repeat
           nod:=tmp^[lng];
           start:=li[nod];
           while s^[start]=1 do start:=start+1;
           vecin:=b^[start];
           tip:=t^[start];
           li[nod]:=start+1;
           s^[start]:=1;
           p:=cauta(nod,li[vecin],ls[vecin]);
           if t^[p]<>tip then begin
             if p>1 then
               if b^[p-1]=nod then
                 if t^[p-1]=tip then p:=p-1;
             if p<m then
               if b^[p+1]=nod then
                 if t^[p+1]=tip then p:=p+1;
                              end;
           s^[p]:=1;
           lng:=lng+1;
           tmp^[lng]:=vecin;
           fel^[lng]:=tip;
           g[nod]:=g[nod]-1;
           g[vecin]:=g[vecin]-1;
     until tmp^[lng]=tmp^[1];
end;

procedure init;
begin
     ciclu(1);
     new(prim);
     prim^.inf:=1;
     prim^.leg:=nil;
     prev:=prim;
     for i:=2 to lng do begin
        new(x);
        x^.inf:=tmp^[i];
        x^.tip:=fel^[i];
        x^.leg:=nil;
        prev^.leg:=x;
        prev:=x;
                       end;
end;

procedure work;
begin
     crt:=prim;
     repeat
           while (crt<>nil) and (g[crt^.inf]=0) do crt:=crt^.leg;
           if crt<>nil then begin
             ciclu(crt^.inf);
             new(baza);
             baza^.inf:=1;
             baza^.leg:=nil;
             prev:=baza;
             for i:=2 to lng do begin
                new(x);
                x^.inf:=tmp^[i];
                x^.tip:=fel^[i];
                x^.leg:=nil;
                prev^.leg:=x;
                prev:=x;
                               end;
             last:=prev;
             last^.leg:=crt^.leg;
             crt^.leg:=baza^.leg;
             baza^.leg:=nil;
             dispose(baza);
                            end;
     until crt=nil;
end;

procedure scrie;
begin
     assign(f,no);rewrite(f);
     writeln(f,'DA');
     write(f,prim^.inf);
     prim:=prim^.leg;
     while prim<>nil do begin
          if prim^.tip=0 then write(f,' ',normal,' ')
          else write(f,' ',special,' ');
          write(f,prim^.inf);
          prim:=prim^.leg;
                        end;
     close(f);
end;

begin {programul principal}
     memorie;
     load;
     nu;
     adauga_muchii;
     sort;
     init;
     work;
     scrie;
end.