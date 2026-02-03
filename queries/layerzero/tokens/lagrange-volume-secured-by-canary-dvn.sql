-- queryid: #6601984
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , t.amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paide_to_l0_canary_dvn_wbtc_canary_dvn l on l.evt_tx_hash = t.tx_hash
        where t.block_date >= current_date - interval '9' month
   and t.blockchain in ('polygon', 'optimism', 'base', 'bnb', 'ethereum', 'arbitrum')
   and t.contract_address in (
                0x0fc2a55d5BD13033f1ee0cdd11f60F7eFe66f467
        , 0x389AD4bb96d0D6EE5B6eF0EFAF4b7db0bA2e02a0
)
)
        , filtered_prices as (
        select
        contract_address
        , blockchain
        , timestamp
        , price
        from dune.saharap.result_filter_prices_day
        where timestamp >= current_date - interval '9' month
   and blockchain in ('bnb')
   and contract_address in (0x389AD4bb96d0D6EE5B6eF0EFAF4b7db0bA2e02a0)
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.timestamp = t.block_date