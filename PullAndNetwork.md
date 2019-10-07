---
title: "D3 soccer Rankings"
date: "07 October, 2019"
output: 
  html_document: 
    keep_md: yes
---


# Men
 








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



 ranking  Team                        Rating  Conference 
--------  -----------------------  ---------  -----------
       1  Amherst                   8.363722  NESCAC     
       2  Johns Hopkins             6.435379  CC         
       3  Tufts                     5.772514  NESCAC     
       4  Mary Washington           5.700787  CAC        
       5  Calvin                    5.567140  MIAA       
       6  Christopher Newport       5.543309  CAC        
       7  Washington and Lee        5.418442  ODAC       
       8  Covenant                  5.215679  USAC       
       9  Roanoke                   5.193439  ODAC       
      10  Franklin and Marshall     4.378234  CC         
      11  Connecticut College       4.261961  NESCAC     
      12  Middlebury                4.208395  NESCAC     
      13  Oneonta State             3.983242  SUNYAC     
      14  Catholic                  3.883375  LAND       
      15  Gettysburg                3.874163  CC         
      16  Chicago                   3.671766  UAA        
      17  Ithaca                    3.641007  LL         
      18  Hardin-Simmons            3.580379  ASC        
      19  Rowan                     3.535411  NJAC       
      20  Oglethorpe                3.503903  SAA        
      21  Bates                     3.469974  NESCAC     
      22  RPI                       3.463533  LL         
      23  Claremont-Mudd-Scripps    3.314924  SCIAC      
      24  Messiah                   3.301238  MACC       
      25  Ohio Wesleyan             3.186408  NCAC       

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      28  Central              3.1409878  ARC        
      32  Loras                3.0285347  ARC        
      61  Luther               2.1806491  ARC        
      73  Simpson              1.7211806  ARC        
     141  Wartburg             1.0199542  ARC        
     220  Dubuque              0.5287342  ARC        
     235  Nebraska Wesleyan    0.4617576  ARC        
     376  Coe                  0.0713437  ARC        
     390  Buena Vista          0.0444160  ARC        

```r
rankedteams %>% filter(Team == "Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 3.028535        ARC      32
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

![](PullAndNetwork_files/figure-html/plottop25Men-1.png)<!-- -->
# Women





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
       1  Pomona-Pitzer          13.677916  SCIAC      
       2  Messiah                12.195209  MACC       
       3  Christopher Newport    10.482813  CAC        
       4  Arcadia                10.162750  MACC       
       5  Gettysburg              9.509140  CC         
       6  MIT                     9.363117  NEWMAC     
       7  William Smith           8.750692  LL         
       8  Washington U.           8.738304  UAA        
       9  Wheaton (Ill.)          8.159610  CCIW       
      10  TCNJ                    7.917645  NJAC       
      11  Johns Hopkins           7.541190  CC         
      12  Chicago                 6.802198  UAA        
      13  Tufts                   6.302403  NESCAC     
      14  Centre                  6.275105  SAA        
      15  Dickinson               5.770909  CC         
      16  Geneseo State           5.762074  SUNYAC     
      17  Washington and Lee      5.579075  ODAC       
      18  Haverford               5.405032  CC         
      19  McDaniel                4.914681  CC         
      20  Middlebury              4.750553  NESCAC     
      21  Chapman                 4.744196  SCIAC      
      22  Stevens                 4.704247  MACF       
      23  St. Thomas              4.369327  MIAC       
      24  Swarthmore              4.150574  CC         
      25  Randolph-Macon          4.036175  ODAC       

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      33  Wartburg             3.3519998  ARC        
      90  Nebraska Wesleyan    1.3623120  ARC        
      94  Dubuque              1.3034897  ARC        
      98  Loras                1.2710479  ARC        
     149  Simpson              0.7595572  ARC        
     177  Coe                  0.5109695  ARC        
     194  Luther               0.4052699  ARC        
     259  Central              0.2089984  ARC        
     407  Buena Vista          0.0027065  ARC        

```r
rankedteams %>% filter(Team=="Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 1.271048        ARC      98
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

![](PullAndNetwork_files/figure-html/plottop25Women-1.png)<!-- -->
