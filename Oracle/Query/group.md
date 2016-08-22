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
```
