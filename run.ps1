Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$gambarPath = "$env:TEMP\fm\fake-malw-main\gambar.png"

# Cek file ada
if (-not (Test-Path $gambarPath)) {
    Write-Host "Gambar tidak ditemukan: $gambarPath"
    exit
}

# Loop 5 kali saja
for ($i = 1; $i -le 5; $i++) {
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
        Start-Sleep -Milliseconds 500
    } catch {
        Write-Host "Error: $_"
    }
}

Start-Sleep -Seconds 10
