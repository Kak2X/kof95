@echo off
echo Assembling...
rgbds\rgbasm -h -L -vo -v -o kof95u.o config-us.asm
if %ERRORLEVEL% neq 0 goto assemble_fail

echo Linking...
rgbds\rgblink -m kof95u.map -n kof95u.sym -d -o kof95u.gb kof95u.o
if %ERRORLEVEL% neq 0 goto link_fail

echo ==========================
echo   Build Success.
echo ==========================
echo Fixing header checksum...
rgbds\rgbfix -v kof95u.gb
if EXIST original_us.gb ( fc /B kof95u.gb original_us.gb | more )

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