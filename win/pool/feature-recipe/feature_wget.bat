@echo off
call %*
goto :eof

:list_wget
	set "%~1=1_11_4"
goto :eof

:default_wget
	set "%~1=1_11_4"
goto :eof

:install_wget
	set "_VER=%~1"

	set TEST_FEATURE=0
	set FEATURE_ROOT=
	set FEATURE_PATH=
	set FEATURE_VER=

	if not exist %STELLA_APP_FEATURE_ROOT%\wget mkdir %STELLA_APP_FEATURE_ROOT%\wget
	if "%_VER%"=="" (
		call :default_wget "_DEFAULT_VER"
		call :install_wget_!_DEFAULT_VER!
	) else (
		call :list_wget "_list_ver"
		for %%v in (!_list_ver!) do (
			if "%%v"=="%_VER%" (
				call :install_wget_%_VER%
			)
		)
	)
goto :eof

:feature_wget
	set "_VER=%~1"

	set TEST_FEATURE=0
	set FEATURE_ROOT=
	set FEATURE_PATH=
	set FEATURE_VER=

	if "%_VER%"=="" (
		call :default_wget "_DEFAULT_VER"
		call :feature_wget_!_DEFAULT_VER!
	) else (
		call :list_wget "_list_ver"
		for %%v in (!_list_ver!) do (
			if "%%v"=="%_VER%" (
				call :feature_wget_%_VER%
			)
		)
	)
goto :eof


:install_wget_1_11_4
	set VERSION=1_11_4
	set INSTALL_DIR="%STELLA_APP_FEATURE_ROOT%\wget\%VERSION%"
	
	echo ** Installing wget version %VERSION% in %INSTALL_DIR%

	call :feature_wget_1_11_4
	if "%FORCE%"=="1" ( 
		set TEST_FEATURE=0
		call %STELLA_COMMON%\common.bat :del_folder "%INSTALL_DIR%"
	)
	if "!TEST_FEATURE!"=="0" (	
		call %STELLA_COMMON%\common.bat :uncompress "%STELLA_FEATURE_REPOSITORY_LOCAL%\wget-1.11.4-1-bin.zip" "%INSTALL_DIR%"
		call %STELLA_COMMON%\common.bat :uncompress "%STELLA_FEATURE_REPOSITORY_LOCAL%\wget-1.11.4-1-dep.zip" "%INSTALL_DIR%"
		
		call :feature_wget_1_11_4
		if "!TEST_FEATURE!"=="1" (
			echo wget installed
		) else (
			echo ** ERROR
		)
	) else (
		echo ** Already installed
	)
goto :eof

:feature_wget_1_11_4
	set TEST_FEATURE=0
	
	if exist "%STELLA_APP_FEATURE_ROOT%\wget\1_11_4\bin\wget.exe" (
		set "TEST_FEATURE=1"
		set "FEATURE_ROOT=%STELLA_APP_FEATURE_ROOT%\wget\1_11_4"
		set "FEATURE_PATH=!FEATURE_ROOT!\bin"
		set FEATURE_VER=1_11_4
		if %VERBOSE_MODE% GTR 0 (
			echo ** EXTRA FEATURE Detected : wget in !FEATURE_ROOT!
		)
	)
goto :eof

