Sub IntermediateTJH()

'Establish Variables
      Dim Ticker As String
      Dim LastRow As Long
      Dim TotalVolume As Variant
      Dim x As Long
      Dim FirstValue As Double
      Dim EndValue As Double
      Dim YearlyChange As Double
      Dim PercentChaneg As Double
      Dim WSC As Integer

WSC = ThisWorkbook.Worksheets.count

For j = 1 To WSC

'Set up Headings
      Range("I1") = "Ticker"
      Range("J1") = "Yearly Change"
      Range("K1") = "Percent Change"
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
      EndValue = Cells(i, 6)
      YearlyChange = EndValue - FirstValue

      If FirstValue = 0 Then                                   'if Opening value is zero you will get an error with Percent change'
          PercentChange = 0
       Else
          PercentChange = YearlyChange / FirstValue
       End If

          FirstValue = Cells(i + 1, 3)
              j = 0
      If Cells(i + 1, 3) = 0 And Cells(i + 1, 1) <> 0 Then     'if Opening value equals zero on first row of ticker we have to check to see '
          Do While Cells(i + 1 + j, 1) = Cells(i + 2 + j, 1)   ' if we get an opening value on a subsequent line
                If Cells(i + 2 + j, 3) <> 0 Then
                    FirstValue = Cells(i + 2 + j, 3)
                        Exit Do
                    Else: j = j + 1
                End If
          Loop
      End If

'Print Table Values to Cells
      Cells(x, 9) = Ticker
      Cells(x, 10) = YearlyChange
      Cells(x, 11) = PercentChange
      Cells(x, 12) = TotalVolume
'Reset Volume to zero for next Ticker
      TotalVolume = 0
'Advance Row in Summary Table
      x = x + 1
  End If
Next i

'Format Yearly Change column - Red if negative and Green if positive
      Range("J2").Select
      Range(Selection, Selection.End(xlDown)).Select
      Selection.FormatConditions.Add Type:=xlCellValue, Operator:=xlGreater, Formula1:="=0"
              With Selection.FormatConditions(1).Interior
                  .Color = 65280
              End With
      Selection.FormatConditions.Add Type:=xlCellValue, Operator:=xlLess, Formula1:="=0"
      Selection.FormatConditions(Selection.FormatConditions.count).SetFirstPriority
              With Selection.FormatConditions(1).Interior
                  .Color = 255
              End With

'Format Column "K" Percent Change to % with two decimals and column "L" woth commas
      Range("K:K,Q2:Q3").Select
      Selection.NumberFormat = "0.00%"
      Range("L:L,Q4").Select
      Selection.NumberFormat = "#,##0"


'Format Header and Resize columns to autofit'
      Rows("1:1").Select
        With Selection
            .HorizontalAlignment = xlCenter
            .VerticalAlignment = xlCenter
            .WrapText = True
        End With

        With Selection.Font
            .Name = "Calibri"
            .FontStyle = "Bold"
            .Size = 14
            Columns("A:P").Select
            Columns("A:P").EntireColumn.AutoFit
        End With

'if at the last sheet then exit for loop and End Sub otherwise go to the next sheet'
      If ActiveSheet.Index = Worksheets.count Then
      Exit For
      Else
      ActiveSheet.Next.Select
      End If

Next j

End Sub
