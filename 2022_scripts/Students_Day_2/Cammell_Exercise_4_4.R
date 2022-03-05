# Day_1.R
# Reads in some data about Laminaria collected along the Cape Peninsula
# do various data manipulations, analyses and graphs
# C Cammell
# 8 February 2022


library(tidyverse) #load tidyverse before beginning the script


# Start of exercise -------------------------------------------------------

laminaria <- read_csv("Data/laminaria.csv") #load the data fro external csv file


# examining of the data ---------------------------------------------------

head(laminaria, 5) # First five lines
tail(laminaria, 2) # Last two lines
glimpse(laminaria) # A more thorough summary
names(laminaria) # The names of the columns

blade_thickness <- laminaria %>% # create new object for criteria
  filter(blade_thickness > 5) %>% # filter criteria of thickness greater than 5
  select(site,region,blade_weight,blade_thickness) # retain specified columns


# "3 days later" ----------------------------------------------------------

laminaria %>% # tell R which data frame to use
  filter(site == "Kommetjie") %>% # filter the site
  nrow() # count the number of data points at said site

laminaria %>% # tell R which data set to use
  filter(total_length == max(total_length)) # select row with max total length

laminaria %>% # tell R which data frame to use
  summarise(
    avg_bld_len = mean(blade_length), # calculating mean blade length
    sd_bld_len = sd(blade_length)) # calculating standard deviation of blade length