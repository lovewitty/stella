if [ ! "$_CMATRIX_INCLUDED_" == "1" ]; then 
_CMATRIX_INCLUDED_=1

# darwin -- OK -- 20151012


feature_cmatrix() {
	FEAT_NAME=cmatrix
	FEAT_LIST_SCHEMA="1_2a:source"
	FEAT_DEFAULT_VERSION=1_2a
	FEAT_DEFAULT_ARCH=
	FEAT_DEFAULT_FLAVOUR="source"
}

feature_cmatrix_1_2a() {
	FEAT_VERSION=1_2a

	FEAT_SOURCE_DEPENDENCIES=
	FEAT_BINARY_DEPENDENCIES=

	FEAT_SOURCE_URL=http://www.asty.org/cmatrix/dist/cmatrix-1.2a.tar.gz
	FEAT_SOURCE_URL_FILENAME=cmatrix-1.2a.tar.gz
	FEAT_SOURCE_URL_PROTOCOL=HTTP_ZIP

	FEAT_BINARY_URL=
	FEAT_BINARY_URL_FILENAME=
	FEAT_BINARY_URL_PROTOCOL=

	FEAT_SOURCE_CALLBACK=
	FEAT_BINARY_CALLBACK=
	FEAT_ENV_CALLBACK=

	FEAT_INSTALL_TEST="$FEAT_INSTALL_ROOT"/bin/cmatrix
	FEAT_SEARCH_PATH="$FEAT_INSTALL_ROOT"/bin
}



feature_cmatrix_install_source() {
	INSTALL_DIR="$FEAT_INSTALL_ROOT"
	SRC_DIR="$STELLA_APP_FEATURE_ROOT/$FEAT_NAME-$FEAT_VERSION-src"
	
	__get_resource "$FEAT_NAME" "$FEAT_SOURCE_URL" "$FEAT_SOURCE_URL_PROTOCOL" "$SRC_DIR" "DEST_ERASE STRIP"

	#__set_toolset "CUSTOM" "CONFIG_TOOL configure BUILD_TOOL make"
	__set_toolset "STANDARD"

	AUTO_INSTALL_CONF_FLAG_PREFIX=
	AUTO_INSTALL_CONF_FLAG_POSTFIX=
	AUTO_INSTALL_BUILD_FLAG_PREFIX=
	AUTO_INSTALL_BUILD_FLAG_POSTFIX=

	__auto_build "$FEAT_NAME" "$SRC_DIR" "$INSTALL_DIR"

}


fi