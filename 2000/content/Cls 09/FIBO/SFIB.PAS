program Suma_Fibonacci;
const NMax = 15000;
type  Indice = 0 .. NMax;
      Sir = array[Indice] of Longint;
var   n, nr: longint;
      F: Sir;

procedure Citire;
var f:text;
begin
assign (f, '5.in'); reset(f);
readln (f, n);
close(f);
end;

procedure   Fibonacci;
var i: LongInt;
begin
F[0]:=0; F[1]:=1;
i:=1;
while (F[i] <= n) And (F[i-1]<=F[i]) do
      begin
      inc(i);
      F[i]:=F[i-1]+F[i-2];
      WriteLn(i:5,F[i]:20)
      end;
If F[i-1]>F[i] Then
   Nr := i-1
Else
   Nr:=i;
end;

procedure Determina;
var fout:text;
    i:LongInt;
begin
assign (fout, 'fib.out'); rewrite(fout);
i:=Nr;
repeat
      while F[i]>n do dec(i);
      writeln (fout, F[i]);
      n:=n-F[i];
until n=0;
close(fout);
end;

begin
     Citire;
     Fibonacci;
     Determina;
end.
