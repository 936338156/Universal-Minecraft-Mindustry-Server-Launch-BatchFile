::变量:[Title = 标题],[Java_Path = Java路径],[MaxRAM = 最大内存],[Server_Name = 服务端文件名称],[Countdown = 重启倒计时],[Command = 命令输入]
::跳转标签:[Check_additional_parameters = 检查附加参数],[Check_Config = 检查配置文件],[Set_Config = 设置配置文件],[Select_start_method = 选择启动方式],[Config_Modification = 修改配置文件],[祖传代码],[Command = 命令输入],
@echo off
::初始化程序
set Title=Launch_Server
set Java_Path=java

::检查附加参数
:Check_additional_parameters
if /I "%1"=="Command" cls & goto Command

::检查配置文件
:Check_Config
if exist Config.bat (
    echo 发现配置文件
    call Config.bat
    goto Select_start_method
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
set /P MaxRAM="输入你希望分配给服务器的内存[格式:?G或?M]:"
set /P Server_Name="输入服务端文件的名称包括后缀'.jar':"
set /P Countdown="输入重启倒计时:"
echo 请确认以下信息正确
echo 分配给服务器的内存:%MaxRAM%
echo 服务端文件:%Server_Name%
choice /C 12 /N /M "1.保存配置并继续 2.重新输入:"
::保存配置部分
if %ERRORLEVEL%==1 (
    title %Title%
    if exist Config.bat del Config.bat
    echo ::窗口名称>>Config.bat
    echo set Title=%Title%>>Config.bat
    echo ::Java路径>>Config.bat
    echo set Java-Path=%Java-Path%>>Config.bat
    echo ::最大分配内存>>Config.bat
    echo set MaxRAM=%MaxRAM%>>Config.bat
    echo ::服务器文件名称>>Config.bat
    echo set Server_Name=%Server_Name%>>Config.bat
    echo ::重启倒计时>>Config.bat
    echo set Countdown=%Countdown%>>Config.bat
    goto Select_start_method
)
if %ERRORLEVEL%==2 goto

::选择启动方式
:Select_start_method
title %Title%
choice /C 1234 /N /M "1.启用自动重启 2.禁用自动重启 3.修改配置文件内容 4.退出程序:"
if %ERRORLEVEL%==1 goto Restart_on
if %ERRORLEVEL%==2 goto Restart_off
if %ERRORLEVEL%==3 goto Config_Modification
if %ERRORLEVEL%==4 exit


::修改配置文件
:Config_Modification
choice /C 1234567 /N /M "1.修改命令行显示的文字 2.修改服务器使用的java路径 3.修改分配给服务器的内存 4.修改服务端文件的名字 5.修改重启倒计时 6.结束修改并重新启动 7.放弃修改:"
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
    set /P MaxRAM="输入分配给服务器的内存:"
    echo 分配给服务器的内存已修改为%MaxRAM%
    goto ConfigModification
)
if %ERRORLEVEL%==4 (
    set /P Server_Name="输入服务端文件的名字:"
    echo 服务端文件的名字已修改为%Server_Name%
    goto ConfigModification
)
if %ERRORLEVEL%==5 (
    set /P Countdown="输入重启倒计时:"
    echo 服务端文件的名字已修改为%Countdown%
    goto ConfigModification
)
if %ERRORLEVEL%==6 (
    if exist Config.bat del Config.bat
    echo ::窗口名称>>Config.bat
    echo set Title=%Title%>>Config.bat
    echo ::Java路径>>Config.bat
    echo set Java-Path=%Java-Path%>>Config.bat
    echo ::最大分配内存>>Config.bat
    echo set MaxRAM=%MaxRAM%>>Config.bat
    echo ::服务器文件名称>>Config.bat
    echo set Server_Name=%Server_Name%>>Config.bat
    echo ::重启倒计时>>Config.bat
    echo set Countdown=%Countdown%>>Config.bat
    cls & %0
)
if %ERRORLEVEL%==7 goto Select_start_method

::祖传代码
::自动重启启用
:Restart_on
cls
%Java-Path% -jar -Xmx%MaxRAM% %Server_Name%
echo 服务器关闭了！将在%Countdown%秒后重新启动
msg %USERNAME% /TIME 5 服务器将在%Countdown%秒后重新启动
choice /C 12 /N /T %Countdown% /D 1 /M  "服务器将在%Countdown%秒后重新启动(1.跳过 2.阻止重启并退出Launch_Server):"
if %ERRORLEVEL%==1 goto Restart_on
if %ERRORLEVEL%==2 exit

::祖传代码
::自动重启禁用
:Restart_off
cls
%Java-Path% -jar -Xmx%MaxRAM% %Server_Name% %Additional_start_parameters%
echo 服务器关闭了！
msg %USERNAME% /TIME 5 服务器关闭了
pause
exit

::命令输入
::我堂堂开发者要是像普通用户一样，一步一步的运行到需要测试的地方，岂不是很拉
:Command
@set /P Command="Command<<"
%Command%
@goto Command