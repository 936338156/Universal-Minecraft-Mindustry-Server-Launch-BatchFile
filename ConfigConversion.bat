@echo off
title Config-Conversion
echo [%time%] [I] 输入要转换的配置文件所在的文件夹路径(例: D:\文件夹)
echo [%time%] [I] 程序会在目标文件夹寻找配置文件
set /p Config-Path="[%time%] [UI] 目标文件夹<<"
if "%Config-Path%"=="" echo [%time%] [E] 输入为空
if exist %Config-Path%\Config.bat call %Config-Path%\Config.bat
if exist %Config-Path%\Config.bat (
    if exist %~dp0Config.bat del %~dp0Config.bat
    echo [%time%] [I] 正在处理
    echo ::窗口名称>>%~dp0Config.bat
    echo set Title=OpenServer>>%~dp0Config.bat
    echo ::Java路径>>%~dp0Config.bat
    echo set Customizing-Java-Path=%CJP%>>%~dp0Config.bat
    echo ::最大分配内存>>%~dp0Config.bat
    echo set MaxRAM=%MRAM%>>%~dp0Config.bat
    echo ::服务器文件名称>>%~dp0Config.bat
    echo set Server-Name=%SN%>>%~dp0Config.bat
    echo [%time%] [I] 处理完成
    echo [%time%] [I] 已将处理完成的Config文件输出至%~dp0Config.bat
    pause
    exit
)
if %ERRORLEVEL%==0 (
    echo [%time%] [E] 处理失败
    echo [%time%] [E] 原因可能是目标文件夹路径不填写正确或目标文件夹不存在
    pause
    exit
)

pause
exit