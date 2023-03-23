# Gud Vim

This is a pretty good vim setup. This setup focuses on Python3 and is
also set up for Rust and Go development (Javascript still WIP).

This configuration works with neovim with a couple additional steps -
see **`neovim`** section below for more details.

## MacOS Install Prereqs

```sh
brew install macvim --override-system-vim
xargs brew install < homebrew.list
```

## Debian GNU/Linux Install Prereqs

```sh
xargs sudo apt install -y < deb-pkgs.txt
```

## Install

```sh
BAK=$HOME/.vim-$(date +%d-%b-%Y).bak
mkdir $BAK
mv $HOME/.vim* $BAK/.
mv $HOME/.darglint $BAK/.
git clone https://github.com/crag-h4k/gud-vim.git $HOME/.vim --recursive
ln -s $HOME/.vim/vimrc $HOME/.vimrc
ln -s $HOME/.vim/darglint $HOME/.darglint
cd $HOME/.vim
git submodule update --recursive --remote bundle/*
```

I have this setup to use a Python3 Virtual Environment

Create a virtual environment with the following commands:

```sh
cd $HOME/.vim
python3 -m venv venv
```

Then activate your virtual environment and install dependancies

```sh
source venv/bin/activate
pip3 install -r requirements.txt
```

### Huzzah! All done

## `neovim` setup

Create a directory and symlink so that `neovim` knows where to look.

```sh
mkdir -p $HOME/.config
ln -s ~/.vim ~/.config/nvim
```

For jedi to work we need to install python's `neovim` module into the system's`PYTHONPATH`.

```sh
deactivate
pip3 install neovim --user
```

After this neovim should work! Please let me know if there are any issues.
