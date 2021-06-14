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