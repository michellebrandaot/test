
library(tidyverse)
library(rvest)
library(httr)
library(jsonlite)
library(tidyverse)
library(jsonlite)
library(httr)
library(janitor)
library(gt)


## scounting##
## 1. table1 - team reacord 
## 2. table_team_efficiency - team efficiency 
## 3. four_factors_table - Four Factors
## 4. traditional table 
## 5 Table_shooting -  shooting style 


#Set header connections 
headers = c(
  `Connection` = 'keep-alive',
  `Accept` = 'application/json, text/plain, */*',
  `x-nba-stats-token` = 'true',
  `X-NewRelic-ID` = 'VQECWF5UChAHUlNTBwgBVw==',
  `User-Agent` = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.87 Safari/537.36',
  `x-nba-stats-origin` = 'stats',
  `Sec-Fetch-Site` = 'same-origin',
  `Sec-Fetch-Mode` = 'cors',
  `Referer` = 'https://stats.gleague.nba.com/',
  `Accept-Encoding` = 'gzip, deflate, br',
  `Accept-Language` = 'en-US,en;q=0.9'
)


url <- "https://stats.gleague.nba.com/stats/leaguedashteamstats?Conference=&DateFrom=&DateTo=&Division=&GameScope=&GameSegment=&LastNGames=0&LeagueID=20&Location=&MeasureType=Advanced&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerExperience=&PlayerPosition=&PlusMinus=N&Rank=N&Season=2020-21&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&StarterBench=&TeamID=0&TwoWay=0&VsConference=&VsDivision="

res <- GET(url = url, add_headers(.headers=headers))
json_resp <- fromJSON(content(res, "text"))
df <- data.frame(json_resp$resultSets$rowSet)

colnames(df) <- json_resp[["resultSets"]][["headers"]][[1]]    
View(df)

## cleaning dataset 
df <- df %>% select(-c(TEAM_ID,CFPARAMS,GP_RANK))

colnames(Team)
### Winning 

Team <- df %>% select(TEAM_NAME,GP, W, L,W_PCT,POSS,PACE, PACE_RANK, PACE_PER40 )

write_csv(Team, "Team.csv")

table_1 <-Team %>% 
  gt(rowname_col = "TEAM_NAME") %>%   
  tab_header(
    title = md("**SCOUTING REPORT**"),
    subtitle = "Regular Season only"
  ) %>%   tab_stubhead(label = "Team") %>%
  cols_label(GP = "Games Played", 
             W = "Wins", 
             L = "Losses",
             W_PCT = "Win Percentage",
             PACE = "Pace",
             PACE_RANK = md("*Rank*")) %>%
  text_transform(
    locations = cells_body(
      columns = PACE_RANK
    ),
    fn = function(x){
      team <- word(x, -1)
      paste0(
        "(", x, ")")
    }
  ) %>% cols_align(
    align = "center",
    columns = everything()
  ) %>%  
  tab_style(style = cell_text(color = "blue",
                                     size = px(10)),
                   locations = cells_body(
                     columns = PACE_RANK)
  ) %>%
  tab_style(
    style = cell_text(size = px(1)),
    locations = cells_column_labels(
      columns = PACE_RANK))
  
  




## Efficiency
Efficiency_table <- df %>% select(TEAM_NAME,OFF_RATING,OFF_RATING_RANK,DEF_RATING, DEF_RATING_RANK,NET_RATING,NET_RATING_RANK)



### TEAM EFFICIENCY ## 

   
table_team_efficiency <- Efficiency_table %>% 
  gt(rowname_col = "TEAM_NAME") %>%   
  tab_header(
    title = md("**Team Efficiency**"),
    subtitle = "Regular Season only"
    ) %>%
  tab_stubhead(label = "Team") %>%
   cols_label(OFF_RATING = "Offensive Rating", 
             DEF_RATING = "Defensive Rating", 
             NET_RATING = "Net Rating",
             OFF_RATING_RANK = md("*Rank*"),
             DEF_RATING_RANK = md("*Rank*"),
             NET_RATING_RANK = md("*Rank*")) %>%
  text_transform(
    locations = cells_body(
      columns = c(OFF_RATING_RANK,DEF_RATING_RANK,NET_RATING_RANK)
    ),
    fn = function(x){
      team <- word(x, -1)
      paste0(
        "(", x, ")")
    }
  ) %>%
  tab_spanner( label = md("**Offense**"),
               columns = c(OFF_RATING,OFF_RATING_RANK)) %>%
  tab_spanner( label =  md("**Defense**"),
               columns = c(DEF_RATING,DEF_RATING_RANK)) %>%
  tab_spanner( label =  md("**Net Rating**"),
               columns = c(NET_RATING,NET_RATING_RANK)) %>%
  cols_align(
    align = "center",
    columns = everything()
    ) %>%
  cols_align(
    align = "left",
    columns = c(OFF_RATING_RANK,DEF_RATING_RANK)
  )  %>% 
  tab_style(style = cell_text(color = "blue",
                              size = px(10)),
            locations = cells_body(
              columns = c(OFF_RATING_RANK,DEF_RATING_RANK,NET_RATING_RANK))
            )%>%
  tab_style(
    style = cell_text(size = px(10)),
    locations = cells_body(
      columns = c(OFF_RATING_RANK,DEF_RATING_RANK,NET_RATING_RANK))
  ) %>%
  tab_style(
    style = cell_text(size = px(1)),
    locations = cells_column_labels(
      columns = c(OFF_RATING_RANK,DEF_RATING_RANK,NET_RATING_RANK))
    )
  


write.csv(Efficiency_table, "Efficiency_table.csv")
