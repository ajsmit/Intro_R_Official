# Exercise 1
# Task 1
# Author: ZM George
# 9 Feb 2022



# load packages -----------------------------------------------------------

library(tidyverse)
library(ggpubr)



# load data ---------------------------------------------------------------

ChickWeight <- datasets::ChickWeight


# construct interesting graph ---------------------------------------------

ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Days", y = "Mass (g)", colour = "diet type") + 
  scale_colour_brewer(palette = "Set1") +
  theme_bw() +
  theme(legend.position = "bottom") 


lm_1 <- ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
  geom_point() +
  geom_smooth(method = "gam") +
  scale_colour_brewer(palette = "Set1") +
  theme_light() +
  labs(x = "Days", y = "Mass (g)")
lm_1
