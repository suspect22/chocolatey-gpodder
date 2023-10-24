$ErrorActionPreference  = 'Stop';
#$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                    = 'https://github.com/gpodder/gpodder/releases/download/3.11.4/windows-gpodder-3.11.4-installer.exe'
$softwareName           = 'gPodder'
$silentArgs             = "/S"
$validExitCodes         = @(0)
$fileType               = 'exe'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  fileType              = $fileType
  url                   = $url

  softwareName          = "$softwareName*"

  checksum              = '3ba0abf62afc52c18d8aa59e415584cde7f5f31e7d94aeaec4da90e3512d7a99'
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
