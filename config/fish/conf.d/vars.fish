set -Ux BAT_CONFIG_PATH $HOME/.batrc
set -Ux DOKKU_HOST seattle.blurrcat.net
set -Ux WORKO_HOME $HOME/.virtualenvs
set -Ux N_PREFIX $HOME/n
set -Ux PROJECT_HOME $HOME/workspace
set -Ux BROWSER lynx
set -Ux EDITOR vim
set -Ux RIPGREP_CONFIG_PATH $HOME/.ripgreprc
# PATH
set -Ux fish_user_paths $N_PREFIX/bin $fish_user_paths
