Public Target1 As String
Public Target2 As String
Public Target3 As String
Public Target6 As String
Public Target7 As String
Public selected_date As String





Sub start_Inventory_macro()
    Inputform.Show vbModeless
End Sub





Sub main_Inventory_macro()
Application.DisplayAlerts = False
Dim flag1 As Boolean
flag1 = False
Dim flag2 As Boolean
flag2 = False
Workbooks.Open Target1
'workbook sheet exist check
For Each ws In Worksheets
    If ws.Name Like "*MRP*" = True Then
        flag1 = True
        MRP_Sheet_name = ws.Name
    End If
Next ws
If flag1 = False Then
    MsgBox "This file doesn't have MRP Sheet.", vbInformation
    GoTo fin
End If
Set o1 = ActiveWorkbook.Sheets(MRP_Sheet_name)
'Check for MRP Sheet, set as Active Worksheet @ MRP





'search data location
i1 = 1
Do While UCase(o1.Cells(i1, 2)) <> "PART NUMBER"
    i1 = i1 + 1
Loop
'Find "PART NUMBER" cell depth (B56) @ MRP 





c1 = 2
i1 = i1 + 1
Do While o1.Cells(i1, c1) <> Target6
    c1 = c1 + 1
Loop
'Find Current Date width @ MRP





Workbooks.Open Target2 ', UpdateLinks:=0
For Each ws In Worksheets
    If ws.Name = "STATUS" Then flag2 = True
Next ws
If flag2 = False Then
    MsgBox "This file doesn't have STATUS Sheet.", vbInformation
    GoTo fin
End If
Set o2 = ActiveWorkbook.Sheets("STATUS")
'Check for STATUS sheet, set as Active Worksheet @ STATUS





'get data from Inventory sheet
Dim poparray(10000, 2) As Variant

i2 = 3
Do While o2.Cells(i2, 1) <> ""
    poparray(i2 - 3, 0) = o2.Cells(i2, 3)
    poparray(i2 - 3, 1) = o2.Cells(i2, 8)
    Last_row = i2 - 3
    i2 = i2 + 1
Loop
'Cycle through records @ STATUS 
'Get values from PART NUMBER and Part Inv [Pcs] columns, store in poparray
'Find last row (but subtract 3???)
'Loop





'copy data to MRP sheet
i4 = i1 + 1Actual 
For i3 = 0 To Last_row
    If poparray(i3, 1) = 0 Then
        o1.Cells(i4 + 10, c1) = 1
    Else
        o1.Cells(i4 + 10, c1) = poparray(i3, 1)
    End If
    i4 = i4 + 11
Next i3
'Set height of Actual Part Number & Due Date
'If Part Inv [Pcs] = 0, then set A-invent for that Part# & Date as 1 [To Let PC know this field was accounted for, is not NULL]
'If it isn't 0, fill A-invent with Part Inv [Pcs]
'Go down to the next Part Number
'Loop





o1.Activate

'save
Nowtime = Format(Now, "yyyy-mm_dd_hhmmss_")
fname = Nowtime & Target7 & "_MRP_with_inv.xlsm"
file_name = Target3 & fname
ActiveWorkbook.SaveAs (file_name)

fin:
o2.Activate
ActiveWorkbook.Saved = True
ActiveWorkbook.Close
Application.DisplayAlerts = True
End Sub