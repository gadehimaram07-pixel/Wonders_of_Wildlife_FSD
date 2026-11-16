@echo off
echo ========================================================
echo   Setting up and Reseeding Oracle Database for Wonders of Wildlife
echo ========================================================

if "%JAVA_HOME%"=="" (
    if exist "C:\Program Files\Java\jdk-17.0.19" set "JAVA_HOME=C:\Program Files\Java\jdk-17.0.19"
    if exist "C:\Program Files\Java\jdk-24" set "JAVA_HOME=C:\Program Files\Java\jdk-24"
)
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "PROJECT_DIR=%~dp0Wonders_of_Wildlife"
set "OJDBC=%PROJECT_DIR%\WEB-INF\lib\ojdbc14.jar"

echo 1. Compiling DBInit seeder...
javac -cp "%OJDBC%" "%PROJECT_DIR%\sql\DBInit.java"
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to compile DBInit.java!
    pause
    exit /b %ERRORLEVEL%
)

echo 2. Running DBInit seeder against Oracle XE...
java -cp "%PROJECT_DIR%;%OJDBC%" sql.DBInit

echo ========================================================
echo   Oracle Database initialized successfully!
echo ========================================================
pause
