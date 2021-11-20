export EM_CORE_HOME=/mnt/c/em/projects/highmark
export PRODUCT_HOME=/mnt/c/em/products/agent-desktop_15.3-2021R2_7.2.0
export AD=$EM_CORE_HOME

last_process_log_path(){
	tail_number=$1
	log_path=$EM_CORE_HOME/logs/ad/cre/session/process
	keyword=process
	get_last_modified_files_at_path $log $keyword $tail_number
}
last_application_log_path(){
	tail_number=$1
	log_path=$EM_CORE_HOME/logs/ad/cre/session/application
	keyword=application
	get_last_modified_files_at_path $log $keyword $tail_number
}
get_last_modified_files_at_path(){
	log=$1
	application=$2
	if [ -z "$3" ]
	then
		TAIL=1
	else
		TAIL=$3
	fi

	FILE_NAME=$(ls $log_path -ltr | grep $keyword | tail -$TAIL | head -1 | rev | cut -d " " -f1 | rev)

	FULL_PATH=$log_path/$FILE_NAME
	echo $FULL_PATH
}
vpl(){
	vim $(last_process_log_path $1)
}
val(){
	vim $(last_application_log_path $1)
}
ccadmin(){
	cmd.exe wslpath -w "${EM_CORE_HOME}/bin/ccadmin.bat" "$@" &
}
ad_kill(){
	dir='C:\ProgramData\Verint\powershell\kill_ad_java.ps1'
	powershell.exe -F $dir
}
ad_restart(){
	ad_kill
	ccadmin start-appserver -Dcontainer.name=ad
}
ced_kill(){
	dir='C:\ProgramData\Verint\powershell\kill_ced_java.ps1'
	powershell.exe -F $dir
}
ced_restart(){
	ced_kill
	ccadmin ced
}
show_config(){
	cmd.exe wslpath -w "${EM_CORE_HOME}/bin/ccadmin.bat" show-config
	wsl-open $EM_CORE_HOME/work/config/show-config-html/index.html
}
validate_config(){
	cmd.exe wslpath -w "${EM_CORE_HOME}/bin/ccadmin.bat" validate-config
	wsl-open $EM_CORE_HOME/work/config/validate-config/validate-config.csv
}
install_ccadmin_autocompletion(){

	if [ -z $EM_CORE_HOME ]; then
		echo Global variable EM_CORE_HOME has not been set. Please set it before install it.
		exit
	else
		sudo ln -sfv ~/dotfiles/em/ccadmin.sh /etc/bash_completion.d/ccadmin
	fi
	completion_file_location="${EM_CORE_HOME}/.em/autocompletion/ccadmin_completion"
	if [ ! -f "$completion_file_location" ]; then
		echo "Generating ccadmin options"...
		options=$("${EM_CORE_HOME}"/bin/ccadmin.sh | grep echo | awk '{print $3}')
		echo $options
		mkdir -p "${EM_CORE_HOME}/.em/autocompletion"
		echo "$options"	>"$completion_file_location"
	fi
}

find_jar_by_classname(){
	find . -name '*.jar' -exec grep -Hls $1 {} \;
}
custdiff(){
	prj_path=$(fzf)
	full_prj_path=$(pwd)/"${prj_path}"

	classpath="${full_prj_path##*/repository/default/}"

	query="${classpath##PC}" #remove project prefix from path


	product_path="${PRODUCT_HOME}"/repository/default

	full_product_path=$(find "${product_path}" | fzf -q "${query}")


	if [ -f  "${full_prj_path}" ] && [ -f "${full_product_path}" ]; then
		echo Comparing "${full_prj_path}" with "${full_product_path}"
		vimdiff "${full_prj_path}" "${full_product_path}"
	fi


}
install_ccadmin_autocompletion(){
	if [ -z $EM_CORE_HOME ]; then
		echo Global variable EM_CORE_HOME has not been set. Please set it before install it.
		exit
	else
		sudo ln -sfv $HOME/.verint/autocompletion/ccadmin.sh /etc/bash_completion.d/ccadmin
	fi
	completion_file_location="${HOME}/.verint/autocompletion/ccadmin_commands"
	if [ ! -f "$completion_file_location" ]; then
		echo "Generating ccadmin options"...
		options=$(ccadmin | grep echo | awk '{print $3}')
		echo $options
		echo "$options"	>"$completion_file_location"
	fi
}