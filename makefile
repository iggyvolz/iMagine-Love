release: get-json
	AUTHOR=iggyvolz love-release # See https://github.com/MisterDA/love-release/issues/21
get-json:
	if [[ ! -f json.lua ]];then wget http://regex.info/code/JSON.lua;fi
