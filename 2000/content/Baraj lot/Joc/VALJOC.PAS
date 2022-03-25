{$N+}
program Solitaire_Plan_Validare;
const NrMaxP = 200;
      infinit = 1E7;
      Puncte:array[1..8] of byte = (15,13,10,7,8,12,15,20);
type  Indice = 0 .. NrMaxP;
      Punct = record
              x, y: double;
              c: byte;
              end;
      MultimePuncte=array[Indice] of Punct;
      Poligon = array[Indice] of Indice;
      Segmente = array[1..2, 1 .. NrMaxP div 2] of Indice;

var n, nM,ks, h, i, g, N_Iz, NrSegm, i1, i2: integer;
    Sol: Segmente;
    M: Poligon;
    S: MultimePuncte;
    Bun, ok: boolean;
    fout: text;
    e1, e2: Punct;
    Test: byte;
    Testul: String;
      rez: Text;

procedure Citire_Intrare;
var fin: text; i: byte;
    nume: string;
begin
{write ('fisier intrare '); readln (nume);}
assign (fin, paramstr(1){nume}); reset(fin);
readln (fin, n);
for i := 1 to n do
    begin
    readln (fin, S[i].x, S[i].y);
    S[i].c := 0;
    end;
close (fin);
end;

function SegmentIntersect (a, b, c, d: Punct): boolean;
var x1, x2, x3, x4, y1, y2, y3, y4: double;
begin
SegmentIntersect := false;
if a.x < b.x then begin x1 := a.x; x2 := b.x end
   else begin x2 := a.x; x1 := b.x end;
if a.y < b.y then begin y1 := a.y; y2 := b.y end
   else begin y1 := b.y; y2 := a.y end;
if c.x < d.x then begin x3 := c.x; x4 := d.x end
   else begin x3 := d.x; x4 := c.x end;
if c.y < d.y then begin y3 := c.y; y4 := d.y end
   else begin y4 := c.y; y3 := d.y end;
if (x1 <= x4) and (x2 >= x3) and (y2 >= y3) and (y4 >= y1) then
   if ((c.x-a.x)*(b.y-a.y)-(b.x-a.x)*(c.y-a.y)) *
      ((d.x-a.x)*(b.y-a.y)-(b.x-a.x)*(d.y-a.y))<= 0 then
      SegmentIntersect := true;
end;

function dist2(i,j: byte): double;
begin
dist2 := sqr(S[i].x-S[j].x)+sqr(S[i].y-S[j].y);
end;

function f(i, j, k: byte): double;
{dreapta este j k}
begin
f:=(S[i].x-S[k].x)*(S[j].y-S[k].y)-(S[i].y-S[k].y)*(S[j].x-S[k].x);
end;

function Apartine (k, i, j: byte): boolean;
{intoarce true daca si numai daca punctul k apartine segmentului i, j}
begin
Apartine := false;
if f(k, i, j)=0 then {k apartine dreptei i, j}
   if sqrt(dist2(i,k))+sqrt(dist2(k,j))=sqrt(dist2(i,j)) then Apartine := true;
end;

function Test2(i1,i2,i3,i4:integer):boolean;
label e1;
var x, y,m1,n1,m2,n2, x1, x2, x3, x4, y1, y2, y3, y4: real;
    gasit: boolean;
    a,b,c,d: Punct;
begin
gasit := false;
a:=s[i1]; b:=s[i2]; c:=s[i3]; d:=s[i4];
m1:=b.y-a.y;n1:=b.x-a.x;
m2:=d.y-c.y;n2:=d.x-c.x;
if m1 = 0 then
   begin
   y:=a.y;
   if c.y=d.y then
      if c.y=a.y then
         begin {dreptele coincid}
e1:         if a.x < b.x then begin x1 := a.x; x2 := b.x end
            else begin x2 := a.x; x1 := b.x end;
         if a.y < b.y then begin y1 := a.y; y2 := b.y end
            else begin y1 := b.y; y2 := a.y end;
         if c.x < d.x then begin x3 := c.x; x4 := d.x end
            else begin x3 := d.x; x4 := c.x end;
         if c.y < d.y then begin y3 := c.y; y4 := d.y end
            else begin y4 := c.y; y3 := d.y end;
         if (x1 <= x4) and (x2 >= x3) and (y2 >= y3) and (y4 >= y1) then
            Test2 := true
            else Test2 := false;
         end
         else
         Test2 := false
      else
      begin
      x:=(a.y-c.y)*n2/m2;
      gasit:=true;
      end
   end
   else
   if (n1*m2<>n2*m1) then
      begin
      y:=((c.x-a.x)*n1*m1+a.y*n1*m2-c.y*n2*m1)/(n1*m2-n2*m1);
      x:=a.x+(y-a.y)*n1/m1;
      gasit :=true;
      end
      else
      goto e1;
if gasit then
   begin
   S[n+1].x:=x; S[n+1].y:=y;
   if Apartine(n+1, i1, i2) and Apartine(n+1, i3,i4) then Test2:=true
      else Test2:=false;
   end;
end;


function Caut(e:Punct):integer;
var i: integer;
begin
Caut := 0;
for i := 1 to n do
    if (e.x=s[i].x) and (e.y=s[i].y) then
       begin
       Caut := i;
       break;
       end;
end;
procedure Incomplet;
begin
writeln ('Gresit!!! Fisierul de iesire este incomplet!');
Bun:=False;
end;

begin
  Citire_Intrare;
  Testul:=Paramstr(1);
  Test := Ord(Testul[1])-48;
  assign (rez, 'punctaj.txt');
  If test=1 Then Rewrite(Rez)
     Else append(rez);
  Bun := true;
  {$I-}
  assign (fout, 'joc.out');
  reset(fout);  {$I+}
  if ioresult<>0 then
     begin
     writeln ('Nu exista fisier de iesire!!!');
     Bun:=False;
     end
  else
  begin
  if seekeof(fout) then
     Incomplet
     else
     begin
     readln (fout, N_Iz);
     if n_Iz <> n mod 2 then
     begin
     writeln ('Gresit! Numarul minim de puncte izolate este ', n mod 2);
     Bun:=false;
     end
     else
     begin
     if seekeof(fout) then Incomplet
        else
        begin
     readln (fout, nrSegm);
     if NrSEgm <> n div 2 then
        begin
        writeln ('Gresit! Numarul de segmente ce pot fi trasate este ', n div 2);
        Bun:=false;
        end
        else
        for h := 1 to nrsegm do
            begin
            if seekeof(fout) then
               Incomplet
               else
               begin
               readln (fout, e1.x, e1.y, e2.x, e2.y);
            i1 := Caut(e1);
            if i1 = 0 then
               begin
               writeln('Punctul ', e1.x:7:2, ', ', e1.y:7:2, ' nu apartine multimii de puncte date!');
               Bun:=false;
               end
               else
               begin
               i2:=Caut(e2);
               if i2 = 0 then
                  begin
                  writeln('Punctul ', e2.x:7:2, ', ', e2.y:7:2, ' nu apartine multimii de puncte date!');
                  Bun:=false;
                  end
                  else
                  begin
                  if S[i1].c > 0 then
                     begin
                     writeln('Punctul ', e1.x:7:2, ', ', e1.y:7:2, ' este utilizat de prea multe ori');
                     Bun:=false;
                     end
                     else
                     begin
                     inc(S[i1].c);
                     if S[i2].c > 0 then
                        begin
                        writeln('Punctul ', e2.x:7:2, ', ', e2.y:7:2, ' este utilizat de prea multe ori');
                        Bun:=false;
                        end
                        else
                        begin
                        inc(S[i2].c);
                        Sol[1,h]:=i1; Sol[2,h]:=i2;
                        {verific daca segmentul e1, e2 nu intersecteaza alte segmente}
                        ok := true;
                        for g := 1 to h - 1 do
                            if Test2 (i1, i2, sol[1,g], sol[2,g]) then
                               begin
                               ok := false;
                               break;
                               end;
                        if not ok then
                           begin
           write('Segmentul ', e1.x:7:2, ',',e1.y:7:2,';',e2.x:7:2,',',e2.y:7:2,' se intersecteaza cu ');
           writeln(s[sol[1,g]].x:7:2,',',s[sol[1,g]].y:7:2,';',s[sol[2,g]].x:7:2,',',s[sol[2,g]].y:7:2);
                           Bun:=false;
                           end
                           else
                           begin
                           {verific daca segmentul e1 e2 nu contine alte puncte in interior}
                           ok := true;
                           for g := 1 to n do
                               if (g<>i1)and(g<>i2)and Apartine(g, i1, i2) then
                                  begin
                                  ok := false;
                                  break;
                                  end;
                           if not ok then
                              begin
 writeln ('Segmentul ', e1.x:7:2, ',',e1.y:7:2,';',e2.x:7:2,' ',e2.y:7:2,' contine punctul ',s[g].x:7:2,',',s[g].y:7:2);
                              Bun:=false;
                              end;
                           end;
                     end  end;   end; end;   end; end;end;end;end;end;
if Bun then
   Begin
      writeln ('CORECT!!!  - ', Puncte[Test], ' PUNCTE');
      WriteLn(Rez, Puncte[Test])
   End
   else writeln(Rez, 0);
Close(Rez);
WriteLn('Am terminat testul ', Test);
Readln
end.