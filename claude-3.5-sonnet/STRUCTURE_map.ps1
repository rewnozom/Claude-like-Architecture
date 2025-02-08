# Get current directory path
$currentPath = Get-Location

# Vi behöver inte Get-FileIcon funktionen längre eftersom vi bara visar mappar
function Get-DirectoryTree {
    param (
        [string]$Path = $currentPath,
        [int]$IndentLevel = 0,
        [string[]]$ExcludeDirs = @(
            "venv", "env", "__pycache__", "node_modules", ".git", "_unimplemented_Developmemt",
            "bin", "obj", "build", "dist", "coverage", "logs", "NodeX.egg-info",
            ".next", ".nuxt", ".output", ".cache",
            "target", "out", ".idea", ".vscode"
        )
    )

    if ($IndentLevel -eq 0) {
        Write-Output "`n📁 $(Split-Path $Path -Leaf)"
    }

    # Hämta endast directories med -Directory switch
    $items = Get-ChildItem -Path $Path -Directory

    foreach ($item in $items) {
        if ($ExcludeDirs -contains $item.Name) {
            continue
        }

        $indent = "    " * $IndentLevel
        Write-Output "$indent├── 📁 $($item.Name)"
        
        # Rekursivt anrop för undermappar
        Get-DirectoryTree -Path $item.FullName -IndentLevel ($IndentLevel + 1) -ExcludeDirs $ExcludeDirs
    }
}

# Kör funktionen för nuvarande mapp
Get-DirectoryTree