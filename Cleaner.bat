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

bcdedit >nul
if %errorlevel% == 1 goto noadmin
echo 시행될 항목들:
echo · 시스템 무결성 검사 및 복원
echo · 시스템 손상 복원
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
set /p long1=[?] 시스템 무결성 검사 및 손상 복원은 많은 시간이 소요됩니다. 진행 하시겠습니까? (Y/N)
if /i "%long1%" == "Y" goto :y2
if /i "%long1%" == "N" goto :y2
goto :y



:y2
echo.
set /p long2=[?] 운영 체제 압축은 성능에 따라 많은 시간이 소요됩니다. 진행 하시겠습니까? (Y/N)
if /i "%long2%" == "Y" goto :y3
if /i "%long2%" == "N" goto :y3
goto :y2



:y3
echo.
set /p long3=[?] 데이터 영구 소거는 많은 시간이 소요됩니다. 진행 하시겠습니까? (Y/N)
if /i "%long3%" == "Y" goto :quit
if /i "%long3%" == "N" goto :quit
goto :y3



:quit
echo.
set /p quit=[?] 작업 수행 후 컴퓨터를 종료하시겠습니까? (Y/N)
if /i "%quit%" == "Y" goto :start
if /i "%quit%" == "N" goto :start
goto :quit



:start
cls

if /i "%long1%" == "Y" (

bcdedit >nul
echo ✧ 시스템 무결성 검사 중...
sfc /scannow >nul 2>&1
if %errorlevel% == 1 echo ^<^!^> 검사 중 오류 발생 및 중단되었습니다.
echo ✦ 검사 완료.
echo.

bcdedit >nul
echo ✧ 시스템 복원 중...
dism /online /cleanup-image /restorehealth >nul 2>&1
if %errorlevel% == 1 echo ^<^!^> 복원 중 오류 발생 및 중단되었습니다.
echo ✦ 복원 완료.

)



echo.
echo ✧ 임시 파일 삭제 중...
del /s /f /q C:\Windows\Temp\*.* >nul 2>&1
rd /s /q C:\Windows\Temp >nul 2>&1
del /s /f /q %temp%\*.* >nul 2>&1
rd /s /q %temp% >nul 2>&1
echo ✦ 삭제 완료.

powercfg -h off >nul
echo ✦ 최대 절전 모드 해제됨.

ipconfig /flushdns >nul
echo ✦ DNS 캐시 삭제됨.

netsh interface tcp set global autotuninglevel=experimental >nul
echo ✦ TCP 수신 제한 제거됨.



echo.
if /i "%long2%" == "Y" (

echo ✧ 운영 체제 압축 중...
compact.exe /compactOS:always >nul 2>&1
echo ✦ 압축 완료.

)



echo.
if /i "%long3%" == "Y" (

echo ✧ 데이터 영구 소거 중...
C:\Windows\System32\cipher /w:c: >nul 2>&1
echo ✦ 소거 완료.

)



echo.
if /i "%quit%" == "Y" (

shutdown /s /t 10 /c "[[✦]] 실행 완료. 컴퓨터의 전원을 종료합니다."

)



echo.
echo [[✦]] 완료되었습니다.
echo.
pause
exit



:n
echo.
echo [×] 사용이 중단되었습니다.
echo.
pause
exit



:noadmin
echo [^!] 관리자 권한이 필요합니다.
pause
exit
