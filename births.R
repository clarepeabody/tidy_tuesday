library(tidyverse)
library(openair)
library(RColorBrewer)

x <- download.file("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018-10-02/us_births_2000-2014.csv", destfile = "births.csv")
df <- read.csv("births.csv")

births <-
  df %>%
  mutate(asDate = as.Date(paste(month, date_of_month, "2020", sep = "/"), format = "%m/%d/%y")) %>%
  mutate(day = substr(asDate, 6,10)) %>%
  select(year, day,  births) %>%
  group_by(day) %>%
  summarise(mean = mean(births)) %>%
  mutate(month = as.numeric(substr(day, 1,2))) %>%
  mutate(date_of_month = as.numeric(substr(day, 4,5))) %>%
  select(-day) %>%
  spread(date_of_month, mean) %>%
  gather(key = day, value, 2:32) %>%
  mutate(day = as.numeric(day)) %>%
  mutate(month = factor(month.abb[month], levels = rev(month.abb))) %>%
  mutate(births = value)

ggplot(births, aes(day, month)) +
  scale_x_continuous(breaks= 1:31)+
  geom_tile(aes(fill = births)) +
  ggtitle("U.S. mean births, 2000-2014") +
  theme_minimal()+
  theme(panel.grid = element_blank(),
        plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.title = element_blank())+
  geom_hline(yintercept = seq(0.5, 12.5, by = 1), color = "grey50") +
  geom_vline(xintercept = seq(1.5, 30.5, by = 1), color = "grey50", size = 0.25)