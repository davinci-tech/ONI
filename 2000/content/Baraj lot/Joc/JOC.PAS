program Solitaire_Plan;
const NrMaxP = 200;
      infinit = 1E5;
type  Indice = 1 .. NrMaxP;
      Punct = record
              x, y: real;
              c: byte;
              end;
      MultimePuncte=array[Indice] of Punct;
      Poligon = array[Indice] of Indice;
      Segmente = array[1..2, 1 .. NrMaxP div 2] of Indice;

var n, nM, NrC, i, ks: byte;
    Sol: Segmente;
    M: Poligon;
    S: MultimePuncte;

procedure Citire;
var fin: text; i: byte;
    nume: string;
begin
{write ('fisier intrare '); readln (nume);}
assign (fin, 'joc.in'{nume}); reset(fin);
readln (fin, n);
for i := 1 to n do
    begin
    readln (fin, S[i].x, S[i].y);
    S[i].c := 1;
    end;
NrC := 1;
close (fin);
end;

procedure Afisare;
var fout: text;
    i: integer;
begin
assign(fout, 'joc.out'); rewrite(fout);
writeln (fout, n mod 2);
writeln (fout, ks);
for i := 1 to ks do
    writeln (fout, S[Sol[1,i]].x:10:2, ' ', S[Sol[1,i]].y:10:2,  ' ',S[Sol[2,i]].x:10:2, ' ', S[Sol[2,i]].y:10:2);
close (fout);
end;

function DreaptaJos (nc: byte): integer;
{determina punctul cel mai din jos, cel mai din stanga}
var i, imin: integer; xmin, ymin: real;
begin
xmin := infinit; ymin := infinit;
imin := -1;
for i := 1 to n do
    if (S[i].c=nc) then
       if (S[i].y < ymin) or ((S[i].y = ymin) and (S[i].x < xmin)) then
       begin
       imin := i;
       xmin := S[imin].x; ymin := S[imin].y
       end;
DreaptaJos := imin;
end;

function Arg (x, y: real): real;
begin
if x = 0 then Arg := 90
   else
   if y = 0 then Arg := 0
      else
         if y/x > 0 then Arg := 180 * arctan (y/x)/Pi
            else Arg := 180 - 180*arctan (-y/x)/Pi
end;

function IntoarcereDreapta (x1, y1, x2, y2, x3, y3: real): boolean;
begin
IntoarcereDreapta := (x1 * y2 + x2 * y3 + x3 * y1 - x3 * y2 - x1 * y3 - x2 * y1) < 0;
end;

function f(i, j, k: byte): real;
{dreapta este j k}
begin
f:=(S[i].x-S[k].x)*(S[j].y-S[k].y)-(S[i].y-S[k].y)*(S[j].x-S[k].x);
end;


procedure ConstructiePoligon (var P: Poligon; var nP: byte; nc: byte);

type Lista = ^NodLista;
     NodLista = record
                r, t: real;
                i: Indice;
                urm, pre: Lista;
                end;

var L, q, pp, sf, u: Lista;
    i, imin: integer; x0, y0: real;
    pus: array[Indice] of boolean;

begin
{construiesc lista dublu inlantuita a punctelor, ordonata crescator dupa argument;
coordonatele polare sunt calculate relativ la punctul cel mai de jos, cel mai din dreapta}
for i := 1 to n do pus[i]:=false;
imin := DreaptaJos (nc);
Np:=0;
if imin >0 then
begin
x0 := S[imin].x; y0 := S[imin].y;  pus[imin]:=true;
new (L); L^.i := imin; L^.r := 0; L^.t := 0;
L^.pre := nil; L^.urm := nil;  sf := L;
{inserez succesiv punctele in lista}
for i := 1 to n do
    if (i <> imin) and (S[i].c=nc)then
       begin
       new (pp); pp^.i := i;
       pp^.r := sqrt (sqr (S[pp^.i].x - x0) + sqr (S[pp^.i].y - y0));
       pp^.t := Arg (S[pp^.i].x - x0, S[pp^.i].y - y0);
       {inserez pp in lista}
       q := L;
       while (q <> nil) and (q^.t < pp^.t) do q := q^.urm;
       if (q <> nil) and (q^.t = pp^.t) then
          begin if (pp^.r > q^.r) then
                if (q<>L) then
                   begin pus[q^.i]:=false; pus[pp^.i] := true;
                         q^.r:= pp^.r; q^.i:=pp^.i; dispose (pp)
                   end
                   else {pp se afla pe axa ox}
                   begin
                   while (q<>nil) and (q^.t = 0) and (q^.r<pp^.r) do q:=q^.urm;
                   {inserez inaintea lui q}
                   pp^.urm := q; pus[pp^.i]:=true;
                   if q = nil then begin pp^.pre := sf; sf^.urm := pp; sf := pp; end
                      else
                      begin
                      pp^.pre := q^.pre;
                      if (pp^.pre <> nil) then pp^.pre^.urm := pp
                         else L := pp;
                      q^.pre := pp;
                      end;
                   end
          end
          else
          begin
          {inserez pp inaintea lui q}
          pp^.urm := q; pus[pp^.i]:=true;
          if q = nil then begin pp^.pre := sf; sf^.urm := pp; sf := pp; end
          else
          begin
             pp^.pre := q^.pre;
             if (pp^.pre <> nil) then pp^.pre^.urm := pp
                else L := pp;
             q^.pre := pp;
          end;
         end
    end;

{adaug toate varfurile de pe dreapta [l, l^.urm], ordonate crescator}
if (L^.urm <> nil) then
   begin
   for i := 1 to n do
       if (not pus[i]) and (S[i].c=nc) then
          begin
          new (pp); pp^.i := i;
          pp^.r := sqrt (sqr (S[pp^.i].x - x0) + sqr (S[pp^.i].y - y0));
          pp^.t := Arg (S[pp^.i].x - x0, S[pp^.i].y - y0);
          if pp^.t =L^.urm^.t then
             begin
             q := L^.urm;  pus[i]:=true;
             while (q <> nil) and (q^.t = pp^.t) and (q^.r < pp^.r) do q := q^.urm;
             {inserez pp inaintea lui q}
             pp^.urm := q;
             if q = nil then begin pp^.pre := sf; sf^.urm := pp; sf := pp; end
                else
                begin
                pp^.pre := q^.pre;
                pp^.pre^.urm := pp;
                q^.pre := pp;
                end;
             end
             else dispose (pp)
          end
end;

{adaug varfurile de pe dreapta [sf, l], ordonate descrescator}
if (L^.urm<>nil) and (L^.urm^.t<>sf^.t)then
begin
for i := 1 to n do
    if (not pus[i]) and (S[i].c=nc) then
       begin
       new (pp); pp^.i := i;
       pp^.r := sqrt (sqr (S[pp^.i].x - x0) + sqr (S[pp^.i].y - y0));
       pp^.t := Arg (S[pp^.i].x - x0, S[pp^.i].y - y0);
       if pp^.t = sf^.t then
          begin
          q := sf;  pus[i]:=true;
          while (q <> nil) and (q^.t = pp^.t) and (q^.r < pp^.r) do q := q^.pre;
          {inserez pp dupa lui q}
          pp^.pre :=q; pp^.urm := q^.urm; q^.urm :=pp;
          if (pp^.urm <> nil) then pp^.urm^.pre :=pp
              else sf := pp;
          end
          else dispose (pp);
       end;
end;
{elimin din lista varfurile care nu apartin infasuratorii convexe}
pp := L; q := pp^.urm;
if q <> nil then
   begin
   u := q^.urm;
   while u <> nil do
      begin
      {verific daca q apartine infasuratorii convexe}
         if IntoarcereDreapta (S[pp^.i].x, S[pp^.i].y, S[q^.i].x, S[q^.i].y, S[u^.i].x, S[u^.i].y) then
            begin {elimin q din lista}
            pp^.urm := u; u^.pre := pp; dispose (q);
            q := pp; pp := pp^.pre;
            end
            else begin pp := q; q := q^.urm; u := q^.urm; end;
      end;
   end;

{transfer in P, numai varfurile poligonului care reprezinta infasuratoarea convexa}
while L <> nil do
      begin
      inc (nP); P[nP] := L^.i;
      q := L; L := L^.urm; dispose (q);
      end;
end;
end;

procedure Uneste (i,j: Indice);
begin
inc(ks);
Sol[1, ks]:=i; Sol[2,ks]:=j;
S[i].c :=0; S[j].c := 0;
end;

procedure AfisPol(P: Poligon; n: byte);
var i: byte; fout: text;
begin
assign (fout, 'temp0.pas'); rewrite (fout);
writeln (fout, n);
for i := 1 to n do
    writeln (fout, S[P[i]].x: 10: 2, ' ', S[P[i]].y:10:2);
close (fout);
end;

begin
  Citire;
  repeat
  ConstructiePoligon(M, nM, 1);
  AfisPol(M,nm);
   i := 1;
  while i < nm do
        begin
        Uneste (M[i], M[i+1]);
        inc(i,2);
        end;
  until nm < 3;
  Afisare;
end.