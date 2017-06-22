@echo ========================== install_from_list ==========================
@echo ------------------------- git_from_list -------------------------
@for /f "delims=()" %%a in (git_list.dat) do @( echo %%a >>log.txt && git clone %%a >>log.txt )
@echo ------------------------- update_and_install -------------------------
call update_and_install.bat
@echo ========================== end_install ==========================
@echo Çë link µ½ atom£¡
pause
