library Functions;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

   uses
  SysUtils,
  Classes;

type
 PElement = ^TElement;
 TElement = record
   Next: PElement;
   Marka: string[20];
   Model:string[20];
   Rocznik:integer;
   Cena:integer;
 end;
{$R *.res}

/////////////////////////////
/////////////////////////////

function countElements(Root:PElement):integer; stdcall;
var licznik:integer;
temp:PElement;
begin
    licznik:=1;
    temp:=Root;
    while temp.Next<>nil do
    begin
      temp:=temp.Next;
      inc(licznik);
    end;
    result:=licznik;
end;
/////////////////////////////
function findel(i:integer; Root:PElement):PElement; stdcall;
 var wsk:PElement; n:integer;
 begin
    wsk:=root;
    n:=1;
    while i<>n do
    begin
    wsk:=wsk.Next;
    n:=n+1;
    end;
    result:=wsk;
 end;

 exports
    countElements, findel;

begin
end.
