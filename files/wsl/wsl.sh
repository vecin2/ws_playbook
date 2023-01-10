vimwp(){
	if [ "$#" -ne 1 ]; then
		echo "A window path should be pass,e.g C:\Users\user\Documents\document.txt"
		exit 1
	fi
	vim $(wslpath -u "$1")
}
