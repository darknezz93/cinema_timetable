unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Edycja, Vcl.Grids, Vcl.Imaging.jpeg,Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, StrUtils;
type
PElement= ^TElement;
TElement= record
  Next: PElement;
  Tytu�: string[20];
  Premiera: string[10];
  Godzina: string[5];
  Sala:integer;
  Numer:integer;
  end;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Panel2: TPanel;
    Button6: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Autor: TLabel;
    btnCloseQuery: TButton;
    Panel3: TPanel;
    Button5: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
  procedure FormCreate(Sender: TObject);
  procedure CreateList(tytul:string; godz:string; sala:integer; premiera:string);
  procedure DestroyList;
  procedure wypisz_Grid;
  procedure clean;
  procedure start;
  procedure sortowanieBabelkowe;
  procedure WypSTRGrid(obiekt: PElement; ind: integer);
  procedure Button6Click(Sender:TObject);
  procedure Button2Click(Sender:TObject);
  procedure Button1Click(Sender:TObject);
  procedure Button4Click(Sender:TObject);
  procedure Button5Click(Sender:TObject);
  procedure Button3Click(Sender:TObject);
  procedure Wyszukiwanie(Sender:TObject);
  procedure AuthorInfo(Sender: TObject);
  procedure btnKoniecClick(Sender:TObject);










  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form1: TForm1;
  counter:integer=0;
  Root: PElement;
  Last: PElement;
  i: integer=1;
  bol:boolean=false;
  saveDialog :TSaveDialog;
  openDialog :TOpenDialog;
  procedure saveToFile(p:string);
  procedure zmianaNumeru;
  procedure removeFromList(n:integer);






implementation

{$R *.dfm}

//////////!!!!!!!Tworzy list� jednokierunkow� !!!!!!! ////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.CreateList(tytul:string; godz:string; sala:integer; premiera:string);
var
 NewOne: PElement;
begin
  New(NewOne);
  NewOne^.Next := nil;
  NewOne^.Tytu� := tytul;
  NewOne^.Premiera := premiera;
  NewOne^.Godzina := godz;
  NewOne^.Sala := sala;
  NewOne^.numer := counter+1;
  inc(counter);

  if Root = nil  then
  begin
    Root := NewOne;
    Last := Root;
    end else begin
    Last^.Next := NewOne;
    Last := NewOne;
    end;
  end;
//////////Kasowanie listy////////////////////////
procedure TForm1.DestroyList;
  var
   ToDelete: PElement;
   begin
    while Root <> nil do
      begin
        ToDelete :=Root;
        Root:= Root^.Next;
        Dispose(ToDelete);
      end;
   end;

////////////Dynamiczne wyszukiwanie EDIT1////////////
procedure TForm1.Wyszukiwanie(Sender: TObject);
 var temp:PElement;
 i : integer;
begin
   try
   i:=1;
   clean;
   temp:=root;
   repeat
   begin
   if AnsiContainsText(temp.Tytu�, Edit1.Text)
    then
    begin
    StringGrid1.FixedRows:=1; StringGrid1.FixedCols:=0;
    StringGrid1.RowCount:=i;
    wypSTRGrid(temp,i);
    temp:=temp.Next;
    inc(i);
    //StringGrid1.RowCount:=StringGrid1.RowCount+1;
    end else temp:=temp.Next;
    end;
    until temp.Next=nil ;
    if AnsiContainsText(temp.Tytu�, Edit1.Text) then  wypSTRGrid(temp,i);
    StringGrid1.FixedRows:=1; StringGrid1.FixedCols:=0;
    StringGrid1.RowCount:=i+1;
    if Edit1.Text='' then  wypisz_Grid;
    except

    end;

end;


/////////Zmiana numeru id////////////////////////////////
procedure zmianaNumeru;
var i:integer;
var temp:PElement;
begin
   i:=1;
   temp:=root;
   while temp.Next<>nil do
   begin
   temp.numer:=i;
   inc(i);
   temp:=temp.Next;
   end;
   temp.numer:=i;
   inc(i);
end;

//////////////////Wczytywanie pliku  //////////////////////////////////////
procedure TForm1.Button2Click(Sender:TObject);
var
  temp: TElement;
  f: file of TElement;
  query: integer;
begin
  try
    if(bol=true) then
    begin
      query:=MessageDlg('Czy zapisa�?',mtConfirmation,mbOKCancel,0);
        if query=mrOK then
    begin
      saveDialog := TSaveDialog.Create(self);
      saveDialog.Title := 'Zapisz baz� film�w kina Screen';
      saveDialog.InitialDir := 'C:\';
      saveDialog.Filter := 'Baza danych kina Screen|*.bin';
      saveDialog.DefaultExt :='bin';
    end;

    if saveDialog.Execute then
    begin
      saveToFile(saveDialog.FileName);
    end;
      saveDialog.Free;
    end;

   except
  end;

  openDialog := TOpenDialog.Create(self);
  openDialog.initialDir := 'C:\';
  openDialog.Options := [ofFileMustExist];
  openDialog.Filter :=
  'Baza danych kina Screen|*.bin';
  openDialog.Title := 'Wczytywanie danych kina Screen';

  if openDialog.Execute
  then

  if(bol=true) then
  begin
    DestroyList;
    clean;
    counter:=0;
  end;

  bol:=true;
  try
    begin
    AssignFile(f,openDialog.FileName);
    Reset(f) ;
    try
   while not Eof(f) do begin
    Read (f, temp);
    CreateList(temp.Tytu�,temp.Godzina,temp.Sala,temp.Premiera);
    end;
    zmianaNumeru;
    wypisz_Grid;
    finally
       CloseFile(f);
       openDialog.Free;
    end;
    end;
    except

           ShowMessage('Wyst�pi� b��d wczywywania');
  end;
end;


/////////////////Zapisywanie pliku////////////////////

procedure TForm1.Button1Click(Sender: TObject);
begin
  saveDialog:= TSaveDialog.Create(self);
  saveDialog.Title:='Zapisz baz� film�w kina Screen';
  saveDialog.InitialDir:='C:\';
  saveDialog.Filter:='Baza film�w kina Screen|*bin';
  saveDialog.DefaultExt:='bin';
  if saveDialog.Execute then
  begin
    saveToFile(saveDialog.FileName);
  end;
  saveDialog.Free;
end;

//////////////Save_to_file//////////////////////////

procedure saveToFile(p:string);
  var f:file of TElement; temp:PElement;
  begin
    try
      try
        temp:=root;
        assignfile(f,p);
        rewrite(f);
        while temp<>nil do
        begin
          write(f,temp^);
          temp:=temp.Next;
        end;
      finally
        ShowMessage('Zapisano');           //////////////////////////////
        closefile(f);
      end;
    except
      ShowMessage('Wyst�pi� b�ad przy zapisywaniu!');
    end;
  end;



///////// Procedura start////////////////////////
 procedure TForm1.start;
 begin
     Root := nil;
     Last := nil;
 end;

   ////////////wypisz_Grid////////////////////////////
procedure TForm1.wypisz_Grid;
   var
   temp: PElement;
   i: integer;
 begin
 i:=1; temp:=root;
    while temp<>nil do
    begin
       StringGrid1.Cells[0,i]:=intToStr(temp.numer);
       StringGrid1.Cells[1,i]:=temp.Tytu�;
       StringGrid1.Cells[2,i]:=temp.Godzina;
       StringGrid1.Cells[3,i]:=intToStr(temp.Sala);
       StringGrid1.Cells[4,i]:=temp.Premiera;
       if(i<>1) and (StringGrid1.RowCount=i) then
       StringGrid1.RowCount:=StringGrid1.RowCount+1;
       I:=I+1;
       temp:=temp.Next;
    end;

 end;

///////////BUTTON 6/////////////////////////
procedure TForm1.Button6Click(Sender: TObject);
 begin
     try
     CreateList(Edit3.Text,Edit2.Text,strToint(Edit4.Text),Edit5.Text);
     except
       showmessage('Prosz� poprawi� wpisane dane.');
     end;
     wypisz_Grid;
     Edit3.Clear;
     Edit2.Clear;
     Edit4.Clear;
     Edit5.Clear;
 end;



///////////////WypSTRGrid///////////////////////////////
procedure TForm1.WypSTRGrid(obiekt:PElement; ind:integer);
begin
    StringGrid1.RowCount:=30;
    StringGrid1.Cells[0,ind]:=intToStr(obiekt.numer);
    StringGrid1.Cells[1,ind]:=obiekt.Tytu�;
    StringGrid1.Cells[2,ind]:=obiekt.Godzina;
    StringGrid1.Cells[3,ind]:=intToStr(obiekt.Sala);
    StringGrid1.Cells[4,ind]:=obiekt.Premiera;


end;
/////////////CREATE////////////////////
procedure TForm1.FormCreate(Sender: TObject);
var Check: THandle;
//////////////////SPRAWDZANIE CZY PROGRAM JEST OTWARTY/////////////////
begin
  Check := CreateFileMapping(THANDLE($FFFFFFFF),nil,PAGE_READONLY,0,32,'App');
 if GetLastError=ERROR_ALREADY_EXISTS then
 begin
  Application.Terminate;
  CloseHandle(Check);
 end;
////////////////////OPEN DIALOG///////////////////////////////
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := 'D:\';
  openDialog.Options := [ofFileMustExist];
  openDialog.Filter :=
    'Baza film�w kina Screen|*.bin';
  openDialog.Title:='Wczytywanie bazy film�w kina Screen';
   /////////////////////////////
      start;
    ////////////////////////////
      StringGrid1.Cells[0,0]:='Numer';
      StringGrid1.Cells[1,0]:='Tytu�';
      StringGrid1.Cells[2,0]:='Godzina';
      StringGrid1.Cells[3,0]:='Sala';
      StringGrid1.Cells[4,0]:='Premiera';
      //////////////////////////////

end;



/////////////////////CLEAN///////////////////////////
procedure TForm1.clean;
var i:integer;
begin
   for i := 1 to StringGrid1.RowCount -1
   do StringGrid1.Rows[i].Clear;
end;



////////////////SORTOWANIE/////////////////////////////

function countElements(Root:PElement):integer;
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
////////////FINDEL/////////////
function findel(i:integer; Root:PElement):PElement;
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

////////////////EDYCJA//////////////////////////////////
procedure TForm1.Button3Click(Sender: TObject);
 var edit:TForm5; temp:PElement;
 begin
    try
    if countElements(root)=0 then exit;
    temp:=findel(StrToInt(StringGrid1.Cells[0,StringGrid1.Row]),Root);
    edit:=TForm5.Create(nil);
    edit.Edit1.Text:=temp.Tytu�;
    edit.Edit2.Text:=temp.Godzina;
    edit.Edit3.Text:=intToStr(temp.Sala);
    edit.Edit4.Text:=temp.Premiera;
    edit.ShowModal;
    except
      showmessage('Wybra�e� pusty wiersz');
    end;
end;

////////////////USU�////////////////////////////////////
procedure TForm1.Button4Click(Sender: TObject);
var i, query :integer;
begin
    try
    if countElements(Root)=0 then exit;
    query:=MessageDlg('Czy na pewno usun��?',mtConfirmation,mbOKCancel,0);
    if query=mrOK then
    begin
    ///FUNKCJA///////////////
    //removeFromList(StringGrid1.Row);
    removeFromList(StrToInt(StringGrid1.Cells[0,StringGrid1.Row]));
    clean;
    if StringGrid1.RowCount<>2 then StringGrid1.RowCount:=StringGrid1.RowCount-1;
    ///FUNKCJA///////////////
    counter:=counter-1;
    zmianaNumeru;
    wypisz_Grid;
    end;
    except
        showmessage('Wybra�e� pusty wiersz');
    end;
end;

///////////////REMOVE FROM LIST/////////////////////////////////


procedure removeFromList(n:integer);
 var temp,prev:PElement; k:integer;
 begin
   k:=1;
   temp:=root;
   if n=1 then
   begin
     root:=root.Next;
     Dispose(temp);
   end;

    if(n>1) then
    begin
      while n<>k do
      begin
        prev:=temp;
        temp:=temp.Next;
        k:=k+1;
      end;
      prev.Next:=temp.Next;
      dispose(temp);

      if prev.Next=nil then last:=prev;


    end;
 end;


/////////SORTOWANIE B�BELKOWE//////////////////

procedure TForm1.sortowanieBabelkowe;

var i,j:integer;
licznik:integer;
temp:PElement;
prev:PElement;
addition:PElement;
a:integer;
b:integer;

begin
try
licznik:=countElements(root);                               ///zmienione
licznik:=licznik-1;

for j:=1 to licznik do
  begin;
    prev:=root;
    temp:=prev.Next;
    addition:=root;

    for i:=1 to licznik do
      begin;

         if radiobutton1.Checked then
         begin
         a:=AnsiCompareText(prev.Tytu�,temp.Tytu�);
         end else

         begin
         a:=prev.Sala-temp.Sala;

          end;



          if a>0 then
          begin
            if temp.Next=nil then
              ////////KONIEC/////////////
              begin
                b:=prev.numer;         ///
                prev.numer:=temp.numer;   ///
                temp.numer:=b;         ///
                prev.Next:=nil;
                temp.Next:=prev;
                if licznik<>1 then addition.Next:=temp;
                if licznik=1 then Root:=temp;
                Last:=prev;
              end else if prev=root then
              //////////POCZATEK////////////
                begin
                b:=prev.numer;         ///
                prev.numer:=temp.numer;   ///
                temp.numer:=b;         ///
                prev.Next:=temp.Next;
                temp.Next:=prev;

                Root:=temp;
                addition:=temp;
                temp:=prev.Next;
                end else
                //////�RODEK////////////////
                  begin
                     b:=prev.numer;         ///
                     prev.numer:=temp.numer;   ///
                     temp.numer:=b;         ///
                     prev.Next:=temp.Next;
                     temp.Next:=prev;
                     addition.Next:=temp;
                     addition:=temp;
                     temp:=prev.Next;
                  end;

            end else begin
            if prev<>root then addition:=prev;
            prev:=temp;
            temp:=temp.Next;
            end;
      end;


  wypisz_Grid;
  end;

  except

  end;

 end;

///////////////BUTTON 5 CLICK Sortuj/////////////////

procedure TForm1.Button5Click(Sender: TObject);
begin
  sortowanieBabelkowe;
end;

////////////////////INFORMACJE O AUTORZE////////////////////////

procedure TForm1.AuthorInfo(Sender: TObject);
begin
  Application.MessageBox('Autor:  Adam Szczesiak , Wydzia� Informatyki , nr.109683 ','Autor',MB_OK + MB_ICONQuestion);
end;


//////////////////ZAPIS PRZED ZAMKNI�CIEM///////////////////////
procedure TForm1.btnKoniecClick(Sender: TObject);
begin
case Application.MessageBox('Czy na pewno chcesz zamkn�� program','Zamkni�cie programu',MB_YESNO+MB_ICONQUESTION) of
IDYES:CLOSE;
end;



end;




end.
