# Group
### 季度分组
```sql
select year, quarter, count(1)
from (
    select year,
        case
        when month < 4 then 1
        when month < 7 then 2
        when month < 10 then 3
        else 4
        end as quarter
    from table
) as result
group by year, quarter;
--其它
select trunc((4-1)/3) from dual;
-- wm_concat分组连接函数
select deptno,wm_concat(ename) from emp group by deptno;
-- count,avg 忽略空值
select sum(comm)/count(*),sum(comm)/count(comm),avg(comm) from emp;
----157   550   550
----select count(*),count(nvl(comm,0)) from emp;
--group by 增强
select deptno,job,sum(sal) from emp group by deptno,job;
select deptno,sum(sal) from emp group by deptno;
select sum(sal) from emp;
====
select deptno,job,sum(sal) from emp group by rollup(deptno,job);
```
