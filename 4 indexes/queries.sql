-- indexes:
create index bus_id_index on Shuttlebusline(srcAirportID);
create index plane_id_index on Shuttlebusline(planeid, model, p_size);
-- Shuttles buses lines count per airport
Select airportid, fullname, sum(buscount) AS "Shuttles buses lines count"
from Shuttlebusline inner join airport on srcairportid = airportid
group by airportid, fullname;
-- get count of seats in plane and how much with windows,
-- if seat is with window - planeSeat.isWithWindow val is 1, else - 0
select planeid, model, p_size as "seats count", sum(isWithWindow) as "seats with windows"
from plane natural join planeSeat
group by planeid, model, p_size
order by fullname;
-- for each plane, get how much seats in first, Business and Tourist classes
select * 
from (select planeid, model, p_size from plane) T1
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