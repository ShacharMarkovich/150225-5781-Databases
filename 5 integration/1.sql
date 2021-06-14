-- get for each flight how much tickets sold
select flightid, count(*)
from filghtticket natural join flight natural join Plane
where status = 'S'
group by flightID;