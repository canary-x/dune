
-- queryid: #6561446
select
    chain
    , evt_block_date
    , evt_tx_hash
    , DVN
    , fee
from layerzero_multichain.senduln302_evt_dvnfeepaid
    cross join unnest (zip(concat(requiredDVNs, optionalDVNs), fees)) as t (DVN, fee)
where (
        chain = 'base'
   and DVN = 0x554833698ae0fb22ecc90b01222903fd62ca4b47
)
   or (
        chain = 'ethereum'
   and DVN = 0xa4fe5a5b9a846458a70cd0748228aed3bf65c2cd
)
   or (
        chain = 'arbitrum'
   and DVN = 0xf2e380c90e6c09721297526dbc74f870e114dfcb
)