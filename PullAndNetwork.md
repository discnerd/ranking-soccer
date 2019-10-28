---
title: "D3 soccer Rankings"
date: "28 October, 2019"
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
       1  Christopher Newport      6.496576  CAC        
       2  Amherst                  6.320776  NESCAC     
       3  Calvin                   5.759897  MIAA       
       4  Johns Hopkins            5.624504  CC         
       5  Oneonta State            4.761083  SUNYAC     
       6  Franklin and Marshall    4.745029  CC         
       7  Tufts                    4.334727  NESCAC     
       8  Messiah                  4.067979  MACC       
       9  Connecticut College      4.030470  NESCAC     
      10  Oglethorpe               4.018336  SAA        
      11  Mary Washington          3.671812  CAC        
      12  Gettysburg               3.641193  CC         
      13  RPI                      3.629872  LL         
      14  Catholic                 3.608607  LAND       
      15  Covenant                 3.509402  USAC       
      16  Roanoke                  3.393277  ODAC       
      17  Eastern Connecticut      3.391522  LEC        
      18  Chicago                  3.366958  UAA        
      19  Montclair State          3.347149  NJAC       
      20  Hobart                   3.249763  LL         
      21  St. Mary's (Md.)         3.114100  CAC        
      22  Swarthmore               3.088375  CC         
      23  Ohio Wesleyan            3.069907  NCAC       
      24  Buffalo State            3.018220  SUNYAC     
      25  Washington and Lee       2.990278  ODAC       

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      35  Luther               2.7137231  ARC        
      39  Loras                2.6738134  ARC        
      62  Central              2.0505322  ARC        
      83  Simpson              1.6576422  ARC        
     134  Wartburg             1.1594743  ARC        
     168  Dubuque              0.8947747  ARC        
     223  Nebraska Wesleyan    0.5143846  ARC        
     331  Coe                  0.1780573  ARC        
     389  Buena Vista          0.0509154  ARC        

```r
rankedteams %>% filter(Team == "Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 2.673813        ARC      39
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
       1  Messiah                   12.466660  MACC       
       2  MIT                       10.012659  NEWMAC     
       3  Pomona-Pitzer              9.712955  SCIAC      
       4  Arcadia                    9.275653  MACC       
       5  Christopher Newport        7.568759  CAC        
       6  William Smith              7.548923  LL         
       7  Centre                     7.519408  SAA        
       8  Cal Lutheran               7.382648  SCIAC      
       9  Haverford                  7.149522  CC         
      10  Johns Hopkins              7.075895  CC         
      11  Dickinson                  6.941530  CC         
      12  TCNJ                       6.795400  NJAC       
      13  Wheaton (Ill.)             6.179876  CCIW       
      14  Claremont-Mudd-Scripps     6.174274  SCIAC      
      15  Gettysburg                 5.995080  CC         
      16  Washington U.              5.781421  UAA        
      17  Randolph-Macon             5.723534  ODAC       
      18  Tufts                      5.514718  NESCAC     
      19  Salisbury                  5.364476  CAC        
      20  Chapman                    5.114643  SCIAC      
      21  McDaniel                   5.082714  CC         
      22  Washington and Lee         4.830008  ODAC       
      23  Chicago                    4.744728  UAA        
      24  Stevens                    4.218926  MACF       
      25  Otterbein                  4.174566  OAC        

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      38  Wartburg             2.7540240  ARC        
      69  Loras                1.9091165  ARC        
     110  Dubuque              1.1524931  ARC        
     135  Simpson              0.8262189  ARC        
     150  Nebraska Wesleyan    0.7261487  ARC        
     156  Coe                  0.7009889  ARC        
     169  Luther               0.6088415  ARC        
     224  Central              0.3383623  ARC        
     425  Buena Vista          0.0011032  ARC        

```r
rankedteams %>% filter(Team=="Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 1.909116        ARC      69
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
