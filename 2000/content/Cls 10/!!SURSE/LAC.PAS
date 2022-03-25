{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
{Bors Vencel - Bihor}
const be='lac.in';
      ki='lac.out';
type hel=record
           dep:boolean;
           val:word;
         end;
var l              :array[0..20,1..20,1..20] of byte;
    v              :array[0..20,1..20,1..20] of hel;
    f              :text;
    st,fin         :array[1..2] of byte;
    m              :byte;
    y              :word;
    i,j,k          :word;
    o,p,q,r        :byte;
    ut             :boolean;
Procedure wsol(x,y,z:byte);
var t:boolean;
begin
   if x<m then begin
                 t:=true;
                 if v[x+1,y,z].val+l[x,y,z]=v[x,y,z].val then begin wsol(x+1,y,z);
                                                            if ut then t:=false;
                                                      end;
                 if y<m then
                 if t and (v[x+1,y+1,z].val+l[x,y,z]=v[x,y,z].val) then
                                                      begin wsol(x+1,y+1,z);
                                                            if ut then t:=false;
                                                      end;
                 if (y<m) and (z<m) then
                 if t and (v[x+1,y+1,z+1].val+l[x,y,z]=v[x,y,z].val) then
                                                      begin wsol(x+1,y+1,z+1);
                                                            if ut then t:=false;
                                                      end;
                 if (y<m) and (z>1) then
                 if t and (v[x+1,y+1,z-1].val+l[x,y,z]=v[x,y,z].val) then
                                                      begin wsol(x+1,y+1,z-1);
                                                            if ut then t:=false;
                                                      end;
                 if (y>1) then
                 if t and (v[x+1,y-1,z].val+l[x,y,z]=v[x,y,z].val) then
                                                      begin wsol(x+1,y-1,z);
                                                            if ut then t:=false;
                                                      end;
                 if (y>1) and (z>1) then
                 if t and (v[x+1,y-1,z-1].val+l[x,y,z]=v[x,y,z].val) then
                                                      begin wsol(x+1,y-1,z-1);
                                                            if ut then t:=false;
                                                      end;
                 if (y>1) and (z<m) then
                 if t and (v[x+1,y-1,z+1].val+l[x,y,z]=v[x,y,z].val) then
                                                      begin wsol(x+1,y-1,z+1);
                                                            if ut then t:=false;
                                                      end;
                 if (z<m) then
                 if t and (v[x+1,y,z+1].val+l[x,y,z]=v[x,y,z].val) then
                                                      begin wsol(x+1,y,z+1);
                                                            if ut then t:=false;
                                                      end;
                 if (z>1) then
                 if t and (v[x+1,y,z-1].val+l[x,y,z]=v[x,y,z].val) then
                                                      begin wsol(x+1,y,z-1);
                                                            if ut then t:=false;
                                                      end;
               end;
   if (y=st[1]) and (z=st[2]) then ut:=true;
   if ut then writeln(f,x,' ',y,' ',z,' ',l[x,y,z]);
end;
begin
   assign(f,be);
   reset(f);
   read(f,m);
   read(f,st[1]);
   read(f,st[2]);
   read(f,fin[1]);
   readln(f,fin[2]);
   readln(f,y);
   for i:=1 to y do
    begin
      read(f,o);
      read(f,q);
      read(f,r);
      readln(f,p);
      l[o,q,r]:=p;
    end;
   close(f);
   for i:=0 to m do
    for j:=1 to m do
     for k:=1 to m do
      begin
        v[i,j,k].val:=0;
        v[i,j,k].dep:=false;
      end;
   v[m,st[1],st[2]].val:=l[m,st[1],st[2]];
   v[m,st[1],st[2]].dep:=true;
   for i:=m downto 1 do
    begin
      for j:=1 to m do
       for k:=1 to m do
        if v[i,j,k].dep then
          begin
            v[i-1,j,k].dep:=true;
            if v[i-1,j,k].val<v[i,j,k].val+l[i-1,j,k] then
            v[i-1,j,k].val:=v[i,j,k].val+l[i-1,j,k];
            if j>1 then begin
                          v[i-1,j-1,k].dep:=true;
                          if v[i-1,j-1,k].val<v[i,j,k].val+l[i-1,j-1,k] then
                          v[i-1,j-1,k].val:=v[i,j,k].val+l[i-1,j-1,k];
                    if k>1 then begin
                                   v[i-1,j-1,k-1].dep:=true;
                                   if v[i-1,j-1,k-1].val<v[i,j,k].val+l[i-1,j-1,k-1] then
                                   v[i-1,j-1,k-1].val:=v[i,j,k].val+l[i-1,j-1,k-1];
                                end;
                    if k<m then begin
                                   v[i-1,j-1,k+1].dep:=true;
                                   if v[i-1,j-1,k+1].val<v[i,j,k].val+l[i-1,j-1,k+1] then
                                   v[i-1,j-1,k+1].val:=v[i,j,k].val+l[i-1,j-1,k+1];
                                end;
                        end;
            if k>1 then begin
                            v[i-1,j,k-1].dep:=true;
                            if v[i-1,j,k-1].val<v[i,j,k].val+l[i-1,j,k-1] then
                            v[i-1,j,k-1].val:=v[i,j,k].val+l[i-1,j,k-1];
                    if j<m then begin
                                   v[i-1,j+1,k-1].dep:=true;
                                   if v[i-1,j+1,k-1].val<v[i,j,k].val+l[i-1,j+1,k-1] then
                                   v[i-1,j+1,k-1].val:=v[i,j,k].val+l[i-1,j+1,k-1];
                                end;
                        end;
            if k<m then begin
                          v[i-1,j,k+1].dep:=true;
                          if v[i-1,j,k+1].val<v[i,j,k].val+l[i-1,j,k+1] then
                          v[i-1,j,k+1].val:=v[i,j,k].val+l[i-1,j,k+1];
                        end;
            if j<m then begin
                          v[i-1,j+1,k].dep:=true;
                          if v[i-1,j+1,k].val<v[i,j,k].val+l[i-1,j+1,k] then
                          v[i-1,j+1,k].val:=v[i,j,k].val+l[i-1,j+1,k];
                    if k<m then begin
                                   v[i-1,j+1,k+1].dep:=true;
                                   if v[i-1,j+1,k+1].val<v[i,j,k].val+l[i-1,j+1,k+1] then
                                   v[i-1,j+1,k+1].val:=v[i,j,k].val+l[i-1,j+1,k+1];
                                end;
                        end;
          end;
    end;
    assign(f,ki);
    rewrite(f);
    writeln(f,v[0,fin[1],fin[2]].val);
    ut:=false;
    wsol(0,fin[1],fin[2]);
    close(f);
end.