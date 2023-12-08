"c:\Program Files\7-Zip\7z.exe" a -tzip Love2D.love -r "c:\000mega\0\SOCOBAN\Love2D\*.*"

copy /b love.exe + Love2D.love  boxes.exe
copy boxes.exe d:\BOXES\

"c:\Program Files\Inno Setup 6\ISCC.exe" box-InnoSetup-Script.iss

copy "c:\000mega\0\SOCOBAN\setup\Output\boxsetup.exe" d:\boxsetup.exe

del boxes.exe
del Love2D.love
del "c:\000mega\0\SOCOBAN\setup\Output\boxsetup.exe"

pause

