@echo off
set limit=1000
mkdir check 2> nul
g++ gen.cpp -o check/gen -O2 -std=c++14 -W 
g++ code.cpp -o check/code -O2 -std=c++14 -W 
g++ brute.cpp -o check/brute -O2 -std=c++14 -W 
copy timer.py check > nul
cd check
set count=0
:loop
set /a count=%count%+1
gen > in.txt
brute < in.txt > ans.txt
for /f "tokens=1,2,3 delims= " %%a in ('timer.py %limit%') do (
	set timeout=%%a
	set used=%%b
	set code=%%c
)
if %used% gtr %limit% (
	if %timeout% equ 1 (
		echo Test Case #%count%: [36mTime Limit Exceeded[0m ^(^>%used%ms^)
	) else (
		echo Test Case #%count%: [36mTime Limit Exceeded[0m ^(%used%ms^)
	)
) else if %code% neq 0 (
	echo Test Case #%count%: [35mRuntime Error[0m ^(%used%ms^)
) else (
	fc out.txt ans.txt /N /w > res.txt
	if errorlevel 1 ( 
		echo Test Case #%count%: [31mWrong Answer[0m ^(%used%ms^)
	) else (
		echo Test Case #%count%: [32mAccepted[0m ^(%used%ms^)
		goto :loop
	)
)