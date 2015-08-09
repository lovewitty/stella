#!/bin/bash
_STELLA_CURRENT_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $_STELLA_CURRENT_FILE_DIR/conf.sh




function usage() {
	echo "USAGE :"
	echo "----------------"
	echo "List of commands"
	echo " o-- application management :"
	echo " L     app init <application name> [--approot=<path>] [--workroot=<abs or relative path to approot>] [--cachedir=<abs or relative path to approot>] [--samples]"
	echo " L     app get-data|get-assets|delete-data|delete-assets|update-data|update-assets|revert-data|revert-assets <data id|assets id>"
	echo " L     app get-data-pack|get-assets-pack|update-data-pack|update-assets-pack|revert-data-pack|revert-assets-pack|delete-data-pack|delete-assets-pack <data pack name|assets pack name>"
	echo " L     app get-feature <all|feature schema> : install all features defined in app properties file or install a matching one"
	echo " L     app setup-env <env id|all> : download, build, deploy and run virtual environment based on app properties"
	echo " L     app link <app-path> [--stellaroot=<path>] : link an app to a specific stella path"
	echo " o-- feature management :"
	echo " L     feature install required : install required features for Stella"
	echo " L     feature install <feature schema> [--depforce] [--depignore] : install a feature. [--depforce] will force to reinstall all dependencies. [--depignore] will ignore dependencies. schema = feature_name[#version][@arch][:binary|source][/os_restriction][\os_exclusion]"
	echo " L     feature remove <feature schema> : remove a feature"
	echo " L     feature list <all|feature name|active> : list all available feature OR available versions of a feature OR current active features"
	echo " o-- various :"
	echo " L     stella api list : list public functions of stella api"
	echo " L     stella bootstrap env : launch a shell with all stella env var setted"
	echo " L     stella install dep : install all features and systems requirements if any, for the current OS ($STELLA_CURRENT_OS)"
	echo " L     stella version print : print stella version"
	echo " L     stella search path : print current system search path"
	echo " o-- network management :"
	echo " L     proxy on <name> : active proxy"
	echo " L     proxy off now : disable proxy"
	echo " L     proxy register <name> --proxyhost=<host> --proxyport=<port> [--proxyuser=<string> --proxypass=<string>] : register this proxy"

}


# MAIN -----------------------------------------------------------------------------------

# arguments
PARAMETERS="
DOMAIN=                          'domain'     		a           'app feature stella proxy'         										   				Action domain.
ACTION=                         'action'   					a           'version search remove on off register link api bootstrap install init get-data get-assets get-data-pack get-assets-pack delete-data delete-data-pack delete-assets delete-assets-pack update-data update-assets revert-data revert-assets update-data-pack update-assets-pack revert-data-pack revert-assets-pack get-feature install list'         	Action to compute.
ID=							 ''								s 			'' 						Feature ID or Data or Assets or Env or Distrib ID.
"
OPTIONS="
FORCE=''                       	'f'    		''            		b     		0     		'1'           			Force operation.
APPROOT=''						'' 			'path'				s 			0			'' 						App path (default current)
WORKROOT='' 					'' 			'path'				s 			0			''						Work app path (default equal to app path)
CACHEDIR=''						'' 			'path'				s 			0			''						Cache folder path
STELLAROOT=''                   ''          'path'              s           0           ''                      Stella path to link.
SAMPLES=''                      ''         ''                  b           0       '1'                     Generate app samples.
PROXYHOST='' 					'' 			'host'				s 			0			''					proxy host
PROXYPORT='' 					'' 			'port'				s 			0			''					proxy port
PROXYUSER='' 					'' 			'user'				s 			0			''					proxy user
PROXYPASS='' 					'' 			'password'			s 			0			''					proxy password
DEPFORCE=''						''    		''            		b     		0     		'1'           			Force reinstallation of all dependencies.
DEPIGNORE=''					''    		''            		b     		0     		'1'           		Will not process any dependencies.
"

__argparse "$0" "$OPTIONS" "$PARAMETERS" "Lib Stella" "$(usage)" "" "$@"


# --------------- APP ----------------------------
if [ "$DOMAIN" == "app" ]; then
	_app_options=
	if [ "$FORCE" == "1" ]; then
		_app_options="$_app_options -f"
	fi
	if [ ! "$APPROOT" == "" ]; then
		_app_options="$_app_options --approot=$APPROOT"
	fi
	if [ ! "$WORKROOT" == "" ]; then
		_app_options="$_app_options --workroot=$WORKROOT"
	fi
	if [ ! "$CACHEDIR" == "" ]; then
		_app_options="$_app_options --cachedir=$CACHEDIR"
	fi
	if [ ! "$STELLAROOT" == "" ]; then
		_app_options="$_app_options --stellaroot=$STELLAROOT"
	fi


	$STELLA_BIN/app.sh $ACTION $ID $_app_options
fi



# --------------- FEATURE ----------------------------
if [ "$DOMAIN" == "feature" ]; then
	_feature_options=
	if [ "$FORCE" == "1" ]; then
		_feature_options="$_feature_options -f"
	fi
	$STELLA_BIN/feature.sh $ACTION $ID $_feature_options

fi



# --------------- PROXY ----------------------------
if [ "$DOMAIN" == "proxy" ]; then
	__init_stella_env
	
	if [ "$ACTION" == "on" ]; then
		__enable_proxy "$ID"
	fi

	if [ "$ACTION" == "off" ]; then
		__disable_proxy
	fi

	if [ "$ACTION" == "register" ]; then
		__register_proxy "$ID" "$PROXYHOST" "$PROXYPORT" "$PROXYUSER" "$PROXYPASS"
	fi
fi

# --------------- STELLA ----------------------------
if [ "$DOMAIN" == "stella" ]; then
	__init_stella_env
	
	if [ "$ACTION" == "api" ]; then
		if [ "$ID" == "list" ]; then
			echo $(__api_list)
		fi
	fi

	if [ "$ACTION" == "bootstrap" ]; then
		if [ "$ID" == "env" ]; then
			__bootstrap_stella_env
		fi
	fi

	if [ "$ACTION" == "install" ]; then
		if [ "$ID" == "dep" ]; then
			__stella_requirement
		fi
	fi

	if [ "$ACTION" == "version" ]; then
		if [ "$ID" == "print" ]; then
			v1=$(__get_stella_flavour)
			v2=$(__get_stella_version)
			echo $v1 -- $v2
		fi
		
	fi


	if [ "$ACTION" == "search" ]; then
	    if [ "$ID" == "path" ]; then
	        echo $(__get_active_path)
	    fi
	fi
fi





echo "** END **"