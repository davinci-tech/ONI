var fi, fconc, fcor, fr:text;
    a, g:array[0..10000] of integer;
    n,i,j,k:integer;
    pr, kr, er:longint;
    d, s, pc, kc, ec, ss,tt:longint;
    sum:longint;
    gol:integer;
procedure zero(i:integer; s:string);
begin
  assign(fr, 'rez.txt');rewrite(fr);
  writeln(fr, '   PCT=',i,' ',s);
  close(fr);
  halt;
end;
procedure testeof;
begin
  if seekeof(fconc) then
     zero(0, ' date insuficiente');
end;
begin
  assign(fi, paramstr(1));reset(fi);
  assign(fcor, paramstr(2));reset(fcor);
  assign(fconc, paramstr(3));reset(fconc);
  read(fi, n);
  for i:=1 to n do read(fi, a[i]);
  for i:=1 to n do read(fi, g[i]);
  read(fcor, pr, kr, er);
  testeof;
  read(fconc, pc);
  testeof;
  read(fconc, kc);
  testeof;
  read(fconc, ec);
  if (kr<kc) or (er<ec) then
     zero(0, 'neoptim')
  else begin
    sum:=0;gol:=0;
    for i:=1 to kc do begin
      testeof;
      read(fconc, d);
      testeof;
      read(fconc, s);
      if d<>gol then
         zero(0, ' destinatie ocupata');
      a[d]:=a[s];
      gol:=s;
      if s=0 then ss:=pc else ss:=s;
      if d=0 then tt:=pc else tt:=d;
      sum:=sum+abs(ss-tt)*g[a[s]];
      a[s]:=0;
    end;
    if not seekeof(fconc) then
         zero(0, ' cam multe chestii');
    if sum<>ec then
         zero(0, ' efort incorect calculat');
    for i:=1 to n do
      if a[i]<>i then
         zero(0, ' sir neordonat');
    if paramstr(4)='1' then
       zero(5, '  CORECT *****************')
    else if paramstr(4)<='3' then
       zero(10, '  CORECT *****************')
    else
       zero(15, '  CORECT *****************');

  end;
end.