set file_name=%1
set creator=%2
set Data_File=%3
set GSM_msg=%4
set TD_W_msg=%5
set LTE_msg=%6

set current_path=%~dp0

"%current_path%perl.exe" "%current_path%gen.pl" %file_name% %creator% %GSM_msg% %TD_W_msg% %LTE_msg% "%current_path%case_template.tcl" %Data_File%

rem ping /n 10000 127.1>nul