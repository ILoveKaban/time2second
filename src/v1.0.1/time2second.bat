@echo off
cls
pushd %0\..
title time2second v1.0.1
if not exist time2second.cfg (
	type time2second.cfg > time2second.cfg
	echo # Last update at %date% %time%> time2second.cfg
	echo # ---------------->> time2second.cfg
	echo # time2second v1.0.1>> time2second.cfg
	echo # by Tateshiki0529>> time2second.cfg
	echo # http://tslab.ml/>> time2second.cfg
	echo # ---------------->> time2second.cfg
	echo fileOutput=false>> time2second.cfg
	set fileOutput=false
) else (
	for /f "delims== tokens=1,* eol=#" %%i in ('findstr "[a-zA-Z0-9][a-zA-Z0-9]*=" "time2second.cfg"') do set %%i=%%j
)
goto start

:defaultHeader
cls
echo ----------------
echo time2second v1.0.1
echo by Tateshiki0529
echo http://tslab.ml/
echo ----------------
echo;
exit /b

:start
call :defaultHeader
echo 1.time to second
echo 2.second to time
echo 3.config
echo 4.exit
choice /c 123 >nul
set el=%errorlevel%
if %el% == 1 (
	set h=0
	set m=0
	set s=0
	set c=1
	goto t2s
)
if %el% == 2 (
	set s=0
	goto s2t
)
if %el% == 3 goto editconf
if %el% == 4 goto :eof

:t2s
call :defaultHeader
echo %h% H %m% M %s% S
echo;
if %c% == 1 (set /p "h=H-->") else if %c% == 2 (set /p "m=M-->") else if %c% == 3 (set /p "s=S-->")
if %c% == 3 goto calc_t2s
set /a c+=1
goto t2s

:s2t
call :defaultHeader
echo %s% S
set /p "s=S-->"
goto calc_s2t

:calc_t2s
set sDate=%date%
set sTime=%time%
set result=0
set /a result+=%s%
set /a result+=%m%*60
set /a result+=%h%*3600
set eDate=%date%
set eTime=%time%
goto result_t2s

:calc_s2t
set sDate=%date%
set sTime=%time%
set result_h=0
set result_m=0
set result_s=0
set /a result_h=%s%/3600
set /a tmp=%s%-(%result_h%*3600)
set /a result_m=%tmp%/60
set /a s=%tmp%-(%result_m%*60)
set /a result_s=%s%
set eDate=%date%
set eTime=%time%
goto result_s2t

:result_t2s
call :defaultHeader
if %fileOutput% == true (
	type result.log > result.log
	echo # Created at %date% %time%> result.log
	echo # ---------------->> result.log
	echo # time2second v1.0.1>> result.log
	echo # by Tateshiki0529>> result.log
	echo # http://tslab.ml/>> result.log
	echo # ---------------->> result.log
	echo Results:>>result.log
	echo - Type: time to second>>result.log
	echo - Input: %h% H %m% M %s% S>>result.log
	echo - Output: %result% S>>result.log
	echo - Start: %sDate% %sTime%>>result.log
	echo - End: %eDate% %eTime%>>result.log
)
echo result = %result% S
pause
exit /b

:result_s2t
call :defaultHeader
if %fileOutput% == true (
	type result.log > result.log
	echo # Created at %date% %time%> result.log
	echo # ---------------->> result.log
	echo # time2second v1.0.1>> result.log
	echo # by Tateshiki0529>> result.log
	echo # http://tslab.ml/>> result.log
	echo # ---------------->> result.log
	echo Results:>>result.log
	echo - Type: second to time>>result.log
	echo - Input: %s% S>>result.log
	echo - Output: %result_h% H %result_m% M %result_s% S>>result.log
	echo - Start: %sDate% %sTime%>>result.log
	echo - End: %eDate% %eTime%>>result.log
)
echo result = %result_h% H %result_m% M %result_s% S
pause
exit /b

:editconf
call :defaultHeader
echo 1.file output
echo 2.back
choice /c 12 >nul
set el=%errorlevel%
if %el% == 1 goto ec_fo
if %el% == 2 goto start

:ec_fo
call :defaultHeader
if %fileOutput% == true (
	echo œ1.Turn on the File Output
	echo ›2.Turn off the File Output
) else if %fileOutput% == false (
	echo ›1.Turn on the File Output
	echo œ2.Turn off the File Output
) else (
	echo ›1.Turn on the File Output
	echo ›2.Turn off the File Output
)
echo 3.back
choice /c 123 >nul
set el=%errorlevel%
if %el% == 1 (
	set fileOutput=true
	call :write
) else if %el% == 2 (
	set fileOutput=false
	call :write
)
if %el% == 3 goto editconf
goto ec_fo

:write
set values=%1
echo # Last update at %date% %time%> time2second.cfg
echo # ---------------->> time2second.cfg
echo # time2second v1.0.1>> time2second.cfg
echo # by Tateshiki0529>> time2second.cfg
echo # http://tslab.ml/>> time2second.cfg
echo # ---------------->> time2second.cfg
echo fileOutput=%fileOutput%>> time2second.cfg
exit /b