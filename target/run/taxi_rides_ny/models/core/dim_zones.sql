

  create or replace table `de-bootcamp-350619`.`trips_data_all`.`dim_zones`
  
  
  OPTIONS()
  as (
    


select 
    locationid, 
    borough, 
    zone, 
    replace(service_zone,'Boro','Green') as service_zone
from `de-bootcamp-350619`.`trips_data_all`.`taxi_zone_lookup`
  );
  