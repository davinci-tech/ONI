{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program Analizator_Moara_Clasa_XII;
var fi,fo,fa,fr,fn:text;
    fis,nume:string[30];
    t:boolean;
    a:array[1..10000] of word;
    g:array[1..10000] of byte;
    x:byte;
    p,k,i,j,n,m,pb,kb,w,jj:word;
    err:integer;
    e,eb,ee:longint;
    puncte,pp,rez:byte;
begin
   puncte:=0;
   assign(fr,'rez.txt');
   rewrite(fr);
   val(paramstr(1),x,err);
          writeln(' Moara - testul ',x);
          assign(fa,paramstr(2));
          reset(fa);
          readln(fa,pb,kb,eb);
          close(fa);
          fis:='moara'+chr(48+x)+'.out';
          assign(fo,fis);
          reset(fo);
          if eof(fo) then
             begin
                t:=false;
                writeln(fr,'PCT=0 Fisier iesire GOL !!!');
                close(fo);
             end
          else
             begin
                fis:='moara'+chr(48+x)+'.in';
                assign(fi,fis);
                reset(fi);
                readln(fi,n);
                i:=0;
                repeat
                   if seekeoln(fi) then
                      readln(fi);
                   i:=i+1;
                   read(fi,a[i]);
                until i=n;
                i:=0;
                repeat
                   if seekeoln(fi) then
                      readln(fi);
                   i:=i+1;
                   read(fi,g[i]);
                until seekeof(fi);
                close(fi);
                reset(fo);
                t:=true;
                readln(fo,p,k,e);
                if not ((p>=1) and (p<=n)) then
                   begin
                      writeln(fr,'PCT=0 Pozitie scaun eronata : ',p);
                      t:=false;
                   end;
                if t and (k>kb) then
                   begin
                      writeln(fr,'PCT=0 Mutari : corect=',kb,' elev=',k);
                      t:=false;
                   end;
                if t and (e>eb) then
                   begin
                      writeln(fr,'PCT=0 Eficienta : corect=',eb,' elev=',e);
                      t:=false;
                   end;
                if t then
                   begin
                      w:=0;
                      ee:=0;
                      jj:=0;
                      while t and not seekeof(fo) do
                         begin
                            w:=w+1;
                            readln(fo,i,j);
                            if i<>jj then
                               begin
                                  writeln(fr,'PCT=0 Saci suprapusi ',i,' ',j);
                                  t:=false;
                               end
                            else
                               begin
                                  if j<>0 then
                                     begin
                                        pp:=g[a[j]];
                                        jj:=j;
                                     end
                                  else
                                     begin
                                        j:=p;
                                        pp:=rez;
                                        jj:=0;
                                     end;
                                  if i=0 then
                                     begin
                                        i:=p;
                                        rez:=g[a[j]];
                                     end;
                                  ee:=ee+pp*abs(longint(i)-j);
                               end;
                         end;
                      close(fo);
                      if t and (w>kb) then
                         begin
                            writeln(fr,'PCT=0 Mutari eronate : ', w);
                            t:=false;
                         end;
                      if t and (ee<>e) then
                         begin
                            writeln(fr,'PCT=0 Efort eronat : ', ee);
                            t:=false;
                         end;
                   end;
             end;
          if t then
             case x of
                  1: writeln(fr,'PCT=5 Testul ',x);
                  2: writeln(fr,'PCT=10 Testul ',x);
                  3: writeln(fr,'PCT=10 Testul ',x);
                  4: writeln(fr,'PCT=15 Testul ',x);
                  5: writeln(fr,'PCT=15 Testul ',x);
                  6: writeln(fr,'PCT=15 Testul ',x);
                  7: writeln(fr,'PCT=15 Testul ',x);
                  8: writeln(fr,'PCT=15 Testul ',x);
             end;
       close(fr);
end.