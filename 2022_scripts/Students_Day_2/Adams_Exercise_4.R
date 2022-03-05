Intro_R
# Exercise_4.4
# 8 February 2022
# Purpose: Is to select specific data from large data sets to make it easier to interpret
# Explanations:


library(tidyverse)
laminaria <- read.csv("data/laminaria.csv")
blade_thickness <- laminaria %>%
  filter(blade_thickness > 5) %>%
  select(site,region,blade_weight,blade_thickness)

# Using <- we assign csv file to read laminaria on the windows doc --------
#<- is used to assign the blade_thickness to laminaria whereby the info is piped( %>% )
#By using filter we want to get all the values of blade_thickness that is greater than 5 cm, thereby we pipe this information aswell
#By using select function we refering to a variable. In this case we selecting specific columns which are (site,region,blade_weight,blade_thickness) which are more than one line of code

laminaria %>%
  filter(site == "Kommetjie") %>% 
  nrow()

# Next is to pipe the laminaria data 
# Whereby we filter out only records from KOmmetjie
# nrow function will be able to count the number of rows

laminaria %>% 
  filter(total_length == max(total_length))
# the laminaria data will be piped again to perform calculations subsequnetly to help avoid making mistakes
# by using the filter function we want the records of the maximum total length of laminaria at Kommetjie

laminaria %>% 
  sd_bld_len = sd(blade_length),
avg_bld_wdt = mean(blade_length))

# after using pipe we want to determine the standard deviation of the blade length
# followed by the average or mean of the blade length at the  number of entries at Kommetjie


# Could not calculate data in console, due to issue on laptop. But --------


