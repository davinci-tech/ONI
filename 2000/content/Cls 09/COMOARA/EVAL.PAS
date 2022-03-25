{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
var i,j,k,l:longint;
    m,n:string;
    f1,f2,f3:text;

begin
  writeln(paramstr(1));
  writeln(paramstr(2));
  writeln(paramstr(3));
  writeln(paramstr(4));
  assign(f1,paramstr(1));
  assign(f2,paramstr(2));
  assign(f3,paramstr(3));
  reset(f1);reset(f2);
  readln(f1,m);
  readln(f2,n);
  while m[1]=' ' do
    delete(m,1,1);
  while n[1]=' ' do
    delete(n,1,1);
  while m[length(m)]=' ' do
    delete(m,length(m),1);
  while n[length(n)]=' ' do
    delete(n,length(n),1);
  close(f1);
  close(f2);
  rewrite(f3);
  if m=n then
     writeln(f3,'Corect')
     else
     writeln(f3,'Gresit');
  close(f3);
end.