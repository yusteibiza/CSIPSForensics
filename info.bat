@echo off
cls
chcp 65001 > nul

echo Ejecutando herramienta, espere...
echo.

echo Paso 1 - Obteniendo información de discos...
powershell .\1-hashdiscos.ps1

echo Paso 2 - Obteniendo información del sistema..
powershell .\2-so.ps1

echo Paso 3 - Obteniendo información de usuarios...
powershell .\3-usuarios.ps1

echo Paso 4 - Obteniendo información del último usuario que inició sesión...
powershell .\4-ultimousuario.ps1

echo Paso 5 - Obteniendo información de la última fecha del apagado del sistema...
powershell .\5-fechaapagado.ps1

echo Paso 6 - Obteniendo la última dirección IP asignada al sistema...
powershell .\6-ultimaip.ps1

echo Paso 7 - Obteniendo aplicaciones instaladas...
powershell .\8-navegadores.ps1

echo Paso 9 - Obteniendo la lista de los sitios web accedidos...
rem powershell .\9-sitiosweb.ps1

echo.

exit
