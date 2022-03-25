program generare_teste_moara;
var a:array[1..10000] of word;
    g:array[1..10000] of byte;
    i,j,k,n:word;
    f:text;
begin
   assign(f,'moara.in');
   rewrite(f);
   write('n(2..10000)=');
   readln(n);
   writeln(f,n);
   i:=0;
   randomize;
   write('Ordine   : ');
   repeat
      a[i+1]:=random(n)+1;
      j:=1;
      while (j<=i) and (a[j]<>a[i+1]) do
         j:=j+1;
      if j>i then
         begin
            i:=i+1;
            write(a[i]:3);
         end;
   until i=n;
   writeln;
   write('Greutati : ');
   for i:=1 to n do
       begin
          g[i]:=random(15)+1;
          write(g[i]:3);
       end;
   i:=0;
   j:=0;
   repeat
      i:=i+1;
      j:=j+1;
      write(f,a[i],' ');
      if j>50 then
         begin
            writeln(f);
            j:=0;
         end;
   until i=n;
   writeln(f);
   i:=0;
   j:=0;
   repeat
      i:=i+1;
      j:=j+1;
      write(f,g[i],' ');
      if j>50 then
         begin
            writeln(f);
            j:=0;
         end;
   until i=n;
   close(f);
   writeln;
   writeln(' Done');
   readln;
end.