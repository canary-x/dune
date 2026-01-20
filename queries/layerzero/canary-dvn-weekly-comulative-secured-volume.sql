-- queryid: #6570074
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
, weekly as (
        select
        date_trunc('week', block_date) as week_start
        , SUM(volume_USD) as weekly_volume_usd
        from total
        group by
    1
        order by
    1
)
select
    week_start
    , weekly_volume_usd
    , SUM(weekly_volume_usd) over (
        order by
    week_start rows unbounded preceding
) as cumulative_volume_usd
from weekly;