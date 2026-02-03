-- queryid: #6611124
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , t.amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paide_to_l0_canary_dvn_wbtc_canary_dvn l on l.evt_tx_hash = t.tx_hash
        where t.blockchain in ('base')
   and t.contract_address in (0xD080eD3c74a20250a2c9821885203034ACD2D5ae)
)
        , filtered_prices as (
        select
        contract_address
        , blockchain
        , timestamp
        , price
        from prices.day
        where blockchain in ('base')
   and contract_address in (0xD080eD3c74a20250a2c9821885203034ACD2D5ae)
   and timestamp >= current_date - interval '8' month
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.contract_address = t.contract_address
   and p.blockchain = t.blockchain
   and p.timestamp = t.block_date;
