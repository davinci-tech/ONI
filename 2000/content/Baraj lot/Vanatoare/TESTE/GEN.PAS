var
   f:text;
   st:string;
   max,t,i,j,l,m:integer;

begin
     randomize;
     write('Testul:');readln(st);
     assign(f,st);
     write('T='); readln(t);
     write('L='); readln(l);
     write('M='); readln(m);
     write('Timp maxim:'); readln(max);
     rewrite(f);
     writeln(f,t);
     writeln(f,l,' ',m);
     for i:=1 to l-1 do
         write(f,random(max)+1,' ');
     writeln(f,random(max)+1);
     for i:=1 to m-1 do
         write(f,random(max)+1,' ');
     writeln(f,random(max)+1);
     close(f);
end.