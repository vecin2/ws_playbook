# Setup fzf
# ---------
if [[ ! "$PATH" == */home/vagrant/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/vagrant/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/vagrant/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/vagrant/.fzf/shell/key-bindings.bash"
