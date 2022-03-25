program SOICN_Validare;

const   NMaxVf   = 255;
        Puncte:array[1..10] of Byte = (10,10,10,10,10,10,10,10,10,10);

type    Vf       = 0 .. NMaxVf;
        CompBiconexa =  set of Vf;
        Descompunere = array[Vf] of CompBiconexa;
var
        nr, n, num, i, j, h, nrbic, nrbic_meu: Vf;
        BIC_Meu, BIC: Descompunere;
        A, Ameu: CompBiconexa;
        frez,fout, fmeu: text;
        test,nrez, nume, plinie, plinie_meu:string;
        ok, egal:boolean;
        uz:array[Vf] of boolean;
        nrt, cod:integer;

procedure Citeste_Verigi(var f:text; var A:CompBiconexa);
var i: Vf;
begin
A:=[];
while not seekeoln(f) do
      begin
      read(f, i);
      A:=A+[i];
      end;
readln(f);
end;

procedure AfisareMult (var X: CompBiconexa);
var v: Vf;
begin
for v := 1 to 255 do
    if v in X then write (v, ' ');
writeln;
end;

procedure sterge_spatii(var s:string);
begin
while (s<>'') and (s[1]=' ') do delete(s, 1, 1);
while (s<>'') and (s[length(s)]=' ') do delete(s, length(s), 1);
end;

function majuscule(s:string):string;
var i: byte;
    sm:string;
begin
sm:=s;
for i := 1 to length(s) do sm[i]:=upcase(sm[i]);
majuscule:=sm;
end;

begin {program principal}
nrez:=paramstr(2);
assign(frez, nrez); rewrite(frez);
ok:=true;
nume:=paramstr(1);
{write ('fisier iesire corect'); readln (nume);}
assign(fmeu, nume); reset(fmeu);
readln(fmeu, plinie_meu);
sterge_spatii(plinie_meu);
assign (fout, 'sicn.out'); reset (fout);
if seekeoln(fout) then
         begin
         writeln (frez, 'PCT=0 Eroare! Fisier de iesire incomplet!');
         ok:=false;
         end
else
begin
readln(fout,plinie);
sterge_spatii(plinie);
if majuscule(plinie)<>majuscule(plinie_meu) then
   begin
   writeln(frez, 'PCT=0 Eroare! Raspunsul corect era ', plinie_meu);
   ok:=false;
   end
   else
   if plinie_meu='NEFORTE' then
      begin
      citeste_verigi(fmeu, ameu);
      if seekeoln(fout) then
         begin
         writeln (frez, 'PCT=0 Eroare! Fisier de iesire incomplet!');
         ok:=false;
         end
         else
         begin
         citeste_verigi(fout, a);
      if a <> ameu then
         begin
         writeln (frez, 'PCT=0 Eroare! Verigile slabe sunt:');
         AfisareMult(ameu);
         ok:=false;
         end
         else
         begin
         readln(fmeu, nrbic_meu);
         if seekeof(fout) then
            begin
            writeln (frez, 'PCT=0 Eroare! Fisier de iesire incomplet!');
            ok:=false;
            end
            else
            begin
            readln(fout, nrbic);
            if nrbic<>nrbic_meu then
               begin
               writeln (frez, 'PCT=0 Eroare! Numarul corect de grupuri forte este ', nrbic_meu);
               ok:=false;
               end
               else
               begin
               for i := 1 to nrbic do
                   Citeste_Verigi(fmeu, Bic_Meu[i]);
               for i := 1 to nrbic do
                   if seekeoln(fout) then
                      begin
                      writeln (frez, 'PCT=0 Eroare! Fisier de iesire incomplet!');
                      ok:=false;
                      break;
                      end
                      else
                      Citeste_Verigi(fout,Bic[i]);
               if ok then
                  begin
                  Egal:=true;
                  for h:=1 to nrbic do uz[h]:=false;
                  for i := 1 to nrbic do
                      for j:=1 to nrbic do
                          if Bic_Meu[j]=Bic[i] then
                             begin
                             uz[i]:=true;
                             break;
                             end;
                  for h:=1 to nrbic do
                      if not uz[h] then
                         begin Egal:=false;
                         break;
                         end;
                  if not Egal then
                     begin
                     writeln (frez, 'PCT=0 Eroare! Grupurile forte sunt gresite!');
                     ok :=false;
                     end
                  end;
               end
            end;
         end;
         end;
      end;
end;
close(fmeu);
close (fout);
test:=paramstr(3);
nrt:=ord(test[1])-48;
{val(test,nrt,cod);}
if ok then writeln (frez, 'PCT=Puncte[nrt] CORECT!!!');
end.



