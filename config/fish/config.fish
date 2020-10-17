set fish_greeting ''
if test -f ~/.config/fish/config.local.fish
  source ~/.config/fish/config.local.fish
end

# opam configuration
source /home/han/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
