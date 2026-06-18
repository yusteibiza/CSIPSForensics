@echo off
cls
chcp 65001 > nul
color 0E

echo   ------------------------------
echo - Ejecutando herramienta forense -
echo   ------------------------------
echo - Espere...
echo.

echo [*] Paso 1 - Obteniendo informaci¢n de discos...
powershell .\1-hashdiscos.ps1

echo [*] Paso 2 - Obteniendo informaci¢n del sistema..
powershell .\2-so.ps1

echo [*] Paso 3 - Obteniendo informaci¢n de usuarios...
powershell .\3-usuarios.ps1

echo [*] Paso 4 - Obteniendo informaci¢n del £ltimo usuario que inici¢ sesi¢n...
powershell .\4-ultimousuario.ps1

echo [*] Paso 5 - Obteniendo informaci¢n de la £ltima fecha del apagado del sistema...
powershell .\5-fechaapagado.ps1

echo [*] Paso 6 - Obteniendo la £ltima direcci¢n IP asignada al sistema...
powershell .\6-ultimaip.ps1

echo [*] Paso 7 - Obteniendo aplicaciones instaladas...
powershell .\7-navegadores.ps1

echo [*] Paso 8 - Obteniendo navegadores web instalados...
powershell .\8-navegadores.ps1

echo [*] Paso 9 - Obteniendo la lista de los sitios web accedidos...
powershell .\9-sitiosweb.ps1
del .\resultados\*.db > nul

echo.

exit
