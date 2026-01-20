-- queryid: #6568763
select
    block_date
    , amount as volume
    , amount as volume_USD
from tokens.transfers
    inner join query_6561446 on evt_tx_hash = tx_hash
where (
        blockchain = 'ethereum'
   and contract_address = 0x5fa487bca6158c64046b2813623e20755091da0b
)
   or (
        blockchain = 'arbitrum'
   and contract_address = 0xfDD22Ce6D1F66bc0Ec89b20BF16CcB6670F55A5a
)