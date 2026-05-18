-- queryid: #7508645
with canary_dvn_tx as (
    select distinct
            evt_tx_hash
        , chain as dvn_chain
        , evt_block_date
        from layerzero_multichain.senduln302_evt_dvnfeepaid
            cross join unnest (concat(requiredDVNs, optionalDVNs)) as t (DVN)
        where (
                (
                    chain = 'ethereum'
   and DVN = 0xa4fe5a5b9a846458a70cd0748228aed3bf65c2cd
)
   or (
                    chain = 'base'
   and DVN = 0x554833698ae0fb22ecc90b01222903fd62ca4b47
)
   or (
                    chain = 'bnb'
   and DVN = 0xfa9ba83c102283958b997adc8b44ed3a3cdb5dda
)
   or (
                    chain = 'optimism'
   and DVN = 0x5b6735c66d97479ccd18294fc96b3084ecb2fa3f
)
   or (
                    chain = 'scroll'
   and DVN = 0xdf44a1594d3d516f7cdfb4dc275a79a5f6e3db1d
)
)
)
select
    m.tx_hash_source as tx_hash
    , c.evt_block_date as block_date
    , case
when m.source_chain_key = 'bera'
    then 'Berachain'
else
    m.source_chain
end as blockchain
        , sum(t.usd_value) as volume_usd
from layerzero.transfers t
    inner join layerzero.messages m on t.messages_foreign_key = m.primary_key
    inner join canary_dvn_tx c on m.tx_hash_source = cast(c.evt_tx_hash as varchar)
   and (
        (
            c.dvn_chain = 'ethereum'
   and m.source_chain_key = 'ethereum'
)
   or (
            c.dvn_chain = 'base'
   and m.source_chain_key = 'base'
)
   or (
            c.dvn_chain = 'bnb'
   and m.source_chain_key = 'bsc'
)
   or (
            c.dvn_chain = 'optimism'
   and m.source_chain_key = 'optimism'
)
   or (
            c.dvn_chain = 'scroll'
   and m.source_chain_key = 'scroll'
)
)
where m.project = 'Ether.Fi'
   and m.state = 'Success'
   and t.symbol = 'weETH'
group by
    m.tx_hash_source
    , c.evt_block_date
    , m.source_chain_key
    , m.source_chain
order by
    volume_usd desc