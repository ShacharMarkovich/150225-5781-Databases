-- get for each flight how much tickets sold
select flightid, count(*)
from filghtticket natural join flight natural join Plane
where status = 'S'
group by flightID;
-- get in each airport the employee that service most
select E.employeeID, ep.fullname, Airport.fullname, E.servicesCount
from Airport
    natural join Employee ep
    natural join ( select employeeID, count(*) as servicesCount
        from CustomerService
        group by employeeID
        order by servicesCount OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY
    ) E;
-- get the top 40 flights with most customerService calls
select flightID, srcA.fullname, dstA.fullname, count(*) as servicesCount
from CustomerService natural join (
        (flight inner join airport srcA on flight.srcairportid = srcA.airportID )
        inner join airport dstA on flight.dstAirportid = dstA.airportID)
group by flightID
order by servicesCount OFFSET 0 ROWS FETCH NEXT 40 ROWS ONLY;