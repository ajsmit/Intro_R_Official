# Emma Langtry
# 9 February 2022
# Day 3: Exercise 1
# Purpose: construct 4 unique graphs using new information from ggplot2 and assemble them in a sensible manner for an image (end product)


# Task 1 ------------------------------------------------------------------

# load the necessary packages
library(tidyverse)
library(ggpubr)

# load the data
chick <- datasets::ChickWeight

# Question: Which diet achieves the highest average weight with the lowest margin for error?

graph1 <- ggplot(chick, aes(x = Diet, y = weight)) +
  geom_boxplot(colour = c("#D47788", "#A3A0CE", "#4EC9C6", "#9BDB7F")) +
  labs(x = "Diet Type", y = "Mass (g)") +
  theme_minimal()

# Task 2 ------------------------------------------------------------------

# load data
load("data/SACTNmonthly_v4.0.RData")

# Question: What is the relationship between temperature and depth measured from the different sources?

graph2 <- ggplot(SACTNmonthly_v4.0, aes(x = depth, y = temp)) +
  geom_point(shape = 4, colour = "red") +
  labs(x = "Depth (m)", y = "Temperature (°C)")

# Task 3 ------------------------------------------------------------------

# load data
ecklonia <- read.csv("data/ecklonia.csv")

graph3 <- ggplot(ecklonia, aes(x = stipe_mass, y = stipe_length)) +
  geom_point(aes(size = stipe_diameter)) +
  geom_smooth(method = "lm") +
  labs(x = "Stipe Mass (g)", y = "Stipe Length (m)")
  theme_classic()

graph4 <- ggplot(ecklonia, aes(x = primary_blade_width, y = primary_blade_length, colour = site)) +
  geom_point() +
  labs(x = "Primary Blade Width", y = "Primary Blade Length")
  theme_bw()

# Task 4 ------------------------------------------------------------------

finalgraph <- ggarrange(graph1, graph2, graph3, graph4, ncol = 2, 
                        nrow = 2, 
                        labels = c("A", "B", "C", "D"), 
                        common.legend = TRUE)

ggsave("data/finalgraph.png")
