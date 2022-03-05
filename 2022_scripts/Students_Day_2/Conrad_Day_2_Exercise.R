# Day_2.R
# Laminaria Exercise
# Ammaarah Conrad
# Student number: 3947006
# 08 February 2022

library(tidyverse)

# loading laminaria data

laminaria <- read_csv("R files/intro_r_data/data/laminaria.csv")

# determining the average and standard deviation for blade length

laminaria %>% 
  summarise(
    avg_bld_len = mean(blade_length), # average blade length
    sd_bld_len = sd(blade_length)) # standard deviation for blade length

# subsetting the laminaria data

laminaria %>% # tells R to use the laminaria dataset
  select(site, region, blade_weight, blade_thickness) %>% # only selects the columns that need to be shown
  filter(blade_thickness > 5) # used so that only the blade thickness values greater than 5cm are shown

# calculating which Kommetjie data entry has the greatest length

laminaria %>% 
  filter(site == "Kommetjie") %>% # only data from Kommetjie used
  filter(total_length == max(total_length)) 


