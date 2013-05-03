:: run this from a VS x86 command prompt
@echo off

SET PACKAGE_NAME=zlib-1.2.8

nmake -f win32\Makefile.msc clean
nmake -f win32\Makefile.msc LOC="-DASMV -DASMINF" OBJA="inffas32.obj match686.obj"
set ZLIB_SRC=%cd%
set ZLIB_DEST=%cd%-x86
nmake -f win32\Makefile.msc test
echo.Press return when ready to install!
pause

rmdir /q /s %ZLIB_DEST%
mkdir %ZLIB_DEST%
mkdir %ZLIB_DEST%\bin
mkdir %ZLIB_DEST%\include
mkdir %ZLIB_DEST%\lib
mkdir %ZLIB_DEST%\share
mkdir %ZLIB_DEST%\share\doc
mkdir %ZLIB_DEST%\share\doc\zlib
copy zlib.h %ZLIB_DEST%\include
copy zconf.h %ZLIB_DEST%\include
copy zdll.lib %ZLIB_DEST%\lib
copy zlib1.dll %ZLIB_DEST%\bin
copy zlib1.pdb %ZLIB_DEST%\bin
copy README %ZLIB_DEST%\share\doc\zlib\COPYING
nmake -f win32\Makefile.msc clean

cd %ZLIB_DEST%
set PATH=%PATH%;%ProgramFiles%\7-zip
del ..\%PACKAGE_NAME%-x86.7z
7z a ..\%PACKAGE_NAME%-x86.7z *
cd %ZLIB_SRC%
rmdir /q /s %ZLIB_DEST%

echo.Finished!
pause
