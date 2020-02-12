program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  task_3;

  var Lessons: TLessons;
      str:     String;
begin
  try
    Lessons := TLessons.Create;
    Lessons.add('Anders Hejlsberg', 'A1', 'C#');
    Lessons.add('Anders Hejlsberg', 'A1', 'Turbo/Borland Pascal');
    Lessons.add('Scott Wiltaumot',  'A2', 'C#');
    Lessons.add('James Gosling',    'A2', 'Java');
    Lessons.add('Jonathan Ian Schwartz',    'A2', 'Java');

    writeln(Lessons.wsdtrfg('Anders Hejlsberg', 'A1'));
    writeln(Lessons.wtrgsubjecttggrou('A2', 'Java'));
    writeln(Lessons.wgtgtt('James Gosling'));

    writeln('Press enter to continue...');
    ReadLn(input);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
