

with
reports as (
    select * from {{ ref('stg_fbref__matchs_report') }}
),

matchs_home_away as (
    select * from {{ ref('rem_fbref__matchs_home_away') }}
),

matchs_score as (
    select 
        matchs.match_ha_id,
        reports.home_score,
        reports.away_score,
        reports.home_xG,
        reports.away_xG
    from reports 
        left join matchs_home_away as matchs
        on matchs.match_url = reports.match_url
),

score_id as (
    select 
        {{ dbt_utils.surrogate_key(['match_ha_id']) }} as score_id,
        *
    from matchs_score
)

select * from score_id
