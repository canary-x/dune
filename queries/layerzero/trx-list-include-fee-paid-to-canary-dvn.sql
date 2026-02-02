
-- queryid: #6609012
with
    targets (chain, target_dvn) as (
        values
            ('base', 0x554833698ae0fb22ecc90b01222903fd62ca4b47)
        , ('base', 0x4873d56816f45ef341a8819d7039e4746ed77c21)
        , ('ethereum', 0xa4fe5a5b9a846458a70cd0748228aed3bf65c2cd)
        , ('ethereum', 0x89ca15937e1033af26fe4c5e976216e8c8179408)
        , ('arbitrum', 0xf2e380c90e6c09721297526dbc74f870e114dfcb)
        , ('bnb', 0xfa9ba83c102283958b997adc8b44ed3a3cdb5dda)
        , ('bnb', 0xd29dcf66e264aa7d6833bdac6b9279791a7c246b)
        , ('berachain', 0x575d0de08426223896d9cd4bbaf4c02c9a7dc8c6)
        , ('avalanche_c', 0x6995acd4ae604f8f334f5309a75232544f78e0c9)
        , ('sonic', 0x87a4d47918e83df0fcf6040dbdc358119f7deb2a)
        , ('optimism', 0x5b6735c66d97479ccd18294fc96b3084ecb2fa3f)
        , ('polygon', 0x13feb7234ff60a97af04477d6421415766753ba3)
        , ('linea', 0xda63525a0fc42bcc2cad1dd28708d5ed11849347)
        , ('scroll', 0xdf44a1594d3d516f7cdfb4dc275a79a5f6e3db1d)
        , ('blast', 0x6398e91001cc1682bba103e6b2489fa5675a5a64)
)
        , prefilter as (
        select
        e.chain
        , e.evt_block_date
        , e.evt_tx_hash
        , e.requiredDVNs
        , e.optionalDVNs
        , e.fees
        , t.target_dvn
        from layerzero_multichain.senduln302_evt_dvnfeepaid e
            inner join targets t on e.chain = t.chain
        where (
                contains(e.requiredDVNs, t.target_dvn)
   or contains(e.optionalDVNs, t.target_dvn)
)
)
select
    p.chain
    , p.evt_block_date
    , p.evt_tx_hash
    , u.dvn as dvn
    , u.fee as fee
from prefilter p
    cross join unnest (zip(concat(p.requiredDVNs, p.optionalDVNs), p.fees)) as u (dvn, fee)
where u.dvn = p.target_dvn;