$ErrorActionPreference  = 'Stop';
#$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                    = 'https://github.com/gpodder/gpodder/releases/download/3.10.15/windows-gpodder-3.10.15-installer.exe'
$softwareName           = 'gPodder'
$silentArgs             = "/S"
$validExitCodes         = @(0)
$fileType               = 'exe'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  fileType              = $fileType
  url                   = $url

  softwareName          = "$softwareName*"

  checksum              = '4cba3270c80f99421fd3e87e60556cb00a290469600d976a5c731119ca88c15f'
  checksumType          = 'sha256'
  silentArgs            = $silentArgs
  validExitCodes        = $validExitCodes
}


# silent uninstallation/upgrading of gpodder is not possible via /S Command
# Check if gPodder is already installed
[array]$gpodderRegistryKey = Get-UninstallRegistryKey -SoftwareName "$softwareName*"
if ($gpodderRegistryKey.count -gt 0){

  $UninstallStringFilePath = $gpodderRegistryKey.UninstallString
    Uninstall-ChocolateyPackage -PackageName $softwareName -FileType $fileType -SilentArgs $silentArgs -File $UninstallStringFilePath
}



Install-ChocolateyPackage @packageArgs 