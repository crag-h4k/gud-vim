# Gud Vim

A pretty good vim setup. Python3-first, also wired for Rust and Go
(JavaScript still WIP). Works with both Vim and Neovim: the Neovim entrypoint
is a file-level symlink to `init.lua` in this repo.

## Table of Contents

- [Prereqs](#prereqs)
- [Install](#install)
- [Packages](#packages)
- [Symlink management](#symlink-management)
- [Python virtualenv](#python-virtualenv)
- [Neovim setup](#neovim-setup)

## Prereqs

- macOS: Homebrew
- Debian / Ubuntu: `apt-get`, with sudo

Package installation is handled via `make packages` (see [Packages](#packages)).

## Install

```sh
BAK="$HOME/.vim-$(date +%d-%b-%Y).bak"
mkdir -p "$BAK"
mv "$HOME"/.vim* "$BAK"/ 2>/dev/null || true
mv "$HOME/.darglint" "$BAK"/ 2>/dev/null || true

git clone --recursive https://github.com/crag-h4k/gud-vim.git "$HOME/.vim"
make -C "$HOME/.vim" packages   # optional: brew/apt install
make -C "$HOME/.vim" install
```

## Packages

```sh
make packages
```

Reads from the repo-root lists:

- `homebrew.list` (macOS): macvim, rust, go, llvm, nodejs, python3, tflint,
  yamllint, and more.
- `deb-pkgs.txt` (Debian/Ubuntu): vim-nox, python3-dev.

Safe to re-run. See `scripts/install-packages.sh`.

## Symlink management

```sh
make install     # links vimrc, darglint, init.lua, yamllint config
make uninstall   # removes the managed symlinks
make relink      # uninstall + install
make check       # report status of each managed link
```

Links created by `make install`:

| Source (in repo)        | Destination                      |
| ----------------------- | -------------------------------- |
| `vimrc`                 | `~/.vimrc`                       |
| `darglint`              | `~/.darglint`                    |
| `init.lua`              | `~/.config/nvim/init.lua`        |
| `configs/yamllint`      | `~/.config/yamllint`             |

`make install` refuses to clobber real files; if any destination exists as a
regular file, that entry is skipped until you remove or back it up.

## Python virtualenv

```sh
cd "$HOME/.vim"
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
```

## Neovim setup

`make install` already symlinks `~/.config/nvim/init.lua`, so Neovim will load
this repo's config directly. Install the Python provider into the system
Python (not the venv above):

```sh
deactivate
pip3 install --user neovim
```

Inside Neovim:

```vim
:Lazy sync
:Mason
```

Restart Neovim and you are good.
