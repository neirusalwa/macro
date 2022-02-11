<# : macro.bat
@echo off
@chcp 65001 >nul
title macro maker
set T=1
set Z=1
set pvp=

:type
cls
echo Macro type : (Default : mo)
echo 1 : Mouseover (^<mo^>)
echo 2 : Focus Target (^<f^>)
echo 3 : Focus target + Every Party member (^<f^> -^> ^<8^>)
echo 4 : Co-tank (^<2^>)
echo 5 : Self (^<me^>)
echo 6 : Custom (^<[input]^>)
set /p T=""
cls
echo Content type : (Default : PvE)
echo 1 : PvE
echo 2 : PvP
set /p Z=""
cls
echo Ability's name :
set /p N=""
call :%T%

:1
cls
set x=mo
call :build

:2
cls
set x=f
call :build

:3
cls
call :build

:4
cls
set x=2
call :build

:5
cls
set x=me
call :build

:6
cls
echo Selector :
set /p x=""
call :build

:build
cls
if %Z% neq 1 set pvp=pvp
echo ^/merror off > "%N%.txt"
::im lazy and dont want to implement the slightly better party macro thing (use 2 lines per number)
if %T% == 3 (
    call :loop1
) else (
    call :loop2
)

:loop1
echo ^/%pvp%ac "%N%" ^<f^> >> "%N%.txt"
for /L %%G in (2,1,8) do echo ^/%pvp%ac "%N%" ^<%%G^> >> "%N%.txt"
call :end

:loop2
for /L %%G in (1,1,13) do echo ^/%pvp%ac "%N%" ^<%x%^> >> "%N%.txt"
call :end

:end
echo ^/micon "%N%" %pvp%action >> "%N%.txt"
echo Done (?)
pause
exit
#>