del "%~dp0\*.wav"
del "%~dp0\*.pcm"
"%~dp0\dumpLogToFiles.exe" "%~dp0\audio.lst" 0
ren "%~dp0\*.wav" *.pcm