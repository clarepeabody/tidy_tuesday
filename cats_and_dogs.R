library(tidyverse)
library(httr)
library(readxl)

GET("https://query.data.world/s/qage5daw5py3mwznddsotjbf2ewr64", write_disk(tf <- tempfile(fileext = ".xlsx")))
pets <- read_excel(tf)

head(pets)
