

  create or replace view `de-bootcamp-350619`.`trips_data_all`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `de-bootcamp-350619`.`trips_data_all`.`my_first_dbt_model`
where id = 1;

