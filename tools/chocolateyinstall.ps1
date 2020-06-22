$ErrorActionPreference  = 'Stop';
#$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                    = 'https://github.com/gpodder/gpodder/releases/download/3.10.16/windows-gpodder-3.10.16-installer.exe'
$softwareName           = 'gPodder'
$silentArgs             = "/S"
$validExitCodes         = @(0)
$fileType               = 'exe'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  fileType              = $fileType
  url                   = $url

  softwareName          = "$softwareName*"

  checksum              = 'c4fb996064418b441860c26a94a87b7498de9d51eb8d9eca681e0420c05ebd66'
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