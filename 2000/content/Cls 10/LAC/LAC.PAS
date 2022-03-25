{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
Program Lac;
{
  Program Lac
  de Lucian Pora (09510)
  Copyright (c) Mai 2000 de Tatior Software
  Olimpiada nationala de informatica Constanta 2000
}

{$DEFINE Debuga}

{$IFDEF Debug}
Uses Crt;
{$ENDIF}

Const MaxM = 20;
      MaxP = 100;
      InName = 'lac10.in';
      OutName = 'lace.out';

Var m, l1, c1, l2, c2 : Integer;
    A, X : Array [0..MaxM, 1..MaxM, 1..MaxM] Of Integer;
    F : Text;
    y : Integer;
    n, l, c, p : Byte;
    i : Integer;

Procedure MakeX;

  Procedure PuneOptim(l1, c1 : Integer);
  Begin
       If X[n+1, l1, c1] < X[n, l, c] + A[n+1, l1, c1] Then
          X[n+1, l1, c1] := X[n, l, c] + A[n+1, l1, c1];
  End; {PuneOptim}

Begin
     { Initializeaza "X" cu -1 iar pozitia fianla cu 0 }
     For n := 0 To m-1 Do
         For l := 1 To m Do
             For c := 1 To m Do
                 X[n, l, c] := -1;
     X[0, l2, c2] := 0;
     For n := 0 To m Do
         For l := 1 To  m Do
             For c := 1 To m Do
                 If X[n, l, c] >= 0 Then
                 Begin

                      If (l>1) And (c>1) Then PuneOptim(l-1, c-1);
                      If (l>1)           Then PuneOptim(l-1, c  );
                      If (l>1) And (c<m) Then PuneOptim(l-1, c+1);

                      If           (c>1) Then PuneOptim(l  , c-1);
                                              PuneOptim(l  , c  );
                      If           (c<m) Then PuneOptim(l  , c+1);

                      If (l<m) And (c>1) Then PuneOptim(l+1, c-1);
                      If (l<m)           Then PuneOptim(l+1, c  );
                      If (l<m) And (c<m) Then PuneOptim(l+1, c+1);

                 End; {If}
End; {MakeX}

Procedure Scrie;

  Procedure WriteDr;
  Begin
       {$IFDEF Debug}
       WriteLn('(', n, ',', l, ',', c, ') - ', A[n, l, c]);
       {$ELSE}
       WriteLn(F, n, ' ', l, ' ', c, ' ', A[n, l, c]);
       {$ENDIF}
  End; {WriteDr}

Begin
     {$IFDEF Debug}
     WriteLn('Numaraul maxim de mesaje este ', X[m, l1, c1]);
     WriteLn;
     WriteLn('Drumul este urmatorul : ');
     {$ELSE}
     Assign(F, OutName);
     Rewrite(F);
     WriteLn(F, X[m, l1, c1]);
     {$ENDIF}
     n := m; l := l1; c := c1;
     Repeat
           WriteDr;
           p := X[n, l, c] - A[n, l, c];
           Dec(n);

If (l>1) And (c>1) And (p=X[n, l-1, c-1]) Then Begin  l:=l-1; c:=c-1; End Else
If (l>1) And           (p=X[n, l-1, c  ]) Then Begin  l:=l-1; c:=c  ; End Else
If (l>1) And (c<m) And (p=X[n, l-1, c+1]) Then Begin  l:=l-1; c:=c+1; End Else

If           (c>1) And (p=X[n, l  , c-1]) Then Begin  l:=l  ; c:=c-1; End Else
If                     (p=X[n, l  , c  ]) Then Begin  l:=l  ; c:=c  ; End Else
If           (c<m) And (p=X[n, l  , c+1]) Then Begin  l:=l  ; c:=c+1; End Else

If (l<m) And (c>1) And (p=X[n, l+1, c-1]) Then Begin  l:=l+1; c:=c-1; End Else
If (l<m) And           (p=X[n, l+1, c  ]) Then Begin  l:=l+1; c:=c  ; End Else
If (l<m) And (c<m) And (p=X[n, l+1, c+1]) Then Begin  l:=l+1; c:=c+1; End;

     Until (n=0) And (l=l2) And (c=c2);
     WriteDr;
     {$IFNDEF Debug}
     Close(F);
     {$ENDIF}
End; {Scrie}

Begin
     {$IFDEF Debug}
     ClrScr;
     {$ENDIF}

     { Citeste datele din fisier }
     Assign(F, InName);
     Reset(F);
     ReadLn(F, m, l1, c1, l2, c2);
     ReadLn(F, y);
     For i := 1 To y Do
     Begin
          ReadLn(F, n, l, c, p);
          A[n, l, c] := p;
     End; {For}
     Close(F);

     { Calculeaza cubul "X" care contine drumul optim }
     MakeX;
     { Scrie maximul si calculeaza traseul optim }
     Scrie;

     { Asteapta o tasta pentru a iesi }
     {$IFDEF Debug}
     WriteLn;
     Write('Press any key to exit ...');
     ReadKey;
     {$ENDIF}
End. {Program}
