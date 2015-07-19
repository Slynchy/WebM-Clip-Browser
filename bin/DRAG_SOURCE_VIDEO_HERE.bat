@ECHO OFF
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

call :ColorText 0a "WebM VP9 optimum converter by Slynch"
echo.
echo For converting video into HTML5-friendly clips.
echo Best used for 5-20 second clips.
echo.

set /p starttime=Enter the start time in seconds: %=%

set /p trim=Enter the end time in "M:SS": %=%

:: no sound = -an
set /P c=Do you want sound [Y/N]?
if /I "%c%" EQU "Y" goto :sound
if /I "%c%" EQU "N" goto :nosound
REM set /P c=Experimental [Y/N]?
REM if /I "%c%" EQU "Y" goto :experimental
REM if /I "%c%" EQU "N" goto :nosound
:sound
::ffmpeg -i %1 -acodec libvorbis -qmax 25 -ss 00:00:%starttime% -t 00:0%trim% -threads 8 -async 1 -strict -2 %1.webm
ffmpeg -i %1 -c:v libvpx-vp9 -pass 1 -b:v 4000K -ss 00:00:%starttime% -t 00:0%trim% -threads 8 -speed 4 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -an -f webm %1.webm
ffmpeg -i %1 -c:v libvpx-vp9 -y -pass 2 -b:v 4000K -ss 00:00:%starttime% -t 00:0%trim% -threads 8 -speed 1 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -c:a libopus -b:a 64k -f webm %1.webm
del "ffmpeg2pass-0.log"
pause 
exit

:nosound
::ffmpeg -i %1 -acodec libvorbis -qmax 25 -ss 00:00:%starttime% -t 00:0%trim% -threads 8 -an -async 1 -strict -2 %1.webm
ffmpeg -i %1 -c:v libvpx-vp9 -pass 1 -b:v 4000K -ss 00:00:%starttime% -t 00:0%trim% -threads 8 -speed 4 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -an -f webm %1.webm
ffmpeg -i %1 -c:v libvpx-vp9 -y -pass 2 -b:v 4000K -ss 00:00:%starttime% -t 00:0%trim% -threads 8 -speed 1 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -an -f webm %1.webm
del "ffmpeg2pass-0.log"
pause 
exit

:experimental
ffmpeg -i %1 -c:v libvpx-vp9 -pass 1 -b:v 1000K -ss 00:00:%starttime% -t 00:0%trim% -threads 8 -speed 4 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -an -f webm %1.webm
ffmpeg -i %1 -c:v libvpx-vp9 -y -pass 2 -b:v 1000K -ss 00:00:%starttime% -t 00:0%trim% -threads 8 -speed 1 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -c:a libopus -b:a 64k -f webm %1.webm
pause
exit

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof