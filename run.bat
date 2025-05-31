@echo off
REM ——————————————————————————————
REM 1. 啟動 Appium Server（新的視窗）
REM ——————————————————————————————
start "Appium Server" cmd /k "appium --allow-cors"

REM ——————————————————————————————
REM 2. 等待 Appium 初始化完成（可依照你本機啟動速度調整秒數）
REM ——————————————————————————————
timeout /t 5 /nobreak >nul

REM ——————————————————————————————
REM 3. 執行 Robot Framework 測試
REM ——————————————————————————————
robot --outputdir report test_script

REM ——————————————————————————————
REM 4. （可選）測試結束後關閉 Appium Server 視窗
REM    這裡用 window title “Appium Server” 來識別
REM ——————————————————————————————
taskkill /FI "WINDOWTITLE eq Appium Server*" /T /F >nul

exit /b

