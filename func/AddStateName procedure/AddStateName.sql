-- update all the Shuttlebusline's description in the (given) state (name) to start with the statename.
create or replace procedure AddStateName(stateName in varchar) is begin
update Shuttlebusline
set description = concat(concat(concat('State: ', stateName), '. Description: '),description)
where srcAirportID IN (select airportID
    from ((Airport inner join City on Airport.Cityid = City.Cityid)
    inner join State on City.stateID = state.stateid)
    where State.name = stateName);
end AddStateName;
/