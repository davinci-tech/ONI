{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

program Paranteze;
  const MaxN = 30;

  var a : string;
      catalan : array[0..MaxN] of comp;
      n : byte;
      f : text;

  procedure Citire;
  begin
    assign(f,'i8.in');
    reset(f);
    readln(f,a);
    close(f);
  end;

  procedure Calcul_Catalan; {calculez valorile numerelor lui Catalan}
    var k,j : byte;
  begin
    catalan[0] := 1;
    catalan[1] := 1;
    for k :=2 to n do
    begin
      catalan[k] := 0;
      for j := 0 to k - 1 do
        catalan[k] := catalan[k] + catalan[j]*catalan[k-1-j];
    end;
  end;

  function Numar(i,n : byte):comp; {returneaza numarul de ordine al parantezarii}
    var nr : comp;                 {care incepe pe pozitia i}
        dif,k,j : byte;            {si contine n perechi de paranteze}
  begin
    if n>0
    then begin
           nr := 0;
           dif := 1; {diferenta dintre nr parant deschise si nr parant inchise}
           k := 0;
           while dif > 0 do
           begin
             inc(k);
             if a[i + k] = '('
             then inc(dif)
             else dec(dif);
           end;
           for j := n-1 downto k div 2 + 1 do
             nr := nr + catalan[j]*catalan[n-1-j];
           nr := nr + Numar(i+1,k div 2)*catalan[n-1-k div 2];
           Numar := nr + Numar(i+k+1,n-1-k div 2);
         end
    else Numar := 0; {daca nu mai exista nici o pereche de paranteze}
  end;

  procedure Afisare;
  begin
    assign(f,'parantr.out');
    rewrite(f);
    writeln(f,1 + Numar(1,length(a) div 2):20:0);
    close(f);
  end;

begin
  Citire;
  n := length(a) div 2;
  Calcul_Catalan;
  Afisare;
end.