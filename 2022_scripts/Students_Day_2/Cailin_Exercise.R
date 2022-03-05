# Day_2.R
# Reads in some data about Laminaria collected along the Cape Peninsula for Exercise 4.4
# Cailin_Pillay
# 08/02/2022


# Exercise 4.4 ------------------------------------------------------------

#Load some packages

library(tidyverse)

library(lubridate)

#Load data

# Run this if 'laminaria.csv` has columns separated by ','
laminaria <- read_csv("data/laminaria.csv")


# Basic Calculations for Excerise 4.4 -------------------------------------

laminaria %>% # Tell R which dataset to use
  filter(blade_thickness >5) %>% # Subsetting laminaria data to include where the blade thickness is thicker than 5cm
  select(site, region, blade_weight, blade_thickness) # Retaining only the specific columns


# 3 Days later ------------------------------------------------------------

#Load some packages
library(tidyverse)

library(lubridate)

#Load data

# Run this if 'laminaria.csv` has columns separated by ','
laminaria <- read_csv("data/laminaria.csv") # Tell R where to find the data in the working directory and read the csv file

laminaria %>% # Tell R which dataset to use
  filter(site == "Kommetjie") %>% # Filter out only records from Kommetjie
  nrow() # Count the number of remaining rows

kelp_max<-laminaria %>% #Assigning a new named data frame containing only entries from Kommetjie 
  filter(blade_thickness >5, site == "Kommetjie") %>% # Subsetting laminaria data to include where the blade thickness is thicker than 5cm only for Kommetjie
  select(site, region, blade_weight, blade_thickness,total_length)# Retaining only the specific columns in order to find the row with the greatest length

kelp_max %>% # Tell R to use the new data frame 
  filter(total_length == max(total_length)) # Filtering in order to find the row with the greatest length

# No data available in table
# There is only data available if the thickness was <5; therefore, there is no row with the greatest length
