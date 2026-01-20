-- queryid: #6565827
select
    block_date
    , amount as volume
    , amount_usd volume_USD
from tokens.transfers
    inner join query_6561446 on evt_tx_hash = tx_hash
where (
        blockchain = 'base'
   and contract_address = 0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A
)
   or (
        blockchain = 'ethereum'
   and contract_address = 0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee
)