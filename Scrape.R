
library(tidyverse)
library(rvest)
library(httr)
library(jsonlite)
library(tidyverse)
library(httr)
library(janitor)



#Set header connections for g-league 
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



url <- "https://stats.gleague.nba.com/stats/leaguedashplayershotlocations?College=&Conference=&Country=&DateFrom=&DateTo=&DistanceRange=By+Zone&Division=&DraftPick=&DraftYear=&GameScope=&GameSegment=&Height=&LastNGames=0&LeagueID=20&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerExperience=&PlayerPosition=&PlusMinus=N&Rank=N&Season=2020-21&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&StarterBench=&TeamID=0&VsConference=&VsDivision=&Weight="
res<- GET(url = url, add_headers(.headers=headers))
json_resp <- fromJSON(content(res, "text"))
player_shooting_style <- data.frame(json_resp$resultSets$rowSet)


colnames(player_shooting_style) <- json_resp[["resultSets"]][["headers"]][[4]][[2]] 


colnames(player_shooting_style)


colnames(player_shooting_style)<- c("PLAYER_ID",
  "PLAYER_NAME",
  "TEAM_ID",
  "TEAM_ABBREVIATION",
  "AGE",
  "NICKNAME",
  "Restricted_Area_FGM",
  "Restricted_Area_FGA",
  "Restricted_Area_FG_PCT",
  "In_The_Paint_Non_RA_FGM",
  "In_The_Paint_Non_RA_FGA",
  "In_The_Paint_Non_RA_FG_PCT",
  "Mid_Range_FGM",
  "Mid_Range_FGA",
  "Mid_Range_FG_PCT",
  "Left_Corner_3_FGM",
  "Left_Corner_3_FGA",
  "Left_Corner_3_FG_PCT",
  "Right_Corner_3_FGM",
  "Right_Corner_3_FGA",
  "Right_Corner_3_FG_PCT",
  "Above_the_Break_3_FGM",
  "Above_the_Break_3_FGA",
  "Above_the_Break_3_FG_PCT",
  "Backcourt_3_FGM",
  "Backcourt_3_FGA",
  "Backcourt_3_FG_PCT")
  
  
player_shooting_style <- player_shooting_style %>% select("PLAYER_NAME",
                                                          "TEAM_ABBREVIATION",
                                                          "Restricted_Area_FGM",
                                                          "Restricted_Area_FGA",
                                                          "Restricted_Area_FG_PCT",
                                                          "In_The_Paint_Non_RA_FGM",
                                                          "In_The_Paint_Non_RA_FGA",
                                                          "In_The_Paint_Non_RA_FG_PCT",
                                                          "Mid_Range_FGM",
                                                          "Mid_Range_FGA",
                                                          "Mid_Range_FG_PCT",
                                                          "Left_Corner_3_FGM",
                                                          "Left_Corner_3_FGA",
                                                          "Left_Corner_3_FG_PCT",
                                                          "Right_Corner_3_FGM",
                                                          "Right_Corner_3_FGA",
                                                          "Right_Corner_3_FG_PCT",
                                                          "Above_the_Break_3_FGM",
                                                          "Above_the_Break_3_FGA",
                                                          "Above_the_Break_3_FG_PCT",
                                                          "Backcourt_3_FGM",
                                                          "Backcourt_3_FGA",
                                                          "Backcourt_3_FG_PCT")
    
       
write.csv(player_shooting_style,paste0('data/','player_shooting_style3.csv'))
