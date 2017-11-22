#
# Commands.ps1
#
Test-NetConnection -ComputerName automationkerneliaas.file.core.windows.net -Port 445

PS C:\Users\ostapkravchuk> Compress-Archive -U -Path C:\Users\ostapkravchuk\source\repos\Kernel.DAB.Deployment.IaaS\Kern
el.DAB.Deployment.IaaS\dsc\configureADDNS.ps1\* -DestinationPath C:\Users\ostapkravchuk\source\repos\Kernel.DAB.Deployme
nt.IaaS\Kernel.DAB.Deployment.IaaS\dsc\configureADDNS.ps1.zip