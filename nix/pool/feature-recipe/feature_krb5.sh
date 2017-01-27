if [ ! "$_krb5_INCLUDED_" == "1" ]; then
_krb5_INCLUDED_=1


function feature_krb5() {
	FEAT_NAME=krb5

	FEAT_LIST_SCHEMA="1_15:source"
	FEAT_DEFAULT_VERSION=1_15
	FEAT_DEFAULT_ARCH=
	FEAT_DEFAULT_FLAVOUR="source"


}


function feature_krb5_1_15() {
	FEAT_VERSION=1_15


	FEAT_SOURCE_DEPENDENCIES="openssl#1_0_2d"
	FEAT_BINARY_DEPENDENCIES=

	FEAT_SOURCE_URL=http://web.mit.edu/kerberos/dist/krb5/1.15/krb5-1.15.tar.gz
	FEAT_SOURCE_URL_FILENAME=krb5-1.15.tar.gz
	FEAT_SOURCE_URL_PROTOCOL=HTTP_ZIP

	FEAT_BINARY_URL=
	FEAT_BINARY_URL_FILENAME=
	FEAT_BINARY_URL_PROTOCOL=

	FEAT_SOURCE_CALLBACK=feature_krb5_link
	FEAT_BINARY_CALLBACK=
	FEAT_ENV_CALLBACK=

	FEAT_INSTALL_TEST="$FEAT_INSTALL_ROOT"/bin/kinit
	FEAT_SEARCH_PATH="$FEAT_INSTALL_ROOT"/bin:"$FEAT_INSTALL_ROOT"/sbin

}


function feature_krb5_link() {
	__link_feature_library "openssl#1_0_2d"
}

function feature_krb5_install_source() {
	INSTALL_DIR="$FEAT_INSTALL_ROOT"
	SRC_DIR="$STELLA_APP_FEATURE_ROOT/$FEAT_NAME-$FEAT_VERSION-src"

	__set_toolset "STANDARD"

	__get_resource "$FEAT_NAME" "$FEAT_SOURCE_URL" "$FEAT_SOURCE_URL_PROTOCOL" "$SRC_DIR" "DEST_ERASE STRIP"

	__feature_callback

	AUTO_INSTALL_CONF_FLAG_PREFIX=
	# Tcl is mainly used for test. Using without-tcl disable tests
	AUTO_INSTALL_CONF_FLAG_POSTFIX="--without-tcl"
	AUTO_INSTALL_BUILD_FLAG_PREFIX=
	AUTO_INSTALL_BUILD_FLAG_POSTFIX=

	__auto_build "$FEAT_NAME" "$SRC_DIR/src" "$INSTALL_DIR" "NO_OUT_OF_TREE_BUILD"


}


fi
