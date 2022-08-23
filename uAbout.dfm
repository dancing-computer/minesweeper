object AboutBox: TAboutBox
  Left = 303
  Top = 87
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 213
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 281
    Height = 161
    BevelInner = bvRaised
    BevelWidth = 2
    Color = clBtnHighlight
    TabOrder = 0
    object ProgramIcon: TImage
      Left = 8
      Top = 8
      Width = 65
      Height = 57
      Picture.Data = {
        07544269746D6170EE000000424DEE0000000000000076000000280000000F00
        00000F0000000100040000000000780000000000000000000000100000001000
        0000000000007B7B7B00BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00222222222222222022222222222222202222222122222220222222202222
        2220222202101202222022222000002222202222100000122220221000000000
        1220222210300012222022222000002222202222021012022220222222202222
        2220222222212222222022222222222222202222222222222220}
      Stretch = True
      IsControl = True
    end
    object ProductName: TLabel
      Left = 88
      Top = 16
      Width = 109
      Height = 20
      Caption = 'MineSweeper'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      IsControl = True
    end
    object Version: TLabel
      Left = 88
      Top = 48
      Width = 59
      Height = 13
      Caption = 'Version 0.26'
      IsControl = True
    end
    object Copyright: TLabel
      Left = 8
      Top = 80
      Width = 257
      Height = 33
      AutoSize = False
      Caption = #27880#24847#65306#27492#25195#38647#31995#32479#36824#26377#20123#35768'Bug'#65292#19981#24314#35758#19987#19994#20154#22763#20351#29992#12290
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      WordWrap = True
      IsControl = True
    end
    object Comments: TLabel
      Left = 8
      Top = 120
      Width = 49
      Height = 13
      Caption = 'Comments'
      WordWrap = True
      IsControl = True
    end
  end
  object OKButton: TButton
    Left = 111
    Top = 180
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
    OnClick = OKButtonClick
  end
end
