unit task_1;

{
  TBook---------
  |            |
  TBook        |
           TMagazine
}

interface

{ Базовый класс для товаров }
  type
    TGoods=class
      private
        fName:        String;
        fPrice:       Integer;
        fDescription: String;

        procedure set_name(_name: String);
        procedure set_price(_price: Integer);
        procedure set_description(_description: String);

        function get_name:        String;
        function get_price:       Integer;
        function get_description: String;

      public
        { Запись данных о товаре в файл}
        procedure write_on_file(fPath: String); overload;

        { Конвертирование в строку}
        function stringfy: String; Virtual;
        { Преобразуем в строковое представление JSON объекта}
        function to_json_string:  String; Virtual;

        property Name: String        read get_name        write set_name;
        property Price: Integer      read get_price       write set_price;
        property Description: String read get_description write set_description;

        constructor __init__(_name: String; _price: Integer; _description: String);
        overload; virtual;
        constructor __init__(_name: String; _price: Integer);
        overload; virtual;
    end;

{ Товар.Книга }
    type
      TBook=class(TGoods)

      private
        fAuthor: String;

        procedure set_author(_author: String);

        function get_author: String;

      public
        constructor __init__(_name: String; _price: Integer;
                             _author: String; _description: String); overload;
        constructor __init__(_name: String; _price: Integer;
                     _author: String); overload;

        property Author: String read get_author write set_author;

        function stringfy: String;
    end;

{ Товар.Журнал }
    type
      TMagazine=class(TGoods)

      private
        fNumber: Integer; // Номер журнала

        procedure set_number(_number: Integer);

        function get_number: Integer;

      public
        constructor __init__(_name: String; _price: Integer;
                             _number: Integer; _description: String); overload;
        constructor __init__(_name: String; _price: Integer;
                     _number: Integer); overload;

        property Number: Integer read get_number write set_number;

        function stringfy: String;
      end;

implementation
  uses
    SysUtils;

{ TGoods }

  { Конструктор }
  constructor TGoods.__init__(_name: string; _price: Integer; _description: string);
  begin
    self.Name        := _name;
    self.Price       := _price;
    self.Description := _description;
  end;

  constructor TGoods.__init__(_name: string; _price: Integer);
  begin
    self.Name        := _name;
    self.Price       := _price;
    self.Description := 'No description';
  end;

  { Управление свойством Name }
  procedure TGoods.set_name(_name: string);
  begin
    if Length(_name) = 0 then
      raise Exception.Create('Goods name must be bigger than 0.');

    self.fName := _name;
  end;

  function TGoods.get_name;
  begin
    result := self.fName;
  end;

  { Управление свойством Price }
  procedure TGoods.set_price(_price: Integer);
  begin
    if _price < 0 then
      raise Exception.Create('Price must be -le or -eq 0.');

    self.fPrice := _price;
  end;

  function TGoods.get_price;
  begin
      result := self.fPrice;
  end;


  { Управление свойством Description }
  procedure TGoods.set_description(_description: string);
  begin
      if Length(_description) = 0 then
      begin
        self.fDescription := 'No description';
      end
      else
      begin
        self.fDescription := _description;
      end;

  end;

  function TGoods.get_description;
  begin
    result := self.fDescription;
  end;

  { Функции }
  function TGoods.stringfy;
  begin
    result := '"name": "'        + self.fName            + '",' + ^M + ^J +
              '"price": '        + IntToStr(self.fPrice) + ',' + ^M + ^J +
              '"description": "' + self.fDescription     + '"';
  end;

  function TGoods.to_json_string;
  begin
    result := '{' + ^M + ^J + self.stringfy + ^M + ^J + '}';
  end;

  { Процедуры }
  procedure TGoods.write_on_file(fPath: string);
  var tFile: TextFile;

  begin
    if FileExists(fPath) then raise Exception.Create('File :"' + fPath + '", is exists.');

    AssignFile(tFile, fPath);
    write(tFile, self.to_json_string);
    CloseFile(tFile);
  end;

{ TGoods.TBook}
  { конструктор }
  constructor TBook.__init__(_name: string; _price: Integer; _author: string; _description: string);
  begin
    inherited __init__(_name, _price, _description);

    self.fAuthor := _author;
  end;

  constructor TBook.__init__(_name: string; _price: Integer; _author: string);
  begin
    inherited __init__(_name, _price);

    self.Author := _author;
  end;

  { Управление свойством Author }
  procedure TBook.set_author(_author: string);
  begin
    if Length(_author) = 0 then
      raise Exception.Create('Book author -eq null!');

    self.fAuthor := _author;
  end;

  function TBook.get_author;
  begin
    result := self.fAuthor;
  end;

  {Функции}
  function TBook.stringfy;
  begin
    result := inherited stringfy + ',' + '"author": "' + self.Author + '"' +^M + ^J;
  end;

{ TGoods.TMagazine }
  { конструктор }
  constructor TMagazine.__init__(_name: string; _price: Integer; _number: Integer; _description: string);
  begin
    inherited __init__(_name, _price, _description);

    self.Number := _number;
  end;

  constructor TMagazine.__init__(_name: string; _price: Integer; _number: Integer);
  begin
    inherited __init__(_name, _price);

    self.Number := _number;
  end;

  { Управление свойством Number }
  procedure TMagazine.set_number(_number: Integer);
  begin
    if _number < 0 then
      raise Exception.Create('Nummber must be bigger then -1');

    self.fNumber := _number;
  end;

  function TMagazine.get_number;
  begin
    result := self.fNumber;
  end;

  {Функции}
  function TMagazine.stringfy;
  begin
    result := inherited stringfy + ',' + '"number": "' + IntToStr(self.Number) + '"' +^M + ^J;
  end;

end.