with SUPER_POWER as (
    select
        SUPER_POWER_NAME,
        CATEGORY,
        STRENGTH,
        NOTES
    from {{ source('BOOK', 'SUPER_POWER') }}
),

final as (
    select
        SUPER_POWER.SUPER_POWER_NAME,
        SUPER_POWER.CATEGORY,
        SUPER_POWER.STRENGTH,
        SUPER_POWER.NOTES,
        current_timestamp()::timestamp_ntz as _LOAD_TS,
        'BOOK' as _SOURCE_SYSTEM,
        to_varchar(current_timestamp(), 'YYYYMMDDHH24MISS') as _BATCH_ID,
        md5(to_json(object_construct(*))) as _RECORD_HASH
    from SUPER_POWER
)

select * from final