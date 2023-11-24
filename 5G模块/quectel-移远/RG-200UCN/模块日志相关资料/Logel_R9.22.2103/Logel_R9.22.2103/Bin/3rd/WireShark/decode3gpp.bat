set tshark_path=%~3
set current_path=%~dp0
set pcap=%current_path%\WireShark.pcap
set out=%current_path%\out.txt

"%tshark_path%\text2pcap.exe" -l 162 "%current_path%\WireShark.txt" "%pcap%"

if exist "%out%" (del "%out%")

"%current_path%\perl.exe" "%current_path%\decode.pl" "%1" "%2" "%current_path%\config.csv" "%tshark_path%\tshark.exe" "%pcap%" "%out%"





