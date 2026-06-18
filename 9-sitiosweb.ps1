Add-Type -AssemblyName System.Data

function Get-ChromiumHistory($path, $browser) {
    if (!(Test-Path $path)) { return }

    $query = "SELECT url, title, visit_count, last_visit_time FROM urls ORDER BY last_visit_time DESC LIMIT 20"

    $conn = New-Object System.Data.SQLite.SQLiteConnection("Data Source=$path;Version=3;")
    $conn.Open()

    $cmd = $conn.CreateCommand()
    $cmd.CommandText = $query

    $adapter = New-Object System.Data.SQLite.SQLiteDataAdapter $cmd
    $dt = New-Object System.Data.DataTable
    $adapter.Fill($dt) | Out-Null

    $dt | Select-Object @{n="Browser";e={$browser}}, url, title, visit_count
}

$resultado = @()

$resultado += Get-ChromiumHistory "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\History" "Edge"
$resultado += Get-ChromiumHistory "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\History" "Chrome"

$resultado |
Out-File ".\resultados\9-sitiosweb.txt" -Encoding utf8