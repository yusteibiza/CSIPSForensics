
$outDir = ".\resultados"
$outFile = Join-Path $outDir "011-busquedas_explorer.txt"

$utf8 = New-Object System.Text.UTF8Encoding $false

if (!(Test-Path $outDir)) {
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
}

[System.IO.File]::WriteAllText(
    $outFile,
    "=== Inicio extracción WordWheelQuery $(Get-Date) ===`r`n`r`n",
    $utf8
)

$profiles = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

foreach ($p in $profiles) {

    $sid = $p.PSChildName
    $profilePath = (Get-ItemProperty $p.PSPath -ErrorAction SilentlyContinue).ProfileImagePath

    if (-not $profilePath) { continue }

    $user = Split-Path $profilePath -Leaf

    $hkUser = "Registry::HKEY_USERS\$sid"
    $regPath = "$hkUser\Software\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery"

    if (!(Test-Path $regPath)) {
        continue
    }

    try {

        $data = Get-ItemProperty $regPath -ErrorAction Stop

        $text = "Usuario: $user`r`nSID: $sid`r`n--------------------------`r`n"

        $found = $false

        foreach ($prop in $data.PSObject.Properties) {
            if ($prop.Name -match '^\d+$' -and $prop.Value) {
                $text += "$($prop.Value)`r`n"
                $found = $true
            }
        }

        if (-not $found) {
            $text += "Sin búsquedas registradas`r`n"
        }

        $text += "`r`n"

        [System.IO.File]::AppendAllText($outFile, $text, $utf8)
    }
    catch {
        $msg = $_.Exception.Message
        if (-not $msg) { $msg = "Error desconocido" }

        [System.IO.File]::AppendAllText(
            $outFile,
            "Error en ${user}: ${msg}`r`n`r`n",
            $utf8
        )
    }
}

[System.IO.File]::AppendAllText(
    $outFile,
    "`r`n=== Fin extracción ===`r`n",
    $utf8
)