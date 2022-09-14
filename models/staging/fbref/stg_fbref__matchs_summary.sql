
with source as (
    select * from {{ source('dbsoccer', 'match_summary') }}
),

renamed as (
    select 
        -- ids
        Game_URL as match_url,

        -- strings
        --League as league,
        --Matchweek as matchweek,
        --Home_Team as home_team,
        --Home_Formation as home_formation,
        --Home_Goals as home_goals,
        --Away_Team as away_team,
        --Away_Formation as away_formation,
        --Away_Goals as away_goals,
        Team as team,
        Home_Away as home_away,
        Event_Type as event_type,
        Event_Players as event_players,
        Score_Progression as score_progression,

        -- numerics
        --Home_Score as home_score,
        --Home_xG as home_xG,
        --Home_Yellow_Cards as home_yellow_cards,
        --Home_Red_Cards as home_red_cards,
        --Away_Score as away_score,
        --Away_xG as away_xG,
        --Away_Yellow_Cards as away_yellow_cards,
        --Away_Red_Cards as away_red_cards,
        Event_Time as event_time,
        Event_Half as event_half
        --Penalty_Number as penalty_number,

        -- bolleans
        --Is_Pens as is_pens,

        -- dates / times
        --Match_Date as match_date
    from source
)

select * from renamed
