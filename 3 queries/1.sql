-- All flights from 'Martinez'
select flight.flightid,
    flight.takeoffdatetime,
    p.model,
    srcP.fullname as "src airport",
    dstP.fullname as "dst airport"
from (((flight natural JOIN Plane p)
	INNER JOIN airport srcP ON srcP.Airportid = flight.srcairportid)
    INNER JOIN airport dstP ON dstP.Airportid = flight.dstairportid)
where srcP.Fullname = 'Martinez';