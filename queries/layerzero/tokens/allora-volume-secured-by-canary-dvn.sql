-- queryid: #6633644
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
   and t.blockchain in ('bnb', 'ethereum', 'base')
   and t.contract_address in (
                0xCCe5F304fD043d6A4E8cCB5376A4a4Fb583B98d5
        , 0x8408D45b61f5823298F19a09B53b7339c0280489
        , 0x032d86656Db142138AC97d2c5C4E3766E8c0482d
)
)
        , filtered_prices as (
        select
        contract_address
        , blockchain
        , timestamp
        , price
        from dune.saharap.result_filter_prices_day
        where timestamp >= current_date - interval '2' month
   and blockchain in ('bnb', 'ethereum', 'base')
   and contract_address in (
                0xCCe5F304fD043d6A4E8cCB5376A4a4Fb583B98d5
        , 0x8408D45b61f5823298F19a09B53b7339c0280489
        , 0x032d86656Db142138AC97d2c5C4E3766E8c0482d
)
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.contract_address = t.contract_address
   and p.blockchain = t.blockchain
   and p.timestamp = t.block_date;