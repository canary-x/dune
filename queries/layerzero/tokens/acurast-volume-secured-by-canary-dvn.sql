-- queryid: #6633565
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
                0x6EF2FFB38D64aFE18ce782DA280b300e358CFeAF
        , 0x216b3643ff8b7BB30d8A48E9F1BD550126202AdD
        , 0xc5fEd7c8cCC75D8A72b601a66DffD7A489073F0b
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
                0x6EF2FFB38D64aFE18ce782DA280b300e358CFeAF
        , 0x216b3643ff8b7BB30d8A48E9F1BD550126202AdD
        , 0xc5fEd7c8cCC75D8A72b601a66DffD7A489073F0b
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