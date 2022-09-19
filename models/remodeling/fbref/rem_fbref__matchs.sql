
with
matchs as (
    select * from {{ ref('stg_fbref__matchs_result') }}
),

leagues as (
    select *
    from {{ ref('rem_fbref__leagues') }}
),

matchs_with_league_id as (
    select 
        leagues.league_id,
        matchs.match_url,
        matchs.match_date,
        matchs.match_weekday,
        matchs.match_time,
        matchs.wk as round,
        matchs.attendance,
    from matchs
        left join leagues 
        on matchs.league = leagues.league 
            and matchs.season_end_year = leagues.season_end_year
),

matchs_with_match_id as (
    select 
        {{ dbt_utils.surrogate_key(['match_url']) }} as match_id,
        *
    from matchs_with_league_id
)

select * from matchs_with_match_id
