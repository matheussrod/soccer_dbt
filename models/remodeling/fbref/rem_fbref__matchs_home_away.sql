
with 
matchs as (
    select * from {{ ref('rem_fbref__matchs') }}
),

teams as (
    select * from {{ ref('rem_fbref__teams') }}
),

unpivot_matchs as (
    {{
        dbt_utils.unpivot(
            relation = ref('stg_fbref__matchs_result'), 
            cast_to = 'string', 
            exclude = ['match_url'],
            field_name = 'home_away', value_name = 'team',
            remove = ['country', 'league', 'season_end_year', 'gender', 'wk', 'match_weekday', 'home_goals', 'away_goals', 'attendance', 'match_date', 'match_time']
        )
    }}
),

unpivot_matchs_with_matchs_id as (
    select
        matchs.match_id,
        unpivot_matchs.match_url,
        unpivot_matchs.home_away,
        unpivot_matchs.team
    from unpivot_matchs
        left join matchs 
        on unpivot_matchs.match_url = matchs.match_url
),

matchs_unpivot_with_teams_id as (
    select
        unpivot_matchs.match_id,
        teams.team_id,
        unpivot_matchs.match_url,
        unpivot_matchs.home_away
    from unpivot_matchs_with_matchs_id as unpivot_matchs
        left join teams on teams.team_name = unpivot_matchs.team
),

matchs_unpivot_with_id as (
    select 
        {{ dbt_utils.surrogate_key(['match_id', 'team_id']) }} as match_ha_id,
        *
    from matchs_unpivot_with_teams_id
)

select * from matchs_unpivot_with_id
