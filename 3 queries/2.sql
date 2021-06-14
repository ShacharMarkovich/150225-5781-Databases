--- All airport in Brownborough's City
Select airportid, fullname, ABBREVIATION
from airport natural join city
where city.name = 'Port Donald'
order by fullname;