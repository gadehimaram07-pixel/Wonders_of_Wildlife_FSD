@echo off
if "%JAVA_HOME%"=="" (
    if exist "C:\Program Files\Java\jdk-17.0.19" set "JAVA_HOME=C:\Program Files\Java\jdk-17.0.19"
    if exist "C:\Program Files\Java\jdk-24" set "JAVA_HOME=C:\Program Files\Java\jdk-24"
)
set "CATALINA_HOME=C:\Program Files\Apache Software Foundation\Tomcat 9.0"
set "CATALINA_BASE=%~dp0tomcat_base"
echo Starting Apache Tomcat 9.0 on port 8081...
"%CATALINA_HOME%\bin\catalina.bat" run
