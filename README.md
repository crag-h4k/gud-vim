# Gud Vim

This is a pretty good vim setup. This setup focuses on Python3 and is also set up for Rust development.

## Requirements

```sh
brew install macvim --override-system-vim
xargs brew install < homebrew.list
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

```zsh
source venv/bin/activate
pip install -r requirements.txt
```

### Huzzah! All done
