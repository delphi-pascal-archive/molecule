object Form1: TForm1
  Left = 230
  Top = 127
  Width = 508
  Height = 534
  Caption = 'Molecule'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Timer1: TTimer
    Interval = 30
    OnTimer = Timer1Timer
    Left = 568
    Top = 56
  end
end
