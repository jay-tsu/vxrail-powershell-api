function Set-SelfSignedCerts {
    param(    
        [Parameter (Mandatory = $true, ParameterSetName = "Parameter")]
        # Validates the certificate presented by NSX Manager for HTTPS connections
        [bool]$ValidateCertificate
    )
    try {
        Add-Type -TypeDefinition  @"
        using System.Net;
        using System.Security.Cryptography.X509Certificates;
        public class TrustAllCertsPolicy : ICertificatePolicy
        {
             public bool CheckValidationResult(
             ServicePoint srvPoint, X509Certificate certificate,
             WebRequest request, int certificateProblem)
             {
                 return true;
            }
        }
"@
    }
    catch {
        Write-Host $_ -ForegroundColor "Yellow"
    }

    if (( -not $ValidateCertificate) -and ([System.Net.ServicePointManager]::CertificatePolicy.tostring() -eq 'System.Net.DefaultCertPolicy')) {
        #allow untrusted certificate presented by the remote system to be accepted
        [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
    }
    elseif ($ValidateCertificate -and ([System.Net.ServicePointManager]::CertificatePolicy.tostring() -ne 'System.Net.DefaultCertPolicy')) {
        [System.Net.ServicePointManager]::CertificatePolicy = New-Object -TypeName System.Net.DefaultCertPolicy
    }
}