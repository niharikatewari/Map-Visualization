install.packages("readr")
install.packages("plotly")
install.packages("dplyr")
library(tidyverse)
install.packages("rgdal")
library(rgdal)
library(plotly)
library(dplyr)
library(readr)
install.packages("maptools")
library(maptools)

setwd("C:/Users/Lab Pc/Desktop/Datasets")
mapdata = readOGR(dsn = ".", layer = "IND_adm1")
View(mapdata)

#df = fortify(mapdata)
#View(df)

#ggplot(mapdata)+
 #geom_polygon()
#------------------------------------------------

# sIMPLE PLOT
plot(mapdata)

#-----------------------------------------

#ggplot2 takes as input data frames, not geo spatial data
#mapdata thus needs to be transformed using the tidy() function of the broom package.

library(broom)
map1 <- tidy(mapdata, region = "NAME_1")
View(map1)

library(ggplot2)

mappdat = ggplot(map1, aes(long, lat, group = group))+
  geom_polygon(fill="#6CE8E8", color="white") +
  theme_void()

mappdat
