library(rvest)
library(dplyr)
library(Matrix)

teams <-read_html("http://www.d3soccer.com/teams/index-women")
all_teams<-teams %>% html_nodes("td:nth-child(1) a") %>% html_text() 
all_teams <-  gsub("^\\s+|\\s+$", "", all_teams)
all_conferences <- teams %>% html_nodes(".roster td+ td a") %>% html_text()

root_html <- "https://d3soccer.prestosports.com/seasons/women/2019/schedule?date="

day<-"2019-08-26"
scores <- read_html(paste0(root_html,day))

game_scores<-scores %>% html_nodes(".schedule-filter table") %>% html_table(header=TRUE) %>% .[[1]]
names(game_scores) <- c("Team1", "Score1", "Team2", "Score2", "TimeStatus", "Links")
game_scores %>% select(c("Team1", "Score1", "Team2", "Score2")) %>%
  
  mutate(
    Team2 = str_remove(Team2, "No. [0-9]*"),
    Team2 = str_trim(Team2),
    Team1 = str_remove(Team1, "No. [0-9]*"),
    Team1 = str_trim(Team1)
  )  -> results
if(!is.integer(results$Score1)){
  results %>% mutate_at(vars(contains("Score")), parse_number) -> results
}
results %>% filter(!is.na(Score1) & !is.na(Score2)) ->results

all_results <- results

days<-format(seq(strptime("08/27/12","%m/%d/%H"),Sys.time(),by="day"),"%Y-%m-%d")

for(day in days) {
  #Sys.sleep(runif(1,1,2))
  print(day)
  
  
  scores <- read_html(paste0(root_html, day))
  game_scores <-
    scores %>% html_nodes(".schedule-filter table") %>% 
    html_table(header = TRUE) %>% .[[1]]
  names(game_scores) <-
    c("Team1", "Score1", "Team2", "Score2", "TimeStatus", "Links")
  
  game_scores %>% select(c("Team1", "Score1", "Team2", "Score2")) %>%
    
    mutate(
      Team2 = str_remove(Team2, "No. [0-9]*"),
      Team2 = str_trim(Team2),
      Team1 = str_remove(Team1, "No. [0-9]*"),
      Team1 = str_trim(Team1)
    )  -> results
  if(is.character(results$Score1)){
    results %>% mutate_at(vars(contains("Score")), parse_number) -> results
  }
  results %>% filter(!is.na(Score1) & !is.na(Score2)) ->results
  
  all_results <- bind_rows(all_results, results)
  
  
}



save(all_results, all_teams, file=paste0("2019 Rankings/Women", format(Sys.time(),"%Y %m %d"),
                                         ".Rdata"))




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

A_unnormed <- A

for(i in 1:length(all_teams)){
  if(sum(A[i,] !=0 )){
    A[i,]=A[i,]/sum(A[i,])
  }
}


library(expm)
b=t(rep(1,length(all_teams)))
for( i in 1:10000){
  b<-b%*%A
}

#sol<-eigen(t(A))
rankedteams<-data.frame(Team=all_teams, Rating=as.numeric(t(b)), Conference=all_conferences)
rankedteams <- arrange(rankedteams, desc(Rating))

write.csv(rankedteams, paste("2019 Rankings/D3 Women Soccer RW", 
                             format(Sys.time(),"%Y %m %d"),".csv",sep=""), row.names = TRUE)


