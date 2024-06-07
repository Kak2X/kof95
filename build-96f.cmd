@echo off
echo Assembling...
rgbds\rgbasm -h -L -vo -v -o kof96f.o config-96f.asm
if %ERRORLEVEL% neq 0 goto assemble_fail

echo Linking...
rgbds\rgblink -m kof96f.map -n kof96f.sym -d -o kof96f.gb kof96f.o
if %ERRORLEVEL% neq 0 goto link_fail

echo ==========================
echo   Build Success.
echo ==========================
if EXIST original_96f.gb ( fc /B kof96f.gb original_96f.gb | more )

goto end

:assemble_fail
echo Error while assembling.
goto fail
:link_fail
echo Error while linking.
:fail

echo ==========================
echo   Build failure.
echo ==========================

:end
pause