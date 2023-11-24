set tshark_path=%~1
set current_path=%~dp0
set cap=%current_path%\tempCap.cap
set out=%current_path%\out.txt

"%tshark_path%\tshark.exe" -r "%cap%" -t ad -T text -V > "%out%"

if exist "%cap%" (del "%cap%")
