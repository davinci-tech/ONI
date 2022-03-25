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
    a, b        : Array[0..DimMax+1, 0..DimMax+1] Of Byte;

Procedure Citeste_Date;
Var f: Text;
    i, j, l: Byte;
Begin
   Assign(f, 'kommando.in'); Reset(f);
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

Procedure Trece;
Var Niv, i, j, xx: Byte;
Begin
   FillChar(a, SizeOf(a), 0);
   a[Com[Kapa].x, Com[Kapa].y] := 1;
   For Niv := 2 To h Do
      Begin
         FillChar(b, SizeOf(b), 0);
         For i := 1 To m Do
            For j := 1 To n Do
                If a[i, j] = 1 Then
                   For xx := 1 To 9 Do
                    If c[i+Dx[xx], j+Dy[xx], Niv-1] and Com[Kapa].greu = Com[Kapa].greu
                       Then
                           b[i+Dx[xx], j+Dy[xx]] := 1;
          a := b;
      End;
   For i := 1 To m Do
      For j := 1 To n Do
          If a[i, j] = 1 Then
             Com[Kapa].Ajuns := true;
End;

Begin
   Citeste_Date;
   Assign(g, 'KOMMANDO.OUT'); ReWrite(g);
   For Kapa := 1 To K Do      {pentru fiecare din cei K Komandisti}
        Trece;                {plec de pe nivelul 1}
   For Kapa := 1 To K Do      {contorizez cei ajunsi}
      If Com[Kapa].Ajuns Then Inc(ContorAjunsi);
   If ContorAjunsi >= T Then WriteLn(g, 'DA')
   Else WriteLn(g, 'NU');
   WriteLn(g, ContorAjunsi);
   Close(g);
End.
