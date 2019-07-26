[ Net.ServicePointManager ]::SecurityProtocol = [ Net.SecurityProtocolType ]::TLS12

$Link   = "https://github.com/mcc85s/PSD-Remaster/blob/master/Install/"

$Hybrid = "Provision-Hybrid.ps1"

IWR -URI "$Link/$Hybrid" -OutFile "$Home\Desktop\$Hybrid"

Start-Process Powershell -ArgumentList "-noprofile -File $Hybrid" -verb RunAs
