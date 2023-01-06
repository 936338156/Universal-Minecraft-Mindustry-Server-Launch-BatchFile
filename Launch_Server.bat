::变量:[title = 标题],[javaPath = Java路径],[maxRam = 最大内存],[minRam = 最小内存],[serverName = 服务端文件名称],[countdown = 重启倒计时]
::跳转标签:[CheckConfig = 检查配置文件],[SetConfig = 设置配置文件],[PreLaunchOptions = 启动前选项],[ConfigModification = 修改配置文件]
::理论上这玩意可以运行所有jar文件
@echo off
cls
::初始化
set title=Launch_Server
set javaPath=%JAVA_HOME%\bin\java.exe
set maxRam=2G
set minRam=1G
::检查配置文件
:CheckConfig
if exist Config.bat (
    echo 发现配置文件
    call Config.bat
    goto PreLaunchOptions
) else (
    echo 未发现配置文件
    echo 请手动填写一些必要的信息，将以此为基础创建配置文件
    goto SetConfig
)
::设置配置文件
:SetConfig
title %title%
choice /C YN /N /M "这个设备有多个Java或没有JAVA_HOME?(Y.指定一个路径 N.使用默认的路径):"
if /I %ERRORLEVEL%==1 (
    echo Java路径 例:'D:\Program_Files\Java\jdk-17.0.2\bin\java.exe'
    set /P javaPath="输入Java路径:"
    echo 使用指定Java路径
)
if /I %ERRORLEVEL%==2 (
    set javaPath=%JAVA_HOME%\bin\java.exe
    echo 使用默认java路经
)
set /P maxRam="分配给服务器的最大内存[格式:?G或?M]:"
set /P minRam="分配给服务器的最小内存[格式:?G或?M]:"
set /P serverName="服务端文件名包括后缀'.jar':"
set /P countdown="服务器关闭后的自动重启倒计时:"
echo 请确认以下信息正确
echo 分配给服务器的最大内存:%maxRam%
echo 分配给服务器的最小内存:%minRam%
echo 服务端文件:%serverName%
echo 重启倒计时:%countdown%
choice /C 12 /N /M "1.保存配置并继续 2.重新输入:"
::保存配置部分
if %ERRORLEVEL%==1 (
    title %title%
    if exist Config.bat echo.>Config.bat
    echo set title=%title%>>Config.bat
    echo set javaPath=%javaPath%>>Config.bat
    echo set maxRam=%maxRam%>>Config.bat
    echo set minRam=%minRam%>>Config.bat
    echo set serverName=%serverName%>>Config.bat
    echo set countdown=%countdown%>>Config.bat
    goto PreLaunchOptions
)
if %ERRORLEVEL%==2 goto SetConfig
::选择启动方式
:PreLaunchOptions
title %title%
choice /C 1234 /N /T 10 /D 1 /M "10s后将自动启动服务器(1.跳过倒计时(启用自动重启) 2.仅启动一次(禁用自动重启) 3.修改配置文件内容 4.退出程序):"
if %ERRORLEVEL%==1 set restart=true & goto LaunchServer_0
if %ERRORLEVEL%==2 set restart=false & goto LaunchServer_0
if %ERRORLEVEL%==3 goto ConfigModification
if %ERRORLEVEL%==4 exit
::修改配置文件
:ConfigModification
cls
echo 1.修改命令行标题显示的文字
echo 2.修改服务器使用的java路径
echo 3.修改分配给服务器的最大内存
echo 4.修改分配给服务器的最小内存
echo 5.修改服务端文件名
echo 6.修改重启倒计时
echo 7.结束修改并重新启动
echo 8.放弃修改并重新启动
choice /C 12345678 /N /M "请选择需要修改的选项:"
if %ERRORLEVEL%==1 (
    set /P title="输入命令行显示的文字:"
    goto ConfigModification
)
if %ERRORLEVEL%==2 (
    set /P javaPath="输入服务器使用的java路径:"
    goto ConfigModification
)
if %ERRORLEVEL%==3 (
    set /P maxRam="输入分配给服务器的最大内存:"
    goto ConfigModification
)
if %ERRORLEVEL%==4 (
    set /P maxRam="输入分配给服务器的最小内存:"
    goto ConfigModification
)
if %ERRORLEVEL%==5 (
    set /P serverName="输入服务端文件的名字:"
    goto ConfigModification
)
if %ERRORLEVEL%==6 (
    set /P countdown="输入重启倒计时:"
    goto ConfigModification
)
if %ERRORLEVEL%==7 (
    if exist Config.bat echo.>Config.bat
    echo set title=%title%>>Config.bat
    echo set javaPath=%javaPath%>>Config.bat
    echo set maxRam=%maxRam%>>Config.bat
    echo set minRam=%minRam%>>Config.bat
    echo set serverName=%serverName%>>Config.bat
    echo set countdown=%countdown%>>Config.bat
    %0
)
if %ERRORLEVEL%==8 %0
::启动服务器
:LaunchServer_0
::一个用来让你在服务器启动时连带启动类似frp之类的东东，直接在这个注释下面继续写要在开服时只启动一次的就行了
:LaunchServer_1
cls
%javaPath% -jar -Xmx%maxRam% -Xms%minRam% .\%serverName%
if %restart%==false (
    echo 服务器已关闭
    pause
    exit
)
msg %USERNAME% /TIME %countdown% "服务器关闭，将在%countdown%秒后重新启动服务器"
choice /C 12 /N /T %countdown% /D 1 /M  "服务器关闭，将在%countdown%秒后重新启动服务器(1.跳过倒计时 2.阻止重启并退出Launch_Server):"
if %ERRORLEVEL%==1 goto LaunchServer_1
exit