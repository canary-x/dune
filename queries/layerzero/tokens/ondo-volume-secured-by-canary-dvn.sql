-- queryid: #6615964
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , SUM(t.amount) as amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paid_to_lz_canary_dvn l on l.tx_hash = t.tx_hash
        where t.block_date >= current_date - INTERVAL '1' DAY - INTERVAL '8' MONTH
   and t.blockchain in ('arbitrum', 'ethereum', 'mantle', 'sei')
   and t.contract_address in (
                0x35e050d3C0eC2d29D269a8EcEa763a183bDF9A9D
        , 0x96F6eF951840721AdBF46Ac996b59E0235CB985C
        , 0x5bE26527e817998A7206475496fDE1E68957c5A6
        , 0x54cD901491AeF397084453F4372B93c33260e2A6
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
        where blockchain in ('arbitrum')
   and contract_address in (0x35e050d3C0eC2d29D269a8EcEa763a183bDF9A9D)
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.timestamp = t.block_date