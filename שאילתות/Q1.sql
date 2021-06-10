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
--- All airport in Brownborough's City
Select airportid, fullname, ABBREVIATION
from airport natural join city
where city.name = 'Port Donald'
order by fullname;
-- Shuttles buses lines count per airport
Select airportid, fullname, sum(buscount) AS "Shuttles buses lines count"
from Shuttlebusline inner join airport on srcairportid = airportid
group by airportid, fullname;
-- get count of seats in plane and how much with windows,
-- if seat is with window - planeSeat.isWithWindow val is 1, else - 0
select planeid, model, p_size as "seats count",
    sum(isWithWindow) as "seats with windows"
from plane natural join planeSeat
group by planeid, model, p_size
order by fullname;
-- get takeoffdatetime from given src&dst firports name:
select flightid, model, takeoffdatetime
from (((flight natural JOIN Plane p)
	INNER JOIN airport srcP ON srcP.Airportid = flight.srcairportid)
	INNER JOIN airport dstP ON dstP.Airportid = flight.dstairportid)
where srcP.fullname = 'Duffy' and dstP.fullname = 'Banks';
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
-- get all planes which the actual weight passing the max allowed weight
select planeid, model, currWeight, maxWeight
from plane
where currWeight > maxWeight;
-- get a full path of Shuttlebusline from city to final city
create or replace view citiesID2(srcID, dstID) as
select airport.cityID, Shuttlebusline.dstCityID
from Shuttlebusline join airport on airport.airportID = Shuttlebusline.srcAirportID;
with citiesID(srcID, dstID) 
as (select airport.cityID, Shuttlebusline.dstCityID
    from Shuttlebusline join airport on airport.airportID = Shuttlebusline.srcAirportID
    union all
    select C1.srcID, C2.dstID
    from citiesID C1 join citiesID2 C2 on C1.dstID != C2.srcID)
select cSrc.name, cDst.name
from ((citiesID JOIN City cSrc ON cSrc.cityID = citiesID.srcID)
        JOIN City cDst ON cDst.cityID = citiesID.dstID);