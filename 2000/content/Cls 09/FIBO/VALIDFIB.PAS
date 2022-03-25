Program Validare;
Const DimMax = 500;
      Punct: Array[1..9] Of Byte=(5,5,5,10,10,15,15,15,20);
Type  Indice = 0 .. DimMax;
      Numar = String[80];
      Sir = Array[Indice] of Numar;
      PSir = ^Sir;
var   n: Numar;
      Nr, Ns, i, Test: Integer;
      s: Sir;
      F: PSir;
      Ok: Boolean;
      t: String;
      Rez: Text;

Procedure Citire_Intrare;
Var f: Text;
Begin
   Assign(f, 'FIB.IN'); Reset(f);
   ReadLn(f, n);
   Close(f);
End;

Procedure Sterge_Spatii(s: Numar);
Begin
   While (s<>'') And (s[1]=' ') Do Delete(s, 1, 1);
   While (s<>'') And (s[Length(s)]=' ') Do Delete(s, Length(s), 1);
End;

Procedure Citire_Iesire;
Var f: Text;
Begin
   Assign(f, 'FIB.OUT'); Reset(f);
   Ns := 0;
   While Not SeekEof(f) Do
      Begin
         Inc(Ns);
         ReadLn(f, s[Ns]);
         Sterge_Spatii(s[Ns]);
      End;
   Close(f);
End;

Procedure Ordonare;
Var i: Integer;
    Sch: Boolean;
    Aux: Numar;
Begin
   Repeat
      Sch := False;
      For i := 1 To Ns-1 Do
         If s[i]>s[i+1] Then
            Begin
               Aux := s[i]; s[i] := s[i+1]; s[i+1] := Aux;
               Sch := True;
            End;
   Until Not Sch;
End;

Function TermenFib(x: Numar): Boolean;
Var i: Integer;
Begin
   TermenFib := False;
   For i := 1 To Nr Do
      If F^[i]=x Then
         Begin
            TermenFib := True;
            Break;
         End;
End;

Function Cifra(c: Char): Byte;
Begin
   Cifra := Ord(c)-48;
End;

Function Adunare(a, b: Numar): Numar;
Var t, Cif, i: Byte;
    s: Numar;
Begin
   While Length(a)<Length(b) Do a := '0'+a;
   While Length(a)>Length(b) Do b := '0'+b;
   t := 0;  s := '';
   For i := Length(a) DownTo 1 Do
       Begin
          Cif := (t + Cifra(a[i])+Cifra(b[i])) Mod 10;
          t := (t + Cifra(a[i])+Cifra(b[i])) Div 10;
          s := Chr(Cif+48) + s;
       End;
   If t>0 Then s := Chr(t+48) + s;
   Adunare := s;
End;

Function Compara(a, b: Numar): Integer;
Begin
   If Length(a)>Length(b) Then Compara := 1
   Else
      If Length(b)>Length(a) Then Compara := -1
      Else
         If a>b Then Compara := 1
         Else If a<b Then Compara := -1
              Else Compara := 0;
End;

Procedure Fibonacci;
Var i: Integer;
Begin
   GetMem(F, (DimMax+1)*80);
   F^[0] := '0'; F^[1] := '1';
   i := 1;
   While Compara(F^[i], n) <= 0 Do
      Begin
         Inc(i);
         F^[i] := Adunare(F^[i-1], F^[i-2]);
      End;
   Nr := i;
End;

Function Suma: Numar;
Var Sum: Numar;
    i: Integer;
Begin
   Sum := '0';
   For i := 1 To Ns Do Sum := Adunare(Sum, s[i]);
   Suma := Sum;
End;

begin
   Assign(Rez, 'fibo.rez'); ReWrite(Rez);
   t:=Paramstr(1);
   Test := Ord(t[1])-48;
   Citire_Intrare;
   Citire_Iesire;
   Fibonacci;
   Ok := True;
   For i := 1 To Ns Do
      If Not TermenFib(S[i]) Then
         Begin
            Ok := False;
            WriteLn(Rez, 'PCT=0 Gresit! Termenul ', s[i], ' nu este Fibonacci!');
            Break;
         End;
   If Ok Then
      If Suma<>n Then
         WriteLn(Rez, 'PCT=0 Gresit! Suma este diferita de ', n)
      Else
         Begin
            Ok := True;
            Ordonare;
            For i := 1 To Ns-1 Do
               If TermenFib(Adunare(s[i], s[i+1])) Then
                   Begin
                      WriteLn(Rez, 'PCT=0 Gresit! ', s[i], ' si ', s[i+1], ' sunt termeni Fibonacci consecutivi!');
                      Ok := False;
                      Break;
                   End;
            If Ok Then WriteLn (Rez, 'PCT=',Punct[Test],' CORECT!!')
         End;
   Close(Rez);
End.
