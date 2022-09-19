
with
lineups as (
    select * from {{ ref('stg_fbref__matchs_lineup') }}
),

matchs_home_away as (
    select * from {{ ref('rem_fbref__matchs_home_away') }}
),

lineups_with_matchs_ha_id as (
    select
        matchs.match_ha_id,
        lineups.player_url,
        lineups.starting,
        lineups.pos,
        lineups.age,
        lineups.min
    from lineups
        left join matchs_home_away as matchs 
        on matchs.match_url = lineups.match_url
            and matchs.home_away = lower(lineups.home_away)
),

lineups_id as (
    select 
        {{ dbt_utils.surrogate_key(['match_ha_id', 'player_url']) }} as lineups_id,
        *
    from lineups_with_matchs_ha_id
)

select * from lineups_id
