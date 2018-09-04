'Establish Variables
      Dim Ticker As String
      Dim LastRow As Long
      Dim TotalVolume As Variant
      Dim x As Long
      Dim WSC As Integer

WSC = ThisWorkbook.Worksheets.count

For j = 1 To WSC

'Set up Headings
      Range("I1,P1") = "Ticker"
      Range("L1") = "Total Stock Volume"


'Establish initial Variable values
      x = 2
      TotalVolume = 0
      FirstValue = Cells(2, 3)
      LastRow = ActiveSheet.Cells.SpecialCells(xlCellTypeLastCell).Row

'Loop though all rows to collect data for Summary Table
For i = 2 To LastRow
'If ticker in current cell equals ticker in cell below , continue to add to Total Volume
  If Cells(i, 1) = Cells(i + 1, 1) Then
      TotalVolume = TotalVolume + Cells(i, 7)
   Else
'Establish Values for Summary Table
      TotalVolume = TotalVolume + Cells(i, 7).Value
      Ticker = Cells(i, 1)

'Print Table Values to Cells
      Cells(x, 9) = Ticker
      Cells(x, 12) = TotalVolume
'Reset Volume to zero for next Ticker
      TotalVolume = 0
'Advance Row in Summary Table
      x = x + 1
  End If
Next i

'if at the last sheet then exit for loop and End Sub otherwise go to the next sheet'
      If ActiveSheet.Index = Worksheets.count Then
      Exit For
      Else
      ActiveSheet.Next.Select
      End If

Next j

End Sub
