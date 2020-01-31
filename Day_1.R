# Day 1
# Pupose: to demonstrate some princimples of data analysis
# Date: 28 January 2020
# Author: AJ Smit

# load packages
library(tidyverse)
library(lubridate)

# read in the data
temps <- read_csv("data/SACTN_data.csv")

# look at the data
head(temps)
tail(temps, 12)
glimpse(temps)

# summarise the data
mean_temps <- temps %>% 
  mutate(mon = month(date, label = TRUE, abbr = TRUE)) %>% 
  group_by(site, mon) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE),
            sd_temp = sd(temp, na.rm = TRUE))

# make a graph
ggplot(data = mean_temps, aes(x = mon, y = mean_temp)) +
  geom_point(aes(col = site))


