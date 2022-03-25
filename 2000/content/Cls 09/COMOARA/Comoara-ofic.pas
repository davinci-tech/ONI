{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 65500,0,655360}
var ii,i,j,k,l,m,n:longint;
    fi,fo:text;
    d,p,a,key,v:array[0..51,0..51]of integer;
    x,y:array[1..10]of longint;
    s,suma:longint;
    chei:array[1..10]of set of 1..20;
    ok:array[1..10,0..51,0..51]of byte;
    gata:boolean;

procedure readdata;
begin
  assign(fi,'comoara.in');
  assign(fo,'comoara.out');
  reset(fi);
  readln(fi,m,n);
  for i:=0 to m+1 do
      for j:=0 to n+1 do
          a[i,j]:=99;
  for i:=1 to m do
      begin
        for j:=1 to n do
            read(fi,a[i,j]);
        readln(fi);
      end;
  for i:=1 to m do
      begin
        for j:=1 to n do
            read(fi,v[i,j]);
        readln(fi);
      end;
  for i:=1 to m do
      begin
        for j:=1 to n do
            read(fi,key[i,j]);
        readln(fi);
      end;
  readln(fi,k);
  for i:=1 to k do
      readln(fi,x[i],y[i]);
  close(fi);
end;

procedure init;
begin
  s:=0;
  for ii:=1 to k do
      begin
        ok[ii,x[ii],y[ii]]:=1;
        chei[ii]:=[0];
      end;
  for i:=1 to m do
      for j:=1 to n do
          suma:=suma+v[i,j];
end;

procedure fill(x,i,j:integer);

begin
  if (ok[x,i,j]=0)and(not(a[i,j] in chei[x])) then exit;
  if(i<0)or(i>m)or(j<0)or(j>n) then exit;
  if p[i,j]=1 then exit;
  p[i,j]:=1;
  if ok[x,i,j]=0 then gata:=false;
  ok[x,i,j]:=1;
  chei[x]:=chei[x]+[key[i,j]];
  if a[i,j] in chei[x] then
     a[i,j]:=0;
  s:=s+v[i,j];
  v[i,j]:=0;
  if a[i,j] in chei[x] then
     begin
       fill(x,i-1,j);
       fill(x,i+1,j);
       fill(x,i,j-1);
       fill(x,i,j+1);
     end;
end;

procedure expand;
begin
  gata:=true;
  for ii:=1 to k do
      begin
        fillchar(p,sizeof(p),0);
        fill(ii,x[ii],y[ii]);
      end;

end;

procedure dump;
begin
  for i:=1 to m do
      for j:=1 to n do
          begin
            l:=0;
            for ii:=1 to k do
                if ok[ii,i,j]=1 then
                   l:=1;
            if l=1 then
               d[i,j]:=1;
          end;
  for i:=1 to m do
      begin
        for j:=1 to n do
            write(fo,d[i,j],' ');
        writeln(fo);
      end;

end;

procedure solve;
begin
  init;
  gata:=false;
  while not gata do
    expand;
  rewrite(fo);
  writeln(fo,s);
{  dump;}
  close(fo);
end;

begin
  readdata;
  solve;
end.