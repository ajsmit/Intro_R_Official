# Title: Prepare MS Excel Challenge data
# Aim: Produce the data to use for the MS Excel spreadsheet challenge
# Author: AJ Smit
# Date: 8 February 2022


# Load packages -----------------------------------------------------------

library(tidyverse)
library(lubridate)


# Prepare data for use (not shown) ----------------------------------------

load("data/SACTNmonthly_v4.0.RData")

SACTNmonthly_v4.0 %>%
  filter(src == "SAWS") %>%
  select(-depth, -type, -src) %>%
  mutate(site = droplevels(site)) %>%
  write.csv("data/SACTN_SAWS.csv")