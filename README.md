# blurrcat's dotfiles

## Setup

0. get this repo: `git clone https://github.com/blurrcat/dotfiles.git ~/.dotfiles && cd ~/.dotfiles`
1. `./bootstrap/brew.sh` or `./bootstrap/apt.sh` depending on your OS
2. configurations
  2.1 install vim plugins:
    - open vim
    - :PlugInstall
    - restart
  2.2 install tmux plugins:
    - open tmux
    - ctrl-a + I
  2.3 fish: run `fish_config`
3. profit!


References:
- [rcm](https://github.com/thoughtbot/rcm): dotfile management
- [fish](https://fishshell.com/): **F**riendly **I**nteractive **Sh**ell for the 90s
- [neovim](https://neovim.io/): hyperextensible Vim-based text editor
- [vim-plug](https://github.com/junegunn/vim-plug): vim plguin manager
- tmux: terminal multiplexer
  - [guide](https://thoughtbot.com/upcase/tmux)
  - [tmux-plugin-manager](https://github.com/tmux-plugins/tpm)
- [alacritty](https://github.com/alacritty/alacritty): GPU accelerated terminal simulator
