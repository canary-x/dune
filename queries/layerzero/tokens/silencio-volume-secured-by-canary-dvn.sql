-- queryid: #6638696
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , SUM(t.amount) as amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paid_to_lz_canary_dvn l on l.tx_hash = t.tx_hash
        where t.block_date >= current_date - INTERVAL '1' DAY - INTERVAL '12' MONTH
   and t.blockchain in ('ethereum', 'base', 'peaq')
   and t.contract_address in (
                0x7FA16cEd60019adE15edd0cDb03d689d557B6d1e
        , 0x6Bd83ABC39391Af1E24826E90237C4BD3468b5D2
        , 0x5c3126bfB9A68a7021d461230127470b3824886B
)
        group by
    t.tx_hash
    , t.block_date
    , t.contract_address
    , t.blockchain
)
        , filtered_prices as (
        select
        contract_address
        , blockchain
        , timestamp
        , price
        from dune.zeinab_team_8277.result_filter_prices_day
        where blockchain in ('base')
   and contract_address in (0x6Bd83ABC39391Af1E24826E90237C4BD3468b5D2)
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.timestamp = t.block_date