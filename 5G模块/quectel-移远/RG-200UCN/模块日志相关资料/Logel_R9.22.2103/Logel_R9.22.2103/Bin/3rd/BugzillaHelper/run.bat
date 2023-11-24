@echo off

set net=%1
set opt=%2

set url_external=https://bugzilla.unisoc.com/bugzilla/
set user_external="%~3"

set url_internal=http://bugzilla.sprd.com/bugzilla/
set user_internal="%~3"

set pwd="%~4"
set bug_id="%~5"
set fl_path="%~6"
set private="%~7"

if %net% == 1 (
    "%~dp0\bugzilla_helper.exe" %opt% "%url_external%" %user_external% %pwd% %bug_id% %fl_path% %private%
) else (
    "%~dp0\bugzilla_helper.exe" %opt% "%url_internal%" %user_internal% %pwd% %bug_id% %fl_path% %private%
)

del %fl_path%