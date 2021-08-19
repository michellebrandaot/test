
library(tidyverse)
library(rvest)
library(httr)
library(jsonlite)
library(tidyverse)
library(httr)
library(janitor)



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


## cleaning dataset 
df <- df %>% select(-c(TEAM_ID,CFPARAMS,GP_RANK))


### Winning 

Team <- df %>% select(TEAM_NAME,GP, W, L,W_PCT,POSS,PACE, PACE_RANK, PACE_PER40 )

write_csv(Team, paste0('data/','Team.csv')


## Efficiency
Efficiency_table <- df %>% select(TEAM_NAME,OFF_RATING,OFF_RATING_RANK,DEF_RATING, DEF_RATING_RANK,NET_RATING,NET_RATING_RANK)



write.csv(Efficiency_table, paste0('data/','Efficiency_table.csv')


url_four_factors <- "https://stats.gleague.nba.com/stats/leaguedashteamstats?Conference=&DateFrom=&DateTo=&Division=&GameScope=&GameSegment=&LastNGames=0&LeagueID=20&Location=&MeasureType=Four+Factors&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerExperience=&PlayerPosition=&PlusMinus=N&Rank=N&Season=2020-21&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&StarterBench=&TeamID=0&TwoWay=0&VsConference=&VsDivision="


res1 <- GET(url = url_four_factors, add_headers(.headers=headers))
json_resp1 <- fromJSON(content(res1, "text"))
four_factors <- data.frame(json_resp1$resultSets$rowSet)

colnames(four_factors) <- json_resp1[["resultSets"]][["headers"]][[1]]    
four_factors <- four_factors %>% select(TEAM_NAME,EFG_PCT,FTA_RATE,TM_TOV_PCT,OREB_PCT,OPP_EFG_PCT,OPP_FTA_RATE,OPP_TOV_PCT,OPP_OREB_PCT,EFG_PCT_RANK,FTA_RATE_RANK,TM_TOV_PCT_RANK,OREB_PCT_RANK,
                                          OPP_EFG_PCT_RANK,OPP_FTA_RATE_RANK,OPP_TOV_PCT_RANK,OPP_OREB_PCT_RANK)

                                                                                                    
write.csv(four_factors,paste0('data/','four_factors.csv')
