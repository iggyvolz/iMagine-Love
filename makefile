release: get-json
	love-release -MWL -a iggyvolz -t iMagine # See https://github.com/MisterDA/love-release/issues/21
get-json:
	if [[ ! -f json.lua ]];then wget http://regex.info/code/JSON.lua;fi
