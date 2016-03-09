param([String] $scanPath)
#Script to read all files in directory recursively and update their creation and modification time according to their alphabet order

Write-Host "Files orderer v0.1"
Write-Host "Working folder: $scanPath"

Function ExecuteMain($scanPath){
    $files = Get-ChildItem $scanPath | Where-Object {!$_.PSIsContainer} 
    foreach($file in $files)
    {
        Write-Host $file.Fullname
    }
}

ExecuteMain($scanPath)

cmd /c pause | out-null