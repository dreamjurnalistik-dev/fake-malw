Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$gambarPath = "$env:TEMP\fm\fake-malw-main\gambar.png"

# Debug: tampilkan path yang dicek
Write-Host "Mencari gambar di: $gambarPath"

# Cek file ada
if (-not (Test-Path $gambarPath)) {
    Write-Host "Gambar TIDAK ditemukan di: $gambarPath"
    Write-Host "Isi folder:"
    Get-ChildItem "$env:TEMP\fm\fake-malw-main\" -ErrorAction SilentlyContinue | Format-Table Name, Length
    Start-Sleep -Seconds 10
    exit
}

Write-Host "Gambar DITEMUKAN. Memulai 5 jendela..."

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
        Write-Host "Jendela $i muncul"
        Start-Sleep -Milliseconds 500
    } catch {
        Write-Host "Error pada jendela $i : $_"
    }
}

Write-Host "Selesai 5 jendela. Cek error di atas."
Start-Sleep -Seconds 15
