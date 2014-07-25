@echo off
call %*
goto :eof

:list_cmake
	set "%~1=2_8_12"
goto :eof

:install_cmake
	set "_VER=%~1"
	set "_DEFAULT_VER=2_8_12"

	if not exist %TOOL_ROOT%\cmake mkdir %TOOL_ROOT%\cmake
	if "%_VER%"=="" (
		call :install_cmake_%_DEFAULT_VER%
	) else (
		call :install_cmake_%_VER%
	)
goto :eof

:feature_cmake
	set "_VER=%~1"
	set "_DEFAULT_VER=2_8_12"

	if "%_VER%"=="" (
		call :feature_cmake_%_DEFAULT_VER%
	) else (
		call :feature_cmake_%_VER%
	)
goto :eof



:install_cmake_2_8_12
	set URL=http://www.cmake.org/files/v2.8/cmake-2.8.12-win32-x86.zip
	set VERSION=2.8.12
	set FILE_NAME=cmake-2.8.12-win32-x86.zip
	set "INSTALL_DIR=%TOOL_ROOT%\cmake\%VERSION%-win32-x86"

	echo ** Installing cmake version %VERSION% in %INSTALL_DIR%

	call :feature_cmake_2_8_12
	if "%FORCE%"=="1" ( 
		set TEST_FEATURE=0
		call %STELLA_COMMON%\common.bat :del_folder "%INSTALL_DIR%"
	)
	if "!TEST_FEATURE!"=="0" (
		call %STELLA_COMMON%\common.bat :download_uncompress "%URL%" "%FILE_NAME%" "%INSTALL_DIR%" "DEST_ERASE STRIP"
		
		call :feature_cmake_2_8_12
		if not "!TEST_FEATURE!"=="0" (
			cd /D "!TEST_FEATURE!\bin"
			echo ** CMake installed
			cmake -version
		) else (
			echo ** ERROR
		)
	) else (
		echo ** Already installed
	)
goto :eof

:feature_cmake_2_8_12
	set TEST_FEATURE=0
	set FEATURE_PATH=
	set FEATURE_VER=
	if exist "%TOOL_ROOT%\cmake\2_8_12-win32-x86\bin\cmake.exe" (
		set "TEST_FEATURE=%TOOL_ROOT%\cmake\2_8_12-win32-x86"
	)

	if not "!TEST_FEATURE!"=="0" (
		if %VERBOSE_MODE% GTR 0 (
			echo ** EXTRA FEATURE Detected : cmake in !TEST_FEATURE!
		)
		set "CMAKE_CMD=!TEST_FEATURE!\bin\%CMAKE_CMD%"
		set "CMAKE_CMD_VERBOSE=!TEST_FEATURE!\bin\%CMAKE_CMD_VERBOSE%"
		set "CMAKE_CMD_VERBOSE_ULTRA=!TEST_FEATURE!\bin\%CMAKE_CMD_VERBOSE_ULSSA%"
		set "FEATURE_PATH=!TEST_FEATURE!\bin"
		set FEATURE_VER=2_8_12
	)
goto :eof



