-- queryid: #6568763
-- monad and plasma — no senduln302_evt_dvnfeepaid data on Dune.
with fees as (
    select
        chain
        , evt_tx_hash
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
   or (
                chain = 'hyperevm'
   and DVN = 0x83342ec538df0460e730a8f543fe63063e2d44c4
)
)
        , thbill_oftsent as (
        select
        chain
        , evt_tx_hash
        , evt_block_date
        , CAST(amountSentLD as double) / 1e6 as volume_usd
        from theo_multichain.thbilloft_evt_oftsent
        union all
    select
        'ethereum' as chain
        , evt_tx_hash
        , evt_block_date
        , CAST(amountSentLD as double) / 1e6 as volume_usd
        from theo_ethereum.thbilloftadapter_evt_oftsent
)
select
    o.evt_tx_hash as tx_hash
    , o.evt_block_date as block_date
    , o.chain as blockchain
    , ROUND(SUM(o.volume_usd)
    , 2) as volume_usd
from thbill_oftsent o
    inner join fees f on o.evt_tx_hash = f.evt_tx_hash
   and o.chain = f.chain
group by
    o.evt_tx_hash
    , o.evt_block_date
    , o.chain
order by
    o.evt_block_date desc