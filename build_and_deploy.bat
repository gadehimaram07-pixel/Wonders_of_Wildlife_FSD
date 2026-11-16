@echo off
echo ========================================================
echo   Wonders of Wildlife - Build and Deploy to Tomcat
echo ========================================================

if "%JAVA_HOME%"=="" (
    if exist "C:\Program Files\Java\jdk-17.0.19" set "JAVA_HOME=C:\Program Files\Java\jdk-17.0.19"
    if exist "C:\Program Files\Java\jdk-24" set "JAVA_HOME=C:\Program Files\Java\jdk-24"
)
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "PROJECT_DIR=%~dp0Wonders_of_Wildlife"
set "TOMCAT_BASE=%~dp0tomcat_base"

echo 1. Compiling Java Classes with javac...
pushd "%PROJECT_DIR%"
javac -cp "WEB-INF\lib\*" -d "WEB-INF\classes" src\com\wildlife\util\*.java src\com\wildlife\model\*.java src\com\wildlife\dao\*.java src\com\wildlife\servlet\*.java
popd

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Java compilation failed!
    pause
    exit /b %ERRORLEVEL%
)
echo [SUCCESS] Java classes compiled cleanly.

echo 2. Deploying files to Tomcat webapps...
if exist "%TOMCAT_BASE%\work\Catalina" rd /s /q "%TOMCAT_BASE%\work\Catalina"
if not exist "%TOMCAT_BASE%\webapps\Wonders_of_Wildlife" mkdir "%TOMCAT_BASE%\webapps\Wonders_of_Wildlife"
if not exist "%TOMCAT_BASE%\webapps\ROOT" mkdir "%TOMCAT_BASE%\webapps\ROOT"

xcopy /E /I /Y "%PROJECT_DIR%\*.jsp" "%TOMCAT_BASE%\webapps\Wonders_of_Wildlife\" >nul
xcopy /E /I /Y "%PROJECT_DIR%\*.html" "%TOMCAT_BASE%\webapps\Wonders_of_Wildlife\" >nul
xcopy /E /I /Y "%PROJECT_DIR%\*.css" "%TOMCAT_BASE%\webapps\Wonders_of_Wildlife\" >nul
xcopy /E /I /Y "%PROJECT_DIR%\*.jpg" "%TOMCAT_BASE%\webapps\Wonders_of_Wildlife\" >nul
xcopy /E /I /Y "%PROJECT_DIR%\*.png" "%TOMCAT_BASE%\webapps\Wonders_of_Wildlife\" >nul
xcopy /E /I /Y "%PROJECT_DIR%\*.mp4" "%TOMCAT_BASE%\webapps\Wonders_of_Wildlife\" >nul
xcopy /E /I /Y "%PROJECT_DIR%\WEB-INF" "%TOMCAT_BASE%\webapps\Wonders_of_Wildlife\WEB-INF" >nul

echo 3. Syncing to ROOT webapp...
xcopy /E /I /Y "%TOMCAT_BASE%\webapps\Wonders_of_Wildlife\*" "%TOMCAT_BASE%\webapps\ROOT\" >nul

echo ========================================================
echo   Build and Deployment Successful!
echo ========================================================
