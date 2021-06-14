-- return if flight exists and take of time of flight from given src city to given dst city
create or replace function IsHasFlight(
    srcCityName in varchar,
    dstCityName in varchar,
    takeOfTime out date
  ) return varchar is flightExists varchar(5) := 'false';
begin
select 'true' into flightExists
from FlightsCitiesNames
where srcCityName = srcFullname
  and dstCityName = dstFullname;
select takeoffdatetime into takeOfTime
from FlightsCitiesNames
where srcCityName = srcFullname
  and dstCityName = dstFullname;
return(flightExists);
end IsHasFlight;
/