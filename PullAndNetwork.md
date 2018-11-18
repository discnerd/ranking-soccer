---
title: "D3 soccer Rankings"
date: "17 November, 2018"
output: 
  html_document: 
    keep_md: yes
---

 








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
--------  ----------------------  ----------  -----------
       1  Calvin                   11.691985  MIAA       
       2  Trinity (Texas)          10.226594  SCAC       
       3  Messiah                   8.710240  MACC       
       4  Chicago                   8.296995  UAA        
       5  Kenyon                    7.289976  NCAC       
       6  Case Western Reserve      6.409003  UAA        
       7  Tufts                     5.978909  NESCAC     
       8  Montclair State           4.770197  NJAC       
       9  St. Joseph's (Maine)      4.575101  GNAC       
      10  Cortland State            4.560422  SUNYAC     
      11  Rochester                 4.430930  UAA        
      12  Connecticut College       4.313260  NESCAC     
      13  Amherst                   4.025022  NESCAC     
      14  Carnegie Mellon           3.942810  UAA        
      15  New York University       3.712191  UAA        
      16  Franklin and Marshall     3.620679  CC         
      17  Eastern                   3.458704  MACF       
      18  Stevens                   3.404786  E8         
      19  Mary Washington           3.397302  CAC        
      20  Johns Hopkins             3.395232  CC         
      21  Brockport State           3.278521  SUNYAC     
      22  Southwestern              3.020863  SCAC       
      23  St. Lawrence              3.011453  LL         
      24  Oneonta State             2.930485  SUNYAC     
      25  Williams                  2.874543  NESCAC     

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team              Rating  Conference 
--------  ------------  ----------  -----------
      28  Luther         2.8687028  ARC        
      97  Loras          1.4241471  ARC        
     111  Simpson        1.2630717  ARC        
     112  Wartburg       1.2606610  ARC        
     206  Central        0.5493765  ARC        
     226  Dubuque        0.4772812  ARC        
     338  Buena Vista    0.1420968  ARC        
     396  Coe            0.0410037  ARC        

```r
rankedteams %>% filter(Team == "Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 1.424147        ARC      97
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
       1  Washington U.          15.788130  UAA        
       2  Middlebury             12.980543  NESCAC     
       3  Messiah                11.919958  MACC       
       4  Christopher Newport    10.376270  CAC        
       5  Amherst                 9.163424  NESCAC     
       6  Williams                9.108740  NESCAC     
       7  Swarthmore              8.730184  CC         
       8  Lynchburg               8.670980  ODAC       
       9  William Smith           8.172389  LL         
      10  Hardin-Simmons          6.998214  ASC        
      11  Misericordia            6.841113  MACF       
      12  MIT                     6.414342  NEWMAC     
      13  Johns Hopkins           6.337238  CC         
      14  Centre                  6.064675  SAA        
      15  Stevens                 5.888252  E8         
      16  TCNJ                    5.792517  NJAC       
      17  Wheaton (Ill.)          5.650220  CCIW       
      18  Tufts                   5.069579  NESCAC     
      19  Scranton                4.938271  LAND       
      20  St. Thomas              4.801933  MIAC       
      21  Emory                   4.719954  UAA        
      22  Brandeis                4.378913  UAA        
      23  Ithaca                  4.351043  LL         
      24  RIT                     4.127401  LL         
      25  Chicago                 4.121981  UAA        

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team              Rating  Conference 
--------  ------------  ----------  -----------
      63  Loras          1.8897445  ARC        
      68  Wartburg       1.7519937  ARC        
     113  Dubuque        0.9956318  ARC        
     130  Luther         0.8941130  ARC        
     154  Central        0.6934351  ARC        
     160  Coe            0.6863023  ARC        
     312  Simpson        0.1258792  ARC        
     397  Buena Vista    0.0105653  ARC        

```r
rankedteams %>% filter(Team=="Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 1.889745        ARC      63
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
