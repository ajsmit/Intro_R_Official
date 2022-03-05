# Intro_R
# Exercise_4.4
# Danielle Roach
# 8 February 2022
# Purpose: Reading laminaria into R and doing data manipulations


# Step 1 ------------------------------------------------------------------


library(tidyverse)
laminaria <- read_csv("data/laminaria.csv") # instructing R Studio to read the laminaria file by giving its location in my directory
blade_thickness <- laminaria %>% #assigning laminaria to blade thickness so that we can access it to do further manipulations and then piping it to carry it over into the next line to filter it
  filter(blade_thickness > 5) %>% # We are taking a subset of the data and only including blade thickness values bigger than 5cm
  select(site,region,blade_weight,blade_thickness) # We are retaining only columns containing site,region,blade weight and blade thickness


# Step 2 ------------------------------------------------------------------

laminaria %>% # We are instructing R with which data set to use
  filter(site == "Kommetjie") %>% # We are calculating the number of entries at Kommetjie
  nrow()


# Step 3 ------------------------------------------------------------------

laminaria %>% # We are instructing R with which data set to use
  filter(total_length == max(total_length)) # Selecting the rows of data within the Kommetjie and finding the row with the greatest length


# Step 4 ------------------------------------------------------------------

laminaria %>% # Instructing R with which data set to use
  summarise( 
    sd_bld_len  = sd(blade_length), # finding the standard deviation of blade length
    avg_bld_wdt = mean(blade_length)) # finding the mean of blade length
