@echo off
call %*
goto :eof


REM DISTRIB/OS/PLATFORM INFO ---------------------------

REM NOTE :
REM classification :
REM 	platform <--- os <---- distrib
REM 		example :
REM			linux <----- ubuntu <---- ubuntu 14.04
REM			linux <----- centos <---- centos 6
REM			windows <--- windows <---- windows 7
REM suffix platform :
REM 	each platform have a suffix
REM		example :
REM			windows <---> win
REM			linux <---> linux

:get_os_from_distro
	set _return_var=%~1
	set _distro=%~2

	set "%_return_var%=unknown"

	call %STELLA_COMMON%\common.bat :match_exp "indows.*" "%_distro%"
	if "!_match_exp!"=="TRUE" (
		set "%_return_var%=windows"
		goto :eof
	)

	call %STELLA_COMMON%\common.bat :match_exp "buntu.*" "%_distro%"
	if "!_match_exp!"=="TRUE" (
		set "%_return_var%=ubuntu"
		goto :eof
	)

	call %STELLA_COMMON%\common.bat :match_exp "ebian.*" "%_distro%"
	if "!_match_exp!"=="TRUE" (
		set "%_return_var%=debian"
		goto :eof
	)

	call %STELLA_COMMON%\common.bat :match_exp "archlinux.*" "%_distro%"
	if "!_match_exp!"=="TRUE" (
		set "%_return_var%=archlinux"
		goto :eof
	)

	call %STELLA_COMMON%\common.bat :match_exp "boot2docker.*" "%_distro%"
	if "!_match_exp!"=="TRUE" (
		set "%_return_var%=linuxgeneric"
		goto :eof
	)

	call %STELLA_COMMON%\common.bat :match_exp "Mac OS X.*" "%_distro%"
	if "!_match_exp!"=="TRUE" (
		set "%_return_var%=macos"
		goto :eof
	)

	call %STELLA_COMMON%\common.bat :match_exp "macos.*" "%_distro%"
	if "!_match_exp!"=="TRUE" (
		set "%_return_var%=macos"
		goto :eof
	)

	call %STELLA_COMMON%\common.bat :match_exp "Red Hat Enterprise Linux" "%_distro%"
	if "!_match_exp!"=="TRUE" (
		set "%_return_var%=rhel"
		goto :eof
	)

goto :eof



:get_platform_from_os
	set _return_var=%~1
	set _os=%~2


	set "%_return_var%=unknown"

	if "!_os!"=="windows" (
		set "%_return_var%=windows"
		goto :eof
	)

	if "!_os!"=="centos" (
		set "%_return_var%=linux"
		goto :eof
	)

	if "!_os!"=="centos" (
		set "%_return_var%=linux"
		goto :eof
	)

	if "!_os!"=="archlinux" (
		set "%_return_var%=linux"
		goto :eof
	)

	if "!_os!"=="ubuntu" (
		set "%_return_var%=linux"
		goto :eof
	)


	if "!_os!"=="debian" (
		set "%_return_var%=linux"
		goto :eof
	)

	if "!_os!"=="linuxgeneric" (
		set "%_return_var%=linux"
		goto :eof
	)

	if "!_os!"=="macos" (
		set "%_return_var%=darwin"
		goto :eof
	)

goto :eof



:get_platform_suffix
	set _return_var=%~1
	set _platform=%~2

	set "%_return_var%=unknown"


	if "!_platform!"=="windows" (
		set "%_return_var%=win"
		goto :eof
	)

	if "!_platform!"=="linux" (
		set "%_return_var%=linux"
		goto :eof
	)

	if "!_platform!"=="darwin" (
		set "%_return_var%=darwin"
		goto :eof
	)
goto :eof



:: TODO : TO FINISH see nix version
:set_current_platform_info

	REM alternative https://support.microsoft.com/fr-fr/kb/556009
	if "!PROCESSOR_ARCHITECTURE!"=="x86" (
		set "STELLA_CPU_ARCH=32"
		set "STELLA_KERNEL_ARCH=32"
	)

	if "!PROCESSOR_ARCHITECTURE!"=="AMD64" (
		set "STELLA_CPU_ARCH=64"
		set "STELLA_KERNEL_ARCH=64"
	)


	set "STELLA_NB_CPU=!NUMBER_OF_PROCESSORS!"

	call :get_os_from_distro "STELLA_CURRENT_OS" "windows"
	call :get_platform_from_os "STELLA_CURRENT_PLATFORM" "%STELLA_CURRENT_OS%"
	call :get_platform_suffix "STELLA_CURRENT_PLATFORM_SUFFIX" "%STELLA_CURRENT_PLATFORM%"
goto :eof


REM REQUIREMENTS STELLA -------------

:ask_install_requirements
	set /p input="Do you wish to auto-install requirements for stella ? [Y/n] "
	if not "%input%"=="n" (
		call :__stella_requirement
		@echo off
	)
goto :eof

:__stella_requirement
	call %STELLA_COMMON%\common-feature.bat :feature_install unzip#5_51_1 "HIDDEN INTERNAL"
	call %STELLA_COMMON%\common-feature.bat :feature_install wget#1_17_1_INTERNAL@x86:binary "HIDDEN INTERNAL"
	call %STELLA_COMMON%\common-feature.bat :feature_install sevenzip#9_38 "HIDDEN INTERNAL"
	call %STELLA_COMMON%\common-feature.bat :feature_install patch#2_5_9_INTERNAL:binary "HIDDEN INTERNAL"
goto :eof


REM REQUIRE ---------------------

:require
	REM binary to test
	set "_artefact=%~1"
	REM feature name (for stella) or sys name (for package manager)
	set "_id=%~2"

	REM OPTIONAL
	REM SYSTEM
	REM STELLA_FEATURE
	set "OPT_require=%~3"

	REM TODO : return-code to return ?
	set _result=0

	set _opt_optional=OFF
	set _opt_system=ON
	set _opt_stella_feature=OFF
	for %%O in (%OPT_require%) do (
		if "%%O"=="OPTIONAL" set _opt_optional=ON
		if "%%O"=="SYSTEM" (
			set _opt_system=ON
			set _opt_stella_feature=OFF
		)
		if "%%O"=="STELLA_FEATURE" (
			set _opt_stella_feature=ON
			set _opt_system=OFF
		)
	)

	echo ** REQUIRE !_id! (!_artefact!)

	set "_found="
	call %STELLA_COMMON%\common.bat :which "_found" "!_artefact!"

	if "!_found!" == "" (
		if "!_opt_optional!" == "ON" (
			if "!_opt_system!" == "ON" (
				echo ** WARN -- You should install !_artefact! -- Try stella.bat sys install !_id! OR install it manually
			) else (
				if "!_opt_stella_feature!" == "ON" (
					echo ** WARN -- You should install !_artefact! -- Try stella.bat feature install !_id!
				) else (
					echo ** WARN -- You should install !_artefact!
					echo -- For a system install : try stella.bat sys install !_id! OR install it manually
					echo -- For an install from Stella : try stella.bat feature install !_id!
				)
			)
		) else (
			if "!_opt_system!" == "ON" (
				echo ** ERROR -- Please install !_artefact!
				echo ** Try stella.bat sys install !_id! OR install it manually
				set "_result=1"
				@echo off
				goto :end
			) else (
				if "!_opt_stella_feature!" == "ON" (
					echo ** REQUIRE !_id! : installing it from stella
					call %STELLA_COMMON%\common-feature.bat :feature_install !_id!

					REM echo -- For an install from Stella : try stella.bat feature install !_id!
					REM @echo off
					REM goto :end
					REM TODO fork this to not pertubate current feature_install
					REM but first review stella api boot on windows
					REM call %STELLA_COMMON%\common-feature.bat :feature_install "!_id!" "INTERNAL HIDDEN"
					REM __feature_init "$_id"
				) else (
					echo ** ERROR -- Please install !_artefact!
					echo -- For a system install : try stella.bat sys install !_id! OR install it manually
					echo -- For an install from Stella : try stella.bat feature install !_id!
					set "_result=1"
					@echo off
					goto :end
				)
			)
		)
	)
goto :eof


REM PACKAGE SYSTEM ---------

:get_current_package_manager
	set "_result_get_manager=%~1"

	set "!_result_get_manager!=chocolatey"

	REM TODO for MSYS or CYGWIN package manager could be specific

goto :eof

:sys_install
	call :sys_install_%~1
goto :eof

:sys_remove
	call :sys_remove_%~1
goto :eof

:sys_package_manager
	REM INSTALL or REMOVE
	set "_action=%~1"
	set "_id=%~2"
	set "_packages_list=%~3"
	set "_optional_args=%~4"

	echo  ** !_action! !_id! on your system

	call :get_current_package_manager "_package_manager"

	set "_flag_package_manager=OFF"
	set "_packages="
	for %%O in (!_packages_list!) do (
		if "%%O"=="|" (
			set "_flag_package_manager=OFF"
		)
		if "!_flag_package_manager!"=="ON" (
			set "_packages=!_packages! %%O"
		)
		if "%%O"=="!_package_manager!" (
			set "_flag_package_manager=ON"
		)
	)


	if "!_action!"=="INSTALL" (
		if "!_package_manager!"=="chocolatey" (
			choco install !_packages! !_optional_args!
		)
	)
	if "!_action!"=="REMOVE" (
		if "!_package_manager!"=="chocolatey" (
			choco uninstall !_packages! !_optional_args!
		)
	)

goto :eof


:: --------- SYSTEM RECIPES-------
:sys_install_vs
	call :sys_install_vs2015community
goto :eof

:sys_install_chocolatey
	echo  ** Install Chocolatey on your system
	call %STELLA_COMMON%\common.bat :download "https://chocolatey.org/install.ps1" "chocolatey.ps1" "!STELLA_APP_TEMP_DIR!"
	REM TODO manage web proxy
	REM $env:chocolateyProxyLocation=!STELLA_PROXY_HOST!
	REM $env:chocolateyProxyUser=!STELLA_PROXY_PORT!
	powershell -NoProfile -ExecutionPolicy Bypass -Command "& '!STELLA_APP_TEMP_DIR!\chocolatey.ps1' %*"
	set "PATH=!PATH!;C:\ProgramData\chocolatey\bin"
	del /q "!STELLA_APP_CACHE_DIR!\chocolatey.ps1"
	del /q "!STELLA_APP_TEMP_DIR!\chocolatey.ps1"
goto :eof

:sys_remove_chocolatey
	echo  ** Remove Chocolatey from your system
	call %STELLA_COMMON%\common.bat :del_folder "C:\ProgramData\chocolatey"
goto :eof


:sys_install_vs2015community
	REM NOTE : by default some visual studio tools are not installed
	REM https://social.msdn.microsoft.com/Forums/en-US/1071be0e-2a46-4c30-9546-ea9d7c4755fa/where-is-vcvarsallbat-file?forum=visualstudiogeneral
	call :sys_package_manager "INSTALL" "vs2015community" "chocolatey visualstudio2015community"
goto :eof

:sys_remove_vs2015community
	call :sys_package_manager "REMOVE" "vs2015community" "chocolatey visualstudio2015community"
goto :eof
