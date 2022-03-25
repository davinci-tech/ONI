program gen;

const no='i7.';
      nmax=5000;
      mmax=10000;

var f:text;
    n,m,i,j,k,l,aux,p:integer;
    a,b:array [1..mmax] of integer;
    g,spc:array [1..nmax] of integer;
    ch:char;
    ok:boolean;

procedure load;
begin
     write('N              : ');readln(n);
     write('M              : ');readln(m);
     write('Posibil? (y/n) : ');readln(ch);
     if ch='n' then begin
       m:=m-1;
       n:=n-1;
                    end;
end;

procedure init;
begin
     for i:=1 to n-1 do begin
        a[i]:=i;
        b[i]:=i+1;
                        end;
     a[n]:=1;
     b[n]:=n;
end;

procedure work;
begin
     randomize;
     for k:=n+1 to m do begin
        repeat
              i:=random(n)+1;
              j:=random(n)+1;
              if i<>j then begin
                if j<i then begin
                  aux:=i;
                  i:=j;
                  j:=aux;
                            end;
                ok:=true;
                for l:=1 to k-1 do
                   if (a[l]=i) and (b[l]=j) then begin
                     ok:=false;
                     l:=k-1;
                                                 end;
                           end
              else ok:=false;
        until ok;
        a[k]:=i;
        b[k]:=j;
                        end;
end;

procedure speciale;
begin
     for i:=1 to n do
        g[i]:=0;
     for i:=1 to m do begin
        g[a[i]]:=g[a[i]]+1;
        g[b[i]]:=g[b[i]]+1;
                      end;
     p:=0;
     for i:=1 to n do begin
        if (g[i] and 1)=1 then spc[i]:=1
        else spc[i]:=random(2);
        if spc[i]=1 then p:=p+1;
                      end;
end;

procedure nu;
begin
     if ch='n' then begin
       n:=n+1;
       m:=m+1;
       a[m]:=1;
       b[m]:=n;
       spc[n]:=0;
                    end;
end;

procedure scrie;
begin
     assign(f,no);rewrite(f);
     writeln(f,n);
     writeln(f,m);
     for i:=1 to m do
        writeln(f,a[i],' ',b[i]);
     writeln(f,p);
     for i:=1 to n do
        if spc[i]=1 then write(f,i,' ');
     writeln(f);
     close(f);
end;

begin {programul principal}
     load;
     init;
     work;
     speciale;
     nu;
     scrie;
end.