cargo --version;
if (("$?" != "0")); then
    echo "rust toolchain and cargo needed!";
    exit 1;
fi
echo "installing rust utils ..."
cargo install --locked bat;
cargo install ripgrep;
cargo install exa;
cargo install zoxide --locked;
cargo install cargo-update

BASH="$HOME/.bashrc"

if [[ -e $BASH ]]; then
    sed -i '/DAH SHELL DEFINITIONS/,/DAH SHELL END/d' $BASH
    echo "
# DAH SHELL DEFINITIONS

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

# DAH SHELL END
" >> $BASH
else
    echo "Could not find .bashrc in home dir!";
    exit 1;
fi

# source $BASH
