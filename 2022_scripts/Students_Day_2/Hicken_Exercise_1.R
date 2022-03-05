
# Loading data ------------------------------------------------------------

library(tidyverse)

Laminaria <- read.csv("data/laminaria.csv")
Laminaria

summary(Laminaria)

# Regions with blade thickness >5 ------------------------------------------

Laminaria %>%   
  filter(blade_thickness >5) %>% 
  select(site, region, blade_thickness, blade_weight)

# Number of rows and row with greatest length in Kommetjie ----------------

Laminaria %>% 
  filter(site =="Kommetjie") %>% 
  nrow()

Kelp_max <- Laminaria %>% 
  filter(site =="Kommetjie") %>% 
  filter(total_length == max(total_length))

  
