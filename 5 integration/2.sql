-- get in each airport the employee that service most
select E.employeeID, ep.fullname, Airport.fullname, E.servicesCount
from Airport
    natural join Employee ep
    natural join ( select employeeID, count(*) as servicesCount
        from CustomerService
        group by employeeID
        order by servicesCount OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY
    ) E;