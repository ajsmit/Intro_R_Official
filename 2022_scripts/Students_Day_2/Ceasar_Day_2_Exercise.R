# Intro R_Day 2
# Exercise 4.4
# Jamie Ceasar
# 4222057
# 8 Feb 2022

# Purpose: Applying skills learned on day 2 to complete the assigned exercise

# load packages -----------------------------------------------------------

library(tidyverse) 

# The tidyverse package contains certain functions that are needed to load the laminaria.csv file into R.


# load data into R --------------------------------------------------------

laminaria <- read.csv('Data/data/laminaria.csv') 

# colums are separated by ',' hence the use of the "read.csv() function
# note the use of '.' instead of '_', as the "read_csv()" function did not work


# Subsetting data ---------------------------------------------------------

laminaria %>% # Tells R which dataframe to use
  filter(blade_thickness >= 5) %>% # Filter out rows where blade thickness is greater than 5 cm
  select(site, region, blade_weight, blade_thickness) # Select specific columns 

# This returns a subset which is a dataframe itself and can therefore be assigned to a new dataframe.

kelp_bld_thk <- laminaria %>%
  filter(blade_thickness >= 5) %>% 
  select(site, region, blade_weight, blade_thickness)


# Number of data points at Kommetjie? -------------------------------------

laminaria %>% # Tell R which dataset to use
  filter(site == "Kommetjie") %>% # Filter out only records from Kommetjie
  nrow() # Counts the number of remaining rows

# This returns the value "9", meaning that there are 9 entries for Kommetjie

laminaria %>% # Tell R which dataset to use
  filter(total_length == max(total_length)) # Select row with max total length






