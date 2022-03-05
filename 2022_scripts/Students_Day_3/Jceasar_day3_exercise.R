# Intro_R_Day_3
# Jamie Ceasar
# Exercises
# 9 Feb 2022

# Purpose: Apply newly attained skills to variaous datasets


# load packages -----------------------------------------------------------

library(tidyverse)


# load data
laminaria <- read.csv('Data/data/laminaria.csv')


# create graph 

ggplot(laminaria, aes(x = blade_length, y = blade_weight, colour = region)) +
  geom_point(size = 2) + # change the point size
  geom_smooth(method = "lm", size = 1) + # change line size
  labs(x = "Blade length (cm)", y = "Blade weight (g)", colour = "Region") + # Change the labels
  theme_light() + #change background 
  theme(legend.position = "bottom") # Change the legend position

  # In both regions, we see that as as blade length increases, blade weight increases, 
  # indicating a positive correlation.
  # This relationship is represented by the smooth/straight line produced
  # It is also noticable that, the West Coast region has larger individuals Laminaria spp. 


# Exercise 1: Task 1 ------------------------------------------------------

# load chicken data
ChickWeight <-datasets::ChickWeight

# create plot

fig_1 <- ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
  geom_point(shape = 19, size = 2) +
  geom_smooth(method = "lm", size = 1.2) +
  scale_color_brewer(palette = "Paired" ) + 
  labs(x = "Time (days)", y = "Mass (g)", colour = "diet type") + # Change the labels
  theme_light() +
  theme(legend.position = "bottom")
fig_1

RColorBrewer::display.brewer.all() # used to select my colour palette


# Task 2 ------------------------------------------------------------------

# load packages
# libray(tidyverse) has already been loaded
library(ggpubr)

# load data
load('Data/data/SACTNmonthly_v4.0.RData')

# create faceted plot

SACTN_data <- SACTNmonthly_v4.0 %>% 
  select(site, temp, date, depth) %>% 
  slice(1:1478)

ggplot(data = SACTN_data, aes(x =date, y = temp, colour = site)) +
  geom_point(size = 1.2, shape = 21, fill = "white") +
  geom_smooth(method = "lm") +
  scale_color_brewer(palette = "Paired" ) + 
  facet_wrap(~site, ncol = 2) +
  labs(x = "Date", y = "Temp. (°C)") +
  theme_bw() +
  theme(legend.position = "bottom")


# Line

line_1 <- ggplot(data = SACTN_data, aes(x = date, y = temp, colour = site)) +
  geom_point(size = 1.2, shape = 21, fill = "white") +
  geom_smooth(method = "lm") +
  scale_color_brewer(palette = "Paired" ) +
  labs(x = "Date", y = "Temp. (°C)") +
  theme_bw() +
  theme(legend.position = "bottom")
  
line_1


# Task 3 ------------------------------------------------------------------

# load data
ecklonia <- read.csv('Data/data/ecklonia.csv')

# create plot_1

box_1 <- ggplot(data = ecklonia, aes(x =site, y = stipe_diameter, fill = site)) +
  geom_boxplot(alpha=0.5) +
  scale_fill_brewer(palette = "Paired" )+
  labs(x = "Site", y = "Stipe Diameter (cm)") +
  theme_light() +
  theme(legend.position = "none")
box_1

# create plot_2

histogram_1 <- ggplot(data = ecklonia, aes(x = stipe_diameter)) +
  geom_histogram(aes(fill = site), position = "dodge", binwidth = 2) +
  labs(x = "stipe_diameter", y = "count")
histogram_1


# Task 4 ------------------------------------------------------------------

# recall graphs from tasks, 1, 2 and 3 and assign to an object

ggarrange(fig_1, line_1, box_1, histogram_1,
          ncol = 2, nrow = 2, # Set number of rows and columns
          labels = c("A", "B", "C", "D"), # Label each figure
          common.legend = TRUE) # Create common legend

# First we must assign the code to an object name
grid_1 <- ggarrange(fig_1, line_1, box_1, histogram_1, 
                    ncol = 2, nrow = 2, 
                    labels = c("A", "B", "C", "D"),
                    common.legend = TRUE)

# Then we save the object we created
ggsave(plot = grid_1, filename = "figures/grid_1.pdf")
