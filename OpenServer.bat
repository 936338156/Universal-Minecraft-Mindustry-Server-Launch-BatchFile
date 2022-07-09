::变量简写对照表
::Customizing-Java-Path ; Title ; MaxRAM ; Server-Name ; Startup-Method=SM ; Reboot-Countdown=RC
::GOTO跳转标签简写对照表
::Additional-parameters=AP ; Check-Config=CC ; Server-Config-Settings=SCS ; Save-Config=SC ; Reboot-Countdown-Settings=RCS ; Reboot-True=RT ; Reboot-false=RF

::Information=I ; User input=UI ; ERROR=E
@echo off
echo [%time%] [I] 欢迎使用OpenServer
echo [%time%] [I] 请按照程序的指示操作不然造成的任何后果请自行承担
::程序初始化
::变量参数初始化
set Customizing-Java-Path=java
set Title=OpenServer
::检查是否传入额外参数
:AP
if /I "%1"=="LOG" (
    if /I "%2"=="DEBUG" set ASI=DEBUG
    if /I "%2"=="DB" set ASI=DEBUG
    if exist OpenServer.log del OpenServer.log
    %0 %ASI%>>OpenServer.log
)
if /I "%1"=="DEBUG" cls & goto DEBUG
if /I "%1"=="DB" cls & goto DEBUG

::检查是否存在配置文件
:CC
if exist Config.bat (
    echo [%time%] [I] 发现配置文件
    call Config.bat
    echo [%time%] [I] 已读取
    title %Title%
    goto SM
) else (
    echo [%time%] [I] 未发现配置文件
    echo [%time%] [I] 请手动填写一些必要的信息，我将以此为基础创建配置文件并保存
    goto SCS
)

::配置Config
:SCS
choice /C YN /N /M "[%time%] [UI] 这个设备有多个Java或没有JAVA_HOME?希望指定一个Java路径?(Y/N):"
if %ERRORLEVEL%==0 goto ERROR
if /I %ERRORLEVEL%==1 (
    echo [%time%] [I] Java安装路径 例:D:\Program_Files\Java\jdk-17.0.2\bin\java.exe
    set /P Customizing-Java-Path="[%time%] [UI] 输入Java安装路径:"
    echo [%time%] [I] 已使用自定义Java路径
)
if /I %ERRORLEVEL%==2 (
    set Customizing-Java-Path=java
    echo [%time%] [I] 已使用默认java路经
)
set /P MaxRAM="[%time%] [UI] 输入你希望分配给服务器的内存[格式:?G或?M]:"
set /P Server-Name="[%time%] [UI] 输入服务端文件的名称(不要带 .jar 程序会自动加上 .jar):"
set Server-Name=%Server-Name%.jar
echo [%time%] [I] 请确认以下信息正确
echo [%time%] [I] 分配给服务器的内存:%MaxRAM%
echo [%time%] [I] 服务端文件:%Server-Name%
choice /C YN /N /M "[%time%] [UI] 确认以上信息输入正确?(Y/N):"
if %ERRORLEVEL%==0 goto ERROR
::保存配置部分
:SaveConfig
if %ERRORLEVEL%==1 (
    if exist Config.bat del Config.bat
    echo [%time%] [I] 正在将配置信息保存至Config.bat
    echo ::窗口名称>>Config.bat
    echo set Title=%Title%>>Config.bat
    echo ::Java路径>>Config.bat
    echo set Customizing-Java-Path=%Customizing-Java-Path%>>Config.bat
    echo ::最大分配内存>>Config.bat
    echo set MaxRAM=%MaxRAM%>>Config.bat
    echo ::服务器文件名称>>Config.bat
    echo set Server-Name=%Server-Name%>>Config.bat
    echo [%time%] [I] 配置已保存至Config.bat
    goto SM
)
echo [%time%] [I] 以上信息不正确?
choice /C YN /N /M "[%time%] [UI] 1.重新输入 2.结束程序(1/2):"
if %ERRORLEVEL%==0 goto ERROR
if %ERRORLEVEL%==1 (
    cls
    echo [%time%] [I] 让我们再试一遍
    goto SCS
)
if %ERRORLEVEL%==2 (
    exit
)

::选择启动方式
:SM
echo [%time%] [I] 是否启用自动重启?
choice /C YN /N /M "[%time%] [UI] 是否启用自动重启(Y/N):"
if %ERRORLEVEL%==0 goto ERROR
if %ERRORLEVEL%==1 (
    goto RCS
)
if %ERRORLEVEL%==2 (
    cls
    echo [%time%] [I] 自动重启:OFF
    goto RF
)

::设置自动重启倒计时
:RCS
echo [%time%] [I] 这里只能填写纯数字不可以包含其他字符串,否则会没有缓冲的无限循环
set /P RC="[%time%] [UI] 设置自动重启倒计时(不要小于10秒):"
cls
echo [%time%] [I] 自动重启:ON
goto RT

::自动重启启用
:RT
%Customizing-Java-Path% -jar -Xmx%MaxRAM% %Server-Name%
echo [%time%] [I] 服务器关闭了！将在%RC%秒后重新启动
msg %USERNAME% /TIME 5 服务器将在%RC%秒后重新启动
timeout /T %RC% /NOBREAK
goto RT

::自动重启禁用
:RF
%Customizing-Java-Path% -jar -Xmx%MaxRAM% %Server-Name%
echo [%time%] [I] 服务器寄了！
mshta vbscript:msgbox("服务器已关闭",64,"服务器关闭了")(window.close)
pause
exit

::防止用户操作失误导致代码继续运行到错误的位置
:ERROR
::cls
echo [%time%] [E] 嘿！停下！
echo [%time%] [E] 你的操作出现了一些问题。
echo [%time%] [E] 只有你操作失误导致程序片段将要错误的运行到一个不相关的程序片段时才会来到这里
choice /C 12 /N /M "[%time%] [UI] 1.初始化程序再来一次 2.结束程序(1/2):"
if %ERRORLEVEL%==0 mshta vbscript:msgbox("ERROR",64,"你故意找茬是不是")(window.close) & exit
if %ERRORLEVEL%==1 cls & %0
if %ERRORLEVEL%==2 exit

::调试
::我堂堂开发者要是像普通用户一样，一步一步的运行到需要测试的地方，岂不是很拉
:DEBUG
@echo [%time%] [I] 你可以运行任何CMD能够运行的指令
@echo [%time%] [I] 因为这就是个简单的设置变量，然后直接把变量内容当命令运行的取巧方式
:Command
@set /P Command="OpenServer_Command>"
@if "%Command%"==0203 ( echo Hello world & goto Command )
%Command%
@goto Command

pause
exit