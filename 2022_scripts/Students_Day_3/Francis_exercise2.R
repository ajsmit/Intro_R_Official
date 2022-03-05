#Author: Taufeeqah Francis
#Date: 9 February 2022
#Module: BCB744
# Day 3 Exercise 2

library(tidyverse)
# First exercise ----------------------------------------------------------

laminaria <- read.csv("data/laminaria.csv")

laminaria %>% 
  group_by(site) %>% 
  select(stipe_length, total_length)

ggplot(data = laminaria, aes(x = stipe_length, y = total_length,
                             colour = site)) + 
  geom_point(colour = "black") +
  geom_line() +
labs(x = "stipe_length(cm)", y = "total_length(cm)")

ggplot(data = laminaria, aes(x = blade_thickness, y = blade_weight,
                             colour = site)) +
  geom_point(colour = "black") +
  geom_line(aes(group = site)) +
labs(x = "blade_thickness(cm)", y = "blade_weight(g)")

# Second exercise ---------------------------------------------------------

#Task 1

ChickWeight <- datasets::ChickWeight

line_1 <- ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) + 
  geom_point() + #creates data points
  geom_smooth(method = "lm") +
labs(x = "Time(days)", y = "weight (g)", colour = "Diet type") +
  scale_colour_brewer(palette = "Set2")
line_1

#Task 2

library(ggpubr)

load("biostatistics/data/SACTNmonthly_v4.0.Rdata")

SACTNlast <- SACTNmonthly_v4.0 %>% 
  filter(temp < 11)

facet_1 <- ggplot(data = SACTNmonthly_v4.0, aes(x = depth, y = temp, colour = src)) +
  geom_point() +
  geom_line(aes(group = depth)) + 
  facet_wrap(~depth, ncol = 2) +
  labs(x = "Depth", y = "Temperature")
facet_1

#Task 3

ecklonia <- read.csv("data/ecklonia.csv")

histogram_1 <- ggplot(data = ecklonia, aes(x = stipe_length)) +
  geom_histogram(aes(fill = site), position = "dodge", binwidth = 100) +
  labs(x = "stipe length(cm)", y = "stipe_diameter")
histogram_1

box_1 <- ggplot(data = ecklonia, aes(x = stipe_diameter, y = stipe_mass)) +
  geom_boxplot(aes(fill = site)) +
  labs(x = "Stipe diameter", y = "Stipe Mass (g)")
box_1

ggarrange(line_1, facet_1, histogram_1, box_1,
          ncol = 2, nrow = 2,
          labels = c("A", "B", "C", "D"),
          common.legend = FALSE)

#Task 4

combo_fig <- ggarrange(line_1, facet_1, histogram_1, box_1, 
                       ncol = 2, nrow = 2,
                       labels = c("A", "B", "C", "D"),
                       common.legend = FALSE)



