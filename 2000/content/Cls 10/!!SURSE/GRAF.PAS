{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
{Bors Vencel -Bihor}
const be='graf.in';
      ki='graf.out';
var f  :text;
    x  :array[1..250,1..250] of byte;
    h  :array[1..250] of byte;
    tim:longint absolute $0000:$46C;
    al :longint;
    n,e   :byte;
    i,j,k :byte;
function good:boolean;
var v:boolean;
begin
    good:=true;
    for i:=1 to n do
     begin
       for j:=1 to n do
       if i<>j then
        if x[j,i]> x[i,j] then begin
                                 v:=false;
                                 for k:=1 to n do
                                 if (x[i,k]=1) and (x[k,j]=1) then v:=true;
                                 if not v then good:=false;
                               end;
     end;
end;
procedure find;
var v:boolean;
begin
   for i:=1 to n do
     begin
       for j:=1 to n do
       begin
       if i<>j then
        if x[j,i]> x[i,j] then begin
                                 v:=false;
                                 for k:=1 to n do
                                 if (x[i,k]=1) and (x[k,j]=1) then v:=true;
                                 end;
       if not v then begin
                       v:=true;
                       for k:=1 to n do
                        if v and (x[i,k]*x[j,k]=1) then begin
                                                          v:=false;
                                                          x[j,k]:=0;
                                                          x[k,j]:=1;
                                                        end;
                     end;
       v:=true;
       end;
     end;
end;
begin
    al:=tim+3*18;
    assign(f,be);
    reset(f);
    readln(f,n);
    close(f);
    if n mod 2=0 then e:=n div 2 else e:=(n div 2)+1;
    for i:=1 to n do
     begin
        j:=0;
        while (j<n) and (h[i]<e) do
         begin
           inc(j);
           if j<>i then begin
                          if x[j,i]=0 then begin x[i,j]:=1;inc(h[i]) end;
                        end;
         end;
     end;
    if not good and (tim<al) then begin
                                    for i:=1 to n do
                                     if h[i]=0 then begin inc(h[i]);x[i,1]:=1;x[1,i]:=0;dec(h[1]); end;
                                    find;
                                  end;
    assign(f,ki);
    rewrite(f);
    if good then begin
                   for i:=1 to n do
                   begin
                    for j:=1 to j do
                     write(f,x[i,j],' ');
                    writeln(f);
                   end;
                 end
            else writeln(f,'NU');
    close(f);
end.