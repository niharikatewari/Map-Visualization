install.packages("ggmap")
library(ggplot2)
library(maptools)
library(rgeos)
library(ggmap)
library(readr)
library(rgdal)

setwd("C:/Users/Lab Pc/Desktop/Datasets")
shapefile <- readOGR("IND_adm1.shp")

setwd("C:/Users/HP-PC/Desktop/Datasets")
mapfi = read.csv("Crime2019.csv")

View(shapefile)
View(mapfi)
colnames(mapfi)[2] <- "id"

df = fortify(shapefile, region = "NAME_1") #Or broom package used in previous example 
View(df)

merge.shp.coef<-merge(df,mapfi, by="id", all.x=TRUE)
View(merge.shp.coef)
final.plot<-merge.shp.coef[order(merge.shp.coef$order), ]

library(ggplot2)

# plot --------------------------------------------
plotmap <- ggplot()+
   geom_polygon(data = final.plot,aes(x = long, y = lat, group = group, fill = Count),
                color = "black", size = 0.25) + 
  coord_map()

plotmap

# plot with diff colour --------------------------------------------
viewmap <- ggplot()+
  geom_polygon(data = final.plot, aes(x = long, y = lat, group = group, fill = Count),
               color = "white", size = 0.25) + 
  coord_map()+
  scale_fill_distiller(name = "Total Victims(2019)", palette = "Reds") +
  labs( x = NULL,
        y = NULL,
    title="Crime Rate - Victims of Rape Report 2019")
  
viewmap

#--------------------------------------------
# Changed limit
Map1 <- ggplot()+
  geom_polygon(data = final.plot, aes(x = long, y = lat, group = group, fill = Count),
               color = "white", size = 0.25) + 
  coord_map()+
  scale_fill_distiller(name = "Total Victims(2019)", palette = "Oranges", direction = 1)+
  labs( x = NULL,
        y = NULL,
        title="Crime Rate - Victims of Rape Report 2019")
Map1
#-----------------------------------------------
# with state names 

cnames <- aggregate(cbind(long, lat) ~ id, data=final.plot, FUN=function(x) mean(range(x)))

ggplot()+
  geom_polygon(data = final.plot, aes(x = long, y = lat, group = group, fill = Count),
               color = "white", size = 0.25) + 
  coord_map()+
  scale_fill_distiller(name = "Total Victims(2019)", palette = "Oranges", direction = 1)+
  labs( x = NULL,
        y = NULL,
        title="Crime Rate - Victims of Rape Report 2019")+
  geom_text(data = cnames, aes(long, lat, label = id), size=2, fontface="bold")+
  theme_dark()

# save images
ggsave("India_IMR_2013.png",dpi = 300, width = 20, height = 20, units = "cm")
