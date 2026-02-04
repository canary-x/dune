-- queryid: #6602187
with total as (
    select
        weeth.block_date
        , weeth.volume_USD
        from dune.zeinab_team_8277.result_weeth_secured_volume_canary_dvn as weeth
        union
        select
    wbtc.block_date
    , wbtc.volume_USD
        from dune.zeinab_team_8277.result_wbtc_secured_volume_canary_dvn as wbtc
        union
        select
    thbill.block_date
    , thbill.volume_USD
        from query_6568763 as thbill
        union
        select
    lagrange.block_date
    , lagrange.volume_USD
        from dune.zeinab_team_8277.result_lagrange_la_token_filtered_transfers as lagrange
        union
        select
    apriori.block_date
    , apriori.volume_USD
        from dune.zeinab_team_8277.result_a_priori_apr_token_filtered_transfers as apriori
        union
        select
    zyfai.block_date
    , zyfai.volume_USD
        from dune.zeinab_team_8277.result_zyfai_filtered_transfers as zyfai
        union
        select
    sidekick.block_date
    , sidekick.volume_USD
        from dune.zeinab_team_8277.result_sidekick_filtered_transfers as sidekick
        union
        select
    hemi.block_date
    , hemi.volume_USD
        from dune.zeinab_team_8277.result_hemi_filtered_transfers as hemi
        union
        select
    stable.block_date
    , stable.volume_USD
        from query_6615414 as stable
        union
        select
    aria.block_date
    , aria.volume_USD
        from query_6615857 as aria
        union
        select
    ondo.block_date
    , ondo.volume_USD
        from dune.zeinab_team_8277.result_ondo_finance_filtered_transfers as ondo
        union
        select
    rayls.block_date
    , rayls.volume_USD
        from dune.zeinab_team_8277.result_rayls_filtered_transfers as rayls
        union
        select
    zerog.block_date
    , zerog.volume_USD
        from query_6633212 as zerog
        union
        select
    acurast.block_date
    , acurast.volume_USD
        from dune.zeinab_team_8277.result_acurast_filtered_transfers as acurast
        union
        select
    allora.block_date
    , allora.volume_USD
        from dune.zeinab_team_8277.result_allora_filtered_transfers as allora
        union
        select
    silencio.block_date
    , silencio.volume_USD
        from query_6638696 as silencio
        union
        select
    flow.block_date
    , flow.volume_USD
        from query_6639124 as flow
        union
        select
    common.block_date
    , common.volume_USD
        from dune.zeinab_team_8277.result_common_filtered_transfers as common
        union
        select
    morpho.block_date
    , morpho.volume_USD
        from dune.zeinab_team_8277.result_morpho_filtered_transfers as morpho
)
select
    block_date
    , volume_USD
from total