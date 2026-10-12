set -gx BAT_CONFIG_PATH $HOME/.batrc
set -gx N_PREFIX $HOME/n
set -gx PROJECT_HOME $HOME/workspace
set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc
set -gx SHELL /usr/bin/fish
# Keep per-command wrappers ahead of globally installed npm executables.
fish_add_path ~/.npm-global/bin
fish_add_path ~/.cache/rebar3/bin
fish_add_path ~/.local/bin
