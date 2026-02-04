-- queryid: #6639212
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , t.amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paide_to_l0_canary_dvn_wbtc_canary_dvn l on l.evt_tx_hash = t.tx_hash
        where t.block_date >= current_date - interval '3' month
   and t.blockchain in ('bnb', 'base')
   and t.contract_address in (
                0xA43cA4e5abdf9917eaDE63C2837eeeE321897dAd
        , 0x4c87da04887a1F9F21F777E3A8dD55C3C9f84701
)
)
        , filtered_prices as (
        select
        contract_address
        , blockchain
        , timestamp
        , price
        from dune.saharap.result_filter_prices_day
        where timestamp >= current_date - interval '3' month
   and blockchain in ('bnb')
   and contract_address in (0xA43cA4e5abdf9917eaDE63C2837eeeE321897dAd)
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.timestamp = t.block_date