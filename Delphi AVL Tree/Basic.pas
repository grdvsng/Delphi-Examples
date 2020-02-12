unit task_2;

interface

  { ������, ������� �����}
  type
    TTree=class

    private
      fLeft:        TTree;
      fRight:       TTree;
      fParent:      TTree;
      fValue:       Variant;
      fItems:       TArray<TTree>;
      fRightCout:   Integer;
      fLeftCout:    Integer;

      function get_right:  TTree;
      function get_left:   TTree;
      function get_parent: TTree;
      function get_value:  Variant;

      // ����� ���� ��������
      function make_me_head: TTree;
      // ��������� ���� ��������(�� ��������)
      function compare(another_tree: TTree): Integer;
      // ���� ������� ������(�������, ���� ������ ������ �� �������� ��������)
      function get_tree_head: TTree;
      function _build_json(rec_lvl: Integer): String;
      function _get_tree_value_or_null(_tree: TTree; rec_lvl: Integer): String;
      function get_right_cout: Integer;
      function get_left_cout:  Integer;

      procedure set_value(new_value: Variant);
      procedure set_right(new_right: TTree);
      procedure set_left(new_left: TTree);
      procedure set_right_cout(new_cout: Integer);
      procedure set_left_cout(new_cout: Integer);

      property RightCout: Integer read get_right_cout write set_right_cout;
      property LeftCout:  Integer read get_left_cout  write set_left_cout;
      procedure update_child_cout;

    public
      property Value:  Variant read get_value  write set_value;
      property Right:  TTree   read get_right  write set_right;
      property Left:   TTree   read get_left   write set_left;
      property Parent: TTree   read get_parent;

      // ������ ��� ������� � �������� �����
      constructor __init__(my_value: Variant); overload;
      // ������� � �������
      constructor __init__(my_value: Variant; my_parent: TTree); overload;
      // ������� � ������� � ��������
      constructor __init__(my_value: Variant; my_parent: TTree;
        my_child: TTree); overload;
      // ������� � ������� � ���������
      constructor __init__(my_value: Variant; my_parent: TTree;
        my_child_1: TTree; my_child_2: TTree); overload;

      // ���������� ������ ����, ����� ��������
      procedure add(new_tree_value: Variant); overload;
      // ���������� ������ ����(������)
      procedure add(new_tree: TTree); overload;

      // ������������ ������
      function balance: TTree;
      // ��������������� ������ � ��������������� ������
      function AsArray: TArray<Variant>;
      // ��������� �������� ���������
      function Max: Variant;
      // ���������� ��������
      function Low: Variant;
      // ��������� ������� ���������
      function Max_Node: TTree;
      // ���������� ������� ���������
      function Low_Node: TTree;
      // ���������� �������� ����� ������
      function ToString: String;
      // ���������� JSON ������
      function build_json: String;
      // �������� �������� �� ���������
      function entry_check(val: Variant): Boolean;
      // �����
      function find(val: Variant): TTree;

    end;

    function repeat_str(str: String; loop: Integer): String;
    
implementation
  uses System.Generics.Collections, SysUtils, System.TypInfo, System.Generics.Defaults;

  const
    NL: String = ^M + ^J;
    TAB: String = chr(9);
    NLTAB: String = ^M + ^J + chr(9);
  
{ TTree }
  { ������������ }
  constructor TTree.__init__(my_value: Variant; my_parent, my_child: TTree);
  begin
    self.Value   := my_value;
    self.fParent := my_parent;

    self.add(my_child);
  end;

constructor TTree.__init__(my_value: Variant; my_parent, my_child_1,
    my_child_2: TTree);
  begin
    self.Value   := my_value;
    self.fParent := my_parent;

    self.add(my_child_1);
    self.add(my_child_2);
  end;

  constructor TTree.__init__(my_value: Variant);
  begin
    self.Value := my_value; 
  end;

  constructor TTree.__init__(my_value: Variant; my_parent: TTree);
  begin
    self.Value   := my_value;
    self.fParent := my_parent;
  end;

  { ��������� }
  procedure TTree.add(new_tree_value: Variant);
  var new_tree:   TTree;
  begin
    new_tree := TTree.__init__(new_tree_value, self);

    self.add(new_tree);
  end;

  procedure TTree.add(new_tree: TTree);
  begin
    if self.Value <> new_tree.Value then
    begin
      if self.Value > new_tree.Value then self.Left  := new_tree;
      if self.Value < new_tree.Value then self.Right := new_tree;

      SetLength(self.fItems , Length(self.fItems )+1);
      self.fItems[High(self.fItems)] := new_tree;
    end;

    new_tree.fRightCout := self.fRightCout + self.fLeftCout;
  end;

  procedure TTree.set_left(new_left: TTree);
    begin
       self.LeftCout := self.LeftCout + 1;

       if self.Left <> nil then
         begin self.Left.add(new_left); end
       else
         begin
          self.update_child_cout();

          self.fLeft         := new_left;
          self.fLeft.fParent := self;
       end;
    end;

  procedure TTree.set_left_cout(new_cout: Integer);
  begin
     self.fLeftCout := new_cout;
  end;

  procedure  TTree.update_child_cout;
  var item: TTree;
  begin
    for item in self.fItems do item.RightCout := item.RightCout+1;
  end;

  procedure TTree.set_right(new_right: TTree);
  var item: TTree;
  begin
     self.RightCout := self.RightCout+1;

     if self.Right <> nil then
       begin self.fRight.add(new_right); end
     else
       begin
        self.update_child_cout();

        self.fRight            := new_right;
        self.fRight.fParent    := self;
       end;
  end;

  procedure TTree.set_right_cout(new_cout: Integer);
  begin
       self.fRightCout := new_cout;
  end;

  procedure TTree.set_value(new_value: Variant);
  begin
     self.fValue := new_value;
  end;

  function TTree.ToString: String;
  begin
        result := Format('%s', [self.fValue]);
  end;

{ ������� }
  function TTree.Compare(another_tree: TTree): Integer;
  var LComparer: IComparer<Variant>;
  begin
    LComparer := TComparer<Variant>.Default;

    result := LComparer.Compare(self.Value, another_tree.Value);
  end;

  function TTree.entry_check(val: Variant): Boolean;
  var head: TTree;
  var item: TTree;
  begin
    head   := self.get_tree_head;
    result := false;

    for item in head.fItems do
    begin
      if item.Value = val then
        begin result := true;
              break; end;
    end;
  end;

  function TTree.find(val: Variant): TTree;
  var item: TTree;
  var head: TTree;
  begin
    head := self.get_tree_head;

    for item in head.fItems do
    begin
      if item.Value = val then
        begin result := item;
              break; end;
    end;
  end;

function TTree.get_left: TTree;
  begin
    result := self.fLeft;
  end;

  function TTree.get_left_cout: Integer;
  begin
     result := self.fLeftCout;
  end;

  function TTree.get_parent: TTree;
  begin
    result := self.fParent;
  end;

  function TTree.get_right: TTree;
  begin
     result := Self.fRight;
  end;

  function TTree.get_right_cout: Integer;
  begin
    result := self.fRightCout;
  end;

  function TTree.get_tree_head: TTree;
  var next: TTree;
  begin
     next := self;

     while next.Parent <> nil do
       next := next.Parent;

     result := next;
  end;

  function TTree.get_value: Variant;
  begin
    result := self.fValue;
  end;

  function TTree.Low: Variant;
  begin
     result := self.Low_Node.Value;
  end;

  function TTree.Low_Node: TTree;
  var next: TTree;
  begin
     next := self;

     while next.Left <> nil do
       next := next.Left;

     result := next;
  end;

  function TTree.make_me_head: TTree;
  var old_head: TTree;
      i:        Integer;
      new_tree: TTree;
  begin
    new_tree := TTree.__init__(self.Value);
    old_head := self.get_tree_head;

    new_tree.add(old_head.Value);

    for i:=0 to Length(old_head.fItems)-1   do
      new_tree.add(old_head.fItems[i].Value);

    result := new_tree;
  end;

function TTree.Max: Variant;
  begin
    result := self.Max_Node.Value;
  end;

  function TTree.Max_Node: TTree;
  var next: TTree;
  begin
     next := self;

     while next.Right <> nil do
       next := next.Right;

     result := next;
  end;

  function TTree.AsArray: TArray<Variant>;
  var q:        Integer;
      i:        Integer;
      temp:     TTree;

  begin
      SetLength(result, Length(self.fItems));

      for q:=0 to Length(self.fItems)-1 do
      begin
        for i := 0 to Length(self.fItems)-1 do
        begin
          if self.fItems[i].Value > self.fItems[q].Value then
          begin
            result[i] := self.fItems[q].Value;
            result[q] := self.fItems[i].Value;
          end;
        end;
      end;
  end;

  function TTree.balance: TTree;
  var best:       TTree;
      item:       TTree;
      best_index: Integer;
      now_index:  Integer;
  begin
      best       := self;
      best_index := best.RightCout-best.LeftCout;

      for item in self.fItems do
      begin
         now_index := item.RightCout-item.LeftCout;

         if best_index < 0 then best_index :=best_index*-1;
         if now_index  < 0 then now_index  :=now_index*-1;

         if best_index > now_index then
         begin best       := item;
               best_index := best.RightCout-best.LeftCout; end;
      end;

      result := best.make_me_head;
  end;

function TTree.build_json: String;
  begin
    result := self._build_json(0);
  end;

  function TTree._get_tree_value_or_null(_tree: TTree; rec_lvl: Integer): String;
  begin
      if _tree <> nil then
        begin result := _tree._build_json(rec_lvl); end
      else
        begin result := 'null'; end;
  end;

  function TTree._build_json(rec_lvl: Integer): String;
  var tb: String;
  begin
      tb     := repeat_str(TAB, rec_lvl);
      result := '{' + NL + tb + '"Value": "' + self.ToString +'", ';
      result := result + NL + tb + '"Right": ';
      result := result + self._get_tree_value_or_null(self.fRight, rec_lvl+1);
      result := result + NL + tb + '"Left": ';
      result := result + self._get_tree_value_or_null(self.fLeft, rec_lvl+1) + NL + tb + '}';

      if rec_lvl <> 0 then result := result + ',';
  end;

  function repeat_str(str: String; loop: Integer): String;
  var I: Integer;
  begin
    for I := 0 to loop do
      result := result + str;
  end;
end.
