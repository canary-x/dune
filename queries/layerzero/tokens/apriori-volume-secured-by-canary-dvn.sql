-- queryid: #6601157
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_time
        , t.block_date
        , t.amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paide_to_l0_canary_dvn_wbtc_canary_dvn l on l.evt_tx_hash = t.tx_hash
        where t.blockchain in ('bnb', 'ethereum')
   and t.contract_address in (
                0x299AD4299Da5b2b93Fba4c96967B040C7F611099
        , 0x5A9610919f5e81183823A2be4Bd1BeB2B4da2a20
)
)
        , filtered_prices as (
        select
        contract_address
        , blockchain
        , timestamp
        , price
        from prices.hour
        where blockchain in ('bnb', 'ethereum')
   and contract_address in (
                0x299AD4299Da5b2b93Fba4c96967B040C7F611099
        , 0x5A9610919f5e81183823A2be4Bd1BeB2B4da2a20
)
   and timestamp >= date_trunc('hour', current_timestamp - interval '10' month)
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.contract_address = t.contract_address
   and p.blockchain = t.blockchain
   and p.timestamp = date_trunc('hour', t.block_time);