-- queryid: #6603587
with weeth as (
    select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_weeth_secured_volume_canary_dvn
)
        , wbtc as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_wbtc_secured_volume_canary_dvn
)
        , thbill as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from query_6568763
)
        , lagrange as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_lagrange_la_token_filtered_transfers
)
        , apriori as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_a_priori_apr_token_filtered_transfers
)
        , zyfai as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_zyfai_filtered_transfers
)
        , sidekick as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_sidekick_filtered_transfers
)
        , hemi as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_hemi_filtered_transfers
)
        , stable as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from query_6615414
)
        , aria as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from query_6615857
)
        , ondo as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_ondo_finance_filtered_transfers
)
        , rayls as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_rayls_filtered_transfers
)
        , zerog as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from query_6633212
)
        , acurast as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_acurast_filtered_transfers
)
        , allora as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_allora_filtered_transfers
)
        , silencio as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from query_6638696
)
        , flow as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from query_6639124
)
        , common as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_common_filtered_transfers
)
        , morpho as (
        select
        COUNT(*) as tx_count
        , SUM(volume_USD) as sum_volume_USD
        from dune.zeinab_team_8277.result_morpho_filtered_transfers
)
        , total as (
        select
        tx_count
        , sum_volume_USD
        from weeth
        union all
    select
        tx_count
        , sum_volume_USD
        from wbtc
        union all
    select
        tx_count
        , sum_volume_USD
        from thbill
        union all
    select
        tx_count
        , sum_volume_USD
        from lagrange
        union all
    select
        tx_count
        , sum_volume_USD
        from apriori
        union all
    select
        tx_count
        , sum_volume_USD
        from zyfai
        union all
    select
        tx_count
        , sum_volume_USD
        from sidekick
        union all
    select
        tx_count
        , sum_volume_USD
        from hemi
        union all
    select
        tx_count
        , sum_volume_USD
        from stable
        union all
    select
        tx_count
        , sum_volume_USD
        from aria
        union all
    select
        tx_count
        , sum_volume_USD
        from ondo
        union all
    select
        tx_count
        , sum_volume_USD
        from rayls
        union all
    select
        tx_count
        , sum_volume_USD
        from zerog
        union all
    select
        tx_count
        , sum_volume_USD
        from acurast
        union all
    select
        tx_count
        , sum_volume_USD
        from allora
        union all
    select
        tx_count
        , sum_volume_USD
        from silencio
        union all
    select
        tx_count
        , sum_volume_USD
        from flow
        union all
    select
        tx_count
        , sum_volume_USD
        from flow
        union all
    select
        tx_count
        , sum_volume_USD
        from morpho
)
select
    SUM(tx_count) as total_tx_count
    , SUM(sum_volume_USD) as total_volume_USD
from total