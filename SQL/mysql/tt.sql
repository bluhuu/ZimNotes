select * from mysql.boxes;
select * from mysql.warehouses;
select * from mysql.boxes where value>150;
select distinct contents from boxes;
select avg(value) from boxes;
select warehouse,avg(value) from boxes group by warehouse having avg(value)>150;
select b.code,b.contents,b.value, w.Location from boxes b inner join mysql.warehouses w on b.Warehouse = w.Code;
select count(1),w.code from mysql.warehouses w inner join mysql.boxes b on b.Warehouse=w.Code group by b.warehouse;
select w.code from mysql.warehouses w inner join mysql.boxes b on b.Warehouse=w.Code group by b.warehouse,w.Capacity having count(1)>w.Capacity;
SELECT * FROM Warehouses WHERE Capacity < ( SELECT COUNT(*) FROM Boxes WHERE Warehouse = Warehouses.Code );
select * from warehouses where Capacity < (select count(*) from boxes where Warehouse = Warehouses.Code);
select * from mysql.boxes b inner join mysql.warehouses w on b.Warehouse = w.Code where w.Location='Chicago';
insert into mysql.warehouses(code,location,Capacity) values(6,'New York',3);
DELETE FROM `warehouses` WHERE `code` = '6';
