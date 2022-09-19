
with 
matchs_summary as (
    select * from {{ ref('stg_fbref__matchs_summary') }}
),

matchs_home_away as (
    select * from {{ ref('rem_fbref__matchs_home_away') }}
),

events_with_match_ha_id as (
    select 
        home_away.match_ha_id,
        summary.event_time,
        summary.event_half,
        summary.event_type,
        summary.event_players,
        summary.score_progression
    from matchs_summary as summary
        left join matchs_home_away as home_away
        on home_away.match_url = summary.match_url
            and home_away.home_away = lower(summary.home_away)
),

event_id as (
    select
        {{ dbt_utils.surrogate_key(['match_ha_id', 'event_time', 'event_half', 'event_type', 'event_players', 'score_progression']) }} as event_id,
        *
    from events_with_match_ha_id
)

select * from event_id
