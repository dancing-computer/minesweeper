object OKBottomDlg: TOKBottomDlg
  Left = 232
  Top = 181
  BorderStyle = bsDialog
  Caption = #33258#23450#26827#30424#22823#23567
  ClientHeight = 214
  ClientWidth = 313
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 297
    Height = 161
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 79
    Top = 180
    Width = 75
    Height = 25
    Caption = #30830#23450'(&O)'
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 159
    Top = 180
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040'(&C)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
    OnClick = CancelBtnClick
  end
  object LEditWidth: TLabeledEdit
    Left = 24
    Top = 40
    Width = 257
    Height = 24
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = #23485#24230'(&W):'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -11
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
    ParentFont = False
    TabOrder = 2
  end
  object LEditHeight: TLabeledEdit
    Left = 24
    Top = 80
    Width = 257
    Height = 24
    EditLabel.Width = 43
    EditLabel.Height = 13
    EditLabel.Caption = #39640#24230'(&H):'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -11
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
    ParentFont = False
    TabOrder = 3
  end
  object LEditMinesCount: TLabeledEdit
    Left = 24
    Top = 120
    Width = 257
    Height = 24
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = #38647#25968'(&M):'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -11
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
    ParentFont = False
    TabOrder = 4
  end
end
