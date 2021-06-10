-- get takeoffdatetime from given src&dst firports name:
select flightid, model, takeoffdatetime
from (((flight natural JOIN Plane p)
	INNER JOIN airport srcP ON srcP.Airportid = flight.srcairportid)
	INNER JOIN airport dstP ON dstP.Airportid = flight.dstairportid)
where srcP.fullname = 'Duffy' and dstP.fullname = 'Banks';