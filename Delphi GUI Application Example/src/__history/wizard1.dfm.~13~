object Push_Item_Wizard: TPush_Item_Wizard
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Push new Item'
  ClientHeight = 202
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnMouseMove = FormMouseMove
  PixelsPerInch = 96
  TextHeight = 13
  object LinkLabel2: TLinkLabel
    AlignWithMargins = True
    Left = 271
    Top = 8
    Width = 45
    Height = 17
    AutoSize = False
    Caption = 'Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Sitka Text'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Item_Type: TComboBox
    Left = 8
    Top = 8
    Width = 257
    Height = 21
    TabOrder = 1
    Text = 'Choose Item type'
    TextHint = 'Choose Item type'
    OnChange = Item_TypeChange
  end
  object AcceptButton: TButton
    Left = 160
    Top = 169
    Width = 75
    Height = 25
    Caption = 'Accept'
    Enabled = False
    TabOrder = 2
    OnClick = AcceptButtonClick
  end
  object CancelButton: TButton
    Left = 232
    Top = 169
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = CancelButtonClick
  end
  inline BookFrame: TFrame1
    Left = 8
    Top = 35
    Width = 299
    Height = 121
    TabOrder = 4
    Visible = False
    ExplicitLeft = 8
    ExplicitTop = 35
    ExplicitWidth = 299
    inherited PriceEdit: TLabeledEdit
      OnChange = BookFramePriceEditChange
    end
  end
  inline MagazineFrame: TFrame2
    Left = 0
    Top = 31
    Width = 307
    Height = 120
    TabOrder = 5
    Visible = False
    ExplicitTop = 31
    ExplicitWidth = 307
    inherited PriceEdit: TLabeledEdit
      OnChange = MagazineFramePriceEditChange
    end
    inherited NumberEdit: TLabeledEdit
      OnChange = MagazineFrameNumberEditChange
    end
  end
end
