Program puncte_dpa;
var n,i,k,h,j:longint;
    f:text;
begin
assign(f,'puncte.in');
reset(f);
readln(f,n);
readln(f,k);
close(f);
assign(f,'puncte.out');
rewrite(f);
if k>trunc(n*n/4) then
 write(f,0)
                  else
 begin
  writeln(f,1);
  h:=0;
  for i:=1 to trunc(n/2) do
   for j:=trunc(n/2)+1 to n do
    begin
     inc(h);
     if h<=k then
      writeln(f,i,' ',j);
    end;
 end;
close(f);
end.