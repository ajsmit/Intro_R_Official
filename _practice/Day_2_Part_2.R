# Day_2_Part_2
# AJ Smit
# 16 March 2021
# Chapter 5 practice

# Load libraries
library(tidyverse)

# Load data
ChickWeight <- datasets::ChickWeight

# Create a basic figure
ggplot(data = ChickWeight, aes(x = Time, y = weight, col = Diet)) +
  geom_point() +
  geom_line(aes(group = Chick))

ggplot(data = ChickWeight, aes(x = Time, y = weight)) +
  # geom_point(aes(col = Diet)) +
  geom_point(aes(shape = Diet, col = Diet, size = weight)) +
  geom_line(aes(group = Chick), col = "black")

ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Days", y = "Mass (g)", colour = "diet type") + # Change the labels
  theme(legend.position = "bottom") # Change the legend position

ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
  geom_point() +
  geom_smooth(method = "lm") +
  xlab("Days") + ylab("Mass (g)") + # Change the labels
  theme(legend.position = "bottom") # Change the legend position

# Create a box and whisker plot for the final masses obtained by the chickens 
# at the end of the experiment, comparing the masses between levels of Diet

range(ChickWeight$Time)
unique(ChickWeight$Time)
tail(ChickWeight)
max(ChickWeight$Time)

# Create a box and whisker plot for the masses obtained by the chickens 
# at Times 0, 6, 12 and 21, comparing the masses between levels of Diet

ChickWeight %>% 
  filter(Time %in% c(0, 6, 12, 21)) %>% 
  # filter(Time == 0 | Time == 6 | Time == 12 | Time == 21)) %>% 
  ggplot(aes(x = Diet, y = weight)) +
  geom_boxplot(aes(col = Diet)) +
  facet_wrap(~Time, ncol = 2) +
  xlab("Diet") + ylab("Chick mass (g)")
