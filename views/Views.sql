-- get src & dst shuttle bus's cities
-- used in the recursive with query
create or replace view citiesID2(srcID, dstID) as
select airport.cityID, Shuttlebusline.dstCityID
from Shuttlebusline join airport on airport.airportID = Shuttlebusline.srcAirportID;
-- view of services
create or replace view services(employeeID, flightid, servicesCount) as
select employeeID, flightid, count(*) as servicesCount
from CustomerService
group by employeeID;
-- data about flight and it src & dst airports
create or replace view FlightsCitiesNames
	(flightid, model, takeoffdatetime, srcFullname, dstFullname) AS
select flight.flightid, p.model, flight.takeoffdatetime, srcP.fullname,dstP.fullname
from (((flight natural JOIN Plane p)
	INNER JOIN airport srcP ON srcP.Airportid = flight.srcairportid)
	INNER JOIN airport dstP ON dstP.Airportid = flight.dstairportid);

-- update the following queries to use it:
-- All flights from 'Martinez'
select *
from FlightsCitiesNames
where srcFullname = 'Martinez';
-- get takeoffdatetime from given src&dst firports name:
select flightid, model, takeoffdatetime
from FlightsCitiesNames
where srcFullname = 'Duffy' and dstFullname = 'Banks';