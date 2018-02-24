function ExceptionHandler {
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