#  O Elengemoke-Tshala
# Day 2 Exercise
# BCB 744


# To load libraries
library(tidyverse)

# To load data
laminaria <- read_csv("data/laminaria.csv")

# To filter out all the observations that had kelp blades had a thickness  greater than 5cm, a filter was applied to the laminaria data set.Thereafter, we commanded the R software carryout it function by using the selected variables (sites and the weights of the blades with a thickness of 5cm and greater.

laminaria %>%  
  filter(blade_thickness > 5) %>% 
  select(site,blade_weight, blade_thickness)


# The laminaria dataset was filter to only show the data of the Kommetjie site
laminaria %>% 
  filter(site == "Kommetjie")

#  The data from this site was made into an object and new data was created (lamr_Kom)
lamr_Kom <- laminaria %>% 
  filter(site == "Kommetjie")

# This object(lamr_Kom) was filtered to find the observation with the highest total length.It was found that Ind 11 had the highest total length of 354 
 lamr_Kom %>% 
  filter(total_length == max(total_length))

