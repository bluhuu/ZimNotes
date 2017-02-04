dir *. /b >list.dat && (for /f %%a in (list.dat) do ( if exist %%a apm link %%a)) && if exist list.dat del list.dat /f /q
