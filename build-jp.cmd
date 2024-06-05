@echo off
echo Assembling...
rgbds\rgbasm -h -L -vo -v -o kof95.o config-jp.asm
if %ERRORLEVEL% neq 0 goto assemble_fail

echo Linking...
rgbds\rgblink -m kof95.map -n kof95.sym -d -o kof95.gb kof95.o
if %ERRORLEVEL% neq 0 goto link_fail

echo ==========================
echo   Build Success.
echo ==========================
echo Fixing header checksum...
rgbds\rgbfix -v kof95.gb
if EXIST original_jp.gb ( fc /B kof95.gb original_jp.gb | more )

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