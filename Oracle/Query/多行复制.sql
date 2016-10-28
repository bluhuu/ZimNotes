select * from WX_MENU where WX_ACCOUNT_ID=1000003;


declare
    cursor rowAll is select * from WX_MENU where WX_ACCOUNT_ID=1000000;
    row1 WX_MENU%rowtype;
    i int;
    begin
    i := 1;
    for row1 in rowAll
    loop
        row1.WX_ACCOUNT_ID := 1000003;
        row1.WX_MENU_ID := 1000037 + i;
        i:=i+1;
        insert into WX_MENU values row1;
    end loop;
end;
