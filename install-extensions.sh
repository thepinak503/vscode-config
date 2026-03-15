#!/bin/bash

# VS Code Extensions Installation Script
# Run: chmod +x install-extensions.sh && ./install-extensions.sh

echo "🚀 Installing VS Code Extensions..."
echo "=================================="

# Themes & Icons
code --install-extension zhuangtongfa.material-theme
code --install-extension PKief.material-icon-theme
code --install-extension miguelsolorio.fluent-icons
code --install-extension GitHub.github-vscode-theme
code --install-extension dracula-theme.theme-dracula
code --install-extension enkia.tokyo-night
code --install-extension sdras.night-owl
code --install-extension monokai.theme-monokai-pro-vscode
code --install-extension whizkydee.material-palenight-theme
code --install-extension arcticicestudio.nord-visual-studio-code
code --install-extension jdinhlife.gruvbox

# Code Formatting & Linting
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension EditorConfig.EditorConfig
code --install-extension stylelint.vscode-stylelint
code --install-extension foxundermoon.shell-format

# Git & Version Control
code --install-extension eamodio.gitlens
code --install-extension mhutchie.git-graph
code --install-extension donjayamanne.githistory
code --install-extension GitHub.vscode-pull-request-github
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat

# Language Support - JavaScript/TypeScript
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension dsznajder.es7-react-js-snippets
code --install-extension xabikos.JavaScriptSnippets
code --install-extension christian-kohler.npm-intellisense
code --install-extension eg2.vscode-npm-script

# Language Support - Vue/Svelte/Astro
code --install-extension Vue.volar
code --install-extension svelte.svelte-vscode
code --install-extension astro-build.astro-vscode

# Language Support - Python
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.black-formatter
code --install-extension ms-python.isort
code --install-extension ms-python.debugpy

# Language Support - PHP/Laravel
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension onecentlin.laravel-blade
code --install-extension shufo.vscode-blade-formatter
code --install-extension amiralizadeh9480.laravel-extra-intellisense
code --install-extension MehediDrawormo.laravel-goto-controller
code --install-extension codingyu.laravel-goto-view

# Language Support - Go
code --install-extension golang.go

# Language Support - Rust
code --install-extension rust-lang.rust-analyzer

# Language Support - C/C++
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cpptools-extension-pack
code --install-extension ms-vscode.cmake-tools

# Language Support - C#/.NET
code --install-extension ms-dotnettools.csharp
code --install-extension ms-dotnettools.vscode-dotnet-runtime

# Language Support - Java
code --install-extension redhat.java
code --install-extension vscjava.vscode-java-pack
code --install-extension vscjava.vscode-java-debug
code --install-extension vscjava.vscode-java-test
code --install-extension vscjava.vscode-maven

# Language Support - Ruby
code --install-extension Shopify.ruby-lsp
code --install-extension rebornix.ruby

# Language Support - YAML/TOML/JSON
code --install-extension redhat.vscode-yaml
code --install-extension tamasfe.even-better-toml

# Language Support - SQL/Database
code --install-extension mtxr.sqltools
code --install-extension cweijan.vscode-database-client2

# Docker & Containers
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers

# Remote Development
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension ms-vscode.remote-explorer

# Markdown & Documentation
code --install-extension yzhang.markdown-all-in-one
code --install-extension shd101wyy.markdown-preview-enhanced
code --install-extension bierner.markdown-mermaid
code --install-extension DavidAnson.vscode-markdownlint

# Productivity & Utilities
code --install-extension usernamehw.errorlens
code --install-extension christian-kohler.path-intellisense
code --install-extension formulahendry.auto-rename-tag
code --install-extension formulahendry.auto-close-tag
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension oderwat.indent-rainbow
code --install-extension aaron-bond.better-comments
code --install-extension wayou.vscode-todo-highlight
code --install-extension Gruntfuggly.todo-tree
code --install-extension naumovs.color-highlight
code --install-extension vincaslt.highlight-matching-tag
code --install-extension wix.vscode-import-cost
code --install-extension kisstkondoros.vscode-gutter-preview

# Testing
code --install-extension Orta.vscode-jest
code --install-extension hbenl.vscode-test-explorer
code --install-extension ms-vscode.test-adapter-converter

# REST API & HTTP
code --install-extension humao.rest-client
code --install-extension rangav.vscode-thunder-client

# Live Server & Preview
code --install-extension ritwickdey.LiveServer
code --install-extension ms-vscode.live-server

# Snippets & Templates
code --install-extension abusaidm.html-snippets
code --install-extension ecmel.vscode-html-css
code --install-extension Zignd.html-css-class-completion

# File Management
code --install-extension sleistner.vscode-fileutils
code --install-extension patbenatar.advanced-new-file

# Bookmarks & Navigation
code --install-extension alefragnani.Bookmarks
code --install-extension alefragnani.project-manager

# Time Tracking
code --install-extension WakaTime.vscode-wakatime

# Misc Utilities
code --install-extension mechatroner.rainbow-csv
code --install-extension mikestead.dotenv
code --install-extension redhat.vscode-xml
code --install-extension IBM.output-colorizer
code --install-extension quicktype.quicktype
code --install-extension Tyriar.sort-lines
code --install-extension wmaurer.change-case

echo ""
echo "✅ All extensions installed successfully!"
echo ""
echo "📝 Note: Some extensions require additional setup:"
echo "   - GitHub Copilot: Sign in with GitHub account"
echo "   - Remote SSH: Configure SSH hosts"
echo "   - Python: Select Python interpreter"
echo "   - Go/Rust: Install language toolchains"
echo ""
echo "🔄 Restart VS Code to activate all extensions."
