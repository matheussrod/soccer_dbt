
with
source as (
    select * from {{ source('dbsoccer', 'match_results') }}
),

renamed as (
    select
        -- ids
        MatchUrl as match_url,

        -- strings
        Country as country,
        Competition_Name as league,
        Season_End_Year as season_end_year,
        Gender as gender,
        --Round as round,
        Wk as wk,
        Day as match_weekday,
        Home as home,
        Away as away,
        --Venue as venue,
        --Referee as referee,
        --Notes as notes,

        -- numerics
        HomeGoals as home_goals,
        AwayGoals as away_goals,
        Attendance as attendance,

        -- dates / times
        Date as match_date,
        Time as match_time
    from source
)

select * from renamed
