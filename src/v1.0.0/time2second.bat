@echo off
cls
pushd %0\..
title time2second v1.0.0
goto start

:defaultHeader
cls
echo ----------------
echo time2second v1.0.0
echo by Tateshiki0529
echo http://tslab.ml/
echo ----------------
echo;
exit /b

:start
call :defaultHeader
echo 1.time to second
echo 2.second to time
echo 3.exit
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
if %el% == 3 goto :eof

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
set result=0
set /a result+=%s%
set /a result+=%m%*60
set /a result+=%h%*3600
goto result_t2s

:calc_s2t
set result_h=0
set result_m=0
set result_s=0
set /a result_h=%s%/3600
set /a tmp=%s%-(%result_h%*3600)
set /a result_m=%tmp%/60
set /a s=%tmp%-(%result_m%*60)
set /a result_s=%s%
goto result_s2t

:result_t2s
call :defaultHeader
echo result = %result% S
pause
exit /b

:result_s2t
call :defaultHeader
echo result = %result_h% H %result_m% M %result_s% S
pause
exit /b