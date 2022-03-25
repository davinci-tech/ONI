type
   matr=array[0..200,0..200] of byte;
   vect=array[0..200]of longint;
var fis,rez:text;
    a:matr;c,f:^matr;
    d,tmp,used:vect;
    n,x,i:byte;
    viz:set of byte;
    j,k,ini,fin,fm:word;
    q,max,t:array[0..200] of word;
procedure nue;
begin
     writeln(rez,-1);
     close(rez);halt
end;

function min(m1,m2:word):word;
begin
  if m1<m2 then min:=m1 else min:=m2
end;

procedure add(nod,tata:integer;flux:word);
begin
  viz:=viz+[nod]; inc(fin);
  q[fin]:=nod; t[nod]:=tata;
  max[nod]:=flux
end;
procedure fillmin(i:byte);
var j:byte;
begin
     used[i]:=1;
     for j:=1 to 2*n+1 do
         if a[i,j]=1 then begin
            if used[j]=1 then nue;
            if tmp[j]<tmp[i]+d[i] then begin
               tmp[j]:=tmp[i]+d[i];
               fillmin(j)
            end
         end;
     used[i]:=0
end;
procedure fillmax(i:byte);
var j:byte;
begin
  for j:=0 to 2*n do
    if a[j,i]=1 then
      if not((d[j]>0)or(tmp[j]=tmp[i])) then a[j,i]:=0
      else fillmax(j)
end;
function fluxmax:word;
begin
  repeat
     ini:=1; fin:=1; q[1]:=0;
     max[0]:=maxint;
     viz:=[0];
     while (ini<=fin)  do
     begin
       k:=q[ini]; inc(ini);
       for j:=1 to 2*n+1 do if not (j in viz) then
        if c^[k,j]>f^[k,j] then
          add(j, k,min(max[k],c^[k,j]-f^[k,j]))
        else if f^[j,k]>0 then
          add(j,-k,min(max[k],f^[j,k]))
     end;
     i:=2*n+1;
     if 2*n+1 in viz then
      while i<>0 do
      begin
        j:=t[i];
        if j>=0 then
          inc(f^[j,i],max[2*n+1]);
        if j<0 then
          dec(f^[i,-j],max[2*n+1]);
        i:=j
      end
  until not (2*n+1 in viz);
  j:=0;
  for i:=1 to 2*n do j:=j+f^[0,i];
  fluxmax:=j;
end;
begin
     assign(fis,'spy.in');reset(fis);
     assign(rez,'spy.out');rewrite(rez);
     readln(fis,n);
     for i:=1 to n do read(fis,d[2*i-1]);
     readln(fis);
     d[0]:=0;
     for i:=1 to n do begin a[0,2*i-1]:=1;a[2*i,2*n+1]:=1;a[2*i-1,2*i]:=1 end;
     for i:=1 to 2*n+1 do begin tmp[i]:=-1;used[i]:=0 end;
     for i:=1 to n do begin
         while not seekeoln(fis) do begin
               read(fis,x);a[2*x,2*i-1]:=1;
         end;
         readln(fis)
     end;
     tmp[0]:=0;fillmin(0);
     writeln(rez,tmp[2*n+1]);
     for i:=1 to n do
         for j:=1 to 2*n+1 do
             if (a[2*i,j]=1)and(tmp[2*i]<>tmp[j]) then a[2*i,j]:=0;
     new(c);c^:=a;
     new(f); fillchar(f^,sizeof(matr),0);
     fm:=fluxmax;writeln(rez,fm);
     for i:=1 to n do
         if (2*i-1 in viz) and not(2*i in viz) then write(rez,i,' ');
     writeln(rez);
     close(rez);
end.
