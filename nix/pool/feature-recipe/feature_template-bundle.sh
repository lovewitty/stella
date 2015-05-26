if [ ! "$_TEMPLATE-BUNDLE_INCLUDED_" == "1" ]; then 
_TEMPLATE-BUNDLE_INCLUDED_=1


function feature_template-bundle() {
	FEAT_NAME=template-bundle
	FEAT_LIST_SCHEMA="1_0_0@x64 1_0_0@x86"
	FEAT_DEFAULT_VERSION=1_0_0
	FEAT_DEFAULT_ARCH=x64

	# should be empty or MERGE or NESTED or LIST
	# NESTED : each item will be installed inside the bundle path in a separate directory
	# MERGE : each item will be installed in the bundle path
	# LIST : this bundle is just a list of item that will be installed normally
	FEAT_BUNDLE=NESTED
}



function feature_template-bundle_1_0_0() {
	#if FEAT_ARCH is not not null, properties FOO_ARCH=BAR will be selected and setted as FOO=BAR
	# if FOO_ARCH is empty, FOO will not be changed

	FEAT_VERSION=1_0_0

	# Dependencies (not yet implemented)
	FEAT_DEPENDENCIES=

	# Properties for bundle
	FEAT_BUNDLE_ITEM=
	FEAT_BUNDLE_ITEM_x86="foo#1_0_0@x86 bar#1_0_0@x86"
	FEAT_BUNDLE_ITEM_x84="foo#1_0_0@x64 bar#1_0_0@x64"

	# callback are list of functions
	# automatic callback each time feature is initialized, to init env var
	FEAT_ENV_CALLBACK=feature_template-bundle_setenv
	# automatic callback after all items in bundle list are installed
	FEAT_BUNDLE_CALLBACK=

	# File to test if feature is installed
	FEAT_INSTALL_TEST=$FEAT_INSTALL_ROOT/bin/template-bundle
	# PATH to add to system PATH
	FEAT_SEARCH_PATH=$FEAT_INSTALL_ROOT/bin

}

function feature_template-bundle_setenv()  {
	TEMPLATE_BUNDLE_HOME=$FEAT_INSTALL_ROOT
	export TEMPLATE_BUNDLE_HOME_HOME
}



fi