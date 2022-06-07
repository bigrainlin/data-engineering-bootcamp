

  create or replace view `de-bootcamp-350619`.`trips_data_all`.`stg_yellow_tripdata`
  OPTIONS()
  as 
 
with tripdata as 
(
  select *,
    row_number() over(partition by vendorid, tpep_pickup_datetime) as rn
  from `de-bootcamp-350619`.`trips_data_all`.`yellow_tripdata_2019-2020`
  where vendorid is not null 
)
select
    -- identifiers
    to_hex(md5(cast(coalesce(cast(vendorid as 
    string
), '') || '-' || coalesce(cast(tpep_pickup_datetime as 
    string
), '') as 
    string
))) as tripid,
    cast(vendorid as integer) as vendorid,
    cast(ratecodeid as integer) as ratecodeid,
    cast(pulocationid as integer) as  pickup_locationid,
    cast(dolocationid as integer) as dropoff_locationid,
    
    -- timestamps
    cast(tpep_pickup_datetime as timestamp) as pickup_datetime,
    cast(tpep_dropoff_datetime as timestamp) as dropoff_datetime,
    
    -- trip info
    store_and_fwd_flag,
    cast(passenger_count as integer) as passenger_count,
    cast(trip_distance as numeric) as trip_distance,
    -- yellow cabs are always street-hail
    1 as trip_type,
        
    -- payment info
    cast(fare_amount as numeric) as fare_amount,
    cast(extra as numeric) as extra,
    cast(mta_tax as numeric) as mta_tax,
    cast(tip_amount as numeric) as tip_amount,
    cast(tolls_amount as numeric) as tolls_amount,
    cast(0 as numeric) as ehail_fee,
    cast(improvement_surcharge as numeric) as improvement_surcharge,
    cast(total_amount as numeric) as total_amount,
    cast(payment_type as integer) as payment_type,
    case payment_type
        when 1 then 'Credit card'
        when 2 then 'Cash'
        when 3 then 'No charge'
        when 4 then 'Dispute'
        when 5 then 'Unknown'
        when 6 then 'Voided trip'
    end as payment_type_description, 
    cast(congestion_surcharge as numeric) as congestion_surcharge

from tripdata
where rn = 1

-- dbt build --m <model.sql> --var 'is_test_run: false'


  limit 100

;

