Set objShell = CreateObject("WScript.Shell")

' Obtener la ruta de la carpeta donde está el script
strPath = WScript.ScriptFullName
strFolder = Left(strPath, InStrRev(strPath, "\"))

' Ejecutar fecha.bat primero
objShell.Run Chr(34) & strFolder & "control_tiempo.bat" & Chr(34), 0, True


Set objShell = Nothing
