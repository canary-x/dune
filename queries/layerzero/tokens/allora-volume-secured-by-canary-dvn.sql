-- queryid: #6633644
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , SUM(t.amount) as amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paid_to_lz_canary_dvn l on l.tx_hash = t.tx_hash
        where t.block_date >= current_date - INTERVAL '1' DAY - INTERVAL '10' MONTH
   and t.blockchain in ('ethereum', 'base', 'bnb')
   and t.contract_address in (
                0xCCe5F304fD043d6A4E8cCB5376A4a4Fb583B98d5
        , 0x8408D45b61f5823298F19a09B53b7339c0280489
        , 0x032d86656Db142138AC97d2c5C4E3766E8c0482d
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
   and contract_address in (0xCCe5F304fD043d6A4E8cCB5376A4a4Fb583B98d5)
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.timestamp = t.block_date