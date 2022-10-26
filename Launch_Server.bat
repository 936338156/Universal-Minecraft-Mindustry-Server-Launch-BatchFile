::变量:[Title = 标题],[Java_Path = Java路径],[MaxRAM = 最大内存],[MinRAM = 最小内存],[Server_Name = 服务端文件名称],[Countdown = 重启倒计时]
::跳转标签:[Check_Config = 检查配置文件],[Set_Config = 设置配置文件],[Pre-Launch_Options = 启动前选项],[Config_Modification = 修改配置文件],[Launch_Server = 启动服务器]
@echo off
::初始化程序
set Title=Launch_Server
set Java_Path=java
set MaxRAM=2G
set MinRAM=1G
::检查配置文件
:Check_Config
if exist Config.bat (
    echo 发现配置文件
    call Config.bat
    goto Pre-Launch_Options
) else (
    echo 未发现配置文件
    echo 请手动填写一些必要的信息，将以此为基础创建配置文件
    goto Set_Config
)
::设置配置文件
:Set_Config
title %Title%
choice /C YN /N /M "这个设备有多个Java或没有JAVA_HOME?希望指定一个Java路径?(Y/N):"
if /I %ERRORLEVEL%==1 (
    echo Java安装路径 例:D:\Program_Files\Java\jdk-17.0.2\bin\java.exe
    set /P Java-Path="输入Java安装路径:"
    echo 已使用自定义Java路径
)
if /I %ERRORLEVEL%==2 (
    set Java-Path=java
    echo 已使用默认java路经
)
set /P MaxRAM="输入你希望分配给服务器的最大内存[格式:?G或?M]:"
set /P MinRAM="输入你希望分配给服务器的最小内存[格式:?G或?M]:"
set /P Server_Name="输入服务端文件名包括后缀'.jar':"
set /P Countdown="输入非正常服务器关闭后的自动重启倒计时:"
echo 请确认以下信息正确
echo 分配给服务器的最大内存:%MaxRAM%
echo 分配给服务器的最小内存:%MinRAM%
echo 服务端文件:%Server_Name%
echo 重启倒计时:%Countdown%
choice /C 12 /N /M "1.保存配置并继续 2.重新输入:"
::保存配置部分
if %ERRORLEVEL%==1 (
    title %Title%
    if exist Config.bat del Config.bat
    echo set Title=%Title%>>Config.bat
    echo set Java-Path=%Java-Path%>>Config.bat
    echo set MaxRAM=%MaxRAM%>>Config.bat
    echo set MinRAM=%MinRAM%>>Config.bat
    echo set Server_Name=%Server_Name%>>Config.bat
    echo set Countdown=%Countdown%>>Config.bat
    goto Pre-Launch_Options
)
if %ERRORLEVEL%==2 goto Set_Config
::选择启动方式
:Pre-Launch_Options
title %Title%
choice /C 1234 /N /T 10 /D 1 /M "10s后将自动启动服务器(1.跳过倒计时 2.修改配置文件内容 3.退出程序):"
if %ERRORLEVEL%==1 goto Launch_Server
if %ERRORLEVEL%==2 goto Config_Modification
if %ERRORLEVEL%==3 exit
::修改配置文件
:Config_Modification
echo 1.修改命令行标题显示的文字
echo 2.修改服务器使用的java路径
echo 3.修改分配给服务器的最大内存
echo 4.修改分配给服务器的最小内存
echo 5.修改服务端文件名
echo 6.修改重启倒计时
echo 7.结束修改并重新启动
choice /C 1234567 /N /M "8.放弃修改并重新启动:"
if %ERRORLEVEL%==1 (
    set /P Title="输入命令行显示的文字:"
    echo 命令行显示的文字已修改为%Title%
    goto ConfigModification
)
if %ERRORLEVEL%==2 (
    set /P Java-Path="输入服务器使用的java路径:"
    echo 服务器使用的java路径已修改为%Java-Path%
    goto ConfigModification
)
if %ERRORLEVEL%==3 (
    set /P MaxRAM="输入分配给服务器的最大内存:"
    echo 分配给服务器的最大内存已修改为%MaxRAM%
    goto ConfigModification
)
if %ERRORLEVEL%==4 (
    set /P MaxRAM="输入分配给服务器的最小内存:"
    echo 分配给服务器的最小内存已修改为%MinRAM%
    goto ConfigModification
)
if %ERRORLEVEL%==5 (
    set /P Server_Name="输入服务端文件的名字:"
    echo 服务端文件的名字已修改为%Server_Name%
    goto ConfigModification
)
if %ERRORLEVEL%==6 (
    set /P Countdown="输入重启倒计时:"
    echo 服务端文件的名字已修改为%Countdown%
    goto ConfigModification
)
if %ERRORLEVEL%==7 (
    if exist Config.bat del Config.bat
    echo set Title=%Title%>>Config.bat
    echo set Java-Path=%Java-Path%>>Config.bat
    echo set MaxRAM=%MaxRAM%>>Config.bat
    echo set MinRAM=%MinRAM%>>Config.bat
    echo set Server_Name=%Server_Name%>>Config.bat
    echo set Countdown=%Countdown%>>Config.bat
    cls & %0
)
if %ERRORLEVEL%==8 cls & %0
::启动服务器
:Launch_Server
cls
%Java-Path% -jar -Xmx%MaxRAM% -Xms%MinRAM% .\%Server_Name%
if %ERRORLEVEL%==0 (
    echo 服务器已关闭
    pause
    exit
)
msg %USERNAME% /TIME %Countdown% "服务器非正常关闭，将在%Countdown%秒后重新启动启动服务器"
choice /C 12 /N /T %Countdown% /D 1 /M  "服务器非正常关闭,将在%Countdown%秒后重新启动服务器(1.跳过倒计时 2.阻止重启并退出Launch_Server):"
if %ERRORLEVEL%==1 goto Launch_Server
if %ERRORLEVEL%==2 exit