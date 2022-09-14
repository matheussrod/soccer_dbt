
with source as (
    select * from {{ source('dbsoccer', 'match_lineups') }}
),

renamed as (
    select 
        -- ids
        PlayerURL as player_url,
        MatchURL as match_url,

        -- strings
        --Team as team,
        Home_Away as home_away,
        --Formation as formation,
        --Player_Name as player_name,
        Starting as starting,
        --Nation as nation,
        Pos as pos,
        Age as age,

        -- numerics
        --Player_Num as player_num,
        Min as min
        --Gls as gls,
        --Ast as ast,
        --CrdY as crd_y,
        --CrdR as crd_r

        -- dates / times
        --Matchday as match_date
    from source
)

select * from renamed
