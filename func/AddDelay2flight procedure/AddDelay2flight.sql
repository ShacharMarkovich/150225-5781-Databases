-- add delayHour for all flight's takeoffDateTime from given airport id to 
create or replace procedure AddDelay2flight(delayHour in Int, flight_id in int) is begin
update flight
set takeoffDateTime = takeoffDateTime + delayHour / 24
where flightID = flight_id;
end AddDelay2flight;
/