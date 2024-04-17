#configurable vars
export EM_CORE_HOME=/mnt/c/em/projects/sgroup/2024_Upgrade
export SQL_TEMPLATES_PATH=C:\\ProgramData\\Verint\\sqltask_templates\\templates
export PRODUCT_HOME=/mnt/c/em/products/agent-desktop_2023R4-HFR_9.4.5
export OLD_PRODUCT_HOME=/mnt/c/em/products/agent-desktop_15.3-2021R4-HFR_7.4.4
export PROJECT_PREFIX="SGroup"


dbtype=sqlserver #oracle

#Start EM functions
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
	if [ "$#" -eq 1 ];
	then
		no_of_files=$1
	else
		no_of_files=25
	fi
	dir=$EM_CORE_HOME/logs

	find $dir -type f -exec stat --format '%Y :%y %n' "{}" \; | sort -nr | cut -d: -f2- | head -n $no_of_files
}

ccadmin(){
	cmd.exe wslpath -w "${EM_CORE_HOME}/bin/ccadmin.bat" "$@" | cat
	# cwd=$(pwd)
	# cd "${EM_CORE_HOME}/bin"
	# ./ccadmin.bat "$@" | cat
	# cd $cwd
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
diffrepofile(){
	prj_path=$(fzf)
	full_prj_path=$(pwd)/"${prj_path}"

	classpath="${full_prj_path##*/repository/default/}"

	query="${classpath#"$PROJECT_PREFIX"}" #remove project prefix from path


	product_path="${product_home}"/repository/default

	full_product_path=$(find "${product_path}" | fzf -q "${query}")


	if [ -f  "${full_prj_path}" ] && [ -f "${full_product_path}" ]; then
		echo Comparing "${full_prj_path}" with "${full_product_path}"
		vimdiff "${full_prj_path}" "${full_product_path}"
	fi
}
function three_way_file_merge_usage {
    echo ""
    echo "Allows comparing files from EM project, EM product and EM old product"
    echo ""
    echo "usage: $0 --directory string --force-copy --line-regex string"
    echo ""
    echo "  -d  string  name of the service"
    echo "              (example: config)"
    echo "  -f	flag    override file in merge folder"
    echo "  -r  string  Removes all lines that do no match this regex"
		echo "              (example: policy)"
    echo ""
}
three_way_file_merge(){
	local project_top_folder=""
	local force_copy=""
	local line_regex=""
	local invalid_param=""
		
	while getopts ":d:f:r:" opt; do
		case $opt in
			d) project_top_folder=$OPTARG;;
			f) force=true;;
			r) line_regex=$OPTARG;;
			\?) usage
					return 1;;
		esac
	done
	three_way_finder $project_top_folder
	if [ -z "${project_file_path}" ]; then
		return 1
	fi
	if [ -z "${product_file_path}" ]; then
		return 1
	fi
	merge_folder=$EM_CORE_HOME/"merge"
	merge_subfolders=$(dirname ${project_file_path#"$EM_CORE_HOME/"})
	merge_path=$merge_folder/$merge_subfolders

	otb_file_prefix=$([ -z "$line_regex" ] && echo "otb_" || echo "otb_"$line_regex"_") 
	merge_otb_file=$merge_path/"$otb_file_prefix"$(basename $product_file_path)
	copy_file_if_not_exist "$product_file_path" "$merge_otb_file" "$force"

	project_file_prefix=$([ -z "$line_regex" ] && echo "project_" || echo "project_"$line_regex"_") 
	merge_project_file=$merge_path/"$project_file_prefix"$(basename $product_file_path)
	copy_file_if_not_exist "$project_file_path" "$merge_project_file" "$force"

	product_relative_path=${product_file_path#"$PRODUCT_HOME/"}
	oldotb_file_prefix=$([ -z "$line_regex" ] && echo "oldotb_" || echo "oldotb_"$line_regex"_") 
	merge_oldotb_file=$merge_path/"$oldotb_file_prefix"$(basename $product_file_path)
	copy_file_if_not_exist "$OLD_PRODUCT_HOME"/"$product_relative_path" "$merge_oldotb_file" "$force"

	if [ ! -z "$line_regex" ]; then
		 sed -i "/$line_regex/!d" "$merge_otb_file"
		 sed -i "/$line_regex/!d" "$merge_project_file"
		 sed -i "/$line_regex/!d" "$merge_oldotb_file"
	fi

	kvim -d "$merge_otb_file" "$merge_oldotb_file" "$merge_project_file"
}
copy_file_if_not_exist(){
	if [[ $# -ne 2 && $# -ne 3 ]]; then
		return 1
	fi
	src_file=$1
	dst_file=$2
	force_copy=$3
	

	if [[ ! -f "${dst_file}" || "$force_copy" ]]; then
		echo Creating "$dst_file"
		echo mkdir -p $(dirname "$dst_file")
		mkdir -p $(dirname "$dst_file")
		echo "$src_file" copied to "$dst_file"
		cp "$src_file" "$dst_file"
	fi
}

three_way_finder(){
	if [ $# -eq 1 ]; then
		project_top_folder=$1
	else
		project_top_folder=""
	fi
	# prj_path=$(fzf)
	fzf_path=${EM_CORE_HOME}/$project_top_folder
	project_file_path=$(fd . $fzf_path | fzf)

	query=$(basename "$project_file_path") #query fzf using the file name on the same top folder

	fzf_product_path="${PRODUCT_HOME}"/$project_top_folder

	if [ -z "${project_file_path}" ]; then
		return 1
	fi
	product_file_path=$(fd . "${fzf_product_path}" | fzf -q "${query}")
	#
	#
	# if [ -f  "${full_prj_path}" ] && [ -f "${full_product_path}" ]; then
	# 	echo Comparing "${full_prj_path}" with "${full_product_path}"
	# 	vimdiff "${full_prj_path}" "${full_product_path}"
	#fi
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
snapshot_db(){
	dst=$(realpath $EM_CORE_HOME/../docker/snapshots)
	if [ $# -ne 2 ]; then
		echo "Usage:"
		echo "snapshot_db <<container_name>> <<snapshot_file_name>> (extension will be appended, do not include)"
		echo -e "\nWhere container_name must be one of these: "
		echo $(ls /opt/docker/$dbtype)
		echo -e "\nFile will be created under "${dst}" and \".tar.gz\" will be appended"
		echo 'current files under that folder'
		echo $(ls ${dst})
		return 1
	fi
	container_name=$1
	snapshot_file_name=$2
	echo "Stopping container ${container_name}"
	docker container stop ${container_name}
	dest_file="${dst}"/"${snapshot_file_name}".tar.gz
	if test -f "$dest_file"; then
		echo "$dest_file exists creating a backup"
		cp $dest_file $dest_file".backup"
	else
		echo "File did not exist - will create one"
	fi
	current_path=$(pwd)
	cd /opt/docker/$dbtype
	sudo tar -czvf ${dest_file} ${container_name}
	echo "${dst}/${2}.tar.gz" has been created
	echo "Starting container ${container_name}"
	docker container start ${container_name}
	cd $current_path
}

restore_db_snapshot_and_upgrade_db(){
	sudo echo "" #so we dont to wait for authentication
	restore_db_snapshot "$@"
	echo Waiting for DB to start before running upgrade-database
	sleep 10 
	ccadmin upgrade-database
	#ccadmin  import-data -Dcontainer.name=ad -DimportLocation=c:\\em\\projects\\DUO\\trunk\\migration\\migration-2024_03_04_14_44_33_016.jar
}

restore_db_snapshot(){

	snapshots_path=$(realpath $EM_CORE_HOME/../docker/snapshots)
	if [ $# -ne 3 ]; then
		echo "Usage:"
		echo "restore_snapshot <<container_name>> <<file_name>> <<portname>>"
		echo -e "\nWhere container_name must be one of these: "
		echo $(ls /opt/docker/$dbtype)
		echo -e "\nFile will be created under \"${snapshots_path}\""
		echo 'current files under that folder'
		echo $(ls ${snapshots_path})
		echo -e "\nAnd Port is typically 1521,1522..."
		return 1
	fi
	container_name=$1
	snapshot_file_name=$2
	port=$3



	echo "Stopping docker container"
	docker container stop $container_name

	echo "Deleting docker container"
	docker container rm $container_name

	echo "Remove container data /opt/docker/$dbtype/$container_name"
	sudo rm -rf /opt/docker/$dbtype/$container_name


#create container with backup data
echo "Recreating container $container_name from image ${snapshots_path}/${snapshot_file_name}"
/home/dgarcia/dev/docker/mydocker-cmds/${dbtype}19/run_container_from_tar.sh $container_name $port ${snapshots_path}/${snapshot_file_name}
echo "Starting container " $container_name
docker start $container_name
}

upgrade_patches(){
	if [ "$#" -ne 1 ]; then
		echo "Usage $0 <<version_number>>, e.g. $0 9.1.4"
		return 1
	fi
	#create new product.version file
	curdir=$(pwd)
	mkdir -p /tmp/META-INF
	echo "$1" > /tmp/META-INF/product.version
	cd /tmp
	for file in $EM_CORE_HOME/patches/*.zip
	do
		zip -u "$file" META-INF/product.version
	done
	rm -rf /tmp/META-INF
	cd "$curdir"
}
upgrade_migration_jars(){
	if [ "$#" -ne 1 ]; then
		echo "Usage $0 <<version_number>>, e.g. $0 9.1.4"
		return 1
	fi
	version=$1

	for migration_jar in $EM_CORE_HOME/migration/*.jar; do
		# unzip migration_jar -d 
		# echo $migration_jar
		dest_folder=${migration_jar%.*}
		echo unzip $migration_jar -d $dest_folder
		unzip $migration_jar -d $dest_folder
		find $dest_folder -type f -exec sed -i "s/\"VERSION\" : \".*\",/\"VERSION\" : \"$version\",/" {} +
		jar_filename=$(basename $migration_jar)
		echo "(cd $dest_folder && zip -r ../$jar_filename)"

		(cd $dest_folder && zip -r --freshen ../$jar_filename .)
		echo rm -r $dest_folder
		rm -r $dest_folder
	done
}
