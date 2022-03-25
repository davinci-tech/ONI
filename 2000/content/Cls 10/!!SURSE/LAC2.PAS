{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S-,T-,V+,X+}
{$M 16384,0,655360}
{Dumitran Daniel - Bucuresti}
program lac;
const maxm=20;
      maxp=100;
      fisin='LAC.IN';
      fisout='LAC.OUT';
      pos:array[1..9,1..2] of shortint=((-1,-1),(-1,0),(-1,1),
                                        (0,-1),(0,0),(0,1),
                                        (1,-1),(1,0),(1,1));

type coord=record
             n,l,c:byte;
             end;

var n,l1,c1,l2,c2:byte;
    mat,mes:array[0..maxm+1,0..maxm+1,0..maxm+1] of integer;
    p,nrmax:integer;
    i,j,l,m,k:byte;
    f:text;
    y,x:longint;
    st,max:coord;

procedure findmax(a,b,c:shortint);
begin
  max.n:=a-1;max.l:=b+pos[1,1];max.c:=c+pos[1,2];
  nrmax:=mes[max.n,max.l,max.c];
  for k:=2 to 9 do
    if(mes[a-1,b+pos[k,1],c+pos[k,2]]>nrmax) then begin
      max.l:=b+pos[k,1];max.c:=c+pos[k,2];
      nrmax:=mes[max.n,max.l,max.c];
      end;

  end;

begin
  fillchar(mat,sizeof(mat),0);
  assign(f,fisin);reset(f);
  readln(f,m,l1,c1,l2,c2);
  readln(f,y);
  for x:=1 to y do begin
    readln(f,st.n,st.l,st.c,p);
    inc(mat[st.n,st.l,st.c],p);
    end;
  close(f);

  for i:=0 to m+1 do
    for j:=0 to m+1 do
      for l:=0 to m+1 do
        mes[i,j,l]:=-maxint;

  mes[0,l2,c2]:=0;
  for i:=1 to m do
    for j:=1 to m do
      for l:=1 to m do begin
        findmax(i,j,l);
        if(nrmax=-maxint) then begin
          mes[i,j,l]:=-maxint;
          continue;
          end;
        mes[i,j,l]:=mat[i,j,l]+mes[max.n,max.l,max.c];
        end;

  assign(f,fisout);rewrite(f);
  writeln(f,mes[m,l1,c1]);
  writeln(f,m,' ',l1,' ',c1,' ',mat[m,l1,c1]);
  st.n:=m;st.l:=l1;st.c:=c1;
  for i:=m downto 1 do begin
    findmax(st.n,st.l,st.c);
    st:=max;
    writeln(f,st.n,' ',st.l,' ',st.c,' ',mat[st.n,st.l,st.c]);
    end;
  close(f);
  end.