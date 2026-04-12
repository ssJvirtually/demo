@echo off
echo Setting up Visual Studio 2019 Build Tools environment...
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64

echo.
echo Setting JAVA_HOME to GraalVM...
set JAVA_HOME=C:\Program Files\Java\graalvm-jdk-25.0.2+10.1
set PATH=%JAVA_HOME%\bin;%PATH%

echo.
echo Java version:
java -version

echo.
echo Native-image version:
native-image --version

echo.
echo Building native image...
cd /d C:\Users\jskr4\Downloads\demo
call mvn clean native:compile -Pnative

echo.
echo Build complete! Check target\demo.exe
pause
