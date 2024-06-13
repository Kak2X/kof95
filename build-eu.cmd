@echo off
echo Assembling...
rgbds\rgbasm -h -L -vo -v -o kof95e.o config-eu.asm
if %ERRORLEVEL% neq 0 goto assemble_fail

echo Linking...
rgbds\rgblink -m kof95e.map -n kof95e.sym -d -o kof95e.gb kof95e.o
if %ERRORLEVEL% neq 0 goto link_fail

echo ==========================
echo   Build Success.
echo ==========================
echo Fixing header checksum...
rgbds\rgbfix -v kof95e.gb
if EXIST original_eu.gb ( fc /B kof95e.gb original_eu.gb | more )

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