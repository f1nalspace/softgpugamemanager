program softgpu_profile_mng;

uses
  Forms,
  mainform in 'mainform.pas' {frmMain},
  gameditform in 'gameditform.pas' {frmGameEditor},
  utils in 'utils.pas',
  gameentry in 'gameentry.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SoftGPU Game Manager';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmGameEditor, frmGameEditor);
  Application.Run;
end.
