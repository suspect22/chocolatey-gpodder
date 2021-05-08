$ErrorActionPreference  = 'Stop';
#$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                    = 'https://github.com/gpodder/gpodder/releases/download/3.10.19/windows-gpodder-3.10.19-installer.exe'
$softwareName           = 'gPodder'
$silentArgs             = "/S"
$validExitCodes         = @(0)
$fileType               = 'exe'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  fileType              = $fileType
  url                   = $url

  softwareName          = "$softwareName*"

  checksum              = '95ec6a3f86dcd2bf79417698d6f787151b27a1d8ee4196657f151e3b570f6efa'
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
