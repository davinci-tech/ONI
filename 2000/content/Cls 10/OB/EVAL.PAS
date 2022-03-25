{$M 65000,0,655360}
const
     NMAX=2500;
     rez='rezultat.txt';
type
    obiectiv=record
                   o1,o2,o3,o4,c1,c2,c3,c4:integer;
             end;

var
   mesaj,input,output1,output2,comisie1,comisie2:string;
   o:array[1..NMAX] of ^obiectiv;
   fin,fout1,fout2,fcom1,fcom2:text;
   nm,cost_c,cost,cost_calculat,nr_noduri,i,j,k,n_c,m_c,m,n,mm,nr,aux,aux_c:longint;
   test,nod1,nod2:longint;
   much:array[1..6000,1..2] of integer;
   v:array[1..NMAX] of boolean;
   c:boolean;
   eval1,eval2:boolean;

procedure citire;
var
   i:integer;
begin
     assign(fin,input);
     reset(fin);
     for i:=1 to NMAX do
         new(o[i]);
     n:=0;mm:=0;
{     new(m);}
     while not seekeof(fin) do
           begin
                inc(nr_noduri);
                read(fin,nr);
                readln(fin,o[nr]^.o1,o[nr]^.c1,o[nr]^.o2,o[nr]^.c2,o[nr]^.o3,o[nr]^.c3,o[nr]^.o4,o[nr]^.c4);
           end;
     close(fin);
end;

procedure iesire;
var
   f:text;
begin
     assign(f,rez);
     rewrite(f);
     writeln(f,mesaj);
     close(f);
     halt;
end;

procedure error(msg:string);
var
   f:text;
begin
     if test=1
        then
            begin
                 eval1:=false;
                 mesaj:=msg;
            end
        else
            begin
                 mesaj:=mesaj+'  '+msg;
                 iesire;
            end;
end;

procedure citeste(var f:text;var nr:longint);
begin
     {$i-}
     read(f,nr);
     {$i+}
     if ioresult<>0
        then error('Caractere ilegale !');
end;

procedure citesteln(var f:text;var nr:longint);
begin
     {$i-}
     readln(f,nr);
     {$i+}
     if ioresult<>0
        then error('Caractere ilegale !');
end;

procedure evaluare1;
begin
     eval1:=true;
     assign(fout1,output1);
     assign(fcom1,comisie1);
     {$i-}
     reset(fout1);
     {$i+}
     if ioresult<>0
        then error('Fisierul de iesire nu exista !');
     if not eval1
        then exit;
     reset(fcom1);
     citeste(fout1,n_c);
     if not eval1
        then exit;
     citesteln(fout1,m_c);
     if not eval1
        then exit;
     readln(fcom1,n,m);
     if (n<>n_c) and (m<>m_c)
        then
            begin
                 error('Dimensiunea hartii este incorecta !');
                 if not eval1
                    then exit;
            end;

     for i:=1 to n do
         begin
              for j:=1 to m do
                  begin
                       citeste(fout1,aux_c);
                       if not eval1
                          then exit;
                       read(fcom1,aux);
                       if aux<>aux_c
                          then
                              begin
                                   error('Harta gresita !');
                                   if not eval1
                                      then exit;
                              end;
                  end;
              readln(fout1);
              readln(fcom1);
         end;
     close(fout1);
     close(fcom1);
     error('Harta corecta !');
end;

function muchie(i,j:integer):boolean; { daca exista muchie intre i si j }
begin
     if o[i]^.o1=j
        then
            begin
                 muchie:=true;
                 inc(cost_calculat,o[i]^.c1);
            end;
     if o[i]^.o2=j
        then
            begin
                 muchie:=true;
                 inc(cost_calculat,o[i]^.c2);
            end;
     if o[i]^.o3=j
        then
            begin
                 muchie:=true;
                 inc(cost_calculat,o[i]^.c3);
            end;
     if o[i]^.o4=j
        then
            begin
                 muchie:=true;
                 inc(cost_calculat,o[i]^.c4);
            end;
end;

procedure rec(k,t:integer);
var
   i:integer;
begin
     if v[k]=true
        then
            begin
                 c:=true;
                 exit;
            end;
     v[k]:=true;
     for i:=1 to nm do
         if (much[i,1]=k) and (much[i,2]<>t)
            then rec(much[i,2],k)
            else
                if (much[i,2]=k) and (much[i,1]<>t)
                   then rec(much[i,1],k);
end;

function ciclu:boolean;
begin
     c:=false;
     fillchar(v,sizeof(v),false);
     rec(1,0);
     ciclu:=c;
end;

procedure evaluare2;
begin
     assign(fout2,output2);
     assign(fcom2,comisie2);
     {$i-}
     reset(fout2);
     {$i+}
     if ioresult<>0
        then error('Fisierul de iesire nu exista !');
     reset(fcom2);
     readln(fcom2,cost);
     citesteln(fout2,cost_c);
     if cost<>cost_c
        then error('Cost incorect !');
     nm:=0;
     cost_calculat:=0;
     while not seekeof(fout2) do
           begin
                inc(nm);
                citeste(fout2,nod1);
                citesteln(fout2,nod2);
                if not muchie(nod1,nod2)
                   then error('Muchie inexistenta !');
                much[nm][1]:=nod1;
                much[nm][2]:=nod2;
           end;
     if nm<>nr_noduri-1
        then error('Numar de muchii gresit !');
     if cost_calculat<>cost_c
        then error('Cost bun, muchii gresite !');
     if ciclu
        then error('Rezultatul nu este un arbore !');
     close(fout2);
     close(fcom2);
     error('OK !!!');
end;

begin
     input:=paramstr(1);
     output1:=paramstr(2);
     output2:=paramstr(3);
     comisie1:=paramstr(4);
     comisie2:=paramstr(5);
     citire;
     {--}
     test:=1; evaluare1;
     test:=2; evaluare2;
end.