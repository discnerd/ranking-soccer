---
title: "D3 soccer Rankings"
date: "24 October, 2019"
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
       1  Amherst                  6.689025  NESCAC     
       2  Christopher Newport      6.468039  CAC        
       3  Calvin                   5.932013  MIAA       
       4  Johns Hopkins            5.503946  CC         
       5  Franklin and Marshall    4.342208  CC         
       6  Tufts                    4.240179  NESCAC     
       7  Messiah                  4.126611  MACC       
       8  Oneonta State            3.981761  SUNYAC     
       9  Covenant                 3.980932  USAC       
      10  Connecticut College      3.853494  NESCAC     
      11  Oglethorpe               3.837695  SAA        
      12  Gettysburg               3.805963  CC         
      13  RPI                      3.742792  LL         
      14  Eastern Connecticut      3.697283  LEC        
      15  Mary Washington          3.659956  CAC        
      16  Roanoke                  3.624121  ODAC       
      17  Chicago                  3.579131  UAA        
      18  Ohio Wesleyan            3.342203  NCAC       
      19  Catholic                 3.280111  LAND       
      20  Hobart                   3.204548  LL         
      21  Washington and Lee       3.199828  ODAC       
      22  Buffalo State            3.137836  SUNYAC     
      23  Middlebury               3.115448  NESCAC     
      24  Montclair State          3.012268  NJAC       
      25  Ithaca                   3.009084  LL         

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      29  Loras                2.8517674  ARC        
      36  Luther               2.7843596  ARC        
      56  Central              2.2406225  ARC        
      71  Simpson              1.8058198  ARC        
     119  Wartburg             1.2982037  ARC        
     171  Dubuque              0.8863360  ARC        
     226  Nebraska Wesleyan    0.5007302  ARC        
     358  Coe                  0.1160074  ARC        
     388  Buena Vista          0.0550588  ARC        

```r
rankedteams %>% filter(Team == "Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 2.851767        ARC      29
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
       1  Messiah                   13.784396  MACC       
       2  Arcadia                   10.536546  MACC       
       3  MIT                       10.200448  NEWMAC     
       4  Pomona-Pitzer             10.170130  SCIAC      
       5  Haverford                  7.629970  CC         
       6  Johns Hopkins              7.476009  CC         
       7  Christopher Newport        7.237915  CAC        
       8  William Smith              7.237406  LL         
       9  Centre                     7.077832  SAA        
      10  Wheaton (Ill.)             6.676830  CCIW       
      11  Tufts                      6.503351  NESCAC     
      12  TCNJ                       6.298015  NJAC       
      13  Dickinson                  6.259420  CC         
      14  Washington U.              6.254584  UAA        
      15  Claremont-Mudd-Scripps     5.882994  SCIAC      
      16  Cal Lutheran               5.764427  SCIAC      
      17  Randolph-Macon             5.299079  ODAC       
      18  Salisbury                  5.275787  CAC        
      19  Washington and Lee         5.225886  ODAC       
      20  Chicago                    5.068664  UAA        
      21  Chapman                    4.972396  SCIAC      
      22  Gettysburg                 4.930993  CC         
      23  McDaniel                   4.850411  CC         
      24  Stevens                    4.419874  MACF       
      25  Geneseo State              4.387209  SUNYAC     

```r
rankedteams %>% filter(Conference=="ARC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      37  Wartburg             2.8735461  ARC        
      76  Loras                1.6826645  ARC        
     111  Dubuque              1.0656399  ARC        
     137  Nebraska Wesleyan    0.8501857  ARC        
     140  Simpson              0.8135782  ARC        
     158  Coe                  0.7052256  ARC        
     169  Luther               0.5926716  ARC        
     230  Central              0.3149520  ARC        
     425  Buena Vista          0.0011140  ARC        

```r
rankedteams %>% filter(Team=="Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 1.682664        ARC      76
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
