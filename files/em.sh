export EM_CORE_HOME=/mnt/c/em/projects/hc_prototype
export PRODUCT_HOME=/mnt/c/em/products/agent-desktop_15.3-FP9-HFR_6.2.1
export AD=$EM_CORE_HOME

last_log_path(){
	ADPROCESSLOGS=$EM_CORE_HOME/logs/ad/cre/session/process
	if [ -z "$1" ]
	then
		TAIL=1
	else
		TAIL=$1
	fi

	FILE_NAME=$(ls $ADPROCESSLOGS -ltr | grep process | tail -$TAIL | head -1 | rev | cut -d " " -f1 | rev)

	FULL_PATH=$ADPROCESSLOGS/$FILE_NAME
	echo $FULL_PATH
}
vpl(){
	vim $(last_log_path $1)
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
