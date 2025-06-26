# init_project.ps1
# 🧰 Idempotent setup for new Python project using .venv and split requirements

$venvPath = ".\.venv\Scripts\Activate.ps1"

if (-not (Test-Path ".venv")) {
    Write-Host "📦 Creating virtual environment at .venv"
    python -m venv .venv
} else {
    Write-Host "✅ .venv already exists"
}

# Activate .venv
Write-Host "🔁 Activating virtual environment..."
& $venvPath

# Install runtime packages
if (Test-Path "requirements.txt") {
    Write-Host "📥 Installing runtime requirements..."
    pip install -r requirements.txt
}
else {
    Write-Host "⚠️ No requirements.txt found, skipping runtime package installation"
}

# Install dev tools
if (Test-Path "dev-requirements.txt") {
    Write-Host "📥 Installing development tools..."
    pip install -r dev-requirements.txt
} else {
    Write-Host "⚠️ No dev-requirements.txt found, skipping dev tool installation"
}

# Ensure .gitignore contains .venv
if (-not (Test-Path ".gitignore")) {
    Write-Host "📄 Creating .gitignore"
    Set-Content .gitignore ".venv/"
} elseif (-not (Get-Content .gitignore | Select-String "\.venv")) {
    Write-Host "➕ Adding .venv to existing .gitignore"
    Add-Content .gitignore "`n.venv/"
} else {
    Write-Host "✅ .venv already in .gitignore"
}
