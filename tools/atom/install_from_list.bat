@echo ========================== install_from_list ==========================
@echo ------------------------- git_from_list -------------------------
@for /f %%a in (git_list.dat) do @( echo %%a >>log.txt && git clone %%a >>log.txt )
@echo ------------------------- update_and_install -------------------------
call update_and_install.bat
@echo ========================== end_install ==========================
@echo 请 link 到 atom！
pause
