dir *. /b >list.dat && (for /f %%a in (list.dat) do ( if exist %%a ( pushd %%a && cd >>../log.txt && git remote -v >>../git_list.dat && popd ))) && ( if exist list.dat del list.dat /f /q ) &&  ( if exist log.txt del log.txt /f /q ) 
pause
