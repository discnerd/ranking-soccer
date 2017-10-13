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
       1  Messiah                 5.731043  MACC       
       2  Rowan                   4.793266  NJAC       
       3  Lycoming                4.783010  MACC       
       4  Drew                    4.637748  LAND       
       5  Calvin                  4.528590  MIAA       
       6  Tufts                   4.408126  NESCAC     
       7  Trinity (Texas)         4.085389  SCAC       
       8  Johns Hopkins           3.945631  CC         
       9  Lynchburg               3.891884  ODAC       
      10  Springfield             3.872557  NEWMAC     
      11  Chicago                 3.804972  UAA        
      12  Connecticut College     3.635246  NESCAC     
      13  Cortland State          3.623793  SUNYAC     
      14  Rutgers-Newark          3.603253  NJAC       
      15  John Carroll            3.587357  OAC        
      16  Emory                   3.466131  UAA        
      17  Brandeis                3.443969  UAA        
      18  North Park              3.177998  CCIW       
      19  Kenyon                  3.076622  NCAC       
      20  Carnegie Mellon         3.002427  UAA        
      21  Oglethorpe              2.999867  SAA        
      22  Oneonta State           2.920086  SUNYAC     
      23  St. Joseph's (Maine)    2.899818  GNAC       
      24  Gettysburg              2.827562  CC         
      25  Mary Washington         2.742843  CAC        

```r
rankedteams %>% filter(Conference=="IIAC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      95  Simpson              1.4687990  IIAC       
      96  Wartburg             1.4595503  IIAC       
     114  Luther               1.3183445  IIAC       
     138  Loras                1.1249316  IIAC       
     156  Central              1.0309861  IIAC       
     191  Dubuque              0.8474338  IIAC       
     243  Nebraska Wesleyan    0.5751819  IIAC       
     335  Buena Vista          0.2533235  IIAC       
     364  Coe                  0.1611151  IIAC       

```r
rankedteams %>% filter(Team == "Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 1.124932       IIAC     138
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
       1  Chicago                23.026422  UAA        
       2  TCNJ                   11.380918  NJAC       
       3  Christopher Newport     8.439806  CAC        
       4  Washington U.           7.550164  UAA        
       5  Williams                6.407291  NESCAC     
       6  William Smith           6.373152  LL         
       7  MIT                     6.352211  NEWMAC     
       8  Hardin-Simmons          6.104582  ASC        
       9  Geneseo State           5.819582  SUNYAC     
      10  UW-La Crosse            5.801070  WIAC       
      11  Messiah                 5.686621  MACC       
      12  Trinity (Texas)         5.371953  SCAC       
      13  Hope                    5.203240  MIAA       
      14  Loras                   5.067532  IIAC       
      15  Wheaton (Ill.)          5.057429  CCIW       
      16  Johns Hopkins           4.848980  CC         
      17  Illinois Wesleyan       4.611852  CCIW       
      18  Connecticut College     4.545188  NESCAC     
      19  Carnegie Mellon         3.970259  UAA        
      20  St. Thomas              3.957437  MIAC       
      21  Brandeis                3.495653  UAA        
      22  Western Connecticut     3.455829  LEC        
      23  Swarthmore              3.407231  CC         
      24  Misericordia            3.345300  MACF       
      25  Lynchburg               3.336250  ODAC       

```r
rankedteams %>% filter(Conference=="IIAC") %>% select(ranking, Team, Rating, Conference) %>% knitr::kable()
```



 ranking  Team                    Rating  Conference 
--------  ------------------  ----------  -----------
      14  Loras                5.0675317  IIAC       
      27  Wartburg             3.2855604  IIAC       
      54  Central              2.1302728  IIAC       
     100  Coe                  1.3697197  IIAC       
     133  Dubuque              1.0895673  IIAC       
     139  Luther               1.0773803  IIAC       
     274  Nebraska Wesleyan    0.2613453  IIAC       
     291  Simpson              0.2009545  IIAC       
     346  Buena Vista          0.0778083  IIAC       

```r
rankedteams %>% filter(Team=="Loras")
```

```
##    Team   Rating Conference ranking
## 1 Loras 5.067532       IIAC      14
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
