@echo off
@rem 日本語使うなら文字コードは Shift-JIS に
@rem xcopy は/じゃなくて\でないとダメらしい(1敗)
setlocal EnableDelayedExpansion
cd %1

set dist_org=..\修正\

@rem git diff で新規ファイルを表示させるには下記コマンドが必要
@rem git add -N .

for /f "usebackq delims=" %%i in (`git diff --name-only`) do (
	set hoge=%%i
@rem xcopy のためにパスの"/"を""\"に置換
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


@rem ネットからコピペ. バッチファイルでやるの面倒だから適当なCプログラムでも書けばいい気もする
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
