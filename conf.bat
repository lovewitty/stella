REM TODO : enabled local ?
if "!__STELLA_CONFIGURED__!"=="TRUE" goto :eof

set _STELLA_CONF_CURRENT_FILE_DIR=%~dp0
set _STELLA_CONF_CURRENT_FILE_DIR=%_STELLA_CONF_CURRENT_FILE_DIR:~0,-1%
if "%STELLA_CURRENT_RUNNING_DIR%"=="" set STELLA_CURRENT_RUNNING_DIR=%cd%


:: PATHS
set STELLA_ROOT=%_STELLA_CONF_CURRENT_FILE_DIR%
set STELLA_COMMON=%STELLA_ROOT%\win\common
set STELLA_POOL=%STELLA_ROOT%\win\pool
set STELLA_BIN=%STELLA_ROOT%\win\bin
set STELLA_FEATURE_RECIPE=%STELLA_POOL%\feature-recipe
set STELLA_ARTEFACT=%STELLA_POOL%\artefact
set STELLA_APPLICATION=%STELLA_ROOT%\app
set STELLA_TEMPLATE=%STELLA_POOL%\template

:: URL
set STELLA_URL=http://stella.sh
set STELLA_POOL_URL=%STELLA_URL%/pool
set STELLA_ARTEFACT_URL=%STELLA_POOL_URL%/win/artefact
set STELLA_FEATURE_RECIPE_URL=%STELLA_POOL_URL%/win/feature-recipe
set STELLA_DIST_URL=%STELLA_URL%/dist



:: GATHER PLATFORM INFO  -------------
call %STELLA_COMMON%\platform.bat :set_current_platform_info

:: GATHER CURRENT APP INFO  -------------
set STELLA_APP_PROPERTIES_FILENAME=stella.properties
set STELLA_APP_NAME=

if "%STELLA_APP_ROOT%"=="" (
	set STELLA_APP_ROOT=%STELLA_CURRENT_RUNNING_DIR%
)

call %STELLA_COMMON%\common-app.bat :select_app "_STELLA_APP_PROPERTIES_FILE"
call %STELLA_COMMON%\common-app.bat :get_all_properties !_STELLA_APP_PROPERTIES_FILE!

if "%STELLA_APP_NAME%"=="" (
	set STELLA_APP_NAME=stella
)

:: APP PATH
call %STELLA_COMMON%\common.bat :rel_to_abs_path "STELLA_APP_ROOT" "%STELLA_APP_ROOT%" "%STELLA_CURRENT_RUNNING_DIR%"

if "%STELLA_APP_WORK_ROOT%"=="" (
	set STELLA_APP_WORK_ROOT=%STELLA_APP_ROOT%\workspace
)
call %STELLA_COMMON%\common.bat :rel_to_abs_path "STELLA_APP_WORK_ROOT" "%STELLA_APP_WORK_ROOT%" "%STELLA_APP_ROOT%"

if "%STELLA_APP_CACHE_DIR%"=="" (
	set STELLA_APP_CACHE_DIR=%STELLA_APP_ROOT%\cache
)
call %STELLA_COMMON%\common.bat :rel_to_abs_path "STELLA_APP_CACHE_DIR" "%STELLA_APP_CACHE_DIR%" "%STELLA_APP_ROOT%"


set STELLA_APP_TEMP_DIR=%STELLA_APP_WORK_ROOT%\temp
set STELLA_APP_FEATURE_ROOT=%STELLA_APP_WORK_ROOT%\feature_%STELLA_CURRENT_PLATFORM_SUFFIX%\%STELLA_CURRENT_OS%
set ASSETS_ROOT=%STELLA_APP_WORK_ROOT%\assets
call %STELLA_COMMON%\common.bat :rel_to_abs_path "ASSETS_REPOSITORY" "..\assets_repository" "%STELLA_APP_WORK_ROOT%"


:: for internal features
set STELLA_INTERNAL_WORK_ROOT=%STELLA_ROOT%\workspace
set STELLA_INTERNAL_FEATURE_ROOT=%STELLA_INTERNAL_WORK_ROOT%\feature_%STELLA_CURRENT_PLATFORM_SUFFIX%\%STELLA_CURRENT_OS%
set STELLA_INTERNAL_CACHE_DIR=%STELLA_ROOT%\cache
set STELLA_INTERNAL_TEMP_DIR=%STELLA_INTERNAL_WORK_ROOT%\temp

:: OTHERS ---------------------------------------------
set FEATURE_LIST_ENABLED=
set VERBOSE_MODE=0
set "WGET=wget.exe"
set "UZIP=unzip.exe"
set "SEVENZIP=7z.exe"
set "GIT=git"
set "HG=hg"
set "MVN=mvn"
set "CURL=curl"
set "NPM=npm"

:: VIRTUALIZATION ----------------------
set "VIRTUAL_WORK_ROOT=%STELLA_APP_WORK_ROOT%\virtual"
set "VIRTUAL_TEMPLATE_ROOT=%VIRTUAL_WORK_ROOT%\template"
set "VIRTUAL_ENV_ROOT=%VIRTUAL_WORK_ROOT%\env"

set "VIRTUAL_INTERNAL_ROOT=%STELLA_ROOT%\common\virtual"
set "VIRTUAL_INTERNAL_TEMPLATE_ROOT=%VIRTUAL_INTERNAL_ROOT%\template"
set "VIRTUAL_CONF_FILE=%VIRTUAL_INTERNAL_ROOT%\virtual.ini"

set PACKER_CMD=packer
set VAGRANT_CMD=vagrant

set "PACKER_STELLA_APP_CACHE_DIR=%STELLA_APP_CACHE_DIR%"

:: choose a default hypervisor for packer and vagrant
:: vmware or virtualbox
set VIRTUAL_DEFAULT_HYPERVISOR=virtualbox


:: INTERNAL LIST ---------------------------------------------
set "__STELLA_FEATURE_LIST=git docker-swarm socat nginx mingw-w64 go-build-chain go-crosscompile-chain go docker-bundle docker-client docker-machine oracle-jdk maven spark nikpeviewer dependencywalker conemu goconfig-cli ninja jom cmake packer perl ruby rubydevkit nasm python vagrant openssh wget unzip sevenzip patch gnumake"

:: API ---------------------------------------------
set "STELLA_API_COMMON_PUBLIC=get_active_path uncompress trim argparse is_path_abs get_resource delete_resource update_resource revert_resource download_uncompress del_folder copy_folder_content_into fork run_admin mercurial_project_version git_project_version"
set "STELLA_API_API_PUBLIC=api_connect api_disconnect"
set "STELLA_API_APP_PUBLIC=get_app_property link_app get_data get_assets get_data_pack get_assets_pack delete_data delete_data_pack delete_assets delete_assets_pack update_data update_assets revert_data revert_assets update_data_pack update_assets_pack revert_data_pack revert_assets_pack get_feature get_features"
set "STELLA_API_FEATURE_PUBLIC=feature_remove feature_catalog_info feature_install feature_install_list feature_init list_active_features feature_reinit_installed feature_inspect"
set "STELLA_API_BUILD_PUBLIC=is_import_or_static_lib"
set "STELLA_API_PLATFORM_PUBLIC=require"

set "STELLA_API=%STELLA_COMMON%\common-api.bat :api_proxy+"


set "__STELLA_CONFIGURED__=TRUE"
