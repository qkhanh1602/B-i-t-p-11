@echo off
chcp 65001 > nul
echo ===============================================================
echo     KHỞI CHẠY SPRING TOOLS FOR ECLIPSE (STS) VỚI DỰ ÁN
echo ===============================================================
echo.

set "STS_EXE=D:\taixuong\spring-tools-for-eclipse-5.3.0.RELEASE-e4.40.0-win32.win32.x86_64\sts-5.3.0.RELEASE\SpringToolsForEclipse.exe"
set "WORKSPACE_DIR=%~dp0..\"

if not exist "%STS_EXE%" (
    echo [LỖI] Không tìm thấy SpringToolsForEclipse.exe tại đường dẫn:
    echo "%STS_EXE%"
    echo Vui lòng kiểm tra lại đường dẫn thư mục cài đặt STS.
    pause
    exit /b 1
)

echo Đang khởi chạy Spring Tools for Eclipse...
echo Workspace: %WORKSPACE_DIR%
start "" "%STS_EXE%" -data "%WORKSPACE_DIR%"
exit /b 0
