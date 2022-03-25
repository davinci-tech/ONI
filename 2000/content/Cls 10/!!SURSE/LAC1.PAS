{Machedon Maximilian - Bucuresti}
program cu_lac;
const max=20;
      numein='lac.in';
      numeout='lac.out';
type tindice=0..max;
     tnod= record
           tata:byte;
           mesaje:byte;
           mesaje_max:integer;
           end;
     tmatrice=array [1..max,1..max,1..max] of tnod;
     tloc= record
           l,c:tindice
           end;
     tdepl=array [1..9] of shortint;
const dl:tdepl=(0,0, 0,1,1, 1,-1,-1,-1);
      dc:tdepl=(0,1,-1,0,1,-1, 0, 1,-1);
var fin,fout:text;
    m:tindice;
    st,fi:tloc;
    a:tmatrice;
    max_mes:integer;
    tata_fi:byte;
    clock:longint absolute $0:$46c;

procedure init;
begin
assign(fin,numein);
assign(fout,numeout)
end;

procedure citeste;
var n,l,c:tindice;
    mes:byte;
    i,statii:longint;
begin
reset(fin);
readln(fin,m,st.l,st.c,fi.l,fi.c);
fillchar(a,sizeof(a),0);
readln(fin,statii);
for i:=1 to statii do
      begin
      readln(fin,n,l,c,mes);
      a[n,l,c].mesaje:=mes
      end;
close(fin)
end;

procedure scriere;
var n,l,c:tindice;

procedure rec(tata:byte);
begin
inc(n);
if tata<>10 then
begin
dec(l,dl[tata]);
dec(c,dc[tata]);
rec(a[n,l,c].tata);
writeln(fout,n,' ',l,' ',c,' ',a[n,l,c].mesaje);
inc(l,dl[tata]);
inc(c,dc[tata]);
end;
dec(n)
end;

begin
rewrite(fout);
writeln(fout,max_mes);
l:=fi.l;
c:=fi.c;
n:=0;
rec(tata_fi);
writeln(fout,'0 ',fi.l,' ',fi.c,' 0');
close(fout)
end;

procedure solve;
var n,i,l,c:tindice;
    aux:integer;
    t:byte;

procedure max_parinte;
var k:byte;
    ln,cn,n_1:tindice;
begin
n_1:=n+1;
aux:=-1;
t:=0;
for k:=1 to 9 do
    begin
    ln:=l-dl[k];
    cn:=c-dc[k];
    if (ln>0) and (cn>0) and (ln<=m) and (cn<=m) then
       if a[n_1,ln,cn].tata<>0 then
          if a[n_1,ln,cn].mesaje_max>aux then
             begin
             t:=k;
             aux:=a[n_1,ln,cn].mesaje_max
             end
    end
end;

begin
with a[m,st.l,st.c] do
     begin
     mesaje_max:=mesaje;
     tata:=10
     end;
for n:=m-1 downto 1 do
    for l:=1 to m do
        for c:=1 to m do
            begin
            max_parinte;
            if aux>=0 then
               begin
               a[n,l,c].tata:=t;
               a[n,l,c].mesaje_max:=aux+a[n,l,c].mesaje
               end
            end;
l:=fi.l;
c:=fi.c;
n:=0;
max_parinte;
max_mes:=aux;
tata_fi:=t
end;

begin
init;
citeste;
solve;
scriere
end.