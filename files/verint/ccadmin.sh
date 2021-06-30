_ccadmin()
{
	local cur
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[$COMP_CWORD-1]}"
	before_prev="${COMP_WORDS[$COMP_CWORD-2]}"


	if [ -z "$CCADMIN_COMPLETION_OPTS" ]; then
		CCADMIN_COMPLETION_OPTS=$(cat "$HOME"/.verint/autocompletion/ccadmin_commands | sed "s/\r//g" )
		export CCADMIN_COMPLETION_OPTS
	fi

	if [ "${prev}" == "ccadmin" ] || [ "${before_prev}" == "ccadmin" ] ; then
		COMPREPLY=( $(compgen -W "${CCADMIN_COMPLETION_OPTS}" -- ${cur}) )
		return 0
	fi
}
complete -o default -F _ccadmin ccadmin
