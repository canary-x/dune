with canary_dvn_tx as (
    select distinct
            evt_tx_hash
        , chain as dvn_chain
        from layerzero_multichain.senduln302_evt_dvnfeepaid
            cross join unnest (concat(requiredDVNs, optionalDVNs)) as t (DVN)
        where (
                (
                    chain = 'ethereum'
   and DVN = 0xa4fe5a5b9a846458a70cd0748228aed3bf65c2cd
)
   or (
                    chain = 'berachain'
   and DVN = 0x06e8042729cef3ae6d6db5350f48f9d736c3675d
)
)
)
select
    m.tx_hash_source as tx_hash
    , sum(t.usd_value) as volume_usd
    , date(min(m.ts_source)) as block_date
    , case
when m.source_chain_key = 'ethereum'
    then 'Ethereum'
when m.source_chain_key = 'bera'
    then 'Berachain'
else
    m.source_chain_key
end as blockchain
from layerzero.transfers t
    inner join layerzero.messages m on t.messages_foreign_key = m.primary_key
    inner join canary_dvn_tx c on m.tx_hash_source = cast(c.evt_tx_hash as varchar)
   and (
        (
            c.dvn_chain = 'ethereum'
   and m.source_chain_key = 'ethereum'
)
   or (
            c.dvn_chain = 'berachain'
   and m.source_chain_key = 'bera'
)
)
where m.project = 'Stargate'
   and m.state = 'Success'
   and t.symbol in ('USDC.e', 'WETH', 'USDT', 'USDT0')
group by
    m.tx_hash_source
    , m.source_chain_key
order by
    block_date desc