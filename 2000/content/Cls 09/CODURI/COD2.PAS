program cod_prog;
label e;
var
  cod,cod_temp:string;
  i,j:byte;
  t:text;

function nedes(s:string):boolean;
var
  i:byte;
begin
  nedes:=false;
  for i:=1 to length(s)-1 do
    if s[i]<s[i+1] then
      begin
        nedes:=true;
        break;
      end;
end;

procedure next(pos:byte);
var
  i,start,j:byte;
  next_min:byte;
  ch:char;

begin
  for i:=pos+1 to length(cod) do if cod[i]>cod[pos] then
    begin
      next_min:=i;
      break;
    end;
  if next_min<length(cod) then
    begin
      start:=next_min+1;
      for i:=start to length(cod) do
        if (cod[i]>cod[pos]) and (cod[i]<cod[next_min]) then next_min:=i;
      ch:=cod[pos];
      cod[pos]:=cod[next_min];
      cod[next_min]:=ch;
      if pos+1<length(cod) then
        for i:=pos+1 to length(cod)-1 do
          begin
            start:=i;
            for j:=i+1 to length(cod) do
              if cod[start]>cod[j] then start:=j;
            ch:=cod[i];
            cod[i]:=cod[start];
            cod[start]:=ch;
          end;
    end
  else
    begin
      ch:=cod[length(cod)];
      cod[length(cod)]:=cod[length(cod)-1];
      cod[length(cod)-1]:=ch;
    end;
end;

begin
  assign(t,'cod.in');
  reset(t);
  read(t,cod);
  close(t);
  assign(t,'cod.out');
  rewrite(t);
  if nedes(cod)=true then
    begin
      for i:=length(cod)-1 downto 1 do
        begin
          for j:=i to length(cod) do cod_temp:=cod_temp+cod[j];
          if nedes(cod_temp) then
            begin
              next(i);
              writeln(t,cod);
              goto e;
            end;
        end;
      if i=1 then
        begin
          writeln(t,'Este ultimul cod');
          goto e;
        end;
    end
  else writeln(t,'Este ultimul cod');
e:close(t);
end.