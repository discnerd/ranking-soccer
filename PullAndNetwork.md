---
title: "D3 soccer Rankings"
date: "16 October, 2019"
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



 ranking  Team                        Rating  Conference 
--------  -----------------------  ---------  -----------
       1  Amherst                   7.414961  NESCAC     
       2  Calvin                    5.692945  MIAA       
       3  Christopher Newport       5.651412  CAC        
       4  Johns Hopkins             5.618258  CC         
       5  Washington and Lee        5.274497  ODAC       
       6  Roanoke                   5.206631  ODAC       
       7  Mary Washington           4.951264  CAC        
       8  Franklin and Marshall     4.766964  CC         
       9  Oneonta State             4.365530  SUNYAC     
      10  Oglethorpe                4.124710  SAA        
      11  Connecticut College       3.938528  NESCAC     
      12  Covenant                  3.894994  USAC       
      13  Chicago                   3.878153  UAA        
      14  Messiah                   3.812029  MACC       
      15  Tufts                     3.493890  NESCAC     
      16  Rowan                     3.452578  NJAC       
      17  Buffalo State             3.417202  SUNYAC     
      18  Gettysburg                3.404128  CC         
      19  Claremont-Mudd-Scripps    3.366944  SCIAC      
      20  Gustavus Adolphus         3.258794  MIAC       
      21  RPI                       3.227088  LL         
      22  Catholic                  3.180480  LAND       
      23  Ithaca                    3.177615  LL         
      24  Middlebury                3.168625  NESCAC     
      25  Haverford                 3.103464  CC         

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      29  Loras                2.9150952  ARC        
      30  Luther               2.8836900  ARC        
      35  Simpson              2.7975533  ARC        
      49  Central              2.3806778  ARC        
     139  Wartburg             1.1441626  ARC        
     149  Dubuque              0.9935280  ARC        
     199  Nebraska Wesleyan    0.6419544  ARC        
     338  Coe                  0.1540134  ARC        
     386  Buena Vista          0.0526731  ARC        

```r
rankedteams %>% filter(Team == "Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 2.915095        ARC      29
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
       1  Messiah                   13.573492  MACC       
       2  Arcadia                   13.526114  MACC       
       3  Pomona-Pitzer             13.021459  SCIAC      
       4  MIT                       11.139602  NEWMAC     
       5  William Smith              8.515521  LL         
       6  Tufts                      7.892178  NESCAC     
       7  Haverford                  7.745967  CC         
       8  Washington U.              7.292050  UAA        
       9  Johns Hopkins              7.240167  CC         
      10  Wheaton (Ill.)             7.215972  CCIW       
      11  TCNJ                       6.913048  NJAC       
      12  Centre                     6.572638  SAA        
      13  Gettysburg                 6.499642  CC         
      14  Christopher Newport        6.275333  CAC        
      15  Washington and Lee         5.954593  ODAC       
      16  Chicago                    5.798898  UAA        
      17  Geneseo State              5.533345  SUNYAC     
      18  Dickinson                  5.526288  CC         
      19  Middlebury                 5.164077  NESCAC     
      20  Stevens                    4.880703  MACF       
      21  Salisbury                  4.855156  CAC        
      22  Claremont-Mudd-Scripps     4.825040  SCIAC      
      23  Randolph-Macon             4.755809  ODAC       
      24  McDaniel                   4.563665  CC         
      25  Chapman                    4.563253  SCIAC      

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      34  Wartburg             3.0824714  ARC        
      85  Dubuque              1.4925843  ARC        
      87  Loras                1.4457643  ARC        
     113  Nebraska Wesleyan    1.0567406  ARC        
     134  Simpson              0.8785653  ARC        
     158  Coe                  0.6611684  ARC        
     174  Luther               0.5448771  ARC        
     204  Central              0.3754289  ARC        
     417  Buena Vista          0.0015791  ARC        

```r
rankedteams %>% filter(Team=="Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 1.445764        ARC      87
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
