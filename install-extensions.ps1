# VS Code Extensions Installation Script for Windows
# Run: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; .\install-extensions.ps1

$ErrorActionPreference = "Stop"

$extensions = @(
    # Themes & Icons
    "zhuangtongfa.material-theme",
    "PKief.material-icon-theme",
    "miguelsolorio.fluent-icons",
    "GitHub.github-vscode-theme",
    "dracula-theme.theme-dracula",
    "enkia.tokyo-night",
    "sdras.night-owl",
    "monokai.theme-monokai-pro-vscode",
    "whizkydee.material-palenight-theme",
    "arcticicestudio.nord-visual-studio-code",
    "jdinhlife.gruvbox",

    # Code Formatting & Linting
    "esbenp.prettier-vscode",
    "dbaeumer.vscode-eslint",
    "EditorConfig.EditorConfig",
    "stylelint.vscode-stylelint",
    "foxundermoon.shell-format",

    # Git & Version Control
    "eamodio.gitlens",
    "mhutchie.git-graph",
    "donjayamanne.githistory",
    "GitHub.vscode-pull-request-github",
    "GitHub.copilot",
    "GitHub.copilot-chat",

    # Language Support - JavaScript/TypeScript
    "ms-vscode.vscode-typescript-next",
    "dsznajder.es7-react-js-snippets",
    "xabikos.JavaScriptSnippets",
    "christian-kohler.npm-intellisense",
    "eg2.vscode-npm-script",

    # Language Support - Vue/Svelte/Astro
    "Vue.volar",
    "svelte.svelte-vscode",
    "astro-build.astro-vscode",

    # Language Support - Python
    "ms-python.python",
    "ms-python.vscode-pylance",
    "ms-python.black-formatter",
    "ms-python.isort",
    "ms-python.debugpy",

    # Language Support - PHP/Laravel
    "bmewburn.vscode-intelephense-client",
    "onecentlin.laravel-blade",
    "shufo.vscode-blade-formatter",
    "amiralizadeh9480.laravel-extra-intellisense",
    "MehediDrawormo.laravel-goto-controller",
    "codingyu.laravel-goto-view",

    # Language Support - Go
    "golang.go",

    # Language Support - Rust
    "rust-lang.rust-analyzer",

    # Language Support - C/C++
    "ms-vscode.cpptools",
    "ms-vscode.cpptools-extension-pack",
    "ms-vscode.cmake-tools",

    # Language Support - C#/.NET
    "ms-dotnettools.csharp",
    "ms-dotnettools.vscode-dotnet-runtime",

    # Language Support - Java
    "redhat.java",
    "vscjava.vscode-java-pack",
    "vscjava.vscode-java-debug",
    "vscjava.vscode-java-test",
    "vscjava.vscode-maven",

    # Language Support - Ruby
    "Shopify.ruby-lsp",
    "rebornix.ruby",

    # Language Support - YAML/TOML/JSON
    "redhat.vscode-yaml",
    "tamasfe.even-better-toml",

    # Language Support - SQL/Database
    "mtxr.sqltools",
    "cweijan.vscode-database-client2",

    # Docker & Containers
    "ms-azuretools.vscode-docker",
    "ms-vscode-remote.remote-containers",

    # Remote Development
    "ms-vscode-remote.remote-ssh",
    "ms-vscode-remote.remote-wsl",
    "ms-vscode.remote-explorer",

    # Markdown & Documentation
    "yzhang.markdown-all-in-one",
    "shd101wyy.markdown-preview-enhanced",
    "bierner.markdown-mermaid",
    "DavidAnson.vscode-markdownlint",

    # Productivity & Utilities
    "usernamehw.errorlens",
    "christian-kohler.path-intellisense",
    "formulahendry.auto-rename-tag",
    "formulahendry.auto-close-tag",
    "streetsidesoftware.code-spell-checker",
    "oderwat.indent-rainbow",
    "aaron-bond.better-comments",
    "wayou.vscode-todo-highlight",
    "Gruntfuggly.todo-tree",
    "naumovs.color-highlight",
    "vincaslt.highlight-matching-tag",
    "wix.vscode-import-cost",
    "kisstkondoros.vscode-gutter-preview",

    # Testing
    "Orta.vscode-jest",
    "hbenl.vscode-test-explorer",
    "ms-vscode.test-adapter-converter",

    # REST API & HTTP
    "humao.rest-client",
    "rangav.vscode-thunder-client",

    # Live Server & Preview
    "ritwickdey.LiveServer",
    "ms-vscode.live-server",

    # Snippets & Templates
    "abusaidm.html-snippets",
    "ecmel.vscode-html-css",
    "Zignd.html-css-class-completion",

    # File Management
    "sleistner.vscode-fileutils",
    "patbenatar.advanced-new-file",

    # Bookmarks & Navigation
    "alefragnani.Bookmarks",
    "alefragnani.project-manager",

    # Time Tracking
    "WakaTime.vscode-wakatime",

    # Misc Utilities
    "mechatroner.rainbow-csv",
    "mikestead.dotenv",
    "redhat.vscode-xml",
    "IBM.output-colorizer",
    "quicktype.quicktype",
    "Tyriar.sort-lines",
    "wmaurer.change-case"
)

# Check if VS Code is installed
if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Error: VS Code 'code' command not found." -ForegroundColor Red
    Write-Host "   Make sure VS Code is installed and in your PATH." -ForegroundColor Yellow
    exit 1
}

Write-Host "`n🚀 Installing VS Code Extensions..." -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

$installed = 0
$skipped = 0
$failed = 0
$total = $extensions.Count
$current = 0

# Get currently installed extensions
$installedExtensions = code --list-extensions 2>$null

foreach ($ext in $extensions) {
    $current++
    $percent = [math]::Round(($current / $total) * 100)

    if ($installedExtensions -contains $ext) {
        Write-Host "⏭️  $ext (already installed)" -ForegroundColor Gray
        $skipped++
    } else {
        Write-Progress -Activity "Installing Extensions" -Status "$ext ($current of $total)" -PercentComplete $percent
        $err = $null
        code --install-extension $ext --force 2>&1 | Out-Null

        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ $ext" -ForegroundColor Green
            $installed++
        } else {
            Write-Host "❌ $ext" -ForegroundColor Red
            $failed++
        }
    }
}

Write-Progress -Activity "Installing Extensions" -Completed

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "📊 Summary:" -ForegroundColor Cyan
Write-Host "   ✅ Installed: $installed" -ForegroundColor Green
Write-Host "   ⏭️  Skipped:   $skipped" -ForegroundColor Gray
Write-Host "   ❌ Failed:    $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host ""

if ($failed -eq 0) {
    Write-Host "✅ All extensions installed successfully!" -ForegroundColor Green
} else {
    Write-Host "⚠️  $failed extension(s) failed to install." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📝 Note: Some extensions require additional setup:" -ForegroundColor Yellow
Write-Host "   - GitHub Copilot: Sign in with GitHub account"
Write-Host "   - Remote SSH: Configure SSH hosts"
Write-Host "   - Python: Select Python interpreter"
Write-Host "   - Go/Rust: Install language toolchains"
Write-Host ""
Write-Host "🔄 Restart VS Code to activate all extensions." -ForegroundColor Cyan
