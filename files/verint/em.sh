export EM_CORE_HOME=/mnt/c/em/projects/DU/du
# export EM_CORE_HOME=/mnt/c/em/projects/DTO/trunk
# export SQL_TEMPLATES_PATH=/mnt/c/Users/dgarcia/dev/python/sqltask-templates/prj_config/templates
export SQL_TEMPLATES_PATH=C:\\ProgramData\\Verint\\sqltask_templates\\templates

export PRODUCT_HOME=/mnt/c/em/products/agent-desktop_2023R1-HFR_9.1.8
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

	FILE_NAME=$(ls $log_path -ltr | grep $keyword | grep -v WorkRetrieval | grep -v HotUpdate | tail -$TAIL | head -1 | rev | cut -d " " -f1 | rev)

	FULL_PATH=$log_path/$FILE_NAME
	echo $FULL_PATH
}
vpl(){
	vim $(last_process_log_path $1)
}
tpl(){
	cd $EM_CORE_HOME/logs/ad/cre/session
}
val(){
	vim $(last_application_log_path $1)
}

scanlogs(){
	dir=$EM_CORE_HOME/logs

	find $dir -type f -exec stat --format '%Y :%y %n' "{}" \; | sort -nr | cut -d: -f2- | head -n 25
}

ccadmin(){
	#cmd.exe wslpath -w "${EM_CORE_HOME}/bin/ccadmin.bat" "$@" &
	cwd=$(pwd)
	cd "${EM_CORE_HOME}/bin"
	./ccadmin.bat "$@" | cat
	cd $cwd
}
ad_kill(){
	dir='C:\ProgramData\Verint\ps_scripts\kill_ad_java.ps1'
	powershell.exe -executionpolicy bypass -F $dir
}
ad_restart(){
	ad_kill
	ccadmin start-appserver -Dcontainer.name=ad
}
ced_kill(){
	dir='C:\ProgramData\Verint\ps_scripts\kill_ced_java.ps1'
	powershell.exe -executionpolicy bypass -F $dir
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
recreate_em_app(){
	if [ "$#" -ne 1 ]; then
		echo "Container.name is required as parameter"
		exit 1
	fi
	ad_kill
	ccadmin create-single-app -Dapplication.name="$1"
	ccadmin recreate-container -Dcontainer.name="$1"
	ccadmin start-appserver -Dcontainer.name="$1"
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
	if [ ! -f "${completion_file_location}" ]; then
		echo "Generating ccadmin options"...
		ccadmin | grep echo | awk '{print $3}' >"$completion_file_location"
		echo Completion file created at $completion_file_location
		echo Run ccadmin and hit tab to see autocompletion
	else
		echo Completions file already exist.
		echo "If you want to recreate completions, remove file ${completion_file_location} and run this command again."
	fi
}

