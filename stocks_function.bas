Attribute VB_Name = "Module1"
Sub stocks()

'set needed variables
Dim ticker As String
Dim vol_total As Double
Dim open_price As Double
Dim yChange As Double
Dim pChange As Double
Dim cRow As Integer
Dim lRow As Double

'starting values
lRow = Cells(Rows.Count, 1).End(xlUp).Row
cRow = 2
open_price = Range("C2").Value
Range("P2:P4").Value = 0

'summary table headers
Range("I1") = "Ticker"
Range("J1") = "Yearly Change"
Range("K1") = "Percent Change"
Range("L1") = "Total Stock Volume"
Range("N2") = "Greatest % Increase"
Range("N3") = "Greatest % Decrease"
Range("N4") = "Greatest Total Volume"
Range("O1") = "Ticker"
Range("P1") = "Value"

For i = 2 To lRow

    'new ticker detected
    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
        
        
        'copy one of each ticker name
        ticker = Cells(i, 1)
        Range("I" & cRow).Value = ticker
        
        
        'total stock volume
        vol_total = vol_total + Cells(i, 7).Value
        Range("L" & cRow).Value = vol_total
        
        'check greatest volume
        If vol_total > Range("P4").Value Then
            Range("P4").Value = vol_total
            Range("O4").Value = ticker
        End If
        
        'yearly price change
        yChange = open_price - Range("F" & i)
        Range("J" & cRow).Value = yChange
        pChange = yChange / open_price
        Range("K" & cRow).Value = FormatPercent(pChange, 2)
        
        'check greatest percent increase
        If pChange > Range("P2").Value Then
            Range("P2").Value = FormatPercent(pChange, 2)
            Range("O2").Value = ticker
        End If
        
        'check greatest percent decrease
        If pChange < Range("P3").Value Then
            Range("P3").Value = FormatPercent(pChange, 2)
            Range("O3").Value = ticker
        End If
        
        'formating
        If yChange > 0 Then
            Range("J" & cRow).Interior.ColorIndex = 4
        Else
            Range("J" & cRow).Interior.ColorIndex = 3
        End If
        
        'loop housekeeping
        cRow = cRow + 1
        open_price = Cells(i + 1, 3).Value
        vol_total = 0
        
    Else
        'add to total volume
        vol_total = vol_total + Cells(i, 7)

    End If

Next i

'formating
Range("I1:P1").EntireColumn.AutoFit

End Sub
