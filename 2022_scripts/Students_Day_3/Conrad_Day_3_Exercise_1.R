# Day_3.R
# Day 3 Exercise 1
# Ammaarah Conrad
# Student number: 3947006
# 09 February 2022


# Task 1 ------------------------------------------------------------------

library(tidyverse)
library(ggpubr)

# Question: Which diet type results in the greatest weight in the different chicks?

ChickWeight <- datasets::ChickWeight

# doing the plot
line_1 <- ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
  geom_point() +
  labs(x = "Time (days)", y = "Mass (g)", colour = "Diet type") +
  theme(legend.position = "bottom") +
  geom_line(aes(group = Chick)) +
  scale_colour_brewer(palette = "Set3") +
  theme_grey()
line_1

# Task 2 ------------------------------------------------------------------

load("R files/intro_r_data/data/SACTNmonthly_v4.0")

# looking at the relationship between the temperature and depth of the ocean at different sites.

# plotting the data
line_2 <- ggplot(data = SACTNmonthly_v4.0, aes(x = depth, y = temp, colour = src)) +
  geom_point() +
  labs(x = "Depth", y = "Temperature", colour = "SRC") +
  facet_wrap(~src,ncol = 2) +
  theme(legend.position = "bottom") +
  geom_line(aes(group = site)) +
  scale_colour_brewer(palette = "Set3") +
  theme_grey()
line_2


# Task 3 ------------------------------------------------------------------

ecklonia.csv <- read.csv("R files/intro_r_data/data/ecklonia.csv")

# plotting the primary blade length and primary blade width data for sites into a histogram

histogram_1 <- ggplot(data = ecklonia.csv, aes(x = primary_blade_length)) +
  geom_histogram(aes(fill = site, binwidth = 100)) +
  labs(x = "Primary blade length", y = "Primary blade width")
histogram_1

# plotting the frond length and frond mass data into a box plot

box_1 <- ggplot(data = ecklonia.csv, aes(x = frond_length, y = frond_mass)) +
  geom_boxplot(aes(fill = site)) +
  labs(x = "Frond Length (cm)", y = "Frond Mass (g)")
box_1

ggarrange(histogram_1, box_1,
          ncol = 2, nrow = 2,
          labels = c("C", "D"),
          common.legend = TRUE)


# Task 4 ------------------------------------------------------------------

# placing all four graphs next to each other

ggarrange(line_1, line_2, histogram_1, box_1,
          ncol = 2, nrow = 2,
          labels = c("A", "B", "C","D"),
          common.legend = TRUE)

combo_fig <- ggarrange(line_1, line_2, histogram_1, box_1,
                       ncol = 2, nrow = 2,
                       labels = c("A", "B", "C", "D"), 
                       common.legend = TRUE)
