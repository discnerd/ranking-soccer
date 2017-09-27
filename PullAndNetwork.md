# R Notebook

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*. 








```r
n<-network.initialize(length(all_teams), directed = FALSE, multiple = TRUE)
rankedteams <- rankedteams %>% mutate(ranking = min_rank(desc(Rating)))
network.vertex.names(n) <- as.character(rankedteams$Team)
n %v% "rank" <- rankedteams$ranking
n %v% "rating" <- rankedteams$Rating
n %v% "conference" <- as.character(rankedteams$Conference)

add.edges(n, 
          parse_factor(all_results$Team1,as.character(rankedteams$Team)), 
          parse_factor(all_results$Team2,as.character(rankedteams$Team)), 
          names.eval = rep("PtDiff", nrow(all_results)), 
          vals.eval = all_results %>% mutate(PtDiff= Score1 - Score2) %>%
            .$PtDiff )
```
## Top 25

```r
#rankedteams %>% select(ranking, Team, Rating) %>% knitr::kable()

rankedteams %>% filter(ranking <= 25) %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                     Rating  Conference 
--------  --------------------  ---------  -----------
       1  Chicago                6.910181  UAA        
       2  Johns Hopkins          5.898943  CC         
       3  Calvin                 5.675315  MIAA       
       4  Drew                   5.379360  LAND       
       5  Trinity (Texas)        5.371924  SCAC       
       6  Rowan                  5.329993  NJAC       
       7  Carnegie Mellon        4.976060  UAA        
       8  John Carroll           4.921824  OAC        
       9  Lycoming               4.689400  MACC       
      10  Messiah                4.637460  MACC       
      11  Rutgers-Newark         4.599504  NJAC       
      12  Kenyon                 3.700718  NCAC       
      13  Washington and Lee     3.596234  ODAC       
      14  Cortland State         3.589269  SUNYAC     
      15  Redlands               3.374483  SCIAC      
      16  Mary Hardin-Baylor     3.175975  ASC        
      17  Ohio Wesleyan          3.139407  NCAC       
      18  Haverford              3.064167  CC         
      19  Oneonta State          3.021046  SUNYAC     
      20  Puget Sound            2.974666  NWC        
      21  Connecticut College    2.948518  NESCAC     
      22  Transylvania           2.940746  HCAC       
      23  Emory                  2.910845  UAA        
      24  Texas-Tyler            2.891112  ASC        
      25  Colorado College       2.710006  SCAC       

```r
rankedteams %>% filter(Conference=="IIAC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      54  Wartburg             1.9810832  IIAC       
      91  Loras                1.5216706  IIAC       
      99  Simpson              1.4545626  IIAC       
     118  Luther               1.2733488  IIAC       
     155  Dubuque              0.9722100  IIAC       
     186  Central              0.8049129  IIAC       
     325  Nebraska Wesleyan    0.2384509  IIAC       
     347  Coe                  0.1683650  IIAC       
     361  Buena Vista          0.1444229  IIAC       

```r
rankedteams %>% filter(Team == "Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 1.521671       IIAC      91
```

## Game Network


```r
#net<-ggnetwork(n %s% which( n %v% "rank" < 26), layout="fruchtermanreingold")
net<-ggnetwork(n , layout="fruchtermanreingold")
ggplot(net, aes(x = x, y = y, xend = xend, yend = yend))+
  geom_edges(alpha=0.1)+
  geom_nodes( aes(color=rating), alpha=0.5 ) +theme_blank()+
  scale_color_gradient(low="purple", high="gold")#+
```

![](PullAndNetwork_files/figure-html/plotNetwork-1.png)<!-- -->

```r
#  geom_nodelabel_repel(aes(label=vertex.names))
```





```r
n<-network.initialize(length(all_teams), directed = FALSE, multiple = TRUE)
rankedteams <- rankedteams %>% mutate(ranking = min_rank(desc(Rating)))
network.vertex.names(n) <- as.character(rankedteams$Team)
n %v% "rank" <- rankedteams$ranking
n %v% "rating" <- rankedteams$Rating
n %v% "conference" <- as.character(rankedteams$Conference)

add.edges(n, 
          parse_factor(all_results$Team1,as.character(rankedteams$Team)), 
          parse_factor(all_results$Team2,as.character(rankedteams$Team)), 
          names.eval = rep("PtDiff", nrow(all_results)), 
          vals.eval = all_results %>% mutate(PtDiff= Score1 - Score2) %>%
            .$PtDiff )
```
## Top 25


```r
#rankedteams %>% select(ranking, Team, Rating) %>% knitr::kable()

rankedteams %>% filter(ranking <= 25) %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                      Rating  Conference 
--------  --------------------  ----------  -----------
       1  TCNJ                   23.063553  NJAC       
       2  Chicago                19.697182  UAA        
       3  Johns Hopkins          10.309078  CC         
       4  Christopher Newport     9.661070  CAC        
       5  Hardin-Simmons          7.322851  ASC        
       6  Messiah                 7.080575  MACC       
       7  MIT                     6.997804  NEWMAC     
       8  Western Connecticut     6.901701  LEC        
       9  Geneseo State           6.850464  SUNYAC     
      10  Hope                    6.817682  MIAA       
      11  William Smith           6.503505  LL         
      12  Washington U.           6.133604  UAA        
      13  Emory                   5.704262  UAA        
      14  Trinity (Texas)         5.298850  SCAC       
      15  Swarthmore              5.261781  CC         
      16  Williams                4.901902  NESCAC     
      17  Loras                   4.568371  IIAC       
      18  Carnegie Mellon         4.447589  UAA        
      19  Illinois Wesleyan       4.092019  CCIW       
      20  UW-La Crosse            3.959628  WIAC       
      21  St. Thomas              3.921994  MIAC       
      22  Stevens                 3.585179  E8         
      23  Pacific Lutheran        3.580193  NWC        
      24  New York University     3.527925  UAA        
      25  UW-Whitewater           3.491159  WIAC       

```r
rankedteams %>% filter(Conference=="IIAC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      17  Loras                4.5683708  IIAC       
      35  Wartburg             2.7396117  IIAC       
      50  Coe                  2.1269000  IIAC       
      53  Central              1.9850877  IIAC       
     123  Luther               1.0979238  IIAC       
     193  Dubuque              0.5466503  IIAC       
     257  Nebraska Wesleyan    0.2830530  IIAC       
     327  Simpson              0.0727715  IIAC       
     361  Buena Vista          0.0294158  IIAC       

```r
rankedteams %>% filter(Team=="Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 4.568371       IIAC      17
```

## Game Network


```r
#net<-ggnetwork(n %s% which( n %v% "rank" < 26), layout="fruchtermanreingold")
net<-ggnetwork(n , layout="fruchtermanreingold")
ggplot(net, aes(x = x, y = y, xend = xend, yend = yend))+
  geom_edges(alpha=0.1)+
  geom_nodes( aes(color=rating), alpha=0.5 ) +theme_blank()+
  scale_color_gradient(low="purple", high="gold")#+
```

![](PullAndNetwork_files/figure-html/plotNetworkWomen-1.png)<!-- -->

```r
#  geom_nodelabel_repel(aes(label=vertex.names))
```
