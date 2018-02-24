$allPs1FilesPath = Join-Path -Path $PSScriptRoot -ChildPath 'commands' 

Get-ChildItem -Path $allPs1FilesPath -Recurse -Include *.ps1 | ForEach-Object {
. $_.FullName
}