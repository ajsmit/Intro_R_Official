# Day 3 Exercise
# Author:ZM George
# 9 Feb 2022



# load some packages ------------------------------------------------------

library(tidyverse)

laminarira <- read.csv("data/laminaria.csv")



# create a graph -----------------------------------------------------------

laminarira %>% 
  group_by(site) %>% 
  select(stipe_mass, stipe_length)


ggplot(data = laminarira, aes(x = stipe_mass, y = stipe_length)) +
  geom_point(shape = 25, colour = "darkorchid1") +
  geom_smooth(method = "lm") +
  theme_light() +
  labs(x = "Stipe mass (kg)", y = "Stipe length (cm)")


# The stipe length and stipe mass have a directly proportional relationship.
# The stipe length increases as the stipe mass increases.
  



