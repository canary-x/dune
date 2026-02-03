-- queryid: #6601157
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , t.amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paide_to_l0_canary_dvn_wbtc_canary_dvn l on l.evt_tx_hash = t.tx_hash
        where t.block_date >= current_date - interval '2' month
   and t.blockchain in ('bnb')
   and t.contract_address in (0x011EBe7d75E2C9D1E0bD0be0bEf5C36f0A90075F)
)
        , filtered_prices as (
        select
        contract_address
        , blockchain
        , timestamp
        , price
        from dune.saharap.result_filter_prices_day
        where timestamp >= current_date - interval '2' month
   and blockchain in ('bnb')
   and contract_address in (0x011EBe7d75E2C9D1E0bD0be0bEf5C36f0A90075F)
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.contract_address = t.contract_address
   and p.blockchain = t.blockchain
   and p.timestamp = t.block_date;