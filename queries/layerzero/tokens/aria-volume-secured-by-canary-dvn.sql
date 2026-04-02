-- queryid: #6615857
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , SUM(t.amount) as amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paid_to_lz_canary_dvn l on l.tx_hash = t.tx_hash
        where t.block_date >= current_date - INTERVAL '6' MONTH
   and t.blockchain in ('bnb', 'story')
   and t.contract_address in (
                0x2A7e3392458307493C86388d5E544AAd93286836
        , 0xC9cbbD8f211300Dd0e7a3933b7AeEdAC6F61Dd52
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
   and contract_address in (0x2A7e3392458307493C86388d5E544AAd93286836)
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.timestamp = t.block_date