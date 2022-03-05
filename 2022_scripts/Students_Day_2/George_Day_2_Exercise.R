# ZM George
# 8 Feb 2022
# Exercise


library(tidyverse)

laminaria <- read.csv("intro_r_data/data/laminaria.csv") #Reads the csv file, 'laminaria' becomes an object

laminaria %>% 
  filter(blade_thickness > 5) %>% 
  select(site, region, blade_weight, blade_thickness)
# This only shows the site, region, blade weight and blade thickness columns for where the blade thickness is greater than 5 



laminaria %>% 
  filter(site == 'Kommetjie') %>%
  nrow()
# There are 9 rows of entries for Kommetjie



laminaria %>%
  filter(site == 'Kommetjie') %>% 
  filter(total_length == max(total_length)) 
# The entry with the largest total length in Kommetjie is 354cm



laminaria %>% 
  group_by(site) %>% 
  summarise(mean_bld_weight = mean(blade_weight),
            std_bld_weight = sd(blade_weight))
# This gives us the mean and standard deviation for the blade weight of all the laminaria found  

