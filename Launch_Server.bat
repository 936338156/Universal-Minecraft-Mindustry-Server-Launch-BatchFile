::����:[Title = ����],[Java_Path = Java·��],[MaxRAM = ����ڴ�],[MinRAM = ��С�ڴ�],[Server_Name = ������ļ�����],[Countdown = ��������ʱ]
::��ת��ǩ:[Check_Config = ��������ļ�],[Set_Config = ���������ļ�],[Pre-Launch_Options = ����ǰѡ��],[Config_Modification = �޸������ļ�],[Launch_Server = ����������]
@echo off
::��ʼ������
set Title=Launch_Server
set Java_Path=java
set MaxRAM=2G
set MinRAM=1G
::��������ļ�
:Check_Config
if exist Config.bat (
    echo ���������ļ�
    call Config.bat
    goto Pre-Launch_Options
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
set /P MaxRAM="������ϣ�������������������ڴ�[��ʽ:?G��?M]:"
set /P MinRAM="������ϣ�����������������С�ڴ�[��ʽ:?G��?M]:"
set /P Server_Name="���������ļ���������׺'.jar':"
set /P Countdown="����������������رպ���Զ���������ʱ:"
echo ��ȷ��������Ϣ��ȷ
echo �����������������ڴ�:%MaxRAM%
echo ���������������С�ڴ�:%MinRAM%
echo ������ļ�:%Server_Name%
echo ��������ʱ:%Countdown%
choice /C 12 /N /M "1.�������ò����� 2.��������:"
::�������ò���
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
::ѡ��������ʽ
:Pre-Launch_Options
title %Title%
choice /C 1234 /N /T 10 /D 1 /M "10s���Զ�����������(1.��������ʱ 2.�޸������ļ����� 3.�˳�����):"
if %ERRORLEVEL%==1 goto Launch_Server
if %ERRORLEVEL%==2 goto Config_Modification
if %ERRORLEVEL%==3 exit
::�޸������ļ�
:Config_Modification
echo 1.�޸������б�����ʾ������
echo 2.�޸ķ�����ʹ�õ�java·��
echo 3.�޸ķ����������������ڴ�
echo 4.�޸ķ��������������С�ڴ�
echo 5.�޸ķ�����ļ���
echo 6.�޸���������ʱ
echo 7.�����޸Ĳ���������
choice /C 1234567 /N /M "8.�����޸Ĳ���������:"
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
    set /P MaxRAM="��������������������ڴ�:"
    echo �����������������ڴ����޸�Ϊ%MaxRAM%
    goto ConfigModification
)
if %ERRORLEVEL%==4 (
    set /P MaxRAM="������������������С�ڴ�:"
    echo ���������������С�ڴ����޸�Ϊ%MinRAM%
    goto ConfigModification
)
if %ERRORLEVEL%==5 (
    set /P Server_Name="���������ļ�������:"
    echo ������ļ����������޸�Ϊ%Server_Name%
    goto ConfigModification
)
if %ERRORLEVEL%==6 (
    set /P Countdown="������������ʱ:"
    echo ������ļ����������޸�Ϊ%Countdown%
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
::����������
:Launch_Server
cls
%Java-Path% -jar -Xmx%MaxRAM% -Xms%MinRAM% .\%Server_Name%
if %ERRORLEVEL%==0 (
    echo �������ѹر�
    pause
    exit
)
msg %USERNAME% /TIME %Countdown% "�������������رգ�����%Countdown%���������������������"
choice /C 12 /N /T %Countdown% /D 1 /M  "�������������ر�,����%Countdown%�����������������(1.��������ʱ 2.��ֹ�������˳�Launch_Server):"
if %ERRORLEVEL%==1 goto Launch_Server
if %ERRORLEVEL%==2 exit