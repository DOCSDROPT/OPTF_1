@echo off
@Title Regedit
cd /d %~dp0
color 7
mode con:cols=70 lines=20
SET scrver=0.2

if /i "%~1"=="-ver" (
    echo SET VEREG=%scrver%>%temp%\vereg.cmd
    Exit
)

pause