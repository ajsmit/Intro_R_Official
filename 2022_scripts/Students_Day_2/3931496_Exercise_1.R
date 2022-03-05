#Exercise 1: (Task1-Task4)
#Lauryn Bull
#Purpose:Data visulization and manipulation
#9th February 2022

library(tidyverse)

# Load data:-------------------------------------------

Chickweight <- datasets::ChickWeight

# Plot ggplot graphs:----------------------------------

ggplot(data = ChickWeight, aes(x = Time, y = weight)) +
  geom_point() +
  geom_line(aes(group = Chick))

ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
  geom_point() +
  geom_smooth(method = "gam")

# Changing Axis labels:------------------------------------------------
  
line_1 <- ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) + 
  geom_point() +                #creates data points
  geom_smooth(method = "lm") +
  labs(x = "Time(days)", y = "weight (g)", colour = "Diet type") +
  scale_colour_brewer(palette = "Set1") # Change aesthetics of graph (custom colour)---------------------
line_1
 
# Task2:

library(tidyverse)

#Load data:----------------------------------

load("data/SACTNmonthly_v4.0.Rdata")


unique(SACTNmonthly_v4.0$site) # Look at the site column + Unique shows only unique sites in the list (in repeated sets) only after the ($) function.
unique(SACTNmonthly_v4.0$src) # Look at the src column + Unique shows only unique src variables in the list (in repeated sets)

# Filtering data to include only SAWS data:----------------------------------------------------

library(ggpubr)

Sites_select <- c("Port Nolloth", "Hondeklipbaai", "Doringbaai", "Lamberts Bay")

temps_SAWS <- SACTNmonthly_v4.0 %>%  # Filter out data from  site select function into sites
  filter(src == "SAWS", 
         site == Sites_select)

unique(temps_SAWS$site)
unique(temps_SAWS$temps)

#Choosing the shape,colour and size aesthetics:------------------------------------

facet_1 <- ggplot(data = SACTNmonthly_v4.0, aes(x = depth, y = temp, colour = src)) +
  geom_point() +
  geom_line(aes(group = depth)) + 
  facet_wrap(~depth, ncol = 2) +
  labs(x = "Years", y = "Temperature (°C) ") # Change Axis titles
facet_1
 
#Task 3

library(tidyverse)

# Load data:-------------------------------------------

ecklonia <- read_csv("Data/ecklonia.csv")

# Make the first panel (site) ---------------------------------------------

unique(ecklonia$site) # Look at the site column + Unique shows only unique sites in the list (in repeated sets) only after the ($) function.

# Filtering sites to site_select:--------------------------

library(ggpubr)

unique(ecklonia$site)

Sites_select <- c("Boulders Beach", "Batsata Rock")

temps_site <- ecklonia %>%
  filter(site == Sites_select)
temps_site <- ecklonia %>%
  select(stipe_length,stipe_mass)

#Facetting figures with 2 additional panels:---------------------------------------------

histogram_1 <- ggplot(data = ecklonia, aes(x = stipe_length)) +
  geom_histogram(aes(fill = site), position = "dodge", binwidth = 100) +
  labs(x = "Stipe length(cm)", y = "Stipe Mass(g)")
histogram_1

box_1 <- ggplot(data = ecklonia, aes(x = stipe_length, y = stipe_mass)) +
  geom_boxplot(aes(fill = site)) +
  labs(x = "Stipe length(cm)", y = "Stipe Mass (g)")
box_1

ggarrange(line_1, facet_1, histogram_1, box_1,
          ncol = 2, nrow = 2,
          labels = c("A", "B", "C", "D"),
          common.legend = FALSE)

#Task4
  
combo_fig <- ggarrange(line_1, facet_1, histogram_1, box_1, 
                         ncol = 2, nrow = 2,
                         labels = c("A", "B", "C", "D"),
                         common.legend = FALSE)

