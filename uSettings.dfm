object SettingsForm: TSettingsForm
  Left = 355
  Top = 123
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #35774#32622
  ClientHeight = 213
  ClientWidth = 168
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 24
    Top = 32
    Width = 121
    Height = 24
    EditLabel.Width = 48
    EditLabel.Height = 17
    EditLabel.Caption = #26827#30424#23485#24230
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = #24494#36719#38597#40657
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 24
    Top = 80
    Width = 121
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 17
    EditLabel.Caption = #26827#30424#39640#24230
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = #24494#36719#38597#40657
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    TabOrder = 1
  end
  object LabeledEdit3: TLabeledEdit
    Left = 24
    Top = 128
    Width = 121
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 17
    EditLabel.Caption = #38647#25968
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = #24494#36719#38597#40657
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    TabOrder = 2
  end
  object Button1: TButton
    Left = 36
    Top = 160
    Width = 97
    Height = 33
    Caption = #30830#23450
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
end