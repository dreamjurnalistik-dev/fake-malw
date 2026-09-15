Add-Type -AssemblyName System.Windows.Forms
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds

while ($true) {
    $img = [System.Drawing.Image]::FromFile($temp_file)
    $form = New-Object System.Windows.Forms.Form
    $form.FormBorderStyle = 'None'
    $form.TopMost = $true
    $form.StartPosition = 'Manual'
    $form.Location = New-Object System.Drawing.Point((Get-Random -Max $screen.Width), (Get-Random -Max $screen.Height))
    $form.Size = New-Object System.Drawing.Size(400, 400)
    $form.BackgroundImage = $img
    $form.BackgroundImageLayout = 'Stretch'
    $form.Show()
    Start-Sleep -Milliseconds 200
}
