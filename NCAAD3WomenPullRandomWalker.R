#setwd("C:/Users/mr437799/Dropbox/Current/Data Projects/Football Ranking/Soccer 2015")
#setwd("~/Dropbox/Current/Data Projects/Football Ranking/Soccer 2015")
library(rvest)
library(dplyr)
library(Matrix)

teams <-read_html("http://www.d3soccer.com/teams/index-women")
all_teams<-teams %>% html_nodes("td:nth-child(1) a") %>% html_text() 
all_teams <-  gsub("^\\s+|\\s+$", "", all_teams)
all_conferences <- teams %>% html_nodes(".roster td+ td a") %>% html_text()

root_html <- "http://www.d3soccer.com/seasons/women/2016/schedule?date="
day<-"2016-08-20"
scores <- read_html(paste0(root_html,day))
teams<-scores %>% html_nodes(".conf-teams-container .opponent") %>% html_text()
game_scores<-scores %>% html_nodes(".conf-teams-container .result") %>% html_text() %>% as.numeric()
results<-data.frame(teams, game_scores)
if(length(results[,1])!=0){
  results<-bind_cols(slice(results, seq(1,length(results$teams),2)), slice(results, seq(2,length(results$teams),2)))
  names(results) <- c("Team1", "Score1", "Team2", "Score2")
  results<-results %>% 
    filter((Team1 %in% all_teams) && (Team2 %in% all_teams)) %>% 
    filter(!is.na(Score1)) %>% filter( !is.na(Score2) )
  all_results<-results
} else{
  all_results <- setNames(data.frame(matrix(ncol=4, nrow=0)), c("Team1", "Score1", "Team2", "Score2"))
}
days<-format(seq(strptime("08/20/12","%m/%d/%H"),Sys.time(),by="day"),"%Y-%m-%d")

for(day in days){
  Sys.sleep(runif(1,1,2))
  print(day)
  try({
    scores <- read_html(paste0(root_html,day))
    teams<-scores %>% html_nodes(".conf-teams-container .opponent") %>% html_text()
    game_scores<-scores %>% html_nodes(".conf-teams-container .result") %>% html_text() %>% as.numeric()
    results<-data.frame(teams, game_scores) 
    if(length(results[,1])!=0){
      results<-bind_cols(slice(results, seq(1,length(results$teams),2)), slice(results, seq(2,length(results$teams),2)))
      names(results) <- c("Team1", "Score1", "Team2", "Score2")
      results<-results %>% 
        filter((Team1 %in% all_teams) && (Team2 %in% all_teams)) %>% 
        filter(!is.na(Score1)) %>% filter( !is.na(Score2) )
      all_results<-bind_rows(all_results,results)
    }
  })
}








A=sparseMatrix(seq(1,length(all_teams)),seq(1,length(all_teams)),x=0)
b=rep(1,length(all_teams))
#MOV of 3 is insurmountable
P=matrix(c(1,-1/2,0,0,0,
           -1/2,1,-1/2,0,0,
           0,-1/2,1,-1/2,0,
           0,0,-1/2,1,-1/2,
           0,0,0,-1/2,1)
         ,nrow=5)
v=c(0,0,0,0,1/2)
shares<-solve(P,v)

for(i in 1:length(all_results$Team1)){
  if(abs(all_results[i,]$Score1-all_results[i,]$Score2)>=3){
    if(all_results[i,]$Score1>all_results[i,]$Score2){
      Share1<-1
      Share2<-0
    } else{
      Share2<-1
      Share1<-0
    }
  } else{
    Share1<-shares[all_results[i,]$Score1-all_results[i,]$Score2+3]
    Share2<-1-Share1
  }
  team1=match(all_results[i,]$Team1,all_teams)
  team2=match(all_results[i,]$Team2,all_teams)
  if( is.na(team1) | is.na(team2)){ next }
  A[team1,team2]=
    A[team1,team2]+Share2
  A[team2,team1]=
    A[team2,team1]+Share1
  A[team1,team1]=
    A[team1,team1]+Share1
  A[team2,team2]=
    A[team2,team2]+Share2
}



for(i in 1:length(all_teams)){
  A[i,]=A[i,]/sum(A[i,])
}


library(expm)
b=t(rep(1,length(all_teams)))
for( i in 1:1000){
  b<-b%*%A
}

#sol<-eigen(t(A))
rankedteams<-data.frame(Team=all_teams, Rating=as.numeric(t(b)), Conference=all_conferences)
rankedteams <- arrange(rankedteams, desc(Rating))

write.csv(rankedteams, paste("D3 Women Soccer RW", format(Sys.time(),"%Y %m %d"),".csv",sep=""), row.names = TRUE)


