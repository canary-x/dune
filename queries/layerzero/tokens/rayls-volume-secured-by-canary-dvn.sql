-- queryid: #6632957
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
   and t.blockchain in ('bnb', 'ethereum')
   and t.contract_address in (
                0x17EA10b6aE4FDE59FDBF471Bd28Ab9710F508816
        , 0xB5F7b021a78f470d31D762C1DDA05ea549904fbd
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
   and blockchain in ('bnb', 'ethereum')
   and contract_address in (
                0x17EA10b6aE4FDE59FDBF471Bd28Ab9710F508816
        , 0xB5F7b021a78f470d31D762C1DDA05ea549904fbd
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