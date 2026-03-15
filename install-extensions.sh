#!/bin/sh

VSCODE_EXTENSIONS="zhuangtongfa.material-theme PKief.material-icon-theme miguelsolorio.fluent-icons GitHub.github-vscode-theme dracula-theme.theme-dracula enkia.tokyo-night sdras.night-owl monokai.theme-monokai-pro-vscode whizkydee.material-palenight-theme arcticicestudio.nord-visual-studio-code jdinhlife.gruvbox esbenp.prettier-vscode dbaeumer.vscode-eslint EditorConfig.EditorConfig stylelint.vscode-stylelint foxundermoon.shell-format eamodio.gitlens mhutchie.git-graph donjayamanne.githistory GitHub.vscode-pull-request-github GitHub.copilot GitHub.copilot-chat ms-vscode.vscode-typescript-next dsznajder.es7-react-js-snippets xabikos.JavaScriptSnippets christian-kohler.npm-intellisense eg2.vscode-npm-script Vue.volar svelte.svelte-vscode astro-build.astro-vscode ms-python.python ms-python.vscode-pylance ms-python.black-formatter ms-python.isort ms-python.debugpy bmewburn.vscode-intelephense-client onecentlin.laravel-blade shufo.vscode-blade-formatter amiralizadeh9480.laravel-extra-intellisense MehediDrawormo.laravel-goto-controller codingyu.laravel-goto-view golang.go rust-lang.rust-analyzer ms-vscode.cpptools ms-vscode.cpptools-extension-pack ms-vscode.cmake-tools ms-dotnettools.csharp ms-dotnettools.vscode-dotnet-runtime redhat.java vscjava.vscode-java-pack vscjava.vscode-java-debug vscjava.vscode-java-test vscjava.vscode-maven Shopify.ruby-lsp rebornix.ruby redhat.vscode-yaml tamasfe.even-better-toml mtxr.sqltools cweijan.vscode-database-client2 ms-azuretools.vscode-docker ms-vscode-remote.remote-containers ms-vscode-remote.remote-ssh ms-vscode-remote.remote-wsl ms-vscode.remote-explorer yzhang.markdown-all-in-one shd101wyy.markdown-preview-enhanced bierner.markdown-mermaid DavidAnson.vscode-markdownlint usernamehw.errorlens christian-kohler.path-intellisense formulahendry.auto-rename-tag formulahendry.auto-close-tag streetsidesoftware.code-spell-checker oderwat.indent-rainbow aaron-bond.better-comments wayou.vscode-todo-highlight Gruntfuggly.todo-tree naumovs.color-highlight vincaslt.highlight-matching-tag wix.vscode-import-cost kisstkondoros.vscode-gutter-preview Orta.vscode-jest hbenl.vscode-test-explorer ms-vscode.test-adapter-converter humao.rest-client rangav.vscode-thunder-client ritwickdey.LiveServer ms-vscode.live-server abusaidm.html-snippets ecmel.vscode-html-css Zignd.html-css-class-completion sleistner.vscode-fileutils patbenatar.advanced-new-file alefragnani.Bookmarks alefragnani.project-manager WakaTime.vscode-wakatime mechatroner.rainbow-csv mikestead.dotenv redhat.vscode-xml IBM.output-colorizer quicktype.quicktype Tyriar.sort-lines wmaurer.change-case"

if ! command -v code >/dev/null 2>&1; then
  echo "Error: VS Code 'code' command not found."
  echo "Make sure VS Code is installed and in your PATH."
  exit 1
fi

echo "Installing VS Code Extensions..."
echo "====================================="
echo ""

TOTAL=$(echo "$VSCODE_EXTENSIONS" | wc -w)
INSTALLED=0
SKIPPED=0
FAILED=0

for ext in $VSCODE_EXTENSIONS; do
  if code --list-extensions 2>/dev/null | grep -q "^${ext}$"; then
    echo "SKIP $ext (already installed)"
    SKIPPED=$((SKIPPED + 1))
  else
    if code --install-extension "$ext" --force 2>/dev/null; then
      echo "OK $ext"
      INSTALLED=$((INSTALLED + 1))
    else
      echo "FAIL $ext"
      FAILED=$((FAILED + 1))
    fi
  fi
done

echo ""
echo "====================================="
echo "Summary:"
echo "  Installed: $INSTALLED"
echo "  Skipped:   $SKIPPED"
echo "  Failed:    $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
  echo "All extensions installed successfully!"
else
  echo "$FAILED extension(s) failed to install."
fi

echo ""
echo "Note: Some extensions require additional setup:"
echo "  - GitHub Copilot: Sign in with GitHub account"
echo "  - Remote SSH: Configure SSH hosts"
echo "  - Python: Select Python interpreter"
echo "  - Go/Rust: Install language toolchains"
echo ""
echo "Restart VS Code to activate all extensions."
