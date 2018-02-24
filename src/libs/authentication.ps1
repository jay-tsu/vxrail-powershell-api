# Function accepts uername and password, returns a hash to be used as a
#  -Headers parameter for an Invoke-RestMethod or Invoke-WebRequest
function Get-BasicAuthHeader {
    param (
        [Parameter(Mandatory = $true)] $Username,
        [Parameter(Mandatory = $true)] $Password
    )
    # Doing this step-by-step for illustration; no reason not to reduce it to fewer steps
    # In fact, you can uncomment the following line and remove all the following lines in the function
    # @{ Authorization = "Basic {0}" -f [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Password))) }

    # Make "username:password" string
    $UserNameColonPassword = "{0}:{1}" -f $Username, $Password
    # Could also be accomplished like:
    # $UserNameColonPassword = "$($Username):$($Password)"

    # Ensure it's ASCII-encoded
    $InAscii = [Text.Encoding]::ASCII.GetBytes($UserNameColonPassword)

    # Now Base64-encode:
    $InBase64 = [Convert]::ToBase64String($InAscii)

    # The value of the Authorization header is "Basic " and then the Base64-encoded username:password
    $Authorization = "Basic {0}" -f $InBase64
    # Could also be done as:
    # $Authorization = "Basic $InBase64"

    #This hash will be returned as the value of the function and is the Powershell version of the basic auth header
    $BasicAuthHeader = @{ Authorization = $Authorization }

    # Return the header
    return $BasicAuthHeader
}