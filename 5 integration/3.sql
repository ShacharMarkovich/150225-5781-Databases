-- get the top 40 flights with most customerService calls
select flightID, srcA.fullname, dstA.fullname, count(*) as servicesCount
from CustomerService natural join (
        (flight inner join airport srcA on flight.srcairportid = srcA.airportID )
        inner join airport dstA on flight.dstAirportid = dstA.airportID)
group by flightID
order by servicesCount OFFSET 0 ROWS FETCH NEXT 40 ROWS ONLY;