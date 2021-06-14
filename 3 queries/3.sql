-- Shuttles buses lines count per airport
Select airportid, fullname, sum(buscount) AS "Shuttles buses lines count"
from Shuttlebusline inner join airport on srcairportid = airportid
group by airportid, fullname;
