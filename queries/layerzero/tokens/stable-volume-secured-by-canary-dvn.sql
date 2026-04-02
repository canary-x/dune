-- queryid: #6601157
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , SUM(t.amount) as amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paid_to_lz_canary_dvn l on l.tx_hash = t.tx_hash
        where t.block_date >= current_date - INTERVAL '10' MONTH
   and t.blockchain in ('bnb', 'hyperevm')
   and t.contract_address in (
                0x011EBe7d75E2C9D1E0bD0be0bEf5C36f0A90075F
        , 0xa51dC81944a15623874981181a99D6c56B20ED56
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
        where blockchain in ('bnb')
   and contract_address in (0x011EBe7d75E2C9D1E0bD0be0bEf5C36f0A90075F)
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.timestamp = t.block_date