starship init fish | source
set -U fish_greeting ''

set PATH $PATH /home/cbxcvl/.local/bin

set -U fish_user_paths /home/cbxcvl/.pdtm/go/bin $fish_user_paths

set -x QT_QPA_PLATFORMTHEME qt5ct

set -x HYPRSHOT_DIR /home/cbxcvl/Pictures/Screenshots/

set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

alias ls='exa --icons'
alias ll='exa -l --icons'
alias la='exa -la --icons'
alias lt='exa -T --icons'
alias tree='exa -T --icons'
alias bat='bat --style=auto'
alias cc='clear'

function reload_starship
    source ~/.config/fish/config.fish
end
