
with source as (
    select * from {{ source('dbsoccer', 'match_stats_summary') }}
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
        Player as player,
        --Nation as nation,
        Pos as pos,
        Age as age,

        -- numerics
        --Home_Score as home_score,
        --Home_xG as home_xG,
        --Home_Yellow_Cards as home_yellow_cards,
        --Home_Red_Cards as home_red_cards,
        --Away_Score as away_score,
        --Away_xG as away_xG,
        --Away_Yellow_Cards as away_yellow_cards,
        --Away_Red_Cards as away_red_cards,
        --Player_Num as player_num,
        Min as min,
        Gls as gls,
        Ast as ast,
        PK as pk,
        PKatt as pk_att,
        Sh as sh,
        SoT as sot,
        CrdY as crd_y,
        CrdR as crd_r,
        Fls as fls,
        Fld as fld,
        Off as off,
        Crs as crs,
        TklW as tkl_w,
        Int as int,
        OG as og,
        PKwon as pk_won,
        PKcon as pk_con

        -- dates / times
        --Match_Date as match_date
    from source
)

select * from renamed
