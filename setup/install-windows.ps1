# Intro to CS & Python - environment setup for Windows
#
# Installs VS Code, Python and Git for Windows with winget, then:
#   - installs the Python extension for VS Code
#   - makes Git Bash the default terminal in VS Code
#   - adds a Git Bash profile to Windows Terminal (if Git didn't create one)
#
# Run it from a regular (not administrator) PowerShell window:
#
#   irm https://raw.githubusercontent.com/NadavAharoni/intro-cs-python/main/setup/install-windows.ps1 | iex
#
# It is safe to run more than once: anything already installed is skipped.
# To see what it would do without changing anything, first run:  $env:INTRO_CS_DRY_RUN = "1"

& {
    $DryRun = $env:INTRO_CS_DRY_RUN -eq "1"
    $MinPython = [version]"3.12"
    $GitBash = "C:\Program Files\Git\bin\bash.exe"

    function Write-Step($text) { Write-Host ""; Write-Host "==> $text" -ForegroundColor Cyan }
    function Write-Ok($text) { Write-Host "    OK: $text" -ForegroundColor Green }
    function Write-Note($text) { Write-Host "    $text" }
    function Write-Problem($text) { Write-Host "    PROBLEM: $text" -ForegroundColor Yellow }

    # Reload PATH from the registry, so programs installed a moment ago are found.
    function Update-SessionPath {
        $machine = [Environment]::GetEnvironmentVariable("Path", "Machine")
        $user = [Environment]::GetEnvironmentVariable("Path", "User")
        $env:Path = "$machine;$user"
    }

    # Returns the version of the "python" command, or $null if there is no working one.
    # (The Microsoft Store placeholder prints an error instead of a version.)
    function Get-PythonVersion {
        if (-not (Get-Command python -ErrorAction SilentlyContinue)) { return $null }
        $output = "$(& python --version 2>&1)"
        if ($output -match "Python (\d+)\.(\d+)") { return [version]"$($Matches[1]).$($Matches[2])" }
        return $null
    }

    function Install-WithWinget($id, $override) {
        $wingetArgs = @("install", "--exact", "--id", $id, "--source", "winget", "--no-upgrade",
                        "--accept-source-agreements", "--accept-package-agreements", "--disable-interactivity",
                        "--override", $override)
        if ($DryRun) {
            Write-Note "[dry run] winget $($wingetArgs -join ' ')"
            return $true
        }
        & winget @wingetArgs
        $code = $LASTEXITCODE
        # 0: installed. The other two codes mean it was already installed.
        if ($code -eq 0 -or $code -eq -1978335135 -or $code -eq -1978335189) { return $true }
        Write-Problem "winget failed for $id (exit code $code)"
        return $false
    }

    # --- winget ---------------------------------------------------------------
    Write-Step "Checking winget"
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Problem "winget was not found."
        Write-Note "Install 'App Installer' from the Microsoft Store, then run this script again."
        return
    }
    Write-Ok "winget $(winget --version)"

    # --- VS Code --------------------------------------------------------------
    Write-Step "Installing Visual Studio Code"
    $null = Install-WithWinget "Microsoft.VisualStudioCode" `
        "/VERYSILENT /NORESTART /MERGETASKS=!runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"

    # --- Python ---------------------------------------------------------------
    Write-Step "Installing Python"
    $pythonVersion = Get-PythonVersion
    if ($pythonVersion -and $pythonVersion -ge $MinPython) {
        Write-Ok "Python $pythonVersion is already installed - skipping"
    }
    else {
        if ($pythonVersion) { Write-Note "Found an old Python ($pythonVersion); installing Python 3.14 for your user." }
        # Per-user install, added to the start of the user PATH, so no app execution aliases are involved.
        $null = Install-WithWinget "Python.Python.3.14" "/quiet InstallAllUsers=0 PrependPath=1 Include_launcher=0 Include_test=0"
    }

    # --- Git for Windows ------------------------------------------------------
    Write-Step "Installing Git for Windows (Windows will ask for permission - click Yes)"
    $null = Install-WithWinget "Git.Git" `
        "/VERYSILENT /NORESTART /NOCANCEL /SP- /COMPONENTS=icons,ext\reg\shellhere,assoc,assoc_sh,gitlfs,windowsterminal /o:EditorOption=VisualStudioCode /o:DefaultBranchOption=main /o:PathOption=Cmd"

    Update-SessionPath

    # --- Python extension for VS Code -----------------------------------------
    Write-Step "Installing the Python extension for VS Code"
    $codeCommand = Get-Command code -ErrorAction SilentlyContinue
    if ($DryRun) { Write-Note "[dry run] code --install-extension ms-python.python" }
    elseif ($codeCommand) {
        & $codeCommand.Source --install-extension ms-python.python
        Write-Ok "Python extension"
    }
    else { Write-Problem "the 'code' command was not found; install the Python extension from VS Code instead." }

    # --- Git Bash as the default terminal in VS Code --------------------------
    Write-Step "Making Git Bash the default terminal in VS Code"
    $settingsFile = Join-Path $env:APPDATA "Code\User\settings.json"
    $key = "terminal.integrated.defaultProfile.windows"
    if ((Test-Path $settingsFile) -and (Select-String -Path $settingsFile -Pattern $key -SimpleMatch -Quiet)) {
        Write-Ok "a default terminal is already set in VS Code - leaving it as is"
    }
    elseif ($DryRun) { Write-Note "[dry run] set $key = Git Bash in $settingsFile" }
    elseif (-not (Test-Path $settingsFile)) {
        New-Item -ItemType Directory -Force (Split-Path $settingsFile) | Out-Null
        [IO.File]::WriteAllText($settingsFile, "{`n    `"$key`": `"Git Bash`"`n}`n")
        Write-Ok "created $settingsFile"
    }
    else {
        try {
            $settings = Get-Content $settingsFile -Raw | ConvertFrom-Json
            Copy-Item $settingsFile "$settingsFile.bak" -Force
            $settings | Add-Member -NotePropertyName $key -NotePropertyValue "Git Bash" -Force
            [IO.File]::WriteAllText($settingsFile, ($settings | ConvertTo-Json -Depth 50))
            Write-Ok "updated $settingsFile (backup: settings.json.bak)"
        }
        catch {
            Write-Problem "could not update $settingsFile automatically."
            Write-Note "In VS Code: Ctrl+Shift+P > 'Terminal: Select Default Profile' > Git Bash"
        }
    }

    # --- Git Bash profile in Windows Terminal ---------------------------------
    Write-Step "Adding Git Bash to Windows Terminal"
    $fragmentRoots = @(
        (Join-Path $env:ProgramData "Microsoft\Windows Terminal\Fragments"),
        (Join-Path $env:LOCALAPPDATA "Microsoft\Windows Terminal\Fragments")
    )
    $existing = Get-ChildItem $fragmentRoots -Recurse -Filter *.json -ErrorAction SilentlyContinue |
        Select-String -Pattern "bash.exe" -SimpleMatch -List
    if ($existing) { Write-Ok "Windows Terminal already has a Git Bash profile" }
    elseif ($DryRun) { Write-Note "[dry run] create a Git Bash profile fragment for Windows Terminal" }
    elseif (-not (Test-Path $GitBash)) { Write-Problem "Git Bash was not found at $GitBash" }
    else {
        $folder = Join-Path $env:LOCALAPPDATA "Microsoft\Windows Terminal\Fragments\IntroCS"
        New-Item -ItemType Directory -Force $folder | Out-Null
        $fragment = @'
{
  "profiles": [
    {
      "name": "Git Bash",
      "commandline": "\"C:/Program Files/Git/bin/bash.exe\" -i -l",
      "icon": "C:/Program Files/Git/mingw64/share/git/git-for-windows.ico",
      "startingDirectory": "%USERPROFILE%"
    }
  ]
}
'@
        [IO.File]::WriteAllText((Join-Path $folder "git-bash.json"), $fragment)
        Write-Ok "added (close and reopen Windows Terminal to see it)"
    }

    # --- Summary --------------------------------------------------------------
    Write-Step "Checking the installation"
    $pythonVersion = Get-PythonVersion
    if ($pythonVersion -and $pythonVersion -ge $MinPython) { Write-Ok "python: $(& python --version 2>&1)" }
    else {
        Write-Problem "the 'python' command does not run Python $MinPython or newer."
        Write-Note "These are all the 'python' commands found, in the order Windows tries them:"
        where.exe python 2>$null | ForEach-Object { Write-Note "  $_" }
        Write-Note "Close this window, open a new PowerShell window, and run: python --version"
        Write-Note "If it still shows an old version, show this output to the lecturer."
    }
    if (Get-Command git -ErrorAction SilentlyContinue) { Write-Ok "git: $(git --version)" } else { Write-Problem "git was not found" }
    if (Get-Command code -ErrorAction SilentlyContinue) { Write-Ok "code: VS Code $(code --version | Select-Object -First 1)" } else { Write-Problem "code was not found" }

    Write-Host ""
    Write-Host "Done. Close all PowerShell, Windows Terminal and VS Code windows, and open them again." -ForegroundColor Cyan
}
