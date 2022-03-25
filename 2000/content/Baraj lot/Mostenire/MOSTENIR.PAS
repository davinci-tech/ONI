program Testare;
const NMAX = 1000;
type TVector = array [-1..NMAX] of integer;
     TMatrice = array [1..NMAX] of ^TVector;
     TPNod = ^TNod;
     TNod = record
        info: integer;
        urm: TPNod;
     end;
var
   fin, fout: text;
   nrPers: integer;
   most: TMatrice;
   cai: TVector;
   prim, ultim: TPNod;

procedure Push(nr: integer);
var q: TPNod;
begin
     new(q);
     q^.info := nr;
     q^.urm := NIL;
     if prim = NIL then begin
        prim := q;
     end
     else begin
          ultim^.urm := q;
     end;
     ultim := q;
end;

function Pop: integer;
var q: TPNod;
    x: integer;
begin
     x := prim^.info;
     q := prim;
     prim := prim^.urm;
     dispose(q);
     Pop:=x;
end;

procedure ResetCai;
var i: integer;
begin
     for i:=1 to nrPers do cai[i] := 0;
end;

procedure Citire;
var i, nr, x: integer;
begin
     readln(fin, nrPers);
     for i:=1 to nrPers do begin
         new(most[i]);
         most[i]^[-1] := 0;
     end;
     for i:=1 to nrPers do begin
         nr := 0;
         repeat
             read(fin, x);
             most[i]^[nr+1] := x;
             most[x]^[-1] := 1;
             inc(nr);
         until most[i]^[nr] = 0;
         readln(fin);
         most[i]^[0] := nr-1;
     end
end;

procedure SearchUpIter(nod: integer);
var nrTat, i: longint;
begin
     { Init coada }
     prim := NIL;
     ultim := NIL;

     Push(nod);
     while prim <> NIL do begin
           nod := Pop;
           { Nodul nu are tati }
           nrTat := most[nod]^[0];
           if nrTat = 0 then
              inc(cai[nod])

           { Nodul are tati }
           else begin
                for i := 1 to nrTat do
                    Push(most[nod]^[i]);
           end
     end
end;



procedure SearchUpRec(nod: integer);
var nrTat, i: longint;
begin
     { Nodul nu are tati }
     nrTat := most[nod]^[0];
     if nrTat = 0 then
        inc(cai[nod])

     { Nodul are tati }
     else begin
         for i := 1 to nrTat do
             SearchUpRec(most[nod]^[i]);
     end
end;

function Impozite: longint;
var nrImp, i, j, nr: longint;
begin
     nrImp := 0;
     { pentru orice persoana fara mostenitori }
     for i:=1 to nrPers do if most[i]^[-1] = 0 then begin
         { Reset cai }
         ResetCai;
         { Parcurg in sus }
         SearchUpIter(i);
         { Numar }
         for j:=1 to nrPers do begin
             nr := cai[j];
             nrImp := nrImp + nr * (nr -1) div 2;
         end;
     end;
     Impozite := nrImp;
end;

begin
     { Deschidere fisiere }
     assign(fin, 'Most.in');
     reset(fin);
     assign(fout, 'Most.out');
     rewrite(fout);

     { Citire graf }
     Citire;

     { Calcul }
     writeln(fout,Impozite);
     close(fout);
end.
