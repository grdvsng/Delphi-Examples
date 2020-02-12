unit __form__;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.CustomizeDlg, Vcl.ExtCtrls, task_1,
  WebAdapt, WebComp, Data.DB, Bde.DBTables, Vcl.StdCtrls, Vcl.Grids, Wizard1, System.Generics.Collections;

type
  SomeArr<T> = array of T;

  
type
  TMainView = class(TForm)
    PushOnGrid:     TButton;                            
    Goods:          TStringGrid;
    LinkLabel1:     TLinkLabel;
    LinkLabel2:     TLinkLabel;
    LinkLabel3:     TLinkLabel;
    export_to_json: TButton;
    SaveDialog1:    TSaveDialog;

    procedure _save_diolog_logic;
    procedure PushOnGridClick(Sender: TObject);
    procedure PushNewItemInGoods(item: TGoods);
    procedure export_to_jsonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure export_goods_to_json(fPath: String);
    procedure GoodsClick(Sender: TObject);
    
  private        
    goods_items: TArray<TGoods>;
  public
  
  end;

  procedure grid_remove_row(grid: TStringGrid; RowIndex: Integer);
  procedure array_remove_by_index(var arr: TArray<TGoods>; index: Integer);
var
  MainView: TMainView;

implementation

{$R *.dfm}
  uses System.RegularExpressions;

  procedure array_remove_by_index(var arr: TArray<TGoods>; index: Integer);
  var i: Integer;
  begin
    for i := index+1 to Length(arr) - 1 do
        arr[i-1] := arr[i]; 

    SetLength(arr, Length(arr)-1);
  end;
  
  procedure TMainView.export_goods_to_json(fPath: String);
  var _file:   TextFile;
      content: String;
      i:       Integer;
      re:      TRegEx;
  begin
    content := '[';
    re      := TRegEx.Create(',$');

    AssignFile(_file, fPath);
    Rewrite(_file);
    
    for I := 0  to Length(self.goods_items)-1 do
    begin
      if self.goods_items[i] is TBook then
       content := content + '{' + (self.goods_items[i] as TBook).stringfy + '},';
      if self.goods_items[i] is TMagazine then
       content := content + '{' + (self.goods_items[i] as TMagazine).stringfy + '},';
    end;
    
    write(_file, re.Replace(content, '')+ ']');
    CloseFile(_file);
    
  end;

  procedure TMainView.export_to_jsonClick(Sender: TObject);
  begin
    if Length(self.goods_items) = 0 then
      begin MessageBox(handle, PChar('Table is empty...'), PChar('Info'), MB_OK); end
  else
  begin
      self._save_diolog_logic;
    end;
  end;

  procedure TMainView._save_diolog_logic;
  var 
     fPath: String;
     re:    TRegEx;
  begin
     re := TRegEx.Create('\.json$');
  
    if self.SaveDialog1.Execute(handle) then
      begin fPath := self.SaveDialog1.FileName;
            if re.Match(fPath).Length = 0 then fPath := fPath + '.json';
            if FileExists(fPath) then
              begin if MessageDlg('File exists, reWrite?', mtConfirmation, [mbYes, mbNo], 0) = mrNo 
                then self._save_diolog_logic; 
              end;
            
            self.export_goods_to_json(fPath);
      end;
  end;
  
  procedure TMainView.FormCreate(Sender: TObject);
  begin
    self.SaveDialog1.Filter := 'JSON files (*.json)|*.JSON';
  end;

  procedure TMainView.GoodsClick(Sender: TObject);
  var RowIndex: Integer; 
      grid:     TStringGrid;
      i:        Integer;
  begin
      grid     := Sender As TStringGrid;
      RowIndex := grid.Row;
      
      if (Length(self.goods_items) > 0) and 
         (MessageDlg('Remove Item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        grid_remove_row(grid, RowIndex);
        array_remove_by_index(self.goods_items, RowIndex);
      end;
  end;

procedure TMainView.PushNewItemInGoods(item: TGoods);
  var row: Integer;
  begin
      row                 := Length(self.goods_items);
      self.Goods.RowCount := row + 1;

      SetLength(self.goods_items, Length(self.goods_items)+1);
      self.goods_items[High(self.goods_items)] := item;

      self.Goods.Cells[0, row] := item.Name;
      self.Goods.Cells[1, row] := IntTostr(item.Price);
      self.Goods.Cells[2, row] := item.Description;
  end;

  procedure TMainView.PushOnGridClick(Sender: TObject);
  var row: Integer;
  begin
    Push_Item_Wizard.Show(self, self.PushNewItemInGoods);
  end;

  procedure grid_remove_row(grid: TStringGrid; RowIndex: Integer);
  var i: Integer;
  begin
    for i := RowIndex to grid.RowCount-2 do
      grid.Rows[i].Assign(grid.Rows[i+1]);
          
    grid.Rows[grid.RowCount-1].Clear;
    grid.RowCount := grid.RowCount -1;
  end;
end.
