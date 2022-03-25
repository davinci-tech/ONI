const np=6;         {$r+}
var s:array[1..np*(np-1) div 2] of byte;
    a:array[1..250,1..250] of byte;
    ok:boolean;
    i,j,n:byte; ct:longint;
    fi,fo:text;

procedure final;
var i,j,k:byte;
begin
 k:=1;inc(ct);
 for i := 1 to np do
  for j := i+1 to np do
   begin a[i,j]:=abs(s[k]-1); a[j,i]:=s[k];
         inc(k);
   end;
 for i := 1 to np do
  for j := 1 to np do
   if i<>j then
   begin
    ok := false;
    if a[i,j]=1 then begin ok := true;continue;  end;
    for k := 1 to np do
     if a[i,k]=1 then
      if a[k,j]=1 then begin ok := true; break; end;
    if not ok then exit;
   end;
 for i := 1 to n do
  begin
   for j := 1 to n do write(fo,a[i,j]:2);
   writeln(fo)
  end; close(fo); halt(0);
end;

procedure back(k:byte);
var i:byte;
begin
 if k=np*(np-1) div 2 +1 then final
 else for i := 0 to 1 do
  begin s[k]:=i;
        back(k+1)
  end;
end;

procedure rezolva(k:integer);
var i,j:byte;
begin
 if k=3 then begin a[1,2]:=1;a[2,3]:=1;a[3,1]:=1; exit end;
 if k=6 then begin back(1); exit end;
 for j := 1 to k-2 do
   a[k,j]:=1;
 for i := 1 to k-2 do a[i,k-1]:=1;
 a[k-1,k]:=1;
 rezolva(k-2);
end;

begin
 assign(fi,'graf.in');
 reset(fi);
 assign(fo,'graf.out');
 rewrite(fo);
 readln(fi,n); close(fi);
 if n in [1,2,4] then begin write(fo,'NU'); close(fo); exit end;
 rezolva(n);
 for i := 1 to n do
  begin
   for j := 1 to n do write(fo,a[i,j]:2);
   writeln(fo)
  end; close(fo);
  inc(ct);
end.