{      SCAFANDRUL ADUCATOR DE MESAJE

  Un lac are forma cubica, cu latura m, unde 2<=m<=20. O pozitie ( o casuta)
se precizeaza prin coordonatele i,j,k, unde i=nivelul (1 pentru cel de la
suprafata, m pentru ultimul nivel, cel de pe fundul lacului), j=linia, iar
k=coloana unui nivel; linia 1=linia cea mai apropiata, iar coloana 1 este cea
din staga.
  Astfel, casuta din coltul sus,fata,stanga are coordonatele 1,1,1;  casuta din
coltul sus, spate, stanga are coordonatele 1,m,1, iar casuta de pe fundul
lacului, fata, dreapta are coordonatele m,1,m.
  In lac exista pozitii elementare considerate ca fiind statii de lucru
ce vor sa transmita la suprafata mesaje. Aceste casute pot fi dispuse oriunde
in cub ( chiar si pozitia de plecare a scafandrului).
  Scafandrul se poate deplasa din pozitia sa numai intr-o pozitie de pe nivelul
imediat superior ( de la nivelul i la nivelel i-1, pentru m >= i >= 1 ) si
care difera ca linie si coloana cu cel mult 1 fata de pozitia de plecare.
  Deci dintr-o pozitie nesituata langa vreunul din peretii laterali ai lacului
si nici pe nivelul de sus se poate ajunge in maximum 9 pozitii de pe nivelul
imediat superior.
   Un scafandru se afla pe fundul lacului la coordonatele m,l1,c1. El trebuie
sa ajunga la suprafata ( DEASUPRA primului nivel al cubului), intr-un loc de
coordonate 0,l2,c2, adica imediat deasupra pozitiei 1,l2,c2 din cub.
  CERINTA
  Trebuie sa precizam ce drum trebuie sa aleaga scfandrul pentru a duce la
destinatie cat mai multe mesaje.

DATELE DE INTRARE se afla in fisierul "lac.in" sub forma:
m l1 c1 l2 c2     m=dimensiunea cubului, l1,c1,l2,c2 din enunt
y                 y=numarul de statii
i11 j11 k11 m1
i12 j12 k12 m2
..............    tablou cu pozitiile celor y statii (pe primele trei coloane)
i1y j1y k1y my    si numarul de mesaje din fiecare statie( coloana a patra )

  DATELE DE IESIRE se vor depune in fisieul "lac.out" sub forma:
nr                 numarul total de mesaje aduse la suprafata
i21 j21 k21
i22 j22 k22        tablou cu pozitiile succesive prin care va trece scafandrul
...........               prima pozitie va fi cea de plecare, iar ultima cea
i2m+1 j2m+1 k2m+1               de sosire, precizate in fisierul de intrare

  TIMP DE EXECUTIE: sub o secunda pentru m maxim 20


OBSERVATII:
1. Nu este permisa iesirea din lac decat o data si anume la ultima deplasare
pentru a atinge nivelul 0 din pozitia finala .
2. Numarul maxim de mesaje pentru o statie este 100.

Exemplu
Pentru fisierul de intrare de mai jos 'LAC.IN'

3 2 2 2 2    Muchie cub=3; plecare din poz. 3,2,2 ; sosire in poz. 0,2,2
6            Numar de statii=6
1 3 1 10     Statie pe poz. 1,3,1 cu 10 mesaje
2 1 3 9      Statie pe poz 2,1,3, cu 9 mesaje
2 2 1 6      Statie pe poz. 2,2,1 cu 6 mesaje
2 3 2 7      Statie pe poz. 2,3,2 cu 7 mesaje
2 3 3 8      Statie pe poz. 2,3,3 cu 8 mesaje
3 2 2 5      Statie pe poz. 3,2,2 cu 5 mesaje

fisierul de iesire 'LAC.OUT' va trebui sa fie ca mai jos:

22           Numar total de mesaje =22
3 2 2 5      Poz 3,2,2 de unde se iau 5 mesaje   ( pozitia initiala )
2 3 1 7      Poz 2,3,1 de unde se iau 7 mesaje
1 3 1 10     Poz 1,3,1 de unde se iau 10 mesaje
0 2 2 0      Poz 0,2,2 de unde se iau 0 mesaje   ( pozitia statiei finale )
                }

{Rezolvarea problemei se bazeaza pe tehnica programarii dinamice.

Fie A matricea cu lacul. S-a ales o tablou cubic  pentru a putea exista
un drum de la orice pozitie de pe fundul lacului la orice punct final posibil

Folosim o matrice auxiliara C, tot cu m*m*m elemente, unde C[i,j,k] reprezinta
numarul maxim de mesaje culese pe un drum de la (i,j,k) la iesire, adica la
(0,l2,c2).

Se "vede" usor urmatoarea relatie recurenta, pe care se bazeaza programul:
   C[i,j,k] = A[i,j,k]+max(C[i-1,j+1,k+1], C[i-1,j+1,k], C[i-1,j+1,k-1]
                           C[i-1,j,k+1], C[i-1,j,k], C[i-1,j,k-1]   )
                           C[i-1,j-1,k+1], C[i-1,j-1,k], C[i-1,j-1,k-1]
Dupa ce este facuta o parcurgere pentru completarea matricei C vom avea in
C[m,l1,c1] numarul maxima maxim de mesaje culese.
Aceasta operatie este realizata in programul de mai jos, de catre procedura
"Punctaj".

Procedura "Drum" gaseste drumul propriu-zis si il tipareste.



}


program lac;
type vect=array[1..9] of integer;
var A, C:array [0..21, 0..21,0..21] of integer;
    m,i,j,k,l1,c1,l2,c2,p,x:integer;
    f:text;v:vect;

procedure citire;
var f:text;
    i,j,k,no,lo,co,mo,y:integer;
begin
  assign(f,'lac151.in');
  reset(f);
  readln(f,m,l1,c1,l2,c2);
  readln(f,y);
  for i:=1 to y do
    begin
      readln(f,no,lo,co,mo);a[no,lo,co]:=mo;
    end;
  close(f);
{  writeln;writeln('l1=',l1,' c1=',c1,', l2=',l2,', c2=',c2);
  writeln('Control citire din fisier:');
  for i:=m downto 1 do                           { de sus in jos ,}
 {    begin
        writeln('Nivelul ',i);
        for j:=m downto 1 do                     { din fata spre spate, }
  {         begin
              for k:=1 to m do write(a[i,j,k]:5); { de la stanga spre dreapta. }
   {           writeln
           end
     end;  }
end;

procedure Drum(i,j,k:integer);
begin
  writeln(f,i,' ',j,' ',k,' ',a[i,j,k]);    { Scriu in fisier pozitia curenta }
  if (i<=m) and (i>0) and(j<=m) and (j>0) and(k<=m) and (k>0) then
   if C[i,j,k]=A[i,j,k]+C[i-1,j+1,k+1] then Drum(i-1,j+1,k+1)
    else if C[i,j,k]=A[i,j,k]+C[i-1,j+1,k] then Drum(i-1,j+1,k)
     else if C[i,j,k]=A[i,j,k]+C[i-1,j+1,k-1] then Drum(i-1,j+1,k-1)
      else if C[i,j,k]=A[i,j,k]+C[i-1,j,k+1] then Drum(i-1,j,k+1)
       else if C[i,j,k]=A[i,j,k]+C[i-1,j,k] then Drum(i-1,j,k)
        else if C[i,j,k]=A[i,j,k]+C[i-1,j,k-1] then Drum(i-1,j,k-1)
         else if C[i,j,k]=A[i,j,k]+C[i-1,j-1,k+1] then Drum(i-1,j-1,k+1)
          else if C[i,j,k]=A[i,j,k]+C[i-1,j-1,k] then Drum(i-1,j-1,k)
           else if C[i,j,k]=A[i,j,k]+C[i-1,j-1,k-1] then Drum(i-1,j-1,k-1);

end;
            {  Ideea procedurii Drum: }
            { Se testeaza cum s-a ajuns in C[i,j,k] la valoarea curenta, }
            { adica de la ce casuta s-a ajuns la cea curenta si se repeta }
            { recursiv apelul pentru testarea casutei urmatoare din }
            { drumul scafandrului. Pe masura ce se descopera casuta urmatoare, }
            { ea este trecuta ( prin linia sa ) in fisier }

function max(v:vect):integer;
var m,i:integer;
begin
  m:=v[1];
  for i:=2 to 9 do
     if v[i]>m
        then m:=v[i];
  max:=m
end;

procedure Punctaj;    { Completare tablou de manevra C de la }
var i,j,k:integer;          { nivelul 1 spre cel mai de jos, }
begin              { Se depune in C[i,j,k] max din cele 9 val posibile }
  for i:=1 to m do
    for j:=1 to m do  { Daca macar una era o casuta permisa, se adauga la }
      for k:=1 to m do
      begin       { punctajul din C[i,j,k] valoarea omoloaga din A[i,j,k] }
        v[1]:=C[i-1,j+1,k+1];v[2]:=C[i-1,j+1,k];v[3]:=C[i-1,j+1,k-1];
        v[4]:=C[i-1,j,  k+1];v[5]:=C[i-1,j,  k];v[6]:=C[i-1,j,  k-1];
        v[7]:=C[i-1,j-1,k+1];v[8]:=C[i-1,j-1,k];v[9]:=C[i-1,j-1,k-1];
        C[i,j,k]:=max(v);
        if C[i,j,k]>=0
           then
              C[i,j,k]:=C[i,j,k]+A[i,j,k];
      end;
   {writeln;readln;  writeln('Dupa "Punctaj", matricile C si A');
   for i:=0 to m  do
     begin
        writeln('Nivelul ',i);
        for j:=m downto 1 do
           begin
              for k:=1 to m do write(c[i,j,k]:5);
              write('     ');
              for k:=1 to m do write(a[i,j,k]:5);
              writeln
           end
     end;  readln;     }
  writeln(f,C[m,l1,c1]);{ Scrie in fisier cate mesaje s-au cules }
  Drum(m,l1,c1);
  writeln(f);
end;

begin
  for i:=0 to m do for j:=0 to m+1 do for k:=0 to m+1 do
     begin c[i,j,k]:=0;a[i,j,k]:=0; end;
      { initializare matrice de manevra C }

  citire;
  assign(f,'lac151.out');
  rewrite(f);


  for i:=0 to m+1 do
    begin
       for k:=0 to m+1 do
          begin
             C[i,0,k]:=-1;      { Bordare  C pt a nu se iesi in lateral }
             C[i,m+1,k]:=-1;           { fata, spate }
          end;
       for j:=0 to m+1 do
          begin
             C[i,j,0]:=-1;         { Idem stanga, dreapta }
             C[i,j,m+1]:=-1
          end;

       for j:=0 to m+1 do
          for k:=0 to m+1 do           { Idem sus }
             c[0,j,k]:=-1;

       c[0,l2,c2]:=0;              { Eliberare iesire sus }
    end;
    x:=a[m,l1,c1];
    for j:=0 to m+1 do for k:=0 to m+1 do
       begin a[i,j,k]:=-1; c[i,j,k]:=-1 end;
    a[m,l1,c1]:=x;

   { writeln('Control C dupa bordare, inainte de "Punctaj"');readln;
    for i:=m+1 downto 0 do
     begin
        readln;writeln('Nivelul ',i);
        for j:=m+1 downto 0 do
           begin
              for k:=0 to m+1 do write(c[i,j,k]:3);
              write('    ');
              for k:=0 to m+1 do write(a[i,j,k]:5);
              writeln
           end
     end;                          }

  for i:=0 to m+1 do
     for j:=0 to m+1 do
       for k:=0 to m+1 do
         if (abs(j-l2) <= i) and (abs(c2-k) <= i)
            then C[i,j,k]:=A[i,j,k] { In casutele de unde se ajunge la }
            else C[i,j,k]:=-1;      { suprafata pun val omoloaga din A }
                                      { In celelalte se pune -1, }
                                       { adica nu avem acces la ele }

{   writeln('Control C, dupa transfer din A si cu valorile de -1');readln;
   for i:=0 to m do
     begin
        writeln('Nivelul ',i);
        for j:=m+1 downto 0 do
           begin
              for k:=0 to m+1 do write(c[i,j,k]:3);
              write('     ');
              for k:=0 to m+1 do write(a[i,j,k]:5);
              writeln
           end
     end;
                          }

  Punctaj;
  close(f);
end.


