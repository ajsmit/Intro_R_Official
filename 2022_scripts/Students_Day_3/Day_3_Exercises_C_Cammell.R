# Module: BCB744
# Author: C Cammell
# Date: 9 Feb 2022

# This script undertakes the ggplot exercises on day 3


# Start of graph exercise -------------------------------------------------

library(tidyverse)#load tidyverse before beginning the script

laminaria <- read_csv("Data/laminaria.csv") #load the data from external csv file

laminaria %>% 
  select(site, stipe_length, stipe_mass) #load data and select relevant datasets


# ggplot: plotting stipe length against stipe mass at each site -----------

# create ggplot with extracted data

ggplot(data = laminaria, aes(x = stipe_length, y = stipe_mass, colour = site)) +
  geom_point() + # add points to indicate data values
  geom_line(aes(group = site)) # connect datapoints with lines


ggplot(data = laminaria, aes(x = stipe_length, y = stipe_mass, colour = site)) +
  geom_point() +
  geom_smooth(method = "lm") # replace lines with geom_smooth to make the graph more legible
  

ggplot(data = laminaria, aes(x = stipe_length, y = stipe_mass, colour = site)) +
  geom_point(aes(size = stipe_mass)) +
  geom_smooth(method = "lm", size = 1.2) # change the size of the points


ggplot(data = laminaria, aes(x = stipe_length, y = stipe_mass, colour = site)) +
  geom_point(aes(size = stipe_mass)) +
  geom_smooth(method = "lm") +
  labs(x = "Stipe Length (cm)", y = "Stipe Mass (g)", colour = "Site") + # add axes labels
  theme_dark() + #change the theme (do something new)
  theme(legend.position = "bottom") # move the position of the legend




# Exercise 1 --------------------------------------------------------------

# Task 1: The chicken data ------------------------------------------------

# load some packages ------------------------------------------------------

library(tidyverse)


# start our first ggplot graph --------------------------------------------

# load data

ChickWeight <- datasets::ChickWeight


ChickHalf1 <- ChickWeight %>% 
  filter(Time <12) # filter data into first half to analyse chick weight from day 0-12

ChickHalf1 <- ggplot(data = ChickHalf1, aes(x = Time, y = weight, colour = Diet)) +
  scale_colour_brewer(palette = "YlOrRd") + # add colour palette
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Time (days)", y = "Mass (g)", colour = "Diet type") + # add proper axes labels
  theme_bw() + # one of many themes that we can choose from
  theme(legend.position = "bottom") # change the legend position
ChickHalf1

ChickHalf2 <- ChickWeight %>%
  filter(Time >=12) # filter for second half of data to analyse chick weight from day 12-21

ChickHalf2 <- ggplot(data = ChickHalf2, aes(x = Time, y = weight, colour = Diet)) +
  scale_colour_brewer(palette = "YlOrRd") + # add colour palette
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Time (days)", y = "Mass (g)", colour = "Diet Type") + # add proper axes labels
  theme(legend.position = "bottom") # change the legend position
ChickHalf2

# Create faceted figure to compare trends between the first half of the days and the second half of the days

chick_1 <- ggarrange(ChickHalf1, ChickHalf2, 
          ncol = 2, nrow = 2, # Set number of rows and columns
          common.legend = TRUE) # Create common legend
chick_1


# Task 2:  data in 'data/SACTNmonthly_v4.0.Rdata' -------------------------

SACTNmonthly <- read.csv("Data/SACTNmonthly_v4.0.RData") # read file

# load relevant packages

library(dplyr)
library(ggplot2)

# extract data into ggplot

SACTNmonthly50 <- SACTNmonthly_v4.0 %>%
  slice(1:50) # extract first 50 values to be evaluated

# count number of occurrences of each value in column
table50 <- table(SACTNmonthly50$RDX2)
table50


  
  
  
  
# Task 3: the 'data/ecklonia.csv' data ------------------------------------

# load data

ecklonia <- read.csv("Data/ecklonia.csv")

box_1 <- ggplot(data = ecklonia, aes(x = stipe_length, y = stipe_mass, colour = site)) +
  scale_colour_brewer(palette = "Set2") + # add colour palette
  geom_boxplot(aes(fill = stipe_mass)) +
  labs(x = "Stipe Length (cm)", y = "Stipe Mass (g)", colour = "Site") +
  theme(legend.position = "bottom")
box_1

box_2 <- ggplot(data = ecklonia, aes(x = frond_length, y = frond_mass, colour = site)) +
  scale_colour_brewer(palette = "Set2") + # add colour palette
  geom_boxplot(aes(fill = stipe_mass)) +
  labs(x = "Frond Length (cm)", y = "Frond Mass (g)", colour = "Site") +
  theme(legend.position = "bottom")
box_2

# Comparison between stipe factors and frond factors in plant species maxima
# Create faceted figure to compare trends between the first half of the days and the second half of the days

box_3 <- ggarrange(box_1, box_2, 
          ncol = 2, nrow = 2, # Set number of rows and columns
          common.legend = TRUE) # Create common legend
box_3


# labels for each figure not necessary because axes specify stipe and frond respectively
# comparisons of stipe proportions and frond proportions are seen in the plots above




# Task 4: the last step ---------------------------------------------------


# load package

library(ggpubr)

# combine data sets to be viewed at the same time

ggarrange(chick_1, box_3,
          ncol = 1, nrow = 2, # Set number of rows and columns
          common.legend = FALSE) # Create common legend

  