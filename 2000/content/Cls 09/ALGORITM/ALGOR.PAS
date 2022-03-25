program Testare;
var
   fin, fout: text;
   atom: string;

{ Analizor lexical }
procedure AnaLex;
var cuv: string;
    ch: char;
begin
     { eof }
     if eof(fin) then atom := 'eof'
     else begin
          { citeste si codifica }
          cuv := '';
          repeat
             read(fin, ch);
             if ch in ['A'..'Z'] then ch := chr(ord(ch)+32);
             if ch in ['a'..'z', '_'] then cuv := cuv + ch
             else break;
          until eoln(fin);
          readln(fin);
          atom := cuv;
     end
end;

{ Calculeaza numar cai }
function Instr: longint;
var nr, nrAtunci, nrAltfel, nrCaz, nrTemp: longint;
    contor: integer;
    implicit: boolean;
begin
    nr := 1;
    if atom = 'atrib' then begin
          AnaLex;
          nr := 1;
     end
     else if atom = 'daca' then begin
        { Atunci }
        AnaLex;
        AnaLex;
        nrAtunci := Instr;
        { Altfel }
        nrAltfel := 1;
        if atom = 'altfel' then begin
           AnaLex;
           nrAltfel := Instr;
        end;
        nr := nrAtunci + nrAltfel;
     end

     else if atom = 'alege' then begin
          AnaLex;
          implicit := false;
          nr := 0;
          while (atom = 'caz') or (atom = 'caz_implicit') do begin
                if (atom = 'caz_implicit') then implicit := true;
                AnaLex;
                nrCaz := Instr;
                nr := nr + nrCaz;
          end;
          if not implicit then inc(nr);
     end

     else if atom = 'cat_timp' then begin
          AnaLex;
          nr := Instr+1;
     end

     else if atom = 'repeta' then begin
          AnaLex;
          nr := Instr;
          AnaLex;
     end

     else if atom = 'pentru' then begin
          AnaLex;
          nr := Instr+1;
     end

     else if atom = 'inceput' then begin
          contor := 0;
          repeat
                if atom = 'inceput' then begin
                   AnaLex;
                   inc(contor)
                end
                else if atom = 'sfarsit' then begin
                     AnaLex;
                     dec(contor);
                end
                else begin
                     nrTemp := Instr;
                     nr := nr * nrTemp;
                end
          until contor = 0;
     end

     else nr := 1;

     Instr := nr;
end;

begin
     { Deschidere fisiere }
     assign(fin, 'algor.in');
     reset(fin);
     assign(fout, 'algor.out');
     rewrite(fout);

     { Calcul }
     AnaLex;
     writeln(fout,Instr);
     close(fout);
     close(fin);
end.
