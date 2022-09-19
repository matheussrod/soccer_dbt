
with
teams as (
    select * from {{ ref('stg_fbref__teams') }}
),

teams_with_id as (
    select 
        {{ dbt_utils.surrogate_key(['team_url']) }} as team_id,
        *
    from teams
)

select * from teams_with_id
