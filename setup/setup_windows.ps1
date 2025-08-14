param(
    [bool]$CreateGitHubRepo = $false,
    [string]$RepoName = "cse30-python-starter"
)

$ErrorActionPreference = "Stop"

function Ensure-WinGet {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "winget not found. Please install from Microsoft Store (App Installer)."
        return $false
    }
    return $true
}

function Ensure-Installed($name, $id) {
    if (Get-Command $name -ErrorAction SilentlyContinue) {
        Write-Host "$name already installed."
        return
    }
    if (Ensure-WinGet) {
        Write-Host "Installing $name via winget..."
        # Run winget and check exit code instead of using '||'
        $p = Start-Process winget -ArgumentList @("install","--id",$id,"-e","--silent") -Wait -PassThru
        if ($p.ExitCode -ne 0) {
            Write-Host "Couldn't auto-install $name. Install manually."
        }
    }
}
