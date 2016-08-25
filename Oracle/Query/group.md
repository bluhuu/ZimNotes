# Group
## 季度分组
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
```
## 分组函数
```sql
-- wm_concat分组连接函数
select deptno,wm_concat(ename) from emp group by deptno;
-- count,avg 忽略空值
select sum(comm)/count(*),sum(comm)/count(comm),avg(comm) from emp;
----157   550   550
----select count(*),count(nvl(comm,0)) from emp;
```
## group by 增强
```sql
select deptno,job,sum(sal) from emp group by deptno,job;
select deptno,sum(sal) from emp group by deptno;
select sum(sal) from emp;
====
select deptno,job,sum(sal) from emp group by rollup(deptno,job);
====设置:break on deptno skip 2
====部门号只显示一次,不同部门跳过一行
```
## 树查询
```sql
SELECT CDID,FCDID,
       DECODE( NVL(LEVEL2,0),
               0,SUBSTR('││││││',1,LEVEL1 - 1)||'└',
               DECODE(LEVEL2 - LEVEL1,
                      0,SUBSTR('││││││',1,LEVEL1 - 1)||'├',
                      1,SUBSTR('││││││',1,LEVEL1 - 1)||'├',
                        SUBSTR('││││││',1,LEVEL1 - 1)||'└'
                      )
              )||CDM CDM
  FROM (
SELECT CDID,CDM,FCDID,
       LEVEL LEVEL1,LEAD(LEVEL,1)  OVER (ORDER BY ROWNUM) LEVEL2
  FROM PF_MENU
  WHERE CDM<>'-'
CONNECT BY FCDID= PRIOR CDID START WITH  FCDID='0'
--ORDER SIBLINGS BY CDID
)

--connect by是结构化查询中用到的，其基本语法是：
select ... from tablename
start by cond1
connect by cond2
where cond3
--简单说来是将一个树状结构存储在一张表里，比如一个表中存在两个字段(如emp表中的empno和mgr字段):empno, mgr那么通过表示每一条记录的mgr是谁，就可以形成一个树状结构。
--用上述语法的查询可以取得这棵树的所有记录。
--其中：
--cond1是根结点的限定语句，当然可以放宽限定条件，以取得多个根结点，实际就是多棵树。
--cond2是连接条件，其中用prior表示上一条记录，比如connect by prior id=praentid就是说上一条记录的id是本条记录的praentid，即本记录的父亲是上一条记录。
--cond3是过滤条件，用于对返回的所有记录进行过滤。
--prior和start with关键字是可选项
--prior运算符必须放置在连接关系的两列中某一个的前面。对于节点间的父子关系，prior运算符在一侧表示父节点，在另一侧表示子节点，从而确定查找树结构是的顺序是自顶向下还是自底向上。在连接关系中，除了可以使用列名外，还允许使用列表达式。
--start with子句为可选项，用来标识哪个节点作为查找树型结构的根节点。若该子句被省略，则表示所有满足查询条件的行作为根节点。
```
