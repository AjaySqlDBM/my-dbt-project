with COMIC_BOOK as (
    select
        COMIC_BOOK_NAME,
        ISSUE_DATE
    from {{ source('BOOK', 'COMIC_BOOK') }}
),

final as (
    select
        COMIC_BOOK.COMIC_BOOK_NAME,
        COMIC_BOOK.ISSUE_DATE,
        current_timestamp()::timestamp_ntz as _LOAD_TS,
        'BOOK' as _SOURCE_SYSTEM,
        to_varchar(current_timestamp(), 'YYYYMMDDHH24MISS') as _BATCH_ID,
        md5(to_json(object_construct(*))) as _RECORD_HASH
    from COMIC_BOOK
)

select * from final