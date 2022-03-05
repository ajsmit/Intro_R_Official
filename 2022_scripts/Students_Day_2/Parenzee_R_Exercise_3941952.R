# Author: CJ Parenzee
# Student Number: 3941952
# Date: 8 February 2022
# Exercise

library(tidyverse) # loads the package tidyverse

laminaria <- read.csv("data/laminaria.csv") # Loads the dataset laminaria

laminaria %>% # Indicates which data to use
  filter(blade_thickness > 5) %>% # Filters the stipes with blade thickness greater than 5
  select(site, blade_weight, blade_thickness) # Selects only the columns showing site, blade weight and blade thickness

laminaria %>% #Indicates which data to use
  filter(site == "Kommetjie") %>% # Filters out only Kommetjie sites
  nrow() # Counts the number of rows containing Kommetjie sites

laminaria %>% # Indicates which data to use
  filter(site == "Kommetjie") %>% # Filters out only Kommetjie sites
  filter(total_length == max(total_length)) # Filters the row with the max total length

laminaria %>% # Indicate which data to use
  summarise( #Summarises the variables below
    min_bld_len = min(blade_length), # Calculates the minimum blade length across all sites
    avg_bld_len = mean(blade_length), # Calculates the average blade length across all sites
    max_bld_len = max(blade_length), # Calculates the maximum blade length across all sites
    med_bld_len = median(blade_length), # Calculates the median blade length across all sites
    sd_bld_len = sd(blade_length)) # Calculates the standard deviation of the blade length