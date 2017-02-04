for /f %%a in (git_list.dat) do ( echo %%a >>log_git.txt && git clone %%a >>log_git.txt )
pause
