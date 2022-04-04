Public Shared a As Integer=0
Public Shared c1 As DateTime = DateAdd("m",-3,today())
Public Shared Function StartDateCheck(d1 As Date) as Integer
        Try
			IF d1 < c1 THEN
				a = 1
			ELSE 
				a = 0 
        Catch ex As Exception
            a = 1
        End Try
return a
End Function