#!/bin/bash
_require() {
    if ! type "$1" >/dev/null 2>&1; then
        echo >&2 "$1 is required. Aborting."
        exit 1
    fi
}
_require "nvim"
_require "git"
_require "python3"
_require "wget"

_ask_to_stop() {
    read -p "$1 (y/n) ? " -n 1 choice
    case "$choice" in
        n|N ) exit 2;;
        y|Y ) ;;
        * ) _ask_to_stop "$1";;
    esac
}

_ask_to_stop "nvim will be launched with full init to find a suitable location, ok"
f=$(mktemp)
err_log=$(mktemp)
nvim --headless +'let @@ = fnamemodify($MYVIMRC, ":p:h")' +'put "' +"silent 2,w! $f" +'q!' 2> "$err_log"
nvim_dir=$(cat $f)
echo
echo "Found neovim config in $nvim_dir"
test -s "err_log" && echo "Errors from nvim in $err_log"
_ask_to_stop "Is it gud"

py_env="$nvim_dir/pynvim"
dein_dir="$nvim_dir/dein"
dein_git="$dein_dir/repos/github.com/Shougo/dein.vim"
font_dir="$HOME/.local/share/fonts"
font_file="Fira Code Regular Nerd Font Complete Mono.ttf"
nerd_ver="master"

echo "Removing $py_env..."
rm -rf $py_env
echo "Removing $dein_dir..."
rm -rf $dein_dir

echo
mkdir -p "$dein_dir"
git clone --depth=1 https://github.com/Shougo/dein.vim "$dein_git"

echo
echo "Creating $(python3 --version) venv from $(which python3) in $py_env"
python3 -m venv --copies $py_env
$py_env/bin/python3 -m pip --disable-pip-version-check install pynvim jedi

echo
echo "Dowloading FiraCode nerd font..."
# Use -O to avoid overwrite an exising file
wget -nv "https://github.com/ryanoasis/nerd-fonts/raw/$nerd_ver/patched-fonts/FiraCode/Regular/complete/$font_file" -P "$font_dir" -O "$font_file"

echo
echo "The first start will takes some time to install plugins"
echo
echo "To Do: configure the terminal to use the font"
echo "The End"
