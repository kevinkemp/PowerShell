$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
. (Resolve-Path ~/Documents/WindowsPowershell/ssh-agent-utils.ps1)

# Load posh-git example profile
. 'C:\dev\GitHub\posh-git\profile.example.ps1'

$global:GitPromptSettings.EnableFileStatus = $false #speed up posh-git

New-PSDrive su filesystem 'C:\dev\serviceu'
New-PSDrive gh filesystem 'C:\dev\GitHub'
New-PSDrive -Name mod -PSProvider FileSystem -root $ProfileDir/Modules | Out-Null

function mklink { cmd /c mklink $args }

function ensurePsGetExists {
    if ((Get-Module PsGet) -eq $null) {
        # install psget
        (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
    }
}

function installModule($moduleName) {
    if ((Get-Module $moduleName) -eq $null) {
        ensurePsGetExists

        Install-Module $moduleName
    }
}

installModule find-string
installModule default-ignores
installModule psconfig

Set-Alias subl sublime_text