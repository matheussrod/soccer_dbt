
with 
stats as (
    select * from {{ ref('stg_fbref__matchs_stats_summary') }}
),

matchs_home_away as (
    select * from {{ ref('rem_fbref__matchs_home_away') }}
),

stats_with_match_ha_id as (
    select 
        matchs.match_ha_id,
        stats.player,
        stats.age,
        stats.min,
        stats.gls,
        stats.ast,
        stats.pk,
        stats.pk_att,
        stats.sh,
        stats.sot,
        stats.crd_y,
        stats.crd_r,
        stats.fls,
        stats.fld,
        stats.off,
        stats.crs,
        stats.tkl_w,
        stats.int,
        stats.og,
        stats.pk_won,
        stats.pk_con
    from stats
        left join matchs_home_away as matchs
        on matchs.match_url = stats.match_url
            --#TODO: replace lower in staging?
            and matchs.home_away = lower(stats.home_away)
),

stats_summary_id as (
    select 
        {{ dbt_utils.surrogate_key(['match_ha_id', 'player']) }} as stats_summary_id,
        *
    from stats_with_match_ha_id
)

select * from stats_summary_id
