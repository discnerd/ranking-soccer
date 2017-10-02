# D3 soccer Rankings
`r format(Sys.time(), '%d %B, %Y')`  

 








```r
n<-network.initialize(length(all_teams), directed = FALSE, multiple = FALSE)
rankedteams <- rankedteams %>% mutate(ranking = min_rank(desc(Rating)))
network.vertex.names(n) <- as.character(all_teams)
n %v% "rank" <- arrange(rankedteams,match( Team, all_teams))$ranking
n %v% "rating" <- arrange(rankedteams,match( Team, all_teams))$Rating
n %v% "conference" <- as.character(all_conferences)

network.adjacency(as.matrix(A_unnormed), n, ignore.eval=FALSE, names.eval = c("WinStrength"))
```
## Top 25

```r
#rankedteams %>% select(ranking, Team, Rating) %>% knitr::kable()

rankedteams %>% filter(ranking <= 25) %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                      Rating  Conference 
--------  ---------------------  ---------  -----------
       1  Chicago                 6.387459  UAA        
       2  Drew                    5.616397  LAND       
       3  Rowan                   5.340627  NJAC       
       4  Calvin                  5.173897  MIAA       
       5  Trinity (Texas)         4.709997  SCAC       
       6  Messiah                 4.510491  MACC       
       7  Lycoming                4.420848  MACC       
       8  Johns Hopkins           4.366126  CC         
       9  John Carroll            4.349073  OAC        
      10  Carnegie Mellon         4.342242  UAA        
      11  Rutgers-Newark          4.306585  NJAC       
      12  Cortland State          3.751193  SUNYAC     
      13  Tufts                   3.723015  NESCAC     
      14  Kenyon                  3.595755  NCAC       
      15  Connecticut College     3.412176  NESCAC     
      16  Redlands                3.330118  SCIAC      
      17  Oneonta State           3.255746  SUNYAC     
      18  Lebanon Valley          3.067752  MACC       
      19  Springfield             2.953767  NEWMAC     
      20  Lynchburg               2.908724  ODAC       
      21  Mary Hardin-Baylor      2.893631  ASC        
      22  North Park              2.879306  CCIW       
      23  Gettysburg              2.771240  CC         
      24  Texas-Tyler             2.697626  ASC        
      25  St. Joseph's (Maine)    2.667293  GNAC       

```r
rankedteams %>% filter(Conference=="IIAC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      60  Wartburg             1.8577194  IIAC       
      80  Simpson              1.6348073  IIAC       
     104  Luther               1.4157238  IIAC       
     145  Central              1.0628338  IIAC       
     153  Loras                1.0264488  IIAC       
     199  Dubuque              0.7804019  IIAC       
     277  Nebraska Wesleyan    0.3995934  IIAC       
     318  Buena Vista          0.2629241  IIAC       
     351  Coe                  0.1830870  IIAC       

```r
rankedteams %>% filter(Team == "Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 1.026449       IIAC     153
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
net<-ggnetwork(n %s% which( n %v% "rank" < 26), layout="fruchtermanreingold")
#net<-ggnetwork(n , layout="fruchtermanreingold")
ggplot(net, aes(x = x, y = y, xend = xend, yend = yend))+
  geom_edges(aes(alpha=WinStrength), curvature = 0.2)+
  geom_nodes(  ) +theme_blank()+
  geom_nodelabel_repel(aes(label=vertex.names, fill=rank))+
  scale_color_gradient(low="purple", high="gold")+
  scale_fill_gradient(low="gold", high="purple")
```

```
## Warning: Ignoring unknown parameters: segment.color
```

![](PullAndNetwork_files/figure-html/plottop25Men-1.png)<!-- -->






```r
n<-network.initialize(length(all_teams), directed = FALSE, multiple = TRUE)
rankedteams <- rankedteams %>% mutate(ranking = min_rank(desc(Rating)))
network.vertex.names(n) <- as.character(all_teams)
n %v% "rank" <- arrange(rankedteams,match( Team, all_teams))$ranking
n %v% "rating" <- arrange(rankedteams,match( Team, all_teams))$Rating
n %v% "conference" <- as.character(all_conferences)

network.adjacency(as.matrix(A_unnormed), n, ignore.eval=FALSE, names.eval = c("WinStrength"))
```
## Top 25


```r
#rankedteams %>% select(ranking, Team, Rating) %>% knitr::kable()

rankedteams %>% filter(ranking <= 25) %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                      Rating  Conference 
--------  --------------------  ----------  -----------
       1  TCNJ                   25.129242  NJAC       
       2  Chicago                15.495893  UAA        
       3  Christopher Newport     8.569766  CAC        
       4  Johns Hopkins           8.107610  CC         
       5  Washington U.           7.485769  UAA        
       6  Hope                    6.678503  MIAA       
       7  Hardin-Simmons          6.566498  ASC        
       8  Messiah                 6.411287  MACC       
       9  MIT                     6.246330  NEWMAC     
      10  Williams                6.091171  NESCAC     
      11  William Smith           5.807451  LL         
      12  Geneseo State           5.703525  SUNYAC     
      13  Trinity (Texas)         5.316593  SCAC       
      14  Loras                   4.965232  IIAC       
      15  Emory                   4.572391  UAA        
      16  Western Connecticut     4.528829  LEC        
      17  Carnegie Mellon         4.275072  UAA        
      18  Wheaton (Ill.)          4.214751  CCIW       
      19  UW-La Crosse            4.115985  WIAC       
      20  Swarthmore              3.890943  CC         
      21  UW-Whitewater           3.760338  WIAC       
      22  Illinois Wesleyan       3.527344  CCIW       
      23  St. Thomas              3.394513  MIAC       
      24  Rowan                   3.297814  NJAC       
      25  Connecticut College     3.206989  NESCAC     

```r
rankedteams %>% filter(Conference=="IIAC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      14  Loras                4.9652322  IIAC       
      27  Central              3.1113500  IIAC       
      28  Wartburg             3.1107764  IIAC       
     115  Coe                  1.2279044  IIAC       
     154  Luther               0.9315033  IIAC       
     186  Dubuque              0.6841741  IIAC       
     288  Nebraska Wesleyan    0.1867916  IIAC       
     304  Simpson              0.1410771  IIAC       
     343  Buena Vista          0.0733725  IIAC       

```r
rankedteams %>% filter(Team=="Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 4.965232       IIAC      14
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




```r
net<-ggnetwork(n %s% which( n %v% "rank" < 26), layout="fruchtermanreingold")
#net<-ggnetwork(n , layout="fruchtermanreingold")
ggplot(net, aes(x = x, y = y, xend = xend, yend = yend))+
  geom_edges(aes(alpha=WinStrength), curvature = 0.2)+
  geom_nodes(  ) +theme_blank()+
  geom_nodelabel_repel(aes(label=vertex.names, fill=rank))+
  scale_color_gradient(low="purple", high="gold")+
  scale_fill_gradient(low="gold", high="purple")
```

```
## Warning: Ignoring unknown parameters: segment.color
```

![](PullAndNetwork_files/figure-html/plottop25Women-1.png)<!-- -->
