param([String] $scanPath)
#Script to read all files in directory recursively and update their creation time according to their alphabet order

Write-Host "Files orderer v0.1"
Write-Host "Working folder: $scanPath"

Function ScanDir($scanPath){
    $fileNames = @(Get-ChildItem $scanPath | Where-Object {!$_.PSIsContainer} | Foreach-Object {$_.FullName} | Sort-Object)
    $creationTimes = @(Get-ChildItem $scanPath | Where-Object {!$_.PSIsContainer} | Foreach-Object {$_.CreationTime} | Sort-Object)
    Write-Host "Path $scanPath"
    Write-Host "Files $($fileNames.Length)"
    Write-Host "Dates $($creationTimes.Length)"
    
    for($i = 0; $i -lt $fileNames.Length; $i++){
        $fn = $fileNames[$i]
        $ct = $creationTimes[$i]
        $fd = Get-Item $fn
        Write-Host "-- $($fd.Name) --     $($fd.CreationTime) => $ct"
        $fd.CreationTime = $ct
        $fd.LastWriteTime = $ct
    }
    
    $subDirectories = Get-ChildItem $scanPath | Where-Object {$_.PSIsContainer}
    foreach($dir in $subDirectories){
        ScanDir $dir.FullName
    }
}

ScanDir($scanPath)

cmd /c pause | out-null