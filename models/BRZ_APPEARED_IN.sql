with APPEARED_IN as (
    select
        COMIC_BOOK_NAME,
        SUPERHERO_NAME,
        COMMENTS
    from {{ source('BOOK', 'APPEARED_IN') }}
),

final as (
    select
        APPEARED_IN.COMIC_BOOK_NAME,
        APPEARED_IN.SUPERHERO_NAME,
        APPEARED_IN.COMMENTS,
        current_timestamp()::timestamp_ntz as _LOAD_TS,
        'BOOK' as _SOURCE_SYSTEM,
        to_varchar(current_timestamp(), 'YYYYMMDDHH24MISS') as _BATCH_ID,
        md5(to_json(object_construct(*))) as _RECORD_HASH
    from APPEARED_IN
)

select * from final