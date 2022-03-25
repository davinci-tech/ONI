var a:array[1..21,1..21,1..21] of integer;
    l,c,d,i,j,k,ll,mini,maxi,minj,maxj,mink,maxk,pi,pj,pk:byte;
    fis,fis1:string;f,g:text;
    n:integer;cod:boolean;
Procedure afiscub;
begin
   for pk:=mink to maxk do
       begin
       for pi:=mini to maxi do
           begin
           for pj:=minj to maxj do
               write(a[pi,pj,pk],',');
           writeln;
           end;
       writeln;
       writeln;
       end;
end;

begin
{readln(fis);
readln(fis1);}
assign(f,'cuburi.in');
assign(g,'cuburi.out');
reset(f);
rewrite(g);
readln(f,n);
i:=11;
j:=11;
k:=11;
a[i,j,k]:=1;
mini:=11;maxi:=11;
minj:=11;maxj:=11;
mink:=11;maxk:=11;
for l:=2 to n do
   begin
   readln(f,ll,c,d);
   cod:=true;
   for pi:=mini to maxi do
       for pj:=minj to maxj do
           for pk:=mink to maxk do
               if a[pi,pj,pk]=c then
                  begin
                  i:=pi;j:=pj;k:=pk;
                  cod:=FALSE;
                  end;
   if cod then
           begin
           writeln(g,ll,' ',c,' ',d,' 1');
           writeln(g,0);
           CLOSE(g);
           CLOSE(F);
           halt(1);
           end
    else

   case d of
   1:   begin
        i:=i-1;
        if i<mini then
        mini:=i;
        end;
   2: begin
      i:=i+1;
      if i>maxi then
      maxi:=i;
      end;
   3: begin
      j:=j-1;
      if j<minj then
      minj:=j;
      end;
   4: begin
     j:=j+1;
     if j>maxj then
     maxj:=j;
     end;
   5: begin
      k:=k-1;
      if k<mink then
      mink:=k;
      end;
   6: begin
      k:=k+1;
     if k>maxk then maxk:=k;
      end;
   end;
   if a[i,j,k]=0 then
             begin
             a[i,j,k]:=ll;
             end
         else
             begin
              writeln(g,ll,' ',c,' ',d,' 2' );
              writeln(g,0);
            {  afiscub;}
              CLOSE(g);
              CLOSE(F);
              halt(1);
             end;
   end;
   if (maxi-mini+1)*(maxj-minj+1)*(maxk-mink+1)=n then
      begin
   {   afiscub;}
      writeln(g,0);
      write(g,(maxi-mini+1),' ',(maxj-minj+1),' ',(maxk-mink+1))
      end
      else
      begin
      writeln(g,0);
      writeln(g,0);
      {afiscub}
      end;
close(f);
CLOSE(g);
end.