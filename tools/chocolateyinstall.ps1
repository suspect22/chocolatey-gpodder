
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/gpodder/gpodder/releases/download/3.10.11/windows-gpodder-3.10.11-installer.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url           = $url

  softwareName  = 'gPodder*'

  checksum      = 'D6E4E7A9D06CB419147A1AD49F8199B99D75EC802DC9FE6DA24C1061384D0B7D'
  checksumType  = 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs








