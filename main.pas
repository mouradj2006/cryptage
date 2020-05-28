program ouex;
uses crt;
type tclef=string[21];
var
tx1 ,tx2 : text ;
cle:tclef;
procedure creation ( var tx1,tx2 : text ) ;
begin
assign(tx1,'initial.txt');
assign(tx2,'final.txt');
rewrite(tx2);
end;
procedure saisiecle(var cle:tclef);

function clevalide(cle:tclef):boolean;
var i:integer;
test:boolean;
begin
i:=1;test:=true;
repeat
    if(cle[i] in ['0','1'])then
    i:=i+1
    else
   test:=false;
until (test=false)or(i=length(cle));
 clevalide:=(length(cle) mod 7 =0 )and    (length(cle) <=21 )and test;
end;
begin
repeat
    writeln('Donner la cle');
    readln(cle)
until (clevalide(cle));
    
end;
function decbin(n:integer):string;
var r,c:string;
begin
r:='';
  while(n<>0) do 
  begin
  str(n mod 2,c);
  n:=n div 2;
  r:=c+r;
  end;  
  decbin:=r;
end;
function cryptermsg(msg:string;cle:tclef):string;
var taillebloc,i,j:integer;
bloc,blocbin,bloccrypt,res:string;

begin
    {etape1}
    while(length(msg)*7 mod length(cle)<>0 )Do
    msg:=msg+'\';
{etape2 & 3}
taillebloc:=length(cle)div 7;
i:= 1 ;
blocbin:='';
res:='';
repeat
 bloc:= copy(msg,i,taillebloc);
 blocbin:='';
 for j:=1 to length(bloc)  Do
 blocbin:=blocbin+decbin(ord(bloc[j])) ;
 
{etape4}
bloccrypt:='';
for j:=1 to length(blocbin)  Do
if(blocbin[j]=cle[j])then
bloccrypt:=bloccrypt+'0'
else
bloccrypt:=bloccrypt+'1';

res:=res+bloccrypt;
i:=i+taillebloc;
until (i>length(msg));
cryptermsg:=res;

end;
procedure crypterfichier( var s:text;var d:text;cle:tclef);
var msg:string[36];
begin
reset(s);
rewrite(d);
while not eof (s) do
   begin
      readln (s,msg);
      writeln(d,cryptermsg(msg,cle));
   end;
   close(s);close(d);
end;

begin
creation(tx1,tx2);
{10101100101101}
saisiecle(cle);
crypterfichier(tx1,tx2,cle);
end.