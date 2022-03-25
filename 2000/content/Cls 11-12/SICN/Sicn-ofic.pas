program SOICN;
const   NMaxVf   = 150;
type    Vf       = 0 .. NMaxVf;
        Stiva    = ^NodStiva;
        NodStiva = record
                   f:byte; t: integer;
                   urm: Stiva
                   end;
        Lista    = ^NodLista;
        NodLista = record
                   v: Vf;
                   leg: Lista;
                   end;
        Graf     = array[Vf] of Lista;
        CompBiconexa =  set of Vf;
var     S: Stiva; G: Graf;
        low, dfn: array[Vf] of integer;
        nr, n, num, i, nrdesc: Vf;
        BIC: array[Vf] of CompBiconexa;
        A: CompBiconexa;
        fout: text; nout:string;

procedure Initializare;
var x, y: Vf; p: Lista;
    fin: text; nume: string;
begin
write ('fisier intrare '); readln (nume);
assign(fin, nume); reset(fin);
readln(fin, n);
while not seekeof (fin) do begin
      readln (fin, x, y);
      new(p); p^.v := x; p^.leg:=G[y]; G[y]:=p;
      new(p); p^.v := y; p^.leg:=G[x]; G[x]:=p;
      end;
for x := 0 to n do
    begin
    dfn[x] := -1;
    low[x]:=-1;
    end;
close(fin);
new(S); S^.f := 0; S^.t := -1; S^.urm := nil;
end;

procedure Constructie_Comp_Biconexa(x, u: integer);
var p: Stiva; a, b: integer;
begin
inc(nr);{nr - numarul de componente biconexe}
repeat
   p := S; a:=p^.t; b := p^.f; S := S^.urm;
   BIC[nr] := BIC[nr] + [a, b];
   dispose(p);
until (a = u) and (b = x);
end;

function min (a, b: integer): integer;
begin
if a < b then min := a
         else min := b
end;

procedure Biconex(u, tu: integer);
{calculeaza dfn si low si afiseaza componentele biconexe}
var p: Lista;
    q: Stiva;
    x: integer;
begin
   dfn[u] := num; low[u] := dfn[u];
   inc(num);
   p := G[u];
   while p <> nil do {parcurg lista de adiacenta a lui u}
        begin
        x := p^.v;
        if (x <> tu) and (dfn[x] < dfn[u])
             then begin {insereaza in stiva S muchia(u,x)}
                  new(q); q^.f := x; q^.t := u;
                  q^.urm := S; S := q;
                  end;
        if dfn[x] = -1 then {x nu a mai fost vizitat}
           begin
           if u=0 then inc(nrdesc);
           Biconex (x, u);
           low[u] := min(low[u], low[x]);
           if low[x] >= dfn[u] then begin
              {u este un punct de articulatie;
               am identificat o componenta biconexa, ce contine muchiile din stiva S pana la (u,x)}
               if u<>0 then
                  A := A + [u];
               Constructie_Comp_BiconexA(x, u);
               end;
           end
           else if x <> tu then low[u] := min(low[u], dfn[x]);
        p := p^.leg
        end;
end;

procedure AfisMult (var X: CompBiconexa);
var v: Vf;
begin
for v := 0 to n do
    if v in X then write (fout, v, ' ');
writeln (fout);
end;

begin {program principal}
Initializare;
write('fisier de iesire corect '); readln(nout);
assign (fout, {'soicn.out'}nout); rewrite (fout);
Biconex(0, -1);

if nr = 1 then writeln (fout, 'FORTE')
   else
   begin
   writeln (fout, 'NEFORTE');
   if NrDesc>1 then A:=A+[0];
   AfisMult (A);
   writeln (fout, nr);
   for i := 1 to nr do AfisMult (BIC[i]);
   end;
close (fout);
end.



