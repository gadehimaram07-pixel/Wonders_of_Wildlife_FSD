@echo off
if "%JAVA_HOME%"=="" (
    if exist "C:\Program Files\Java\jdk-17.0.19" set "JAVA_HOME=C:\Program Files\Java\jdk-17.0.19"
    if exist "C:\Program Files\Java\jdk-24" set "JAVA_HOME=C:\Program Files\Java\jdk-24"
)
set "CATALINA_HOME=C:\Program Files\Apache Software Foundation\Tomcat 9.0"
set "CATALINA_BASE=%~dp0tomcat_base"

echo ========================================================
echo   Starting Apache Tomcat 9.0 for Wonders of Wildlife
echo   URL: http://localhost:8081/Wonders_of_Wildlife/
echo   or:  http://localhost:8081/
echo ========================================================

if exist "%CATALINA_BASE%\work" rd /s /q "%CATALINA_BASE%\work"
"%CATALINA_HOME%\bin\catalina.bat" run
