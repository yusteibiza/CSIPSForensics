Get-CimInstance Win32_ComputerSystem | Select-Object UserName |
Out-File ".\resultados\4-ultimousuario.txt" -Encoding utf8