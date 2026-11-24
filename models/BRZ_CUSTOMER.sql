with CUSTOMER as (
    select
        C_CUSTKEY,
        C_NAME,
        C_ADDRESS,
        C_NATIONKEY,
        C_ACCTBAL,
        C_MKTSEGMENT,
        C_COMMENT
    from {{ source('BOOK', 'CUSTOMER') }}
),

final as (
    select
        CUSTOMER.C_CUSTKEY,
        CUSTOMER.C_NAME,
        CUSTOMER.C_ADDRESS,
        CUSTOMER.C_NATIONKEY,
        CUSTOMER.C_ACCTBAL,
        CUSTOMER.C_MKTSEGMENT,
        CUSTOMER.C_COMMENT,
        current_timestamp()::timestamp_ntz as _LOAD_TS,
        'BOOK' as _SOURCE_SYSTEM,
        to_varchar(current_timestamp(), 'YYYYMMDDHH24MISS') as _BATCH_ID,
        md5(to_json(object_construct(*))) as _RECORD_HASH
    from CUSTOMER
)

select * from final