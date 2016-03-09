
$workingFolder = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

Function SetKeyValue($key, $value){
    if (-Not (Test-Path "Registry::$key")){
        New-Item -Path "Registry::$key" -ItemType RegistryKey -Force
    }
    Set-ItemProperty -path "Registry::$key" -Name "(Default)" -Type "String" -Value $value
}

$key1 = "HKEY_CLASSES_ROOT\Directory\shell\Reorder-File-creation-time-by-AZ\command"
$val1 = "powershell $workingFolder\reorder-file-creation-time-by-AZ.ps1 %1"

SetKeyValue $key1 $val1

$key2 = "HKEY_CLASSES_ROOT\Directory\Background\shell\Reorder-File-creation-time-by-AZ\command"
$val2 = "powershell $workingFolder\reorder-file-creation-time-by-AZ.ps1 %V"

SetKeyValue $key2 $val2

