Describe  'Get-SystemHealth checks' {

    Context 'Checking the function Get-SystemHealth.' {
        It 'The function Get-SystemHealth() is running' {
            Get-SystemHealth -server 10.62.81.84 -username user -password password | Should be "OK"
        }

    }
}