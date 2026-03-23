
-- queryid: #6854446
with
    targets (chain, target_dvn) as (
        values
            ('base', 0x4873d56816f45ef341a8819d7039e4746ed77c21)
        , ('ethereum', 0x89ca15937e1033af26fe4c5e976216e8c8179408)
        , ('bnb', 0xd29dcf66e264aa7d6833bdac6b9279791a7c246b)
        , ('berachain', 0x575d0de08426223896d9cd4bbaf4c02c9a7dc8c6)
        , ('avalanche_c', 0x6995acd4ae604f8f334f5309a75232544f78e0c9)
        , ('bob', 0x8bafe0299cb4d3ff75d3f7045554474bf414fd11)
        , ('sei', 0xf2e89ed7e342c708ba8cd79b293ad9244f5fccb3)
        , ('sonic', 0x87a4d47918e83df0fcf6040dbdc358119f7deb2a)
        , ('optimism', 0x6f798d30577c91e8f9291e82e633dbe4dce16b93)
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
        , multichain_dvn_fee_paid as (
        select
        p.chain
        , p.evt_block_date
        , p.evt_tx_hash
        , u.dvn as dvn
        , u.fee as fee
        from prefilter p
            cross join unnest (zip(concat(p.requiredDVNs, p.optionalDVNs), p.fees)) as u (dvn, fee)
        where u.dvn = p.target_dvn
)
        , monad_dvn_fee_paid as (
        select
        m.block_time
        , m.tx_hash
        from monad.logs m
        where contract_address = 0xC39161c743D0307EB9BCc9FEF03eeb9Dc4802de7
   and (
                bytearray_position (m.data, FROM_HEX('6398e91001cc1682bba103e6b2489fa5675a5a64')) > 0
)
)
        , unichain_dvn_fee_paid as (
        select
        m.block_time
        , m.tx_hash
        from unichain.logs m
        where contract_address = 0xC39161c743D0307EB9BCc9FEF03eeb9Dc4802de7
   and (
                bytearray_position (m.data, FROM_HEX('0x148ae5e1df44cf8b6d258430eab79b28d0da4aa6')) > 0
)
)
        , flow_dvn_fee_paid as (
        select
        m.block_time
        , m.tx_hash
        from flow.logs m
        where contract_address = 0xe1844c5D63a9543023008D332Bd3d2e6f1FE1043
   and (
                bytearray_position (m.data, FROM_HEX('0xbbdc8c15936e5ce33ffbcaf1aba2a8f17e31efb5')) > 0
)
)
select
    evt_tx_hash as tx_hash
from multichain_dvn_fee_paid
union
select
    tx_hash
from monad_dvn_fee_paid
union
select
    tx_hash
from unichain_dvn_fee_paid
union
select
    tx_hash
from flow_dvn_fee_paid