-- queryid: #6186365
with weeth as (
    select
        COUNT(*) as tx_count
        , SUM(volume) as volume
        , SUM(volume_USD) as volume_USD
        from query_6565827
)
        , thbill as (
        select
        COUNT(*) as tx_count
        , SUM(volume) as volume
        , SUM(volume_USD) as volume_USD
        from query_6568763
)
        , total as (
        select
        tx_count
        , volume
        , volume_USD
        from weeth
        union all
    select
        tx_count
        , volume
        , volume_USD
        from thbill
)
select
    SUM(tx_count) as total_tx_count
    , SUM(volume) as total_volume
    , SUM(volume_USD) as total_volume_USD
from total