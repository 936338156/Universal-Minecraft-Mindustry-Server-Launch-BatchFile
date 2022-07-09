::������д���ձ�
::Customizing-Java-Path ; Title ; MaxRAM ; Server-Name ; Startup-Method=SM ; Reboot-Countdown=RC
::GOTO��ת��ǩ��д���ձ�
::Additional-parameters=AP ; Check-Config=CC ; Server-Config-Settings=SCS ; Save-Config=SC ; Reboot-Countdown-Settings=RCS ; Reboot-True=RT ; Reboot-false=RF

::Information=I ; User input=UI ; ERROR=E
@echo off
echo [%time%] [I] ��ӭʹ��OpenServer
echo [%time%] [I] �밴�ճ����ָʾ������Ȼ��ɵ��κκ�������ге�
::�����ʼ��
::����������ʼ��
set Customizing-Java-Path=java
set Title=OpenServer
::����Ƿ���������
:AP
if /I "%1"=="LOG" (
    if /I "%2"=="DEBUG" set ASI=DEBUG
    if /I "%2"=="DB" set ASI=DEBUG
    if exist OpenServer.log del OpenServer.log
    %0 %ASI%>>OpenServer.log
)
if /I "%1"=="DEBUG" cls & goto DEBUG
if /I "%1"=="DB" cls & goto DEBUG

::����Ƿ���������ļ�
:CC
if exist Config.bat (
    echo [%time%] [I] ���������ļ�
    call Config.bat
    echo [%time%] [I] �Ѷ�ȡ
    title %Title%
    goto SM
) else (
    echo [%time%] [I] δ���������ļ�
    echo [%time%] [I] ���ֶ���дһЩ��Ҫ����Ϣ���ҽ��Դ�Ϊ�������������ļ�������
    goto SCS
)

::����Config
:SCS
choice /C YN /N /M "[%time%] [UI] ����豸�ж��Java��û��JAVA_HOME?ϣ��ָ��һ��Java·��?(Y/N):"
if %ERRORLEVEL%==0 goto ERROR
if /I %ERRORLEVEL%==1 (
    echo [%time%] [I] Java��װ·�� ��:D:\Program_Files\Java\jdk-17.0.2\bin\java.exe
    set /P Customizing-Java-Path="[%time%] [UI] ����Java��װ·��:"
    echo [%time%] [I] ��ʹ���Զ���Java·��
)
if /I %ERRORLEVEL%==2 (
    set Customizing-Java-Path=java
    echo [%time%] [I] ��ʹ��Ĭ��java·��
)
set /P MaxRAM="[%time%] [UI] ������ϣ����������������ڴ�[��ʽ:?G��?M]:"
set /P Server-Name="[%time%] [UI] ���������ļ�������(��Ҫ�� .jar ������Զ����� .jar):"
set Server-Name=%Server-Name%.jar
echo [%time%] [I] ��ȷ��������Ϣ��ȷ
echo [%time%] [I] ��������������ڴ�:%MaxRAM%
echo [%time%] [I] ������ļ�:%Server-Name%
choice /C YN /N /M "[%time%] [UI] ȷ��������Ϣ������ȷ?(Y/N):"
if %ERRORLEVEL%==0 goto ERROR
::�������ò���
:SaveConfig
if %ERRORLEVEL%==1 (
    if exist Config.bat del Config.bat
    echo [%time%] [I] ���ڽ�������Ϣ������Config.bat
    echo ::��������>>Config.bat
    echo set Title=%Title%>>Config.bat
    echo ::Java·��>>Config.bat
    echo set Customizing-Java-Path=%Customizing-Java-Path%>>Config.bat
    echo ::�������ڴ�>>Config.bat
    echo set MaxRAM=%MaxRAM%>>Config.bat
    echo ::�������ļ�����>>Config.bat
    echo set Server-Name=%Server-Name%>>Config.bat
    echo [%time%] [I] �����ѱ�����Config.bat
    goto SM
)
echo [%time%] [I] ������Ϣ����ȷ?
choice /C YN /N /M "[%time%] [UI] 1.�������� 2.��������(1/2):"
if %ERRORLEVEL%==0 goto ERROR
if %ERRORLEVEL%==1 (
    cls
    echo [%time%] [I] ����������һ��
    goto SCS
)
if %ERRORLEVEL%==2 (
    exit
)

::ѡ��������ʽ
:SM
echo [%time%] [I] �Ƿ������Զ�����?
choice /C YN /N /M "[%time%] [UI] �Ƿ������Զ�����(Y/N):"
if %ERRORLEVEL%==0 goto ERROR
if %ERRORLEVEL%==1 (
    goto RCS
)
if %ERRORLEVEL%==2 (
    cls
    echo [%time%] [I] �Զ�����:OFF
    goto RF
)

::�����Զ���������ʱ
:RCS
echo [%time%] [I] ����ֻ����д�����ֲ����԰��������ַ���,�����û�л��������ѭ��
set /P RC="[%time%] [UI] �����Զ���������ʱ(��ҪС��10��):"
cls
echo [%time%] [I] �Զ�����:ON
goto RT

::�Զ���������
:RT
%Customizing-Java-Path% -jar -Xmx%MaxRAM% %Server-Name%
echo [%time%] [I] �������ر��ˣ�����%RC%�����������
msg %USERNAME% /TIME 5 ����������%RC%�����������
timeout /T %RC% /NOBREAK
goto RT

::�Զ���������
:RF
%Customizing-Java-Path% -jar -Xmx%MaxRAM% %Server-Name%
echo [%time%] [I] ���������ˣ�
mshta vbscript:msgbox("�������ѹر�",64,"�������ر���")(window.close)
pause
exit

::��ֹ�û�����ʧ���´���������е������λ��
:ERROR
::cls
echo [%time%] [E] �٣�ͣ�£�
echo [%time%] [E] ��Ĳ���������һЩ���⡣
echo [%time%] [E] ֻ�������ʧ���³���Ƭ�ν�Ҫ��������е�һ������صĳ���Ƭ��ʱ�Ż���������
choice /C 12 /N /M "[%time%] [UI] 1.��ʼ����������һ�� 2.��������(1/2):"
if %ERRORLEVEL%==0 mshta vbscript:msgbox("ERROR",64,"������Ҳ��ǲ���")(window.close) & exit
if %ERRORLEVEL%==1 cls & %0
if %ERRORLEVEL%==2 exit

::����
::�����ÿ�����Ҫ������ͨ�û�һ����һ��һ�������е���Ҫ���Եĵط������Ǻ���
:DEBUG
@echo [%time%] [I] ����������κ�CMD�ܹ����е�ָ��
@echo [%time%] [I] ��Ϊ����Ǹ��򵥵����ñ�����Ȼ��ֱ�Ӱѱ������ݵ��������е�ȡ�ɷ�ʽ
:Command
@set /P Command="OpenServer_Command>"
@if "%Command%"==0203 ( echo Hello world & goto Command )
%Command%
@goto Command

pause
exit