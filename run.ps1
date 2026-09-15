Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$gambarPath = Join-Path $scriptPath "gambar.jpg"

# Cek file ada
if (-not (Test-Path $gambarPath)) {
    Write-Host "Gambar tidak ditemukan: $gambarPath"
    exit
}

# Loop tak terbatas
while ($true) {
    try {
        $img = [System.Drawing.Image]::FromFile($gambarPath)
        $form = New-Object System.Windows.Forms.Form
        $form.FormBorderStyle = 'None'
        $form.TopMost = $true
        $form.StartPosition = 'Manual'
        $form.Location = New-Object System.Drawing.Point(
            (Get-Random -Max ($screen.Width - 400)),
            (Get-Random -Max ($screen.Height - 400))
        )
        $form.Size = New-Object System.Drawing.Size(400, 400)
        $form.BackgroundImage = $img
        $form.BackgroundImageLayout = 'Stretch'
        $form.Show()
        Start-Sleep -Milliseconds 200
    } catch {
        Write-Host "Error: $_"
    }
}
