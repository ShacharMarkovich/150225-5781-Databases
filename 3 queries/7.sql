-- get all planes which the actual weight passing the max allowed weight
select planeid, model, currWeight, maxWeight
from plane
where currWeight > maxWeight;