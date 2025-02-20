@echo off
@chcp 65001
cls
title ✧ Computer Cleaner
echo.
echo ┌───────────────────┐
echo    Computer Cleaner
echo     by ASTRO
echo └───────────────────┘
echo.

bcdedit >>nul
if %errorlevel% == 1 goto noadmin
echo 시행될 항목들:
echo · 임시 파일 (Temp) 삭제
echo · 최대 절전모드 해제
echo · DNS 캐시 삭제
echo · TCP 수신 제한 제거
echo · 운영체제 압축
echo · 삭제된 데이터 영구 소거 (Cipher)
echo.
goto :init

:init
set /p go=✧ 진행 (Y/N)
if /i "%go%" == "Y" goto :y
if /i "%go%" == "N" goto :n
goto :init

:y
echo.
set /p long=✧ 데이터 영구 소거 및 운영체제 압축은 많은 시간이 소요됩니다. 진행 하시겠습니까? (Y/N)
if /i "%long%" == "Y" goto :start
if /i "%long%" == "N" goto :start
goto :y

:start
del /s /f /q C:\Windows\Temp\*.* 
rd /s /q C:\Windows\Temp 
del /s /f /q %temp%\*.* 
rd /s /q %temp%
powercfg -h off
ipconfig /flushdns
netsh interface tcp set global autotuninglevel=experimental

if /i "%long%" == "Y" (
compact.exe /compactOS:always
C:\Windows\System32\cipher /w:c:
)

echo.
echo ✦ 완료되었습니다.
echo.
pause
exit

:n
echo.
echo ✧ 사용이 중단되었습니다.
echo.
pause
exit

:noadmin
echo ✧ 관리자 권한이 필요합니다.
pause
exit