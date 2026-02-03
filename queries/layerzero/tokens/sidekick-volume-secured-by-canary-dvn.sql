-- queryid: #6611264
with txs as (
    select distinct
            evt_tx_hash
        from dune.zeinab_team_8277.result_transaction_list_include_fee_paide_to_l0_canary_dvn_wbtc_canary_dvn
        where evt_block_date >= current_date - interval '5' month
)
, filtered_transfers as (
        select
        t.tx_hash
        , t.block_date
        , t.amount
        , t.contract_address
        , t.blockchain
        from tokens.transfers t
            inner join txs l on l.evt_tx_hash = t.tx_hash
        where t.blockchain in ('bnb'
, 'Ethereum')
   and t.contract_address in (
                0x0A73d885CdD66adF69c6D64c0609e55C527dB2BE
        , 0xfb072b42907dA2Bf7A8E8cB5dCAa790D45Fd81a8
)
)
        , filtered_prices as (
        select
        contract_address
        , blockchain
        , timestamp
        , price
        from prices.day
        where blockchain in ('bnb', 'Ethereum')
   and contract_address in (
                0x0A73d885CdD66adF69c6D64c0609e55C527dB2BE
        , 0xfb072b42907dA2Bf7A8E8cB5dCAa790D45Fd81a8
)
   and timestamp >= current_date - interval '5' month
)
select
    t.block_date
    , t.amount as volume
    , t.amount * p.price as volume_USD
from filtered_transfers t
    left join filtered_prices p on p.contract_address = t.contract_address
   and p.blockchain = t.blockchain
   and p.timestamp = t.block_date;