Program GenTest;

Const DimMax = 35;

Type Dim = 1..DimMax;
     Cladire = Array[Dim, Dim, Dim] Of Byte;

Var c: Cladire;

Procedure Genereaza_Date;
Var f: Text;
    m, n, h, i, j, l, x, y: Byte;
    Test: String;
    K, T, Greu: Byte;
Begin
   Randomize;
   Write('Nume fisier test : '); ReadLn(Test);
   Assign(f, Test); ReWrite(f);
   Write('m ='); ReadLn(m); Write(f, m, ' ');
   Write('n ='); ReadLn(n); Write(f, n, ' ');
   Write('h ='); ReadLn(h); Write(f, h, ' ');
   Write('K ='); ReadLn(K); Write(f, K, ' ');
   Write('T ='); ReadLn(T); WriteLn(f, T);
   For i := 1 To h - 2 Do           { un etaj}
     Begin
        For j := 1 To m Do      { m linii}
          For l := 1 To n Do    { n coloane}
             Begin
             {   c[j, l, i] := Random(256);}
                Write(f, 1, {pc[j, l, i], }' ')
             End;
        WriteLn(f)
     End;

   For i := 1 To 2 Do           { un etaj}
     Begin
        For j := 1 To m Do      { m linii}
          For l := 1 To n Do    { n coloane}
             Begin
             {   c[j, l, i] := Random(256);}
                if (j=m)and(l=n) then write(f,'1 ')
                else
                Write(f, 0, {pc[j, l, i], }' ')
             End;
        WriteLn(f)
     End;



   For i := 1 To K Do
     Begin
   {     Greu := 1 + Random(255);
        x := 1 + Random(m);
        y := 1 + Random(n);   }
        WriteLn(f, '1 1 1'{Greu, ' ', x, ' ', y})
     End;
   Close(f)
End;

Begin
   Genereaza_Date;
End.
