var f:text;
    c:char;
    s,s1:string;
    i,k,n:integer;
begin
     randomize;
     for k:=1 to 20 do
     begin
       str(k,s1);
       s1:='t'+s1;
     Assign(f,s1);
     rewrite(f);
     n:=random(99)+2;
     s:='';
     for i:=1 to n do
         s:=s+chr(random(26)+97);
     writeln(f,s);
     close(f);
     end;
end.