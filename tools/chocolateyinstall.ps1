$ErrorActionPreference  = 'Stop';
#$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                    = 'https://github.com/gpodder/gpodder/releases/download/3.10.12/windows-gpodder-3.10.12-installer.exe'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  fileType              = 'exe'
  url                   = $url

  softwareName          = 'gPodder*'

  checksum              = 'b5271f7cb3080314c55cb6f5e0238e2a971a18a72895e80d5650fec455a2bbd0'
  checksumType          = 'sha256'
  silentArgs            = '/S'
  validExitCodes        = @(0)
}

Install-ChocolateyPackage @packageArgs 