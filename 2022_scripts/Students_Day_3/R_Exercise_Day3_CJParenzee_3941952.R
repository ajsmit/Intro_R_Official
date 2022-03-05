# CJ Parenzee
# Student Number: 3941952
# BCB744
# Exercise 5.5 Day 3

library(tidyverse)
laminaria <- read.csv("data/laminaria.csv")

laminaria %>% 
  group_by(site) %>% 
  select(stipe_length, stipe_mass)

ggplot(data = laminaria, aes(x = stipe_length, y = stipe_mass, colour = site)) +
  geom_point() +
  geom_line() +
  labs(x = "Stipe length(cm)", y = "Stipe Mass(g)", colour = "Site") +
  theme(legend.position = "bottom")


# EXERCISE 1 --------------------------------------------------------------

#Task 1: The chicken data


library(tidyverse)

ChickWeight <- datasets::ChickWeight

line_1 <- ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) + 
  geom_point() +
  geom_line(aes(group = Chick)) +
  labs(x = "Time(Days)", y = "Mass(g)") +
  scale_colour_brewer(palette = "Set2")

line_1

#Task 2: data in 'data/SACTNmonthly_v4.0.Rdata'


library(ggpubr)

load("data/SACTNmonthly_v4.0.RData")

SACTNmonthly <- SACTNmonthly_v4.0


facet_1 <- ggplot(data = SACTNmonthly, aes(x = date, y = temp, colour = )) +
  geom_point() +
  geom_smooth(method = "lm") + 
  facet_wrap(~depth, ncol = 2) + 
  labs(x = "Date", y = "Temperature(Celcius)", colour = "Depth(m)") +
  theme(legend.position = "bottom")

facet_1

# Task 3: the 'data/ecklonia.csv' data --------------------------

ecklonia <- read.csv("data/ecklonia.csv")


histogram_1 <- ggplot(data = ecklonia, aes(x = stipe_length)) +
  geom_histogram(aes(fill = site), position = "dodge", binwidth = 100) +
  labs(x = "Stipe Length", y = "Stipe Diameter")

histogram_1

box_1 <- ggplot(data = ecklonia, aes(x = stipe_length, y = stipe_mass)) +
  geom_boxplot(aes(fill = site)) +
  labs( x = "Stipe Length(cm)", y = "Stipe Mass (g)")

box_1


ggarrange(histogram_1, box_1,
          ncol = 2, nrow = 2,
          labels = c("A", "B", "C", "D"),
          common.legend = TRUE)

combo_fig <- ggarrange(line_1, facet_1, histogram_1, box_1,
                       ncol = 2, nrow = 2, 
                       labels = c("A", "B", "C", "D"), 
                       common.legend = TRUE) 
combo_fig
