# Assignment_1 Day 1
# Replicate MS Excel spreadsheet challenge
# AJ Smit
# 15 March 2021


# Load stuff --------------------------------------------------------------

library(tidyverse)
library(lubridate)
SACTN <- read_csv("data/SACTN_data.csv")
summary(SACTN)


# Do stuff ----------------------------------------------------------------

SACTN_grp <- SACTN %>%
  mutate(yr = year(date),
         mo = month(date)) %>% 
  group_by(site, mo) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% 
  ungroup()

ggplot(SACTN_grp, aes(x = mo, y = mean_temp)) +
  geom_line(aes(group = site), colour = "red") +
  facet_wrap(~site, nrow = 3) +
  labs(x = "Year", y = "Temperature (°C)",
       title = "Monthly mean temperature")
---