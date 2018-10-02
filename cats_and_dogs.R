library(tidyverse)
library(httr)
library(readxl)
library(usmap)

GET("https://query.data.world/s/qage5daw5py3mwznddsotjbf2ewr64", write_disk(tf <- tempfile(fileext = ".xlsx")))

df <- read_excel(tf)

pets <-
  df %>%
  mutate(ratio = `Dog Owning Households (1000s)`/`Cat Owning Households`) %>%
  mutate(fips = fips(Location)) %>%
  mutate(cut = cut(ratio, breaks = seq(0,2,by = 0.25), include.lowest = T))%>%
  select(fips, ratio, cut)

png("catdog.png", res = 300, width = 6*300, height = 3*300)
plot_usmap(regions = "states", data = pets, value = "cut", lines = "white")+
  scale_fill_viridis_d(name = "Ratio of Dog:Cat Owning Households", option = "D")+
  labs(title = "Cats and Dogs in the U.S.")+
  theme(legend.position = "right")
dev.off()