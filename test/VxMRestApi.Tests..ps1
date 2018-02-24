Describe  'Module import checks' {

    Context 'Checking the module VxMRestApi.psm1 can be loaded successfully.' {

        (Get-ChildItem -Path '..\src' -Include *.psd1 -Recurse).FullName | ForEach-Object {
            It 'Module VxMRestApi is loading' {
                Import-Module $_ -Force
            } | Should be $null
        } 
    }
}