program htmlIDE_p;

uses
  Vcl.Forms,
  htmlIDE_u in 'htmlIDE_u.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  uPreview in 'uPreview.pas' {frmPreview};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Jet');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmPreview, frmPreview);
  Application.Run;
end.
