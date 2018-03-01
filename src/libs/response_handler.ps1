function Trace-Exception {
    param(    
        [Parameter (Mandatory = $true, ParameterSetName = "Parameter")]
        [Exception]$Exception
    )

    Write-Host "Caught an exception:" -ForegroundColor Red

    if ($Exception.Response) {
        $result = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($result)
        $reader.BaseStream.Position = 0
        $reader.DiscardBufferedData()
        Write-Host "Exception Message: $($reader.ReadToEnd())" -ForegroundColor Red
    }
    else {
        Write-Host "Exception Message: $($exception.Message)" -ForegroundColor Red
    }
}

function Export-Response {
    param(    
        [Parameter (Mandatory = $true)]
        [Microsoft.PowerShell.Commands.HtmlWebResponseObject]$response
    )

    Write-Host $response.RawContent

    # Write-Host "Request Headers" -ForegroundColor Green
    # $response.RawContent -match "(?<protocol>(HTTP.*))" | out-null
    # if ($matches.ContainsKey("protocol")) {
    #     Write-Host $matches["protocol"]
    # }
    # $response.RawContent -match "(?<content_type>(Content-Type:.*))" | out-null
    # if ($matches.ContainsKey("content_type")) {
    #     Write-Host $matches["content_type"]
    # }
    # $response.RawContent -match "(?<date>(Date:.*))" | out-null
    # if ($matches.ContainsKey("date")) {
    #     Write-Host $matches["date"]
    # }
    # $response.RawContent -match "(?<location>(Location:.*))" | out-null
    # if ($matches.ContainsKey("location")) {
    #     Write-Host $matches["location"]
    # }
    # Write-Host "Response Body" -ForegroundColor Green
    # Write-Host ($response.Content | convertFrom-Json | Format-List | Out-String)
}