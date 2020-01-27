# Day_3.R
# The intention of this analysis is to...
# AJ Smit
# 21 Feb 2018


# Set-up ------------------------------------------------------------------

library(tidyverse)



# Load the data -----------------------------------------------------------

chicks <- datasets::ChickWeight



# Make a graph ------------------------------------------------------------

ggplot(data = chicks, aes(x = Time, y = weight)) +
  geom_point(shape = 24, colour = "salmon", fill = "yellow") +
  geom_line(aes(group = Chick), colour = "lightyellow2", alpha = 0.9) +
  geom_smooth(method = "lm", aes(colour = Diet)) +
  labs(x = "Time (days)", y = "Mass (g)") +
  theme_bw()



# Continuing --------------------------------------------------------------

library(ggpubr)


