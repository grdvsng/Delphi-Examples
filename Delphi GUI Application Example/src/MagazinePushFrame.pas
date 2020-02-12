unit MagazinePushFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Generics.Collections, task_1, Vcl.Grids;

type
  TFrame2 = class(TFrame)
    NameEdit:        TLabeledEdit;
    NumberEdit:      TLabeledEdit;
    PriceEdit:       TLabeledEdit;
    DescriptionEdit: TLabeledEdit;
  private

  public
    obj: TMagazine;

    function get_data: TDictionary<String, String>;

    procedure ClearEdits;

    function get_obj: TMagazine;
  end;

implementation

{$R *.dfm}
    function TFrame2.get_data;
    var data: TDictionary<String, String>;
    begin
      data := TDictionary<String, String>.Create;

      data.Add('name', self.NameEdit.Text);
      data.Add('price', self.PriceEdit.Text);
      data.Add('number', self.NumberEdit.Text);
      data.Add('description', self.DescriptionEdit.Text);

      result := data;
    end;

  procedure TFrame2.ClearEdits;
  var i: Integer;
  begin
    for i := 0 to self.ComponentCount - 1 do
      if self.Components[i] is TLabeledEdit then TLabeledEdit(self.Components[i]).Clear;
  end;

  function TFrame2.get_obj;
  var data: TDictionary<String, String>;
  begin
    data := self.get_data;

    result := TMagazine.__init__(data['name'],
                               StrToInt(data['price']),
                               StrToInt(data['number']),
                               data['description']);
  end;
end.
