unit BookPushFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Generics.Collections, Vcl.Grids, task_1;

type
  TFrame1 = class(TFrame)
    LinkLabel1:      TLinkLabel;
    NameEdit:        TLabeledEdit;
    AuthorEdit:      TLabeledEdit;
    PriceEdit:       TLabeledEdit;
    DescriptionEdit: TLabeledEdit;
  private

  public
    obj: TBook;

    function get_data: TDictionary<String, String>;

    procedure ClearEdits;
    function get_obj: TBook;
  end;

implementation

{$R *.dfm}
    function TFrame1.get_data;
    var data: TDictionary<String, String>;
    begin
      data := TDictionary<String, String>.Create;

      data.Add('name', self.NameEdit.Text);
      data.Add('price', self.PriceEdit.Text);
      data.Add('author', self.AuthorEdit.Text);
      data.Add('description', self.DescriptionEdit.Text);

      result := data;
    end;

  function TFrame1.get_obj;
  var data: TDictionary<String, String>;
  begin
    data := self.get_data;

    result := TBook.__init__(data['name'], StrToInt(data['price']), data['author'], data['description']);
  end;

  procedure TFrame1.ClearEdits;
  var i: Integer;
  begin
    for i := 0 to self.ComponentCount - 1 do
      if self.Components[i] is TLabeledEdit then TLabeledEdit(self.Components[i]).Clear;
  end;

end.
