-- queryid: #6565827
select
    block_date
    , amount as volume
    , amount_usd volume_USD
from tokens.transfers
    inner join dune.zeinab_team_8277.result_transaction_list_include_fee_paide_to_l0_canary_dvn_wbtc_canary_dvn on evt_tx_hash = tx_hash
where blockchain in ('base', 'ethereum', 'scroll')
   and contract_address in (
        0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A
        , 0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee
        , 0x01f0a31698C4d065659b9bdC21B3610292a1c506
)