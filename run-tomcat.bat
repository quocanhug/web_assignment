@echo off
chcp 65001 >nul
title Tomcat 10.1 - web_assignment

echo ===================================================
echo [1/3] Đang đóng gói dự án sang file WAR...
echo ===================================================
call mvn package -DskipTests
if errorlevel 1 (
    echo [LOI] Build Maven that bai! Vui long kiem tra loi code.
    pause
    exit /b %errorlevel%
)

echo.
echo ===================================================
echo [2/3] Dang deploy web_assignment.war vao Tomcat 10.1...
echo ===================================================
copy /Y "target\web_assignment.war" "D:\uni\hk1nam3\web\tools\apache-tomcat-10.1.59\webapps\"

echo.
echo ===================================================
echo [3/3] Dang khoi dong Apache Tomcat 10.1.59...
echo Website se chay tai: http://localhost:8080/web_assignment/
echo Nhan Ctrl + C de dung server.
echo ===================================================

set "CATALINA_HOME=D:\uni\hk1nam3\web\tools\apache-tomcat-10.1.59"
set "CATALINA_BASE=D:\uni\hk1nam3\web\tools\apache-tomcat-10.1.59"
cd /d "D:\uni\hk1nam3\web\tools\apache-tomcat-10.1.59\bin"
catalina.bat run
