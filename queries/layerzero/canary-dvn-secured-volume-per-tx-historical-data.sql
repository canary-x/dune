-- queryid: #6568907
with total as (
    select
        weeth.block_date
        , weeth.volume_USD
        from query_6565827 as weeth
        union
        select
    thbill.block_date
    , thbill.volume_USD
        from query_6568763 as thbill
)
select
    block_date
    , volume_USD
from total