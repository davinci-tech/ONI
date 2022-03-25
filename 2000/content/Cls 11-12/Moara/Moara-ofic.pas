{ prof. Ioan Maxim - Suceava }

program moara;
var a:array[1..10000] of word;
    g:array[1..10000] of byte;
    v:array[1..10000] of boolean;
    m:array[1..100] of word;
    i,j,jj,n,k,p,pp,min,max:word;
    e,ee:longint;
    w:byte;
    f,h:text;
    function pozmin(k:word):word;
    var min:byte;
        i,j:word;
    begin
       i:=k;
       v[i]:=true;
       min:=g[a[i]];
       j:=a[i];
       repeat
          if min<g[a[i]] then
             begin
                min:=g[a[i]];
                j:=a[i];
             end;
          i:=a[i];
          v[i]:=true;
       until i=k;
       pozmin:=j;
    end;
    function poz(k:word):word;
    var i:word;
    begin
       i:=1;
       while a[i]<>k do
          i:=i+1;
       poz:=i;
    end;
begin
   assign(f,'moara1.in');
   reset(f);
   readln(f,n);
   i:=0;
   repeat
      if seekeoln(f) then
         readln(f);
      i:=i+1;
      read(f,a[i]);
   until i=n;
   i:=0;
   repeat
      if seekeoln(f) then
         readln(f);
      i:=i+1;
      read(f,g[i]);
   until seekeof(f);
   close(f);
   p:=0;
   w:=0;
   i:=1;
   repeat
      while (i<=n) and v[i] do
         i:=i+1;
      if (i<=n) and (a[i]<>i) then
         begin
            w:=w+1;
            m[w]:=pozmin(i);
         end;
      i:=i+1;
   until i>n;
   min:=m[1];
   max:=m[1];
   for i:=2 to w do
       begin
          if m[i]<min then
             min:=m[i];
          if m[i]>max then
             max:=m[i];
       end;
   pp:=min;
   ee:=65000;
   for p:=min to max do
       begin
          e:=0;
          for i:=1 to w do
              e:=e+g[a[m[i]]]*(abs(longint(p)-m[i])+abs(longint(p)-a[p]));
          if e<ee then
             begin
                ee:=e;
                pp:=p;
             end;
       end;
   assign(f,'moa.out');
   rewrite(f);
   p:=pp;
   e:=0;
   k:=0;
   for i:=1 to w do
       begin
          pp:=a[m[i]];
          j:=m[i];
          writeln(f,'0 ',j);
          k:=k+1;
          e:=e+g[pp]*abs(longint(m[i])-p);
          repeat
             write(f,j,' ');
             jj:=poz(j);
             a[j]:=a[jj];
             writeln(f,jj);
             k:=k+1;
             e:=e+g[j]*abs(longint(j)-jj);
             j:=jj;
          until j=pp;
          e:=e+g[pp]*abs(longint(j)-p);
          a[pp]:=pp;
          k:=k+1;
          writeln(f,j,' 0');
       end;
   close(f);
   assign(f,'moa.out');
   reset(f);
   assign(h,'moara1.out');
   rewrite(h);
   writeln(h,p,' ',k,' ',e);
   repeat
      readln(f,i,j);
      writeln(h,i,' ',j);
   until seekeof(f);
   close(f);
   close(h);
end.
