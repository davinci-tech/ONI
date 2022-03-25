{paramstr1=fi pe testul respectiv;
 paramstr(2)=fo concurent;
 paramstr(3)=punctaj pe test}
var fi,fo,fr:text;      {$r+}
    i,j,k:byte;
    n,ct:longint;
    a:array[1..250,1..250] of byte;
    ok:boolean;
    s:string;
begin
 assign(fi,paramstr(1));{fi pe testul respectiv}
 reset(fi);readln(fi,n); close(fi);
 assign(fo,paramstr(2)); {fo al concurentului}
 assign(fr,'result.txt');
 rewrite(fr);
 {$i-}
 reset(fo);
 if ioresult<>0 then
  begin writeln(fr,'PCT=0 fisier de iesire lipsa');
        close(fr);close(fo);
        halt(1)
  end;
 {$i+}
 if n in [2,4] then
  begin
   read(fo,s);
   while s[1]=' ' do delete(s,1,1);
   if (s='nu') or (s='Nu') or (s='NU')
    then
     begin
      writeln(fr,paramstr(3));
      close(fr); close(fo);
      halt(0)
     end
     else begin writeln('PCT=0 Gresit - in ac. caz nu are solutie');
                close(fr);close(fo);
                halt(5)
          end;
    end;
 {$i-}
 for i := 1 to n do             {citire din fisiere}
  for j := 1 to n do
    begin
      read(fo,a[i,j]);
      if ioresult<>0 then
       begin
        writeln(fr,'PCT=0 format gresit al datelor de iesire');
        close(fr);        close(fo);
        halt(7);
       end;
     end;
  {$i+}close(fo);
 for i := 1 to n do             {verificare matrice}
  for j := 1 to n do
   begin
    if (i<>j) and (a[i,j]+a[j,i]<>1) then {intre 2 noduri un singur arc}
     begin
      writeln(fr,'PCT=0 intre nodurile ',i,' ',j,' legaturi gresite');
      close(fr);
      halt(2);
     end;
    if a[i,j]=1 then inc(ct);
  end;
 if ct<>n*(n-1) div 2 then          {nr incorect de arce}
     begin
      writeln(fr,'PCT=0 sunt ',ct,' arce = gresit');
      close(fr);
      halt(3);
     end;
 for i := 1 to n do             {legaturi intre oricare doua noduri}
  for j := 1 to n do
   if i<>j then
   begin
    ok := false;
    if a[i,j]=1 then begin ok := true;continue;  end;
    for k := 1 to n do
     if a[i,k]=1 then
      if a[k,j]=1 then begin ok := true; break; end;
    if not ok then
     begin
      writeln(fr,'PCT=0 drumul intre ',i,' ',j,' nu are lungime 1 sau 2');
      close(fr);
      halt(4);
     end;
   end;
   write(fr,paramstr(3));
   close(fr);
   halt(0);
end.