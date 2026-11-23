with SUPERHERO as (
    select
        SUPERHERO_NAME,
        BIRTHPLACE,
        SUPERHERO_TYPE,
        HAS_MASK
    from {{ source('BOOK', 'SUPERHERO') }}
),

final as (
    select
        SUPERHERO.SUPERHERO_NAME,
        SUPERHERO.BIRTHPLACE,
        SUPERHERO.SUPERHERO_TYPE,
        SUPERHERO.HAS_MASK,
        current_timestamp()::timestamp_ntz as _LOAD_TS,
        'BOOK' as _SOURCE_SYSTEM,
        to_varchar(current_timestamp(), 'YYYYMMDDHH24MISS') as _BATCH_ID,
        md5(to_json(object_construct(*))) as _RECORD_HASH
    from SUPERHERO
)

select * from final