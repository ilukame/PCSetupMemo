@echo off
@rem ���{��g���Ȃ當���R�[�h�� Shift-JIS ��
@rem xcopy ��/����Ȃ���\�łȂ��ƃ_���炵��(1�s)
setlocal EnableDelayedExpansion
cd %1

set dist_org=..\�C��\

@rem git diff �ŐV�K�t�@�C����\��������ɂ͉��L�R�}���h���K�v
@rem git add -N .

for /f "usebackq delims=" %%i in (`git diff --name-only`) do (
	set hoge=%%i
@rem xcopy �̂��߂Ƀp�X��"/"��""\"�ɒu��
	set hoge=!hoge:/=\!
@rem	echo !hoge!
	call :SUB "%%i"
@rem	set /a j=j-1
@rem	call echo %%hoge:~0,!J!%%
	call set dist=%%hoge:~0,!J!%%
@rem	echo !dist!
	set dist=!dist_org!!dist!
@rem	echo !dist!
	xcopy !hoge! !dist! /I /E /D /Y
)
@rem call echo %%LINE:~0,%J%%%
exit


@rem �l�b�g����R�s�y. �o�b�`�t�@�C���ł��̖ʓ|������K����C�v���O�����ł������΂����C������
@rem https://teratail.com/questions/n30eda6h6sm61d
:SUB
	set LINE=%~1
	set I=0
:LOOP
	call set C=%%LINE:~%I%,1%%
	if "%C%"=="" goto NEXT
	if "%C%"=="/" set /a J=%I%+1
	set /a I+=1
	goto LOOP
:NEXT
	exit /b

@rem pause > nul
