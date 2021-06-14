-- for each plane, get how much seats in first, Business and Tourist classes
select * 
from (
	select planeid, model, p_size 
	from plane) T1
    natural join (
        select planeid, count(*) as "Tourist class"
        from planeSeat
        where class = 'T'
        group by planeid) T2
    natural join (
        select planeid, count(*) as "Business class"
        from planeSeat
        where class = 'B'
        group by planeid) T3
    natural join (
        select planeid, count(*) as "First Class"
        from planeSeat
        where class = 'F'
        group by planeid) T4;