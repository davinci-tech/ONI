const p:array[1..7,'a'..'c'] of byte=((5,0,0),(2,3,2),(4,6,4),(3,4,3),(3,4,3),(6,8,6),(10,14,10));
type
   matr=array[0..201,0..201] of byte;
   vect=array[0..201]of integer;
var fis,rez:text;
    a:matr;
    d,tmp:vect;
    n,x,i:byte;
    tmin,tcon,cati,ccon:word;
    fa,fb,fc,test,nc:byte;
    er:integer;

procedure err(a:string);
begin writeln(rez,a);close(rez);halt end;

procedure cit_date;
begin
  assign(fis,paramstr(1));reset(fis);
  readln(fis,n);
  for i:=1 to n do read(fis,d[2*i-1]);
  readln(fis);
  d[0]:=0;
  for i:=1 to n do begin
      a[0,2*i-1]:=1;a[2*i,2*n+1]:=1;
      a[2*i-1,2*i]:=1
  end;
  for i:=1 to 2*n+1 do tmp[i]:=-1;
  for i:=1 to n do begin
      while not seekeoln(fis) do begin
            read(fis,x);a[2*x,2*i-1]:=1;
      end;
      readln(fis)
  end;
  close(fis);
end;

procedure cit_bun;
begin
  assign(fis,paramstr(2));reset(fis);
  readln(fis,tmin);
  readln(fis,cati);
  close(fis);
end;

procedure fillmin(i:byte);
var j:byte;
begin
     for j:=1 to 2*n+1 do
         if a[i,j]=1 then begin
            if tmp[j]<tmp[i]+d[i] then begin
               tmp[j]:=tmp[i]+d[i];
               fillmin(j)
            end
         end;
end;
procedure gata;
var pct:byte;
    mess,mesp:string;
begin
     pct:=0;mess:='';
     if fa=10 then begin pct:=pct+p[test,'a'];mess:=mess+'a)OK ' end
     else mess:='a)incorect ';
     if fb=0 then mess:=mess+'b) nu exista ' else
        if fb=10 then begin pct:=pct+p[test,'b'];mess:=mess+'b)OK ' end
           else mess:='b)incorect ';
     if fc=0 then mess:=mess+'c) nu exista ' else
        if fc=10 then begin pct:=pct+p[test,'c'];mess:=mess+'c)OK ' end
           else if fc=1 then mess:=mess+'c)non-noduri'
                else mess:=mess+'c)nu ajuta';
     str(pct,mesp);
     err('PCT='+mesp+' '+mess)
end;
begin
     cit_date;cit_bun;
     assign(rez,paramstr(4));rewrite(rez);
     val(paramstr(5),test,er);
     assign(fis,paramstr(3));{$I-}reset(fis);{$I+}
     if ioresult<>0 then err('PCT=0 Fisier de rezultate inexistent!');
     if eof(fis) then err('PCT=0 Fisier de rezultate vid!');
     fa:=0;fb:=0;fc:=0;
     {$I-}read(fis,tcon){$I+};
     if ioresult<>0 then err('PCT=0 Format numeric incorect');
     if (tcon=-1) and (tmin>0) then err('PCT=0 Convocarea este posibila!');
     if (tcon>=0) and(tmin=-1) then err('PCT=0 Convocarea nu este posibila!');
     if (tcon=-1)and(tmin=-1) then err('PCT=5 OK!');
     if tcon=tmin then fa:=10 else fa:=1;
     if eof(fis) then gata;
     {$I-}read(fis,ccon){$I+};
     if ioresult<>0 then gata;
     if cati<>ccon then fb:=1 else fb:=10;
     if seekeof(fis) then gata;
     nc:=0;
     while not seekeof(fis) do begin
           nc:=nc+1;
           {$I-}read(fis,x);{$I+}
           if (ioresult<>0) or not (x in [1..n]) then begin fc:=1;gata end;
           dec(d[2*x-1])
     end;
     close(fis);
     tmp[0]:=0;fillmin(0);
     if tmp[2*n+1]<tmin then fc:=10 else fc:=2;
     gata;
end.
