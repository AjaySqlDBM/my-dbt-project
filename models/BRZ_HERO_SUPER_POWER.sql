with HERO_SUPER_POWER as (
    select
        SUPERHERO_NAME,
        SUPER_POWER_NAME
    from {{ source('BOOK', 'HERO_SUPER_POWER') }}
),

final as (
    select
        HERO_SUPER_POWER.SUPERHERO_NAME,
        HERO_SUPER_POWER.SUPER_POWER_NAME,
        current_timestamp()::timestamp_ntz as _LOAD_TS,
        'BOOK' as _SOURCE_SYSTEM,
        to_varchar(current_timestamp(), 'YYYYMMDDHH24MISS') as _BATCH_ID,
        md5(to_json(object_construct(*))) as _RECORD_HASH
    from HERO_SUPER_POWER
)

select * from final