::����:[Title = ����],[Java_Path = Java·��],[MaxRAM = ����ڴ�],[Server_Name = ������ļ�����],[Countdown = ��������ʱ],[Command = ��������]
::��ת��ǩ:[Check_additional_parameters = ��鸽�Ӳ���],[Check_Config = ��������ļ�],[Set_Config = ���������ļ�],[Select_start_method = ѡ��������ʽ],[Config_Modification = �޸������ļ�],[�洫����],[Command = ��������],
@echo off
::��ʼ������
set Title=Launch_Server
set Java_Path=java

::��鸽�Ӳ���
:Check_additional_parameters
if /I "%1"=="Command" cls & goto Command

::��������ļ�
:Check_Config
if exist Config.bat (
    echo ���������ļ�
    call Config.bat
    goto Select_start_method
) else (
    echo δ���������ļ�
    echo ���ֶ���дһЩ��Ҫ����Ϣ�����Դ�Ϊ�������������ļ�
    goto Set_Config
)

::���������ļ�
:Set_Config
title %Title%
choice /C YN /N /M "����豸�ж��Java��û��JAVA_HOME?ϣ��ָ��һ��Java·��?(Y/N):"
if /I %ERRORLEVEL%==1 (
    echo Java��װ·�� ��:D:\Program_Files\Java\jdk-17.0.2\bin\java.exe
    set /P Java-Path="����Java��װ·��:"
    echo ��ʹ���Զ���Java·��
)
if /I %ERRORLEVEL%==2 (
    set Java-Path=java
    echo ��ʹ��Ĭ��java·��
)
set /P MaxRAM="������ϣ����������������ڴ�[��ʽ:?G��?M]:"
set /P Server_Name="���������ļ������ư�����׺'.jar':"
set /P Countdown="������������ʱ:"
echo ��ȷ��������Ϣ��ȷ
echo ��������������ڴ�:%MaxRAM%
echo ������ļ�:%Server_Name%
choice /C 12 /N /M "1.�������ò����� 2.��������:"
::�������ò���
if %ERRORLEVEL%==1 (
    title %Title%
    if exist Config.bat del Config.bat
    echo ::��������>>Config.bat
    echo set Title=%Title%>>Config.bat
    echo ::Java·��>>Config.bat
    echo set Java-Path=%Java-Path%>>Config.bat
    echo ::�������ڴ�>>Config.bat
    echo set MaxRAM=%MaxRAM%>>Config.bat
    echo ::�������ļ�����>>Config.bat
    echo set Server_Name=%Server_Name%>>Config.bat
    echo ::��������ʱ>>Config.bat
    echo set Countdown=%Countdown%>>Config.bat
    goto Select_start_method
)
if %ERRORLEVEL%==2 goto

::ѡ��������ʽ
:Select_start_method
title %Title%
choice /C 1234 /N /M "1.�����Զ����� 2.�����Զ����� 3.�޸������ļ����� 4.�˳�����:"
if %ERRORLEVEL%==1 goto Restart_on
if %ERRORLEVEL%==2 goto Restart_off
if %ERRORLEVEL%==3 goto Config_Modification
if %ERRORLEVEL%==4 exit


::�޸������ļ�
:Config_Modification
choice /C 1234567 /N /M "1.�޸���������ʾ������ 2.�޸ķ�����ʹ�õ�java·�� 3.�޸ķ�������������ڴ� 4.�޸ķ�����ļ������� 5.�޸���������ʱ 6.�����޸Ĳ��������� 7.�����޸�:"
if %ERRORLEVEL%==1 (
    set /P Title="������������ʾ������:"
    echo ��������ʾ���������޸�Ϊ%Title%
    goto ConfigModification
)
if %ERRORLEVEL%==2 (
    set /P Java-Path="���������ʹ�õ�java·��:"
    echo ������ʹ�õ�java·�����޸�Ϊ%Java-Path%
    goto ConfigModification
)
if %ERRORLEVEL%==3 (
    set /P MaxRAM="�����������������ڴ�:"
    echo ��������������ڴ����޸�Ϊ%MaxRAM%
    goto ConfigModification
)
if %ERRORLEVEL%==4 (
    set /P Server_Name="���������ļ�������:"
    echo ������ļ����������޸�Ϊ%Server_Name%
    goto ConfigModification
)
if %ERRORLEVEL%==5 (
    set /P Countdown="������������ʱ:"
    echo ������ļ����������޸�Ϊ%Countdown%
    goto ConfigModification
)
if %ERRORLEVEL%==6 (
    if exist Config.bat del Config.bat
    echo ::��������>>Config.bat
    echo set Title=%Title%>>Config.bat
    echo ::Java·��>>Config.bat
    echo set Java-Path=%Java-Path%>>Config.bat
    echo ::�������ڴ�>>Config.bat
    echo set MaxRAM=%MaxRAM%>>Config.bat
    echo ::�������ļ�����>>Config.bat
    echo set Server_Name=%Server_Name%>>Config.bat
    echo ::��������ʱ>>Config.bat
    echo set Countdown=%Countdown%>>Config.bat
    cls & %0
)
if %ERRORLEVEL%==7 goto Select_start_method

::�洫����
::�Զ���������
:Restart_on
cls
%Java-Path% -jar -Xmx%MaxRAM% %Server_Name%
echo �������ر��ˣ�����%Countdown%�����������
msg %USERNAME% /TIME 5 ����������%Countdown%�����������
choice /C 12 /N /T %Countdown% /D 1 /M  "����������%Countdown%�����������(1.���� 2.��ֹ�������˳�Launch_Server):"
if %ERRORLEVEL%==1 goto Restart_on
if %ERRORLEVEL%==2 exit

::�洫����
::�Զ���������
:Restart_off
cls
%Java-Path% -jar -Xmx%MaxRAM% %Server_Name% %Additional_start_parameters%
echo �������ر��ˣ�
msg %USERNAME% /TIME 5 �������ر���
pause
exit

::��������
::�����ÿ�����Ҫ������ͨ�û�һ����һ��һ�������е���Ҫ���Եĵط������Ǻ���
:Command
@set /P Command="Command<<"
%Command%
@goto Command