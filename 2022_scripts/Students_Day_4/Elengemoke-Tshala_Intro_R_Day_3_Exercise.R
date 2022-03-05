# O Elengemoke-Tshala
# Day 3 Exercise
# 9 Feb 2022

# Purpose: to practice making graphs in R



# To load libraries
library(tidyverse)

# To load data
laminaria <- read_csv("data/laminaria.csv")

# To create a plot

ggplot(data = laminaria, aes(x =site, y = stipe_mass)) +
geom_point(aes(size = stipe_mass, colour = stipe_length, alpha = 0.2)) +
  geom_line(size = 0.9) +  
  labs(x = "Site", y = "Stipe mass (g)") +
  scale_colour_distiller(palette = "Paired")
  
  
# Interpretation:The stipes of Rocky Bank consists of numerous taller and moderate stipes,compared to stipes in all sites, as a result, the stipe mass of this site is more on other sites. All stipes in A-Frame, Baboon rock, Miller's Point, Roman Rock and Batsata Rock are shorter, hence lower stipe mass are observed in these sites.Moreover, in Sea Point,Betty's Bay, Buffels, Buffels South, Bordjiestif North, Olifantsbos and Kommetjie majority of stipes have a moderate length, consequently, these sites have moderate stipe mass. 