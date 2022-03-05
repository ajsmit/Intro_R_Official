#  Day_2.R
# Reads in some data about Laminaria collected along the Cape Peninsula
# do various data manipulations, analyses and graphs
# ct patel
# 8 feb 2022
laminaria %>%  
  filter(blade_thickness > 5) %>% 
  select(site, blade_weight, blade_thickness)
# a filter was applied to the laminaria spread sheet to filtr out all the observations which had kelp blades a thickness of less than 5cm. then we selected to only view the individual sites and the weights of the blades with a thickness of 5cm and above.
laminaria %>% 
  filter(site == "Kommetjie")
# the laminaria data was filter to on ly show the data of the Kommetjie site
kelp_Kom <- laminaria %>% 
  filter(site == "Kommetjie")
#  this sites data was hen made into an object and is displayed in the environments pane
kelp_Kom %>% 
  filter(total_length == max(total_length))
# this object was then filtered to find the observation with the greatest total length.
