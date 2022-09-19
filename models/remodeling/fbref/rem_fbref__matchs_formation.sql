
with
reports_unpivot as (
    {{
        dbt_utils.unpivot(
            relation = ref('stg_fbref__matchs_report'),
            cast_to = 'string',
            exclude = ['home_formation', 'away_formation', 'match_url'],
            field_name = 'home_away', value_name = 'team',
            remove = ['home_score', 'away_score', 'home_xG', 'away_xG']
        )
    }}
),

formation_away_home as (
    select
        match_url,
        case
            when home_away = 'home_team' then 'home'
            else 'away'
        end as home_away,
        case 
            when home_away = 'home' then home_formation
            else away_formation
        end as formation
    from reports_unpivot
),

matchs_home_away as (
    select * from {{ ref('rem_fbref__matchs_home_away') }}
),

formation_with_match_ha_id as (
    select
        matchs.match_ha_id,
        formation.formation
    from formation_away_home as formation
        left join matchs_home_away as matchs
        on matchs.match_url = formation.match_url
            and matchs.home_away = formation.home_away
),

formation_id as (
    select 
        {{ dbt_utils.surrogate_key(['match_ha_id', 'formation']) }} as formation_id,
        *
    from formation_with_match_ha_id
)

select * from formation_id
