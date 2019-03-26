library(tidyverse)
library(fivethirtyeight)

college <- college_recent_grad

ggplot(college, aes(x = sharewomen, y = college_jobs/total))+
  geom_point()+
  geom_smooth(method = "lm")+
  scale_alpha_continuous()

ggplot(college, aes(x = p25th, y = unemployed/total))+
  geom_point(aes(color = major_category))
