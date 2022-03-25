program eval_euler;

const
      rez='rezultat.txt';
      nmax=5000;
      mmax=10000;
      normal='-';
      special='*';

type vector_int=array [1..2*mmax] of integer;
     pvector_int=^vector_int;
     vector_byte=array [1..2*mmax] of byte;
     pvector_byte=^vector_byte;


var f:text;
    a,b:pvector_int;
    s,t:pvector_byte;
    li,ls,g:array [1..nmax] of integer;
    spc:array [1..nmax] of byte;
    n,m,p,i,j,k,kk,med,aux,first,prev,now:integer;
    status_comisie,status_concurent:string;
    ch:char;
    ni,no,comisie:string;

procedure memorie;
begin
     new(a);
     new(b);
     new(t);
     new(s);
end;

procedure load_input;
begin
     ni:=paramstr(1);
     no:=paramstr(2);
     comisie:=paramstr(3);
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

procedure load_comisie;
begin
     assign(f,comisie);reset(f);
     readln(f,status_comisie);
     close(f);
end;

procedure cauta(var ce:integer;li,ls:integer);
begin
     if li<=ls then begin
       med:=(li+ls) shr 1;
       if ce<b^[med] then cauta(ce,li,med-1)
       else
           if ce=b^[med] then p:=med
           else cauta(ce,med+1,ls);
                    end;
end;

procedure error(msg:string);
begin
     assign(f,rez);
     rewrite(f);
     writeln(f,msg);
     close(f);
     halt;
end;

procedure load_output;
begin
     assign(f,no);
     reset(f);
     readln(f,status_concurent);
     for i:=1 to length(status_concurent) do
        status_concurent[i]:=upcase(status_concurent[i]);
     p:=pos(status_comisie,status_concurent);
     if p=0 then error('Determinare gresita a posibilitatii!');
     read(f,first);
     if ioresult<>0 then error('Caractere ilegale!');
     prev:=first;
     while not seekeoln(f) do begin
          repeat
                read(f,ch);
          until ch<>' ';
          if (ch<>normal) and (ch<>special) then error('Caractere ilegale!');
          read(f,now);
          if ioresult<>0 then error('Caractere ilegale!');
          if ch=normal then begin
            p:=0;
            cauta(now,li[prev],ls[prev]);
            if p=0 then error('Muchie inexistenta!');
            if s^[p]=1 then error('Muchie parcursa de mai multe ori!');
            s^[p]:=1;
            cauta(prev,li[now],ls[now]);
            s^[p]:=1;
            m:=m-2;
                            end
          else
              if (spc[prev]=0) or (spc[now]=0) then error('Muchie virtuala fara noduri virtuale!');
          prev:=now;
                              end;
     close(f);
     if prev<>first then error('Ciclu ne-inchis!');
     if m<>0 then error('Ciclu ne-eulerian!');
     error('O.K.');
end;

begin {programul principal}
     memorie;
     load_input;
     sort;
     load_comisie;
     load_output;
end.