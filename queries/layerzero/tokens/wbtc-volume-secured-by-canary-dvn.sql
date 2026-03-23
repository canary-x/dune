with filtered_transfers as (
    select
        t.tx_hash
        , t.block_time
        , SUM(t.amount) as amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
        where t.block_time >= CURRENT_DATE - INTERVAL '18' MONTH
   and t.blockchain in ('bnb'
        , 'ethereum', 'base'
        , 'berachain', 'avalanche_c'
        , 'bob', 'sonic'
        , 'sei', 'optimism'
        , 'monad', 'unichain'
        , 'flow'
)
   and t.contract_address in (
                0x0555E30da8f98308EdB960aa94C0Db47230d2B9c
        , 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599
        , 0x408d4cd0adb7cebd1f1a1c33a0ba2098e1295bab
        , 0xc3f854b2970f8727d28527ece33176fac67fef48
        , 0x717dae2baf7656be9a9b01dee31d571a9d4c9579
        , 0x68f180fcCe6836688e9084f035309E29Bf0A2095
)
   and exists (
                select
                    1
                from dune.zeinab.result_transaction_list_include_fee_paide_to_wbtc_canary_dvn l
                where l.tx_hash = t.tx_hash
)
        group by
    t.tx_hash
    , t.block_time
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
        where blockchain in ('ethereum')
   and contract_address in (0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599)
)
        select
        t.blockchain
        , t.block_time
        , t.amount as volume
        , t.amount * p.price as volume_USD
        , p.price as price_usd
        from filtered_transfers t
            left join filtered_prices p on p.timestamp = date(t.block_time)
