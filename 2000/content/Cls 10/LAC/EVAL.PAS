program lac;
var A:array [0..21, 0..21,0..21] of integer;
    ln,lv,cn,cv,nn,nv,m,m1,i,j,k,i1,j1,k1,l1,c1,l2,c2,x,y,mes,sum,sum_com:integer;
    f,g,h:text;s,string_mes:string;er1,er2,er3,er4:boolean;
    input,output,comisie:string;

function punctaj(s:string):integer;
begin
     while pos('\',s)<>0 do
       delete(s,1,pos('\',s));
     if s='lac10.in'
        then
            begin
                 punctaj:=10;
                 exit;
            end;
     if s='lac100.in'
        then
            begin
                 punctaj:=7;
                 exit;
            end;
     if s='lac101.in'
        then
            begin
                 punctaj:=13;
                 exit;
            end;
     if s='lac15.in'
        then
            begin
                 punctaj:=10;
                 exit;
            end;
     if s='lac151.in'
        then
            begin
                 punctaj:=15;
                 exit;
            end;
     if s='lac20.in'
        then
            begin
                 punctaj:=10;
                 exit;
            end;
     if s='lac21.in'
        then
            begin
                 punctaj:=17;
                 exit;
            end;
     if s='lac3.in'
        then
            begin
                 punctaj:=5;
                 exit;
            end;
     if s='lac4.in'
        then
            begin
                 punctaj:=5;
                 exit;
            end;
     if s='lac5.in'
        then
            begin
                 punctaj:=8;
                 exit;
            end;
end;

procedure error(msg:string);
var
   f:text;
begin
     assign(f,'rezultat.txt');
     rewrite(f);
     if msg='Corect !'
        then write(f,'PCT= ',punctaj(input),' ')
        else write(f,'PCT=0 ');
     writeln(f,msg);
     close(f);
     halt;
end;

procedure citire;
var no,lo,mo,co:integer;
begin
  comisie:=paramstr(1);
  input:=paramstr(2);
  output:=paramstr(3);

  assign(h,comisie);reset(h);
  readln(h,sum_com);
  close(h);

  assign(f,input);reset(f);
  reset(f);
  readln(f,m,l1,c1,l2,c2);readln(f,y);
  for i:=1 to m do for j:=1 to m do for k:=1 to m do a[i,j,k]:=0;
  for i:=1 to y do
    begin
       readln(f,no,lo,co,mo);
       a[no,lo,co]:=mo;
    end;
  close(f);
{  writeln;writeln('l1=',l1,' c1=',c1,', l2=',l2,', c2=',c2);}
{  writeln('Control citire din fisier:');}
         { de sus in jos, din fata spre spate, de la stanga spre dreapta. }
{  for i:=m downto 1 do
     begin
        writeln('Nivelul ',i);
        for j:=m downto 1 do
           begin
              for k:=1 to m do write(a[i,j,k]:5);
              writeln
           end
     end;}



end;

begin
  citire;
  er1:=false;{ ce a cules <> ce era pe drumul lui}
  er2:=false;{suma lui totala<>ce a cules}
  er3:=false;{suma lui < cea a comisiei }
  er4:=false;{mutare ilegala }
  assign(g,output);reset(g);readln(g,mes);
  if sum_com>mes
     then
        begin
           error('Prea putine mesaje culese.');
           er3:=true;
        end
  {   else
        writeln('Numarul de mesaje este corect !');};

  {reset(g);readln(g,mes);writeln('Mesaje elev=',mes);}

  sum:=0;lv:=l1;cv:=c1;nv:=m+1;
  while not eof(g) do
     begin
        readln(g,i1,j1,k1,m1); ln:=j1;cn:=k1;nn:=i1;
        if nn<>nv-1
           then
              begin
                 error('Saritura ilegala dpdv al nivelelui.');
{                 writeln('De la nivelul precedent ',nv,' ai trecut direct la nivelul ',nn);}
                 er4:=true
              end;
        if (abs(ln-lv)>1) or (abs(cn-cv)>1)
           then
              begin
                 error('saritura ilegala dpdv al liniilor si coloanelor.');
{                 writeln('Din (linie,col)=',lv:3,cv:3,' ai trecut direct la poz ',ln:3,cn:3);}
                 er4:=true
              end;
        {write('Citesc de la elev din poz. :',i1:3,j1:3,k1:3,' mesaje:',m1);
        writeln(', iar in A, la ',i1:2,j1:2,k1:2,' se afla ',a[i1,j1,k1]);}
        sum:=sum+m1;
        if a[i1,j1,k1]<>m1
           then
              begin
                  error('numar de mesaje dintr-o casuta incorect.');
{                 error('Din casuta ',i1:2,j1:2,k1:2,' ai cules ',m1,' dar acolo sunt ',a[i1,j1,k1] );}
                 er1:=true
              end;
{        writeln('El e in poz ',i1:3,j1:3,k1:3);}
        if not((abs(l2-j1)<=i1) and (abs(k1-c2)<=i1))
           then
              begin
{                 er1:=true;}
                  error('traseu ilegal.');
{                 writeln('Esti in casuta ilegala ',i1:3,j1:3,k1:3);}
              end;
        if i1=0
           then readln(g);
        lv:=ln;cv:=cn;nv:=nn;
     end;  { end of file}

  if sum<>mes
     then
        begin
            error('suma de mesaje calculata incorect.');
{           writeln('Suma declarata de elev=',mes,', dar pe drumul indicat se culeg ',sum,' mesaje.');}
           er2:=true;
        end;
{  if er1 then
     writeln('Ai intrat intr-o zona interzisa !');}
  if (not er1) and (not er2) and (not er3) and (not er4)
     then
        error('Corect !');

{   readln}
end.