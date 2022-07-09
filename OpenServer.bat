::������д���ձ�
::Customizing-Java-Path ; Title ; MaxRAM ; Server-Name ; Startup-Method=SM ; Reboot-Countdown=RC
::GOTO��ת��ǩ��д���ձ�
::Additional-parameters=AP ; Check-Config=CC ; Server-Config-Settings=SCS ; Save-Config=SC ; Reboot-Countdown-Settings=RCS ; Reboot-True=RT ; Reboot-false=RF

@echo off
::�����ʼ��
::����������ʼ��
set Customizing-Java-Path=java
set Title=OpenServer

echo ��ӭʹ��OpenServer
echo �밴�ճ����ָʾ������Ȼ��ɵ��κκ�������ге�
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
    echo ���������ļ�
    call Config.bat
    echo �Ѷ�ȡ
    goto SM
) else (
    echo δ���������ļ�
    echo ���ֶ���дһЩ��Ҫ����Ϣ���ҽ��Դ�Ϊ�������������ļ�������
    goto SCS
)

::����Config
:SCS
title %Title%
choice /C YN /N /M "����豸�ж��Java��û��JAVA_HOME?ϣ��ָ��һ��Java·��?(Y/N):"
if /I %ERRORLEVEL%==1 (
    echo Java��װ·�� ��:D:\Program_Files\Java\jdk-17.0.2\bin\java.exe
    set /P Customizing-Java-Path="����Java��װ·��:"
    echo ��ʹ���Զ���Java·��
)
if /I %ERRORLEVEL%==2 (
    set Customizing-Java-Path=java
    echo ��ʹ��Ĭ��java·��
)
set /P MaxRAM="������ϣ����������������ڴ�[��ʽ:?G��?M]:"
set /P Server-Name="���������ļ�������(��Ҫ�� .jar ������Զ����� .jar):"
set Server-Name=%Server-Name%.jar
echo ��ȷ��������Ϣ��ȷ
echo ��������������ڴ�:%MaxRAM%
echo ������ļ�:%Server-Name%
choice /C YN /N /M "ȷ��������Ϣ������ȷ?(Y/N):"
::�������ò���
:SaveConfig
if %ERRORLEVEL%==1 (
    title %Title%
    if exist Config.bat del Config.bat
    echo ���ڽ�������Ϣ������Config.bat
    echo ::��������>>Config.bat
    echo set Title=%Title%>>Config.bat
    echo ::Java·��>>Config.bat
    echo set Customizing-Java-Path=%Customizing-Java-Path%>>Config.bat
    echo ::�������ڴ�>>Config.bat
    echo set MaxRAM=%MaxRAM%>>Config.bat
    echo ::�������ļ�����>>Config.bat
    echo set Server-Name=%Server-Name%>>Config.bat
    echo �����ѱ�����Config.bat
    goto SM
)
echo ������Ϣ����ȷ?
choice /C YN /N /M "1.�������� 2.��������(1/2):"
if %ERRORLEVEL%==1 (
    cls
    echo ����������һ��
    goto SCS
)
if %ERRORLEVEL%==2 (
    exit
)

::ѡ��������ʽ
:SM
title %Title%
echo �Ƿ������Զ�����?
choice /C 123 /N /M "1.�����Զ����� 2.�����Զ����� 3.�޸������ļ�����:"
if %ERRORLEVEL%==1 (
    goto RCS
)
if %ERRORLEVEL%==2 (
    cls
    echo �Զ�����:OFF
    goto RF
)
if %ERRORLEVEL%==3 goto ConfigModification

::�޸������ļ�
:ConfigModification
choice /C 12345 /N /M "1.�޸���������ʾ������ 2.�޸ķ�����ʹ�õ�java·�� 3.�޸ķ�������������ڴ� 4.�޸ķ�����ļ������� 5.�����޸Ĳ���������OpenServer:"
if %ERRORLEVEL%==1 (
    set /P Title="������������ʾ������:"
    echo ��������ʾ���������޸�Ϊ%Title%
    goto ConfigModification
)
if %ERRORLEVEL%==2 (
    set /P Customizing-Java-Path="���������ʹ�õ�java·��:"
    echo ������ʹ�õ�java·�����޸�Ϊ%Customizing-Java-Path%
    goto ConfigModification
)
if %ERRORLEVEL%==3 (
    set /P MaxRAM="�����������������ڴ�:"
    echo ��������������ڴ����޸�Ϊ%MaxRAM%
    goto ConfigModification
)
if %ERRORLEVEL%==4 (
    set /P Server-Name="���������ļ�������:"
    echo ������ļ����������޸�Ϊ%Server-Name%
    goto ConfigModification
)
if %ERRORLEVEL%==5 (
    if exist Config.bat del Config.bat
    echo ::��������>>Config.bat
    echo set Title=%Title%>>Config.bat
    echo ::Java·��>>Config.bat
    echo set Customizing-Java-Path=%Customizing-Java-Path%>>Config.bat
    echo ::�������ڴ�>>Config.bat
    echo set MaxRAM=%MaxRAM%>>Config.bat
    echo ::�������ļ�����>>Config.bat
    echo set Server-Name=%Server-Name%>>Config.bat
    cls & %0
)

::�����Զ���������ʱ
:RCS
echo ����ֻ����д�����ֲ����԰��������ַ���,�����û�л��������ѭ��
set /P RC="�����Զ���������ʱ(��ҪС��10��):"
cls
echo �Զ�����:ON
goto RT

::�Զ���������
:RT
%Customizing-Java-Path% -jar -Xmx%MaxRAM% %Server-Name%
echo �������ر��ˣ�����%RC%�����������
msg %USERNAME% /TIME 5 ����������%RC%�����������
choice /C 12 /N /T %RC% /D 1 /M  "����������%RC%�����������(1.���� 2.��ֹ�������˳�OpenServer):"
if %ERRORLEVEL%==1 goto RT
if %ERRORLEVEL%==2 exit

::�Զ���������
:RF
%Customizing-Java-Path% -jar -Xmx%MaxRAM% %Server-Name%
echo ���������ˣ�
mshta vbscript:msgbox("�������ѹر�",64,"�������ر���")(window.close)
pause
exit

::����
::�����ÿ�����Ҫ������ͨ�û�һ����һ��һ�������е���Ҫ���Եĵط������Ǻ���
:DEBUG
@echo ����������κ�CMD�ܹ����е�ָ��
@echo ��Ϊ����Ǹ��򵥵����ñ�����Ȼ��ֱ�Ӱѱ������ݵ��������е�ȡ�ɷ�ʽ
:Command
@set /P Command="OpenServer_Command>"
@if "%Command%"==0203 ( echo Hello world & goto Command )
%Command%
@goto Command

pause
exit