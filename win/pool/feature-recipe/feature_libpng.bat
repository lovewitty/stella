@echo off
call %*
goto :eof

:feature_libpng
	set "FEAT_NAME=libpng"
	set "FEAT_LIST_SCHEMA=1_6_18:source"
	set "FEAT_DEFAULT_VERSION=1_6_18"
	set "FEAT_DEFAULT_ARCH="
	set "FEAT_DEFAULT_FLAVOUR=source"
goto :eof


:feature_libpng_1_6_18
	set "FEAT_VERSION=1_6_18"
	set "FEAT_SOURCE_DEPENDENCIES=zlib#1_2_8"
	set FEAT_BINARY_DEPENDENCIES=

	set "FEAT_SOURCE_URL=http://download.sourceforge.net/libpng/lpng1618.zip"
	set "FEAT_SOURCE_URL_FILENAME=lpng1618.zip"
	set "FEAT_SOURCE_URL_PROTOCOL=HTTP_ZIP"
	
	set FEAT_BINARY_URL=
	set FEAT_BINARY_URL_FILENAME=
	set FEAT_BINARY_URL_PROTOCOL=
	
	set "FEAT_SOURCE_CALLBACK=feature_libpng_link"
	set FEAT_BINARY_CALLBACK=
	set FEAT_ENV_CALLBACK=

	set "FEAT_INSTALL_TEST=!FEAT_INSTALL_ROOT!\bin\libpng16.dll"
	set "FEAT_SEARCH_PATH=!FEAT_INSTALL_ROOT!\bin"	

goto :eof

:feature_libpng_link
	call %STELLA_COMMON%\common-build.bat :link_feature_library "zlib#1_2_8" "FORCE_DYNAMIC LIBS_NAME z"
goto :eof

:feature_libpng_install_source
	set "INSTALL_DIR=!FEAT_INSTALL_ROOT!"
	set "SRC_DIR=!STELLA_APP_FEATURE_ROOT!\!FEAT_NAME!-!FEAT_VERSION!-src"
	
	call %STELLA_COMMON%\common-build.bat :set_toolset "MS"
	

	call %STELLA_COMMON%\common.bat :get_resource "!FEAT_NAME!" "!FEAT_SOURCE_URL!" "!FEAT_SOURCE_URL_PROTOCOL!" "!SRC_DIR!" "STRIP"	

	set "AUTO_INSTALL_CONF_FLAG_POSTFIX="
	set "AUTO_INSTALL_BUILD_FLAG_POSTFIX="
	

	call %STELLA_COMMON%\common-feature.bat :feature_callback

	call %STELLA_COMMON%\common-build.bat :auto_build "!FEAT_NAME!" "!SRC_DIR!" "!INSTALL_DIR!"

goto :eof



