::����:[title = ����],[javaPath = Java·��],[maxRam = ����ڴ�],[minRam = ��С�ڴ�],[serverName = ������ļ�����],[countdown = ��������ʱ]
::��ת��ǩ:[CheckConfig = ��������ļ�],[SetConfig = ���������ļ�],[PreLaunchOptions = ����ǰѡ��],[ConfigModification = �޸������ļ�]
::�����������������������jar�ļ�
@echo off
cls
::��ʼ��
set title=Launch_Server
set javaPath=%JAVA_HOME%\bin\java.exe
set maxRam=2G
set minRam=1G
::��������ļ�
:CheckConfig
if exist Config.bat (
    echo ���������ļ�
    call Config.bat
    goto PreLaunchOptions
) else (
    echo δ���������ļ�
    echo ���ֶ���дһЩ��Ҫ����Ϣ�����Դ�Ϊ�������������ļ�
    goto SetConfig
)
::���������ļ�
:SetConfig
title %title%
choice /C YN /N /M "����豸�ж��Java��û��JAVA_HOME?(Y.ָ��һ��·�� N.ʹ��Ĭ�ϵ�·��):"
if /I %ERRORLEVEL%==1 (
    echo Java·�� ��:'D:\Program_Files\Java\jdk-17.0.2\bin\java.exe'
    set /P javaPath="����Java·��:"
    echo ʹ��ָ��Java·��
)
if /I %ERRORLEVEL%==2 (
    set javaPath=%JAVA_HOME%\bin\java.exe
    echo ʹ��Ĭ��java·��
)
set /P maxRam="�����������������ڴ�[��ʽ:?G��?M]:"
set /P minRam="���������������С�ڴ�[��ʽ:?G��?M]:"
set /P serverName="������ļ���������׺'.jar':"
set /P countdown="�������رպ���Զ���������ʱ:"
echo ��ȷ��������Ϣ��ȷ
echo �����������������ڴ�:%maxRam%
echo ���������������С�ڴ�:%minRam%
echo ������ļ�:%serverName%
echo ��������ʱ:%countdown%
choice /C 12 /N /M "1.�������ò����� 2.��������:"
::�������ò���
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
::ѡ��������ʽ
:PreLaunchOptions
title %title%
choice /C 1234 /N /T 10 /D 1 /M "10s���Զ�����������(1.��������ʱ(�����Զ�����) 2.������һ��(�����Զ�����) 3.�޸������ļ����� 4.�˳�����):"
if %ERRORLEVEL%==1 set restart=true & goto LaunchServer_0
if %ERRORLEVEL%==2 set restart=false & goto LaunchServer_0
if %ERRORLEVEL%==3 goto ConfigModification
if %ERRORLEVEL%==4 exit
::�޸������ļ�
:ConfigModification
cls
echo 1.�޸������б�����ʾ������
echo 2.�޸ķ�����ʹ�õ�java·��
echo 3.�޸ķ����������������ڴ�
echo 4.�޸ķ��������������С�ڴ�
echo 5.�޸ķ�����ļ���
echo 6.�޸���������ʱ
echo 7.�����޸Ĳ���������
echo 8.�����޸Ĳ���������
choice /C 12345678 /N /M "��ѡ����Ҫ�޸ĵ�ѡ��:"
if %ERRORLEVEL%==1 (
    set /P title="������������ʾ������:"
    goto ConfigModification
)
if %ERRORLEVEL%==2 (
    set /P javaPath="���������ʹ�õ�java·��:"
    goto ConfigModification
)
if %ERRORLEVEL%==3 (
    set /P maxRam="��������������������ڴ�:"
    goto ConfigModification
)
if %ERRORLEVEL%==4 (
    set /P maxRam="������������������С�ڴ�:"
    goto ConfigModification
)
if %ERRORLEVEL%==5 (
    set /P serverName="���������ļ�������:"
    goto ConfigModification
)
if %ERRORLEVEL%==6 (
    set /P countdown="������������ʱ:"
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
::����������
:LaunchServer_0
::һ�����������ڷ���������ʱ������������frp֮��Ķ�����ֱ�������ע���������дҪ�ڿ���ʱֻ����һ�εľ�����
:LaunchServer_1
cls
%javaPath% -jar -Xmx%maxRam% -Xms%minRam% .\%serverName%
if %restart%==false (
    echo �������ѹر�
    pause
    exit
)
msg %USERNAME% /TIME %countdown% "�������رգ�����%countdown%�����������������"
choice /C 12 /N /T %countdown% /D 1 /M  "�������رգ�����%countdown%�����������������(1.��������ʱ 2.��ֹ�������˳�Launch_Server):"
if %ERRORLEVEL%==1 goto LaunchServer_1
exit