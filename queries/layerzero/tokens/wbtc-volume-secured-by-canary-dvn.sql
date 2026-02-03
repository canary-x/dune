-- queryid: #6609124
with filtered_transfers as (
    select
        t.tx_hash
        , t.block_date
        , t.amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paide_to_l0_canary_dvn_wbtc_canary_dvn l on l.evt_tx_hash = t.tx_hash
        where t.block_date >= current_date - interval '1' year
   and t.blockchain in ('bnb', 'ethereum', 'base', 'berachain', 'avalanche_c', 'sonic')
   and t.contract_address in (
                0x0555E30da8f98308EdB960aa94C0Db47230d2B9c
        , 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599
)
)
        , filtered_prices as (
        select
        contract_address
        , blockchain
        , timestamp
        , price
        from dune.saharap.result_filter_prices_day
        where timestamp >= current_date - interval '1' year
   and blockchain in ('ethereum')
   and contract_address in (0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599)
)
select
    t.blockchain
    , t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
    , p.price as price_usd
from filtered_transfers t
    left join filtered_prices p on p.timestamp = t.block_date