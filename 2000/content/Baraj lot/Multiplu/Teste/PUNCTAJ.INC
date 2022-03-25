procedure punctaj(test:string; puncte:real);
var f:text;
begin
     assign(f,'p.tmp');
     {$i-} append(f); {$i+}
     if ioresult<>0 then rewrite(f);
     writeln(f,test,' ',puncte:0:2);
     close(f);
end;
