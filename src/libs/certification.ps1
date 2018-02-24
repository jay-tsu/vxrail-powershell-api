function Disable-SelfSignedCerts {
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

    if ([System.Net.ServicePointManager]::CertificatePolicy.tostring() -eq 'System.Net.DefaultCertPolicy') {
        #allow untrusted certificate presented by the remote system to be accepted
        [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
    }
}