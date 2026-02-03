-- queryid: #6612695
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , t.amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paide_to_l0_canary_dvn_wbtc_canary_dvn l on l.evt_tx_hash = t.tx_hash
        where t.block_date >= current_date - interval '6' month
   and t.blockchain in ('bnb', 'base')
   and t.contract_address in (
                0x5fFD0EAdc186AF9512542d0d5e5eAFC65d5aFc5B
        , 0xBcaBa0baC0F4Bff8cC8659F2218C6d5324b46061
)
)
        , filtered_prices as (
        select
        contract_address
        , blockchain
        , timestamp
        , price
        from prices.day
        where timestamp >= current_date - interval '6' month
   and blockchain in ('bnb', 'base')
   and contract_address in (
                0x5fFD0EAdc186AF9512542d0d5e5eAFC65d5aFc5B
        , 0xBcaBa0baC0F4Bff8cC8659F2218C6d5324b46061
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
