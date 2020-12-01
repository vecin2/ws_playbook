# Setup fzf
# ---------
#export FZF_DEFAULT_OPTIONS="--extended --color fg:241,bg:230,hl:33,fg+:241,bg+:221,hl+:33 --color info:33,prompt:33,pointer:166,marker:166,spinner:33"
# Setting fd as the default source for fzf
#export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_COMMAND='ag --path-to-ignore ~/.gitignore -g "" --follow'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export MY_BASHRC_VAR="$FZF_DEFAULT_COMMAND"
if [[ ! "$PATH" == */home/dgarcia/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/dgarcia/.fzf/bin"
fi
fzf-binds() {
	printf 'ctrl-e:execute(echo {+} | xargs -o ${EDITOR:-vim})+abort,'
        printf 'ctrl-y:execute-silent(echo {} | xargs echo -n | xclip -selection clipboard),'
        printf 'ctrl-r:execute-silent(realpath {} | xargs echo -n | xclip -selection clipboard)'
}

#export FZF_DEFAULT_OPTS="--bind '$(fzf-binds)'"
export FZF_DEFAULT_OPTS="
        --bind 'ctrl-v:execute(less -K {})'
	--bind 'ctrl-e:execute(vim {} < /dev/tty > /dev/tty)+abort'
        --bind 'ctrl-y:execute-silent(echo {} | xargs echo -n | xclip -selection clipboard)'
        --bind 'ctrl-r:execute-silent(realpath {} | xargs echo -n | xclip -selection clipboard)'"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/dgarcia/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/dgarcia/.fzf/shell/key-bindings.bash"

# fkill - kill process
fkill() {
	local pid
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if [ "x$pid" != "x" ]
	then
		echo $pid | xargs kill -${1:-9}
	fi
}



# Modified version where you can press
#   - CTRL-O or Enter to open with `open` command,
#   - CTRL-E to open with the $EDITOR
#   - CTRL-N or Enter key to navigate in natilus


#fo() {
#	local out file key
#	IFS=$'\n'
# 	out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e,ctrl-n)
#	key=$(head -1 <<< "$out")
#	file=$(head -2 <<< "$out" | tail -1)
#	if [ -n "$file" ]; then
#	 if [ "$key" = ctrl-e ]; then
#		 ${EDITOR:-vim} "$file"
#	 elif [ "$key" = ctrl-n ]; then
#		 nautilus "$file"
#	 else
#		 xdg-open "$file"
#	 fi
#	fi
#}
#bind '"\C-o":"fo\n"'


cf() {
	local file

	file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

	if [[ -n $file ]]
	then
		if [[ -d $file ]]
		then
			cd -- $file
		else
			cd -- ${file:h}
		fi
	fi
}

ft() {
	folder=$(lb | fzf --ansi | awk '{print $2}')
	cd $folder
}

#fg conflicts with 'fg' linux command which bring back a background process
fgr(){
  local file

  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}

fsvn(){
	local paths
	paths=$(svn st | fzf -m | awk '{print $2}')

	if [ "x$paths" != "x" ]
	then
		echo $paths | xargs svn $1
	fi
}
