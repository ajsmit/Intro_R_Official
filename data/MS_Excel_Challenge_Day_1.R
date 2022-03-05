# Title: MS Excel Challenge
# Aim: Replicate MS Excel spreadsheet challenge
# Author: AJ Smit
# Date: 8 February 2022


# Load packages -----------------------------------------------------------

library(tidyverse)
library(lubridate)


# Load data ---------------------------------------------------------------

# reads in the data
temps <- read.csv("data/SACTN_SAWS.csv")

# which sites do we have?
unique(temps$site)


# Do stuff ----------------------------------------------------------------

temps_mo <- temps %>%
  mutate(yr = year(date),
         mo = month(date)) %>%
  group_by(site, mo) %>%
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>%
  ungroup()

temps_yr <- temps %>%
  mutate(yr = year(date),
         mo = month(date)) %>%
  group_by(site, yr) %>%
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>%
  ungroup()
temps_yr

ggplot(temps_mo, aes(x = mo, y = mean_temp)) +
  geom_line(aes(group = site), colour = "red") +
  facet_wrap(~site, nrow = 3) +
  labs(x = "Year", y = "Temperature (°C)",
       title = "Monthly mean temperature")
