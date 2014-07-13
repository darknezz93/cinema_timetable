unit Edycja;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm5 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender:TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}
uses Unit1;

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
///////////Button 1 Click//////////////////

procedure TForm5.Button1Click(Sender:TObject);

var temp:PElement;
begin
     try
     temp:=findel(Form1.StringGrid1.Row,root);                //zmienione
     temp.Tytu³:=Edit1.Text;
     temp.Godzina:=Edit2.Text;
     temp.Sala:=StrToInt(Edit3.Text);
     temp.Premiera:=Edit4.Text;
     Form1.wypisz_Grid;
     close;
     except
        showMessage('Popraw dane!');
     end;
end;

end.
