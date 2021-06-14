-- get count of seats in plane and how much with windows,
-- if seat is with window - planeSeat.isWithWindow val is 1, else - 0
select planeid, model, p_size as "seats count",
    sum(isWithWindow) as "seats with windows"
from plane natural join planeSeat
group by planeid, model, p_size
order by fullname;