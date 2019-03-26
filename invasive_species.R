library(tidyverse)
library(RCurl)
library(gplots)
library(scales)

x <- download.file("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018-10-02/us_births_2000-2014.csv", destfile = "births.csv")
births <- read.csv("births.csv")

max = c(0:12)
births <-
  births %>%
  mutate(day = as.factor(paste(date_of_month, month, sep = "-"))) %>%
  mutate(day_of_the_year = (month - 1)*max(births[(month-1),3])+)
  mutate(rescale = rescale(births))

png("heatmap.png", res = 300, height = 20*300, width = 3*300)
(p <-
  ggplot(births, aes(year, date)) +
  geom_tile(aes(fill = births), colour = "white")+
  scale_fill_gradient(low = "white", high = "steelblue"))
dev.off() 

