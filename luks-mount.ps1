$UUID = "eea55269-b5c7-44c2-a80a-b332679a69bc"
wsl --mount \\.\PHYSICALDRIVE1 --bare
$device = wsl -e bash -c "blkid -t UUID=$UUID -o device" | Out-String -Stream | ForEach-Object { $_.Trim() }
if (-not $device) {
    Write-Host "Partition mit UUID $UUID nicht gefunden."
    exit 1
}
wsl -e bash -c "cryptsetup luksOpen $device Projekte"
wsl mkdir -p /mnt/wsl/Projekte
wsl mount /dev/mapper/Projekte /mnt/wsl/Projekte
