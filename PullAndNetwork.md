---
title: "D3 soccer Rankings"
date: "10 November, 2019"
output: 
  html_document: 
    keep_md: yes
---


# Men
 








```r
n<-network.initialize(length(all_teams), directed = TRUE, multiple = FALSE)
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



 ranking  Team                       Rating  Conference 
--------  ----------------------  ---------  -----------
       1  Johns Hopkins            7.274983  CC         
       2  Mary Washington          6.404937  CAC        
       3  Christopher Newport      6.325505  CAC        
       4  Franklin and Marshall    6.058318  CC         
       5  Washington and Lee       5.861226  ODAC       
       6  Amherst                  5.501767  NESCAC     
       7  Calvin                   5.199598  MIAA       
       8  Tufts                    4.758455  NESCAC     
       9  Oneonta State            4.453158  SUNYAC     
      10  Messiah                  4.320247  MACC       
      11  Catholic                 4.099097  LAND       
      12  Chicago                  3.762664  UAA        
      13  Oglethorpe               3.747740  SAA        
      14  Gustavus Adolphus        3.743559  MIAC       
      15  Montclair State          3.642345  NJAC       
      16  Roanoke                  3.604485  ODAC       
      17  Connecticut College      3.470336  NESCAC     
      18  Centre                   3.367097  SAA        
      19  Covenant                 3.305011  USAC       
      20  Kenyon                   3.293775  NCAC       
      21  RPI                      3.273092  LL         
      22  Middlebury               3.271638  NESCAC     
      23  Luther                   3.254263  ARC        
      24  Ohio Wesleyan            3.177396  NCAC       
      25  Gettysburg               3.162307  CC         

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      23  Luther               3.2542631  ARC        
      37  Loras                2.6883572  ARC        
      71  Central              1.8101338  ARC        
      72  Simpson              1.7990103  ARC        
     107  Wartburg             1.3455691  ARC        
     157  Dubuque              0.9588503  ARC        
     237  Nebraska Wesleyan    0.4408276  ARC        
     340  Coe                  0.1439193  ARC        
     389  Buena Vista          0.0453757  ARC        

```r
rankedteams %>% filter(Team == "Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 2.688357        ARC      37
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
#  geom_nodetext(aes(label=vertex.names))
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



```r
net<-ggnetwork(n %s% which( n %v% "conference" == "ARC"), layout="fruchtermanreingold")
#net<-ggnetwork(n , layout="fruchtermanreingold")
ggplot(net, aes(x = x, y = y, xend = xend, yend = yend))+
  geom_edges(aes(alpha=WinStrength), curvature = 0.2, arrow = arrow(length = unit(3, "points")))+
  geom_nodes(  ) +theme_blank()+
  geom_nodelabel_repel(aes(label=vertex.names, fill=rating))+
  scale_color_gradient(low="purple", high="gold")+
  scale_fill_gradient(low="gold", high="purple")
```

![](PullAndNetwork_files/figure-html/plotARCMen-1.png)<!-- -->

# Women





```r
n<-network.initialize(length(all_teams), directed = TRUE, multiple = TRUE)
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



 ranking  Team                         Rating  Conference 
--------  -----------------------  ----------  -----------
       1  Messiah                   16.330702  MACC       
       2  Pomona-Pitzer             11.707515  SCIAC      
       3  MIT                       10.220679  NEWMAC     
       4  Centre                     9.173013  SAA        
       5  Dickinson                  8.989772  CC         
       6  Johns Hopkins              8.647593  CC         
       7  William Smith              7.881491  LL         
       8  TCNJ                       7.479769  NJAC       
       9  Randolph-Macon             7.385438  ODAC       
      10  Arcadia                    6.685450  MACC       
      11  Christopher Newport        6.601017  CAC        
      12  Amherst                    5.888979  NESCAC     
      13  Cal Lutheran               5.789285  SCIAC      
      14  Haverford                  5.605548  CC         
      15  Washington U.              5.484681  UAA        
      16  Gettysburg                 5.427867  CC         
      17  Wheaton (Ill.)             5.425046  CCIW       
      18  Stevens                    5.040512  MACF       
      19  Tufts                      4.804656  NESCAC     
      20  Middlebury                 4.705482  NESCAC     
      21  Salisbury                  4.654062  CAC        
      22  Chapman                    4.652565  SCIAC      
      23  Claremont-Mudd-Scripps     4.647273  SCIAC      
      24  Virginia Wesleyan          4.489239  ODAC       
      25  Swarthmore                 4.285389  CC         

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      40  Wartburg             2.7775720  ARC        
      86  Loras                1.4648382  ARC        
     114  Dubuque              1.0332235  ARC        
     141  Luther               0.7819084  ARC        
     144  Simpson              0.7565518  ARC        
     163  Nebraska Wesleyan    0.6168924  ARC        
     173  Coe                  0.5830980  ARC        
     240  Central              0.2848666  ARC        
     424  Buena Vista          0.0012541  ARC        

```r
rankedteams %>% filter(Team=="Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 1.464838        ARC      86
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
#  geom_nodetext(aes(label=vertex.names))
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

## ARC


```r
net<-ggnetwork(n %s% which( n %v% "conference" == "ARC"), layout="fruchtermanreingold")
#net<-ggnetwork(n , layout="fruchtermanreingold")
ggplot(net, aes(x = x, y = y, xend = xend, yend = yend))+
  geom_edges(aes(alpha=WinStrength), curvature = 0.2, arrow = arrow(length = unit(3, "points")))+
  geom_nodes(  ) +theme_blank()+
  geom_nodelabel_repel(aes(label=vertex.names, fill=rating))+
  scale_color_gradient(low="purple", high="gold")+
  scale_fill_gradient(low="gold", high="purple")
```

![](PullAndNetwork_files/figure-html/plotARCWomen-1.png)<!-- -->
