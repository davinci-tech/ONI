{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 16384,0,655360}
Program Eliberarea_Prizonierilor;

Const DimMax = 35;
      MaxK   = 200;
      Dx: Array[1..9] Of -1..1 = (0, 0, 1,1,1,0,-1,-1,-1);
      Dy: Array[1..9] Of -1..1 = (0,-1,-1,0,1,1, 1, 0,-1);

Type Dim = 0..DimMax+1;
     Komando = Record
                  x, y: Dim;      {locul de pornire de pe acoperis}
                  Greu: Byte;     {greutatea}
                  Ajuns: Boolean; {initial FALSE pentru toti}
               End;
     Cladire = Array[Dim, Dim, Dim] Of Byte;

Var c           : Cladire;
    Com         : Array[1..MaxK] Of Komando;
    ContorAjunsi: Byte;
    m, n, h     : Byte;
    Kapa, K, T  : Byte;
    g           : Text;
    p:array[1..dimmax,1..dimmax] of set of 1..dimmax;

Procedure Citeste_Date;
Var f: Text;
    i, j, l: Byte;
Begin
   Assign(f, 'm'); Reset(f);
   ReadLn(f, m, n, h, K, T);
   For i := 1 To h Do           {citeste un etaj}
     Begin
        For j := 1 To m Do      {citeste m linii}
          For l := 1 To n Do    {citeste n coloane}
            Read(f, c[j, l, i]);
        ReadLn(f)
     End;
   For i := 1 To K Do           {citeste cei K Komandisti}
      With Com[i] Do
         Begin
            ReadLn(f, Greu, x, y);
            Ajuns := False
         End;
   Close(f)
End;

Procedure Trece(Kapa: Byte; xx, yy, Nivel: Dim);
Var  i: 1..9;
Begin
   if yy in p[nivel,xx] then exit;
   p[nivel,xx]:=p[nivel,xx]+[yy];

   If Not Com[Kapa].Ajuns Then
      If Nivel = h Then
         Begin
            Com[Kapa].Ajuns := True; {Kapa a ajuns !!! la parter}
            Exit
         End
      Else
         For i := 1 To 9 Do  {incearca in cele 9 posibile directii}
           If c[xx+Dx[i], yy+Dy[i], Nivel] and Com[Kapa].greu= Com[Kapa].greu
{              then
              if not(yy+dy[i] in p[nivel+1,xx+dx[i]])
 }             Then            {daca trece prin aceasta camera}
                 Trece(Kapa, xx+Dx[i], yy+Dy[i], Nivel+1) {incearca la nivelul urmator}
End;

Begin
   Citeste_Date;
   Assign(g, 'KOMMANDO.OUT'); ReWrite(g);
   For Kapa := 1 To K Do      {pentru fiecare din cei K Komandisti}
      begin
        if kapa mod 10=0 then
           writeln(kapa);
        fillchar(p,sizeof(p),0);
        Trece(Kapa, Com[Kapa].x, Com[Kapa].y, 1); {plec de pe nivelul 1}
      end;
   For Kapa := 1 To K Do      {contorizez cei ajunsi}
      If Com[Kapa].Ajuns Then Inc(ContorAjunsi);
   If ContorAjunsi >= T Then WriteLn(g, 'DA')
   Else WriteLn(g, 'NU');
   WriteLn(g, ContorAjunsi);
   Close(g);
End.
