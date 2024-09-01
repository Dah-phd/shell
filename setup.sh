cargo --version;
if (("$?" != "0")); then
    echo "rust toolchain and cargo needed!";
    exit 1;
fi
echo "installing rust utils ..."
cargo install --locked bat
cargo install ripgrep
cargo install exa
cargo install zoxide --locked
cargo install idiom
cargo install cargo-update
cargo install starship --locked
rustup component add rust-analyzer

BASHRC="$HOME/.bashrc"

if [[ -e $BASHRC ]]; then
    sed -i '/DAH SHELL DEFINITIONS/,/DAH SHELL END/d' $BASHRC
    echo "
# DAH SHELL DEFINITIONS

# init starship
eval \"\$(starship init bash)\"

# init zoxide
eval \"\$(zoxide init bash)\"

# rust replacement for coreutils
alias ls=\"exa\"
alias cat=\"bat\"
alias grep=\"rg\"
alias cd=\"z\"
alias i=\"idiom\"
alias cargo-update=\"cargo install-update -a\"
alias rfmt=\"cargo fmt && cargo test\"

# DAH SHELL END" >> $BASHRC
    echo "Updated bashrc!"
    source $BASHRC
else
    echo "Could not find $HOME/.bashrc in home dir!";
fi

if [[ -e $HOME/.config/ ]]; then
    if [[ -e $HOME/.config/alacritty/alacritty.toml ]]; then
        echo "skipping alacritty.toml it already exists!"
    else
        mkdir -p $HOME/.config/alacritty/
        echo "
[colors.primary]
background = \"#000000\"

[font]
size = 14

[window]
dimensions = {columns = 160, lines = 40}
decorations = \"None\"
startup_mode = \"Maximized\"" > $HOME/.config/alacritty/alacritty.toml
        echo "Create alacritty.toml with presets!"
    fi
else
    echo "Could not find $HOME/.config/ directory!"
fi
echo "FINISHED!"
