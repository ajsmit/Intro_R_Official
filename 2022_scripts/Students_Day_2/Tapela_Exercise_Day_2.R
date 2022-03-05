#DAY 2 INTRO R Exercise
#Author: M H Tapela
#Date: 08/02/22

# Exercise ----------------------------------------------------------------

#Tell R where to find data using: setwd() or open existing project


# Load libraries
library(tidyverse)

# Load the csv data 
laminaria <- read_csv("data/laminaria.csv")

#Subsetting the original laminaria dataset such that the new subset dataset contains a blade thickness >5cm, site ,region, blade weight 
laminaria %>% 
  filter(blade_thickness > 5) %>% 
  select(site, region, blade_weight, blade_thickness)


#3 Days later...

#Tell R where to find data using: setwd() or open existing project

# Load libraries
library(tidyverse)

# Load the csv data 
laminaria <- read_csv("data/laminaria.csv")

#Assigning Subsetted dataset to a new object 
lam_3_Days <- laminaria %>% 
  filter(blade_thickness > 5) %>% 
  select(site, region, blade_weight, blade_thickness)

#A count of the number of rows with a blade thickness > 5cm in Kommetjie
lam_3_Days %>%
  filter(site == "Kommetjie") %>% 
  nrow()
#0 entries in Kommetjie with a blade thickness greater than 5cm

#Finding the entry with the greatest total length in Kommetjie
lam_3_Days %>% 
  filter(site == "Kommetjie", total_length == max(total_length))
#No entry in Kommetjie with a blade thickness >5cm so total length cannot be calculated