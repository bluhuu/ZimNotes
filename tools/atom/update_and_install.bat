@dir *. /b >list.dat && @(for /f %%a in (list.dat) do @( if exist %%a @( pushd %%a && cd >>../log.txt && git fetch --all >>../log.txt && git reset --hard origin/master >>../log.txt && npm i >>../log.txt && popd ))) && ( if exist list.dat del list.dat /f /q ) &&  ( if exist log.txt del log.txt /f /q ) 
pause
