$username = "lv-teamcity.kernel@eleks.com"
$password = "B?rW?atPEa"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr


Login-AzureRmAccount -Credential $cred 


$ResourceGroupLocation = "West Europe"

$TemplateFile = "C:\Users\ostapkravchuk\source\repos\Kernel.DAB.Deployment.IaaS\Kernel.DAB.Deployment.IaaS\ARMTemplates\prod\createVnet.json"
$ResourceGroupName = "AzureResourceGroupAutomation"

$TemplateParametersFile = "C:\Users\ostapkravchuk\source\repos\Kernel.DAB.Deployment.IaaS\Kernel.DAB.Deployment.IaaS\ARMTemplates\prod\createVNet.parameters.json"

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force


$ErrorMessages = Format-ValidationOutput (Test-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName `
-TemplateFile $TemplateFile `
-TemplateParameterFile $TemplateParametersFile `
@OptionalParameters)
if ($ErrorMessages) {
Write-Output '', 'Validation returned the following errors:', @($ErrorMessages), '', 'Template is invalid.'
}
else {
Write-Output '', 'Template is valid.'
}


New-AzureRmResourceGroupDeployment -Name ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')) `
-ResourceGroupName $ResourceGroupName `
-TemplateFile $TemplateFile `
-TemplateParameterFile $TemplateParametersFile `
-Force -Verbose `
-ErrorVariable ErrorMessages