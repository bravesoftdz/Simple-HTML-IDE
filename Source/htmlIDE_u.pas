unit htmlIDE_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SynEditHighlighter, SynHighlighterHtml,
  SynEdit, SynMemo, Vcl.WinXCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, uPreview,
  Vcl.OleCtrls, SHDocVw, ActiveX, Vcl.ExtDlgs, ShellAPI, Vcl.Menus;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    SynMemo1: TSynMemo;
    SynHTMLSyn1: TSynHTMLSyn;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    chktab: TCheckBox;
    chkwordwrap: TCheckBox;
    chkhighlight: TCheckBox;
    chklive: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    FontDialog1: TFontDialog;
    OpenTextFileDialog1: TOpenTextFileDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
    Label1: TLabel;
    Label2: TLabel;
    Button4: TButton;
    Label3: TLabel;
    ppmsynedit: TPopupMenu;
    Clear1: TMenuItem;
    N1: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    Button6: TButton;
    Button7: TButton;
    procedure Button5Click(Sender: TObject);
    procedure chktabClick(Sender: TObject);
    procedure chkwordwrapClick(Sender: TObject);
    procedure WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
    procedure SynMemo1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OpenURL(url: string);
    procedure Button4Click(Sender: TObject);
    procedure chkhighlightClick(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenTextFileDialog1.Execute then
    SynMemo1.Lines.LoadFromFile(OpenTextFileDialog1.FileName);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveTextFileDialog1.Execute then
    SynMemo1.Lines.SaveToFile(SaveTextFileDialog1.FileName);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  frmPreview.Show;
  WB_LoadHTML(frmPreview.WebBrowser1, SynMemo1.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  OpenURL('https://github.com/Inforcer25/Simple-HTML-IDE');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  FontDialog1.Font := SynMemo1.Font;

  if FontDialog1.Execute then
    SynMemo1.Font := FontDialog1.Font;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  OpenURL('https://www.w3schools.com/html/html_basic.asp');
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  OpenURL('https://www.w3schools.com/html/html_examples.asp');
end;

procedure TForm1.chkhighlightClick(Sender: TObject);
begin
  if chkhighlight.Checked then
    SynHTMLSyn1.Enabled := True
  else
    SynHTMLSyn1.Enabled := False;
end;

procedure TForm1.chktabClick(Sender: TObject);
begin
  if chktab.Checked then
    SynMemo1.WantTabs := True
  else
    SynMemo1.WantTabs := False;
end;

procedure TForm1.chkwordwrapClick(Sender: TObject);
begin
  if chkwordwrap.Checked then
    SynMemo1.WordWrap := True
  else
    SynMemo1.WordWrap := False;
end;


procedure TForm1.Clear1Click(Sender: TObject);
begin
  SynMemo1.Clear;
end;

procedure TForm1.Copy1Click(Sender: TObject);
begin
  SynMemo1.CopyToClipboard;
end;

procedure TForm1.Cut1Click(Sender: TObject);
begin
  SynMemo1.CutToClipboard;
end;

procedure TForm1.OpenURL(url: string);
begin
  ShellExecute(self.WindowHandle,'open',PChar(url),nil,nil, SW_SHOWNORMAL);
end;

procedure TForm1.Paste1Click(Sender: TObject);
begin
  SynMemo1.PasteFromClipboard;
end;

procedure TForm1.SynMemo1Change(Sender: TObject);
begin
  if chklive.Checked then
    if frmPreview.Showing = True then
      WB_LoadHTML(frmPreview.WebBrowser1, SynMemo1.Text);
end;

procedure TForm1.WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  WebBrowser.Navigate('about:blank');
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
   Application.ProcessMessages;

  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := HTMLCode;
        sl.SaveToStream(ms);
        ms.Seek(0, 0);
        (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
  end;
end;

end.
