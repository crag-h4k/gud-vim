# Gud Vim

This is a pretty good vim setup.


## Install

```zsh
BAK=$HOME/.vim-$(date +%d-%b-%Y).bak
mkdir $BAK
mv $HOME/.vim* $BAK/.
git clone https://github.com/crag-h4k/gud-vim.git $HOME/.vim --recursive
ln -s $HOME/.vim/vimrc ~/.vimrc
```

I have this setup to use a Python3 Virtual Environment

Create a virtual environment with 

```zsh
python3 -m venv venv
```

Then activate your virtual environment and install the dependancies

```zsh
source venv/bin/activate
pip install -r requirements.txt
```

