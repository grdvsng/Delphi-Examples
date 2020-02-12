unit task_3;

interface
    uses
      SysUtils, System.Generics.Collections;

    // ����� �������, ������� ����� �������, ������ � �������
    type
      TLesson = class

        public
          Teacher:       String;
          StudentsGroup: String;
          Subject:       String;

        constructor __init__(my_teacher: String; my_sg: String; my_subject: String);

        function ToString: String;
      end;

    // ������� ���������
    type
      TLessons=class

      private
        items: TArray<TLesson>;

      public
        constructor __init__;

        // ��������� �������
        procedure add(teacher: String; sg: String; subject: String);

        // ����� �������� ������ �������� ������������� �������� ������
        function wsdtrfg(teacher: String; sg: String): String;
        // ����� ������������� ������ �������� ������� �������� ������,
        function wtrgsubjecttggrou(sg: String; subj: String): String;
        // ����� ������� ��������� �������� �������������.
        function wgtgtt(teacher: String): String;
      end;

implementation
  const
    NL: String = ^M + ^J;
    TAB: String = chr(9);
    NLTAB: String = ^M + ^J + chr(9);

{ TLesson }

  function TLesson.ToString: String;
  begin
      result := '{' + NL + ' "Teache": "' + self.Teacher + '", ' +
                 NL + '"Subject": "' + self.Subject + '", ' +
                 NL + '"Students Group": "' + self.StudentsGroup + '" ' +
                 NL + '}';
  end;

  constructor TLesson.__init__(my_teacher: String; my_sg: String;
    my_subject: String);
  begin
        self.Teacher       := my_teacher;
        self.StudentsGroup := my_sg;
        self.Subject       := my_subject;
  end;

{ TLessons }

  procedure TLessons.add(teacher: String; sg: String; subject: String);
  var lesson: TLesson;
  begin
      lesson := TLesson.__init__(teacher, sg, subject);

      SetLength(self.items, Length(self.items)+1);
      self.items[High(self.items)] := lesson;
  end;

  function TLessons.wgtgtt(teacher: String): String;
  var lesson: TLesson;
  begin
       result := '{' + NL + '"Teacher": "' + teacher + '", ' + NL + '"Groups:" [';

       for lesson in self.items do
       begin
         if lesson.Teacher = teacher then
           result := result + NLTAB + '"' + lesson.StudentsGroup + '", ';
       end;

       result := result + NLTAB + ']' + Nl + '}';
  end;

  function TLessons.wsdtrfg(teacher: String; sg: String): String;
  var lesson: TLesson;
  begin
        result := '{' + NL + '"Teacher": "' + teacher + '", ' + NL +
                  '"Group:" ' + '"' + sg + '", ' + NL + '"Subjects": [';

       for lesson in self.items do
       begin
         if (lesson.Teacher = teacher) and (lesson.StudentsGroup = sg) then
           result := result + NLTAB + '"' + lesson.Subject + '", ';
       end;

       result := result + NLTAB + ']' + Nl + '}';
  end;


  function TLessons.wtrgsubjecttggrou(sg: String; subj: String): String;
  var lesson: TLesson;
  begin
      result := '{' + NL + '"Group": "' + sg + '", ' + NL +
                  '"Subject:" ' + '"' + subj + '", ' + NL + '"Teachers": [';

       for lesson in self.items do
       begin
         if (lesson.StudentsGroup = sg) and (lesson.Subject = subj) then
           result := result + NLTAB + '"' + lesson.Teacher + '", ';
       end;

       result := result + NLTAB + ']' + Nl + '}';
  end;

  constructor TLessons.__init__;
  begin
    SetLength(self.items, 0);
  end;

end.
