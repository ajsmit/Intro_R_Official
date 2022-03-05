# Module : BCB 744
# Author : Imanathi Kekaya
# Intro R - Day 2 Exercise
# Purpose: manipulate data to for comprehension and analysis

# Load some packages ------------------------------------------------------


library(tidyverse)


#  read collected data about Laminaria along the Cape Peninsula
#  located the file directory and was able to retrieve the correct file
#  opened data file, data columns separated by ',' hence the data would be loaded as read_csv()


# Load data ---------------------------------------------------------------

laminaria <- read_csv("data/laminaria.csv")


# Subsetting data ---------------------------------------------------------


blade_thickness <- laminaria %>%              # pipe command helps us to make calculations in a sequence thus avoiding mistakes
  filter(blade_thickness > 5) %>% 
  select(site,region,blade_weight,blade_thickness)


# Number of entries at Kommetjie ------------------------------------------

laminaria %>%                                 # Tell R which dataframe we are using
  filter(site == "Kommetjie") %>%             # we wanted to select only the rows of data belonging to the Kommetjie site and determine the number of entries to the site thus being able to determine the kelp with the greatest length
  nrow()


# Kelp with greatest length at Kommetjie ----------------------------------

laminaria %>% 
  filter(total_length == max(total_length))   # find row with maximum total length


laminaria %>% 
  summarise(                                 # summarise data to be able to calculate the mean and standard deviation for the total lengths of all the plan
    sd_bld_len = sd(blade_length),
    avg_bld_wdt = mean(blade_length))
