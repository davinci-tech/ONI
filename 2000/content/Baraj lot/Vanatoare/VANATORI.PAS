{$R-,S-,Q-,B-}
type
    matrice=array[0..300,0..1] of integer;

var
   a:array[0..300] of ^matrice;
   max,i,t1,t2,nr,T,l,m:integer;
   timp:array[1..600] of integer;
   f:text;

procedure citire;
begin
     assign(f,'vanatori.in');
     reset(f);
     readln(f,T);
     readln(f,l,m);
     nr:=0;
     for i:=1 to l do
         begin
              inc(nr);
              read(f,timp[nr]);
         end;
     for i:=1 to m do
         begin
              inc(nr);
              read(f,timp[nr]);
         end;
     close(f);
end;

procedure dinamica;
begin
     for i:=0 to T do
         begin
              new(a[i]);
              fillchar(a[i]^,sizeof(a[i]^),0);
         end;
     max:=0;
     for i:=1 to nr do
         for t1:=0 to T do
             for t2:=0 to T do
                 begin
                      a[t1]^[t2][i mod 2]:=a[t1]^[t2][(i-1) mod 2];
                      if (i<=l) and (timp[i]<=t1) and (a[t1]^[t2][i mod 2]<a[t1-timp[i]]^[t2][(i-1) mod 2]+1)
                         then a[t1]^[t2][i mod 2]:=a[t1-timp[i]]^[t2][(i-1) mod 2]+1;

                      if (timp[i]<=t2) and (a[t1]^[t2][i mod 2]<a[t1]^[t2-timp[i]][(i-1) mod 2]+1)
                         then a[t1]^[t2][i mod 2]:=a[t1]^[t2-timp[i]][(i-1) mod 2]+1;
                      if max<a[t1]^[t2][i mod 2]
                         then max:=a[t1]^[t2][i mod 2];
                 end;
     assign(f,'vanatori.out');
     rewrite(f);
     writeln(f,max);
     close(f);
end;

begin
     citire;
     dinamica;
end.