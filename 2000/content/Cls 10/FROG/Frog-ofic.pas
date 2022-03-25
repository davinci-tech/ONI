{$r+}
var {a:array[1..150,1..150] of byte;}
    ok:boolean;
    d,k,i,j,n:word; lung:real;
    fi,fo:text; sens,pas:longint;
procedure scrie;
begin writeln(fo,i,' ',j);
end;

begin
 assign(fi,'frog.in');
 reset(fi);
 assign(fo,'frog.out');
 rewrite(fo);
 readln(fi,n);
 if n=2 then
  begin writeln(fo,1,' ',1);
        writeln(fo,2,' ',1);
        writeln(fo,2,' ',2);
        writeln(fo,1,' ',2);
        writeln(fo,1,' ',1);
        close(fo);
        exit
  end;
 lung:=4*(n-1)+(n-2)*(n-2)*sqrt(2);
{ a[1,1]:=1;} i:=1; j:=1; scrie;
{ a[2,1]:=2;} i:=2; j:=1; scrie;
{ a[2,2]:=3;} i:=2; j:=2; scrie;
 sens:=1;
 pas:=4;
 for d := 1 to n-3 do {pana deasupra DS}
 begin
  for k := 1 to d do
   begin
    i:=i+sens;
    j:=j-sens;
{    a[i,j]:=pas;} scrie;
    inc(pas);
   end;
  if sens=1 then
   begin
    inc(i);
{    a[i,j]:=pas;} scrie;
    inc(pas);
   end
  else
   begin
    inc(j);
{    a[i,j]:=pas;} scrie;
    inc(pas);
   end;
  sens := -sens;
 end;
 for k := 1 to n-2 do  {Diag Secundara}
  begin i:=i+sens;
        j:=j-sens;
{        a[i,j]:=pas;}  scrie;
        inc(pas);
  end; sens := -sens;
 if sens=1 then
    begin
     inc(i);
{     a[i,j]:=pas;} scrie;
     inc(pas);
    end
   else
    begin
     inc(j);
{     a[i,j]:=pas;} scrie;
     inc(pas);
    end;
 for d := n-3 downto 1 do {de sub DS pana la coltul dreapa jos}
 begin
  for k := 1 to d do
   begin
    i:=i+sens;
    j:=j-sens;
{    a[i,j]:=pas;} scrie;
    inc(pas);
   end;
  if sens=1 then
   begin
    inc(j);
{    a[i,j]:=pas;} scrie;
    inc(pas);
   end
  else
   begin
    inc(i);
{    a[i,j]:=pas;} scrie;
    inc(pas);
   end;
  sens := -sens;
 end;
 i:=n; j:=n; {a[n,n] :=pas;} scrie; inc(pas);
 for i := n-1 downto 1 do
  begin
{   a[i,j]:=pas;} scrie;
   inc(pas);
  end;
 for j := n-1 downto 2 do
  begin
{   a[i,j]:=pas;} scrie;
   inc(pas);
  end;
  writeln(fo,'1 1');
{ for i := 1 to n do
  begin
   for j := 1 to n do write(a[i,j]:8);
   writeln
  end;} close(fo);
end.