with SUPERHERO_TYPE as (
    select
        SUPERHERO_TYPE
    from {{ source('BOOK', 'SUPERHERO_TYPE') }}
),

final as (
    select
        SUPERHERO_TYPE.SUPERHERO_TYPE,
        current_timestamp()::timestamp_ntz as _LOAD_TS,
        'BOOK' as _SOURCE_SYSTEM,
        to_varchar(current_timestamp(), 'YYYYMMDDHH24MISS') as _BATCH_ID,
        md5(to_json(object_construct(*))) as _RECORD_HASH
    from SUPERHERO_TYPE
)

select * from final