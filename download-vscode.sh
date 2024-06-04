#!/bin/bash

# 定义保存文件的目录
TARGET_DIR="./vscode_extensions"

# 如果目标目录不存在，则创建它
mkdir -p "$TARGET_DIR"

# 定义扩展名及其下载URL的数组
declare -A extensions=(
    ["vscode-builtin-bat"]="https://open-vsx.org/api/vscode/bat/1.45.1/file/vscode.bat-1.45.1.vsix"
    ["vscode-builtin-clojure"]="https://open-vsx.org/api/vscode/clojure/1.45.1/file/vscode.clojure-1.45.1.vsix"
    ["vscode-builtin-coffeescript"]="https://open-vsx.org/api/vscode/coffeescript/1.45.1/file/vscode.coffeescript-1.45.1.vsix"
    ["vscode-builtin-configuration-editing"]="https://open-vsx.org/api/vscode/configuration-editing/1.45.1/file/vscode.configuration-editing-1.45.1.vsix"
    ["vscode-builtin-cpp"]="https://open-vsx.org/api/vscode/cpp/1.45.1/file/vscode.cpp-1.45.1.vsix"
    ["vscode-builtin-csharp"]="https://open-vsx.org/api/vscode/csharp/1.45.1/file/vscode.csharp-1.45.1.vsix"
    ["vscode-builtin-css"]="https://open-vsx.org/api/vscode/css/1.45.1/file/vscode.css-1.45.1.vsix"
    ["vscode-builtin-css-language-features"]="https://open-vsx.org/api/vscode/css-language-features/1.45.1/file/vscode.css-language-features-1.45.1.vsix"
    ["vscode-builtin-debug-auto-launch"]="https://open-vsx.org/api/vscode/debug-auto-launch/1.45.1/file/vscode.debug-auto-launch-1.45.1.vsix"
    ["vscode-builtin-docker"]="https://open-vsx.org/api/vscode/docker/1.45.1/file/vscode.docker-1.45.1.vsix"
    ["vscode-builtin-emmet"]="https://open-vsx.org/api/vscode/emmet/1.45.1/file/vscode.emmet-1.45.1.vsix"
    ["vscode-builtin-fsharp"]="https://open-vsx.org/api/vscode/fsharp/1.45.1/file/vscode.fsharp-1.45.1.vsix"
    ["vscode-builtin-go"]="https://open-vsx.org/api/vscode/go/1.45.1/file/vscode.go-1.45.1.vsix"
    ["vscode-builtin-groovy"]="https://open-vsx.org/api/vscode/groovy/1.45.1/file/vscode.groovy-1.45.1.vsix"
    ["vscode-builtin-grunt"]="https://open-vsx.org/api/vscode/grunt/1.45.1/file/vscode.grunt-1.45.1.vsix"
    ["vscode-builtin-gulp"]="https://open-vsx.org/api/vscode/gulp/1.45.1/file/vscode.gulp-1.45.1.vsix"
    ["vscode-builtin-handlebars"]="https://open-vsx.org/api/vscode/handlebars/1.45.1/file/vscode.handlebars-1.45.1.vsix"
    ["vscode-builtin-hlsl"]="https://open-vsx.org/api/vscode/hlsl/1.45.1/file/vscode.hlsl-1.45.1.vsix"
    ["vscode-builtin-html"]="https://open-vsx.org/api/vscode/html/1.48.0-next.4a1bcdafe9/file/vscode.html-1.48.0-next.4a1bcdafe9.vsix"
    ["vscode-builtin-html-language-features"]="https://open-vsx.org/api/vscode/html-language-features/1.48.0-next.4a1bcdafe9/file/vscode.html-language-features-1.48.0-next.4a1bcdafe9.vsix"
    ["vscode-builtin-ini"]="https://open-vsx.org/api/vscode/ini/1.45.1/file/vscode.ini-1.45.1.vsix"
    ["vscode-builtin-jake"]="https://open-vsx.org/api/vscode/jake/1.45.1/file/vscode.jake-1.45.1.vsix"
    ["vscode-builtin-java"]="https://open-vsx.org/api/vscode/java/1.45.1/file/vscode.java-1.45.1.vsix"
    ["vscode-builtin-javascript"]="https://open-vsx.org/api/vscode/javascript/1.45.1/file/vscode.javascript-1.45.1.vsix"
    ["vscode-builtin-js-debug"]="https://open-vsx.org/api/ms-vscode/js-debug/1.49.8/file/ms-vscode.js-debug-1.49.8.vsix"
    ["vscode-builtin-json"]="https://open-vsx.org/api/vscode/json/1.46.1/file/vscode.json-1.46.1.vsix"
    ["vscode-builtin-json-language-features"]="https://open-vsx.org/api/vscode/json-language-features/1.46.1/file/vscode.json-language-features-1.46.1.vsix"
    ["vscode-builtin-less"]="https://open-vsx.org/api/vscode/less/1.45.1/file/vscode.less-1.45.1.vsix"
    ["vscode-builtin-log"]="https://open-vsx.org/api/vscode/log/1.45.1/file/vscode.log-1.45.1.vsix"
    ["vscode-builtin-lua"]="https://open-vsx.org/api/vscode/lua/1.45.1/file/vscode.lua-1.45.1.vsix"
    ["vscode-builtin-make"]="https://open-vsx.org/api/vscode/make/1.45.1/file/vscode.make-1.45.1.vsix"
    ["vscode-builtin-markdown"]="https://open-vsx.org/api/vscode/markdown/1.45.1/file/vscode.markdown-1.45.1.vsix"
    ["vscode-builtin-markdown-language-features"]="https://open-vsx.org/api/vscode/markdown-language-features/1.39.2/file/vscode.markdown-language-features-1.39.2.vsix"
    ["vscode-builtin-merge-conflict"]="https://open-vsx.org/api/vscode/merge-conflict/1.45.1/file/vscode.merge-conflict-1.45.1.vsix"
    ["vscode-builtin-npm"]="https://open-vsx.org/api/vscode/npm/1.45.1/file/vscode.npm-1.45.1.vsix"
    ["vscode-builtin-node-debug"]="https://open-vsx.org/api/ms-vscode/node-debug/1.44.8/file/ms-vscode.node-debug-1.44.8.vsix"
    ["vscode-builtin-node-debug2"]="https://open-vsx.org/api/ms-vscode/node-debug2/1.42.1/file/ms-vscode.node-debug2-1.42.1.vsix"
    ["vscode-builtin-objective-c"]="https://open-vsx.org/api/vscode/objective-c/1.45.1/file/vscode.objective-c-1.45.1.vsix"
    ["vscode-builtin-perl"]="https://open-vsx.org/api/vscode/perl/1.45.1/file/vscode.perl-1.45.1.vsix"
    ["vscode-builtin-powershell"]="https://open-vsx.org/api/vscode/powershell/1.45.1/file/vscode.powershell-1.45.1.vsix"
    ["vscode-builtin-pug"]="https://open-vsx.org/api/vscode/pug/1.45.1/file/vscode.pug-1.45.1.vsix"
    ["vscode-builtin-python"]="https://open-vsx.org/api/vscode/python/1.45.1/file/vscode.python-1.45.1.vsix"
    ["vscode-builtin-r"]="https://open-vsx.org/api/vscode/r/1.45.1/file/vscode.r-1.45.1.vsix"
    ["vscode-builtin-razor"]="https://open-vsx.org/api/vscode/razor/1.45.1/file/vscode.razor-1.45.1.vsix"
    ["vscode-builtin-ruby"]="https://open-vsx.org/api/vscode/ruby/1.45.1/file/vscode.ruby-1.45.1.vsix"
    ["vscode-builtin-rust"]="https://open-vsx.org/api/vscode/rust/1.45.1/file/vscode.rust-1.45.1.vsix"
    ["vscode-builtin-scss"]="https://open-vsx.org/api/vscode/scss/1.45.1/file/vscode.scss-1.45.1.vsix"
    ["vscode-builtin-sh"]="https://open-vsx.org/api/vscode/sh/1.45.1/file/vscode.sh-1.45.1.vsix"
    ["vscode-builtin-shellcheck"]="https://open-vsx.org/api/timonwong/shellcheck/0.7.1/file/timonwong.shellcheck-0.7.1.vsix"
    ["vscode-builtin-terraform"]="https://open-vsx.org/api/mauve/terraform/1.4.0/file/mauve.terraform-1.4.0.vsix"
    ["vscode-builtin-vb"]="https://open-vsx.org/api/vscode/vb/1.45.1/file/vscode.vb-1.45.1.vsix"
    ["vscode-builtin-yaml"]="https://open-vsx.org/api/redhat/vscode-yaml/0.11.1/file/redhat.vscode-yaml-0.11.1.vsix"
)

# 遍历数组，下载每个扩展
for extension in "${!extensions[@]}"; do
    url="${extensions[$extension]}"
    output_path="$TARGET_DIR/$extension.vsix"
    echo "Downloading $extension from $url..."
    curl -L -o "$output_path" "$url"
done

echo "All extensions have been downloaded to $TARGET_DIR."
