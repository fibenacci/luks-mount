$luksMappingName = "Projekte"
$luksMappingExists = wsl -e bash -c "ls /dev/mapper/$luksMappingName" | Out-String -Stream | ForEach-Object { $_.Trim() }

if (-not $luksMappingExists) {
    Write-Host "Das LUKS-Mapping '$luksMappingName' existiert nicht."
    exit 1
}

wsl -e bash -c "umount /mnt/wsl/$luksMappingName"
wsl -e bash -c "cryptsetup luksClose $luksMappingName"
Write-Host "LUKS-Partition erfolgreich geschlossen und unmounted."
