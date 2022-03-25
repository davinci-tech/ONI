Program Suma_Fibonacci;
Const DimMax = 500;
Type  Indice = 0 .. DimMax;
      Numar = String[80];
      Sir = Array[Indice] Of Numar;
Var   n: Numar;
      Nr: Integer;
      F: Sir;

Procedure Citire;
Var f: Text;
Begin
   Assign(f, 'FIB.IN'); Reset(f);
   ReadLn(f, n);
   Close(f);
End;

Function Cifra(c: Char): Byte;
Begin
   Cifra := Ord(c) - 48;
End;

Function Adunare(a, b: Numar): Numar;
Var t, Cif, i: byte;
    s: Numar;
begin
   While Length(a) < Length(b) Do a := '0'+a;
   While Length(a) > Length(b) Do b := '0'+b;
   t := 0;  s := '';
   For i := Length(a) DownTo 1 Do
       Begin
          Cif := (t + Cifra(a[i]) + cifra(b[i])) Mod 10;
          t := (t + Cifra(a[i]) + Cifra(b[i])) Div 10;
          s := Chr(Cif+48) + s;
       End;
   If t>0 Then s := Chr(t+48) + s;
   Adunare := s;
End;

Function Compara(a, b: Numar): Integer;
Begin
   If Length(a) > Length(b) Then Compara := 1
   Else
      If Length(b) > Length(a) Then Compara := -1
      Else
         If a > b Then Compara := 1
         Else
            If a < b Then Compara := -1
            Else Compara := 0;
End;

Procedure Fibonacci;
Var i: Integer;
Begin
   F[0] := '0'; F[1] := '1';
   i := 1;
   While Compara(F[i], n) <= 0 Do
      Begin
         Inc(i);
         F[i] := Adunare(F[i-1], F[i-2]);
      End;
   Nr := i;
End;

Function Scadere(a, b: Numar): Numar;
Var c: Numar;
    i: Byte;
    t, Cif: Integer;
Begin
   t := 0; c := '';
   While Length(a) > Length(b) Do b := '0' + b;
   For i := Length(a) DownTo 1 Do
      Begin
        If t + Cifra(a[i])-Cifra(b[i]) >= 0 Then
           Begin
              Cif := t + Cifra(a[i])-Cifra(b[i]);
              t := 0;
           End
        Else
           Begin
              Cif := 10 + t + Cifra(a[i])-Cifra(b[i]);
              t := -1;
           End;
        c := Chr(cif+48) + c;
      End;
   While (c<>'') And (c[1]='0') Do Delete(c, 1, 1);
   If c='' Then c := '0';
   Scadere := c;
End;

Procedure Determina;
Var Fout: Text;
    i: Integer;
Begin
   Assign(Fout, 'FIB.OUT'); ReWrite(Fout);
   i := Nr;
   Repeat
      While Compara(F[i], n)>0 Do Dec(i);
      WriteLn(Fout, F[i]);
      n := Scadere(n, F[i]);
   Until n='0';
   Close(Fout);
End;

Begin
   Citire;
   Fibonacci;
   Determina;
End.
