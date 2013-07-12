$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
. (Resolve-Path ~/Documents/WindowsPowershell/ssh-agent-utils.ps1)

# Load posh-git example profile
. 'C:\dev\GitHub\posh-git\profile.example.ps1'

$global:GitPromptSettings.EnableFileStatus = $false #speed up posh-git

New-PSDrive su filesystem 'C:\dev\serviceu'
New-PSDrive gh filesystem 'C:\dev\GitHub'

import-module psget
import-module find-string
import-module default-ignores
import-module psconfig

Set-Alias subl sublime_text