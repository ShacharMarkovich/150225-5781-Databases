-- get the next comming time flight from given airport
create or replace function GetNextFlight(airport_id in int) return date is takeoftime date;
begin
select min(takeoffdatetime) into takeoftime
from flight
  join airport on srcAirportID = airportID
where airportID = airport_id
  and takeoffdatetime > ALL (
    select sysdate
    from dual
  );
return(takeoftime);
end GetNextFlight;
/