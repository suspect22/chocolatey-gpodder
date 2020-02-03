$ErrorActionPreference  = 'Stop';
#$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                    = 'https://github.com/gpodder/gpodder/releases/download/3.10.13/windows-gpodder-3.10.13-installer.exe'
$softwareName           = 'gPodder'
$silentArgs             = "/S"
$validExitCodes         = @(0)
$fileType               = 'exe'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  fileType              = $fileType
  url                   = $url

  softwareName          = "$softwareName*"

  checksum              = '9d28ed5a0b57387cc9166d9d653d43b983d4bcf202dd6a6f7dac400b032aa31c'
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