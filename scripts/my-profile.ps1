$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
. (Resolve-Path ~/Documents/WindowsPowershell/ssh-agent-utils.ps1)

# Load posh-git example profile
. 'C:\dev\posh-git\profile.example.ps1'

$global:GitPromptSettings.EnableFileStatus = $false #speed up posh-git

New-PSDrive mod fileSystem ~/Documents\WindowsPowerShell/Modules

# Add ability to remember last directory to cd
Remove-Item Alias:cd
function cd {
    if ($args[0] -eq '-') {
        $pwd=$OLDPWD;
    } else {
        $pwd=$args[0];
    }
    $tmp=pwd;   
    if ($pwd) {
        Set-Location $pwd;
    }
    Set-Variable -Name OLDPWD -Value $tmp -Scope global;
}

function mklink { cmd /c mklink $args }

function ensurePsGetExists {
    if ((Get-Module PsGet) -eq $null) {
        # install psget
        (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
    }
}

function installModule($moduleName) {
    if ((Get-Module $moduleName) -eq $null) {
        # ensurePsGetExists

        Install-Module $moduleName
    }
}

installModule find-string
installModule default-ignores
installModule psconfig

Set-Alias subl sublime_text