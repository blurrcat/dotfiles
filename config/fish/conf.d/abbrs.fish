if status --is-interactive
    abbr -a -U dokku $HOME/lib/dokku/contrib/dokku_client.sh
    abbr -a -U ddgr ddgr -n 7
    abbr -a -U tmux tmux -2
    abbr -a -U ta tmux attach -d -t
    abbr -a -U tls tmux ls
    abbr -a -U venv python3 -m venv
    abbr -a -U xclip xclip -sel clip
    abbr -a -U v source ~/.virtualenvs/(pwd | string split '/' | tail -n1)/bin/activate
    abbr -a -U cmark cmark-gfm
end
