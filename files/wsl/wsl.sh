vimwp(){
	if [ "$#" -ne 1 ]; then
		echo "A window path should be pass in quotes,e.g 'C:\Users\user\Documents\document.txt'"
		return 1
	fi
	vim $(wslpath -u "$1")
}
wowp(){
	if [ "$#" -ne 1 ]; then
		echo "A window path should be pass,e.g 'C:\Users\user\Documents\document.txt'"
		exit 1
	fi
	wsl-open $(wslpath -u "$1")

}
