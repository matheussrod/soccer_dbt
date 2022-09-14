
with
source as (
    select * from {{ source('dbsoccer', 'teams') }}
),

renamed as (
    select
        team as team_name,
        team_url
    from source
)

select * from renamed
