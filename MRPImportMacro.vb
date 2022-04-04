Private Sub CommandButton1_Click()
'Open File Dialog
Dim vntFileName As Variant
vntFileName = _
    Application.GetOpenFilename( _
         FileFilter:="Excel file(*.xls?),*.xls?" _
       , FilterIndex:=1 _
       , Title:="Open File" _
       , MultiSelect:=False _
       )

If vntFileName <> False Then
   TextBox1.Value = vntFileName
End If
End Sub








Private Sub CommandButton10_Click()
Calendar.Show
End Sub










Private Sub CommandButton2_Click()
'Open File Dialog
Dim vntFileName As Variant
vntFileName = _
    Application.GetOpenFilename( _
         FileFilter:="Excel file(*.xls?),*.xls?" _
       , FilterIndex:=1 _
       , Title:="Open File" _
       , MultiSelect:=False _
       )

If vntFileName <> False Then
   TextBox2.Value = vntFileName
End If
End Sub









Private Sub CommandButton3_Click()
'Open Folder Dialog
With Application.FileDialog(msoFileDialogFolderPicker)
    If .Show = True Then
        TextBox3 = .SelectedItems(1)
    End If
End With
End Sub







Private Sub CommandButton4_Click()
'Run macro
Target1 = TextBox1.Value '"Select MRP File"
Target2 = TextBox2.Value '"Select Inventory file"
Target3 = TextBox3.Value '"Select Output folder"
Target6 = TextBox6.Value '"Import date"
Target7 = TextBox7.Value '"Project name"
If Target1 = "" Then
MsgBox "Select File"
GoTo fin
End If
If Target2 = "" Then
MsgBox "Select File"
GoTo fin
End If
If Target3 = "" Then
MsgBox "Select Folder"
GoTo fin
End If
If Target7 = "" Then
MsgBox "Select Folder"
GoTo fin
End If






If Right(Target3, 1) <> "\" Then
    Target3 = Target3 & "\"
End If






If Dir(Target1) <> "" Then
    'check the selected file is opened
    On Error Resume Next
    Err.Clear
    Open Target1 For Append As #1
    Close #1
    If Err.Number > 0 Then
        MsgBox "Close the selected file."
        GoTo fin
    End If
Else
    MsgBox "Do not exist" & vbCrLf & Target1
    GoTo fin
End If
If Dir(Target3, vbDirectory) = "" Then
    MsgBox "Do not exist" & vbCrLf & Target3
    GoTo fin
End If
If Dir(Target2) <> "" Then
    'check the selected file is opened
    On Error Resume Next
    Err.Clear
    Open Target2 For Append As #1
    Close #1
    If Err.Number > 0 Then
        MsgBox "Close the selected file."
        GoTo fin
    Else
        main_Inventory_macro
    End If
Else
    MsgBox "Do not exist" & vbCrLf & Target2
    GoTo fin
End If
Unload Me
fin:
End Sub








Private Sub UserForm_Activate()
If selected_date = "" Then
    TextBox6.Value = Date - 1
Else
    TextBox6.Value = selected_date
End If
End Sub







Private Sub UserForm_Initialize()
TextBox6.Value = Date - 1
End Sub
