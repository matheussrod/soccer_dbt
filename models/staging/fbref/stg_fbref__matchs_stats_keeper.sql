
with source as (
    select * from {{ source('dbsoccer', 'match_stats_keeper') }}
),

renamed as (
    select
        -- ids
        Game_URL as match_url,

        -- strings
        League as league,
        Matchweek as matchweek,
        Home_Team as home_team,
        Home_Formation as home_formation,
        Home_Goals as home_goals,
        Away_Team as away_team,
        Away_Formation as away_formation,
        Away_Goals as away_goals,
        Team as team,
        Home_Away as home_away,
        Player as player,
        Nation as nation,
        Age as age,

        -- numerics
        Home_Score as home_score,
        Home_xG as home_xG,
        Home_Yellow_Cards as home_yellow_cards,
        Home_Red_Cards as home_red_cards,
        Away_Score as away_score,
        Away_xG as away_xG,
        Away_Yellow_Cards as away_yellow_cards,
        Away_Red_Cards as away_red_cards,
        Min as min,
        SoTA_Shot_Stopping as sota_shot_stopping,
        GA_Shot_Stopping as ga_shot_stopping,
        Saves_Shot_Stopping as saves_shot_stopping,
        Save_percent_Shot_Stopping as save_percent_shot_stopping,

        -- dates / times
        Match_Date as match_date
    from source
)

select * from renamed
