library(tidyverse)
library(rvest)
library(httr)
library(jsonlite)
library(tidyverse)
library(httr)
library(janitor)


headers <- c(
  `Host` = 'stats.nba.com',
  `User-Agent` = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36',
  `Accept` = 'application/json, text/plain, */*',
  `Accept-Language` = 'en-US,en;q=0.5',
  `Accept-Encoding` = 'gzip, deflate, br',
  `x-nba-stats-origin` = 'stats',
  `x-nba-stats-token` = 'true',
  `Connection` = 'keep-alive',
  `Origin` = "http://stats.nba.com",
  `Referer` = 'https://www.nba.com/',
  `Pragma` = 'no-cache',
  `Cache-Control` = 'no-cache'
)

 
url <-"https://www.nba.com/stats/leaders/?Season=2021-22&SeasonType=Pre%20Season"
res <- GET(url = url, add_headers(.headers=headers))
json_resp <- fromJSON(content(res, "text"))
NBALeagueLeaders <- data.frame(json_resp$resultSets$rowSet)

#write a file
write.csv(NBALeagueLeaders,paste0('data/','NBALeagueLeaders.csv'))
