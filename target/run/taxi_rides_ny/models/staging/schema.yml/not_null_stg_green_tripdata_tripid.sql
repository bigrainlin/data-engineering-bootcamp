select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from `de-bootcamp-350619`.`trips_data_all`.`stg_green_tripdata`
where tripid is null



      
    ) dbt_internal_test