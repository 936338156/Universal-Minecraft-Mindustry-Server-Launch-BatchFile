@echo off
title Config-Conversion
echo [%time%] [I] ����Ҫת���������ļ����ڵ��ļ���·��(��: D:\�ļ���)
echo [%time%] [I] �������Ŀ���ļ���Ѱ�������ļ�
set /p Config-Path="[%time%] [UI] Ŀ���ļ���<<"
if "%Config-Path%"=="" echo [%time%] [E] ����Ϊ��
if exist %Config-Path%\Config.bat call %Config-Path%\Config.bat
if exist %Config-Path%\Config.bat (
    if exist %~dp0Config.bat del %~dp0Config.bat
    echo [%time%] [I] ���ڴ���
    echo ::��������>>%~dp0Config.bat
    echo set Title=OpenServer>>%~dp0Config.bat
    echo ::Java·��>>%~dp0Config.bat
    echo set Customizing-Java-Path=%CJP%>>%~dp0Config.bat
    echo ::�������ڴ�>>%~dp0Config.bat
    echo set MaxRAM=%MRAM%>>%~dp0Config.bat
    echo ::�������ļ�����>>%~dp0Config.bat
    echo set Server-Name=%SN%>>%~dp0Config.bat
    echo [%time%] [I] �������
    echo [%time%] [I] �ѽ�������ɵ�Config�ļ������%~dp0Config.bat
    pause
    exit
)
if %ERRORLEVEL%==0 (
    echo [%time%] [E] ����ʧ��
    echo [%time%] [E] ԭ�������Ŀ���ļ���·������д��ȷ��Ŀ���ļ��в�����
    pause
    exit
)

pause
exit