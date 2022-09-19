
with
matchs_result as (
    select * from {{ ref('stg_fbref__matchs_result') }}  
),

leagues as (
    select 
        distinct
        country,
        league,
        season_end_year,
        gender
    from matchs_result
),

leagues_with_surrogate_key as (
    select
        {{ dbt_utils.surrogate_key(['league', 'season_end_year']) }} as league_id,
        *
    from leagues
)

select * from leagues_with_surrogate_key
