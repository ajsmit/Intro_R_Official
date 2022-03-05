# Final Intro_R Exercises_2
# Author: M H Tapela
# Date: 20/02/22
# Miscellaneous exercises for the mind 2


# Exercise A --------------------------------------------------------------

# Load Packages -----------------------------------------------------------

library(tidyverse)
library(colorspace)
library(devtools)
devtools::install_github('cttobin/ggthemr')
library(ggthemr)

# Load data ---------------------------------------------------------------

shells <- read.csv("shells.csv")


#Plot relationship between shell right length and right width

shell_plot <- ggplot(data = shells, aes(x = right_width, y = right_length, colour = species)) +
  geom_smooth(method = "lm", size = 0.9, se = TRUE, alpha = 0.3) +
  labs(x = "right_width (cm)", y = "right_length (cm)", colour = "species") + # Change the labels
  theme(legend.position = "bottom") # Change the legend position

ggthemr("flat dark")
shell_plot


shells1 <- shells %>% 
  group_by(species)
  
           
histogram_1 <- ggplot(data = shells, aes(x = right_length)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 100) +
  labs(x = "right_width (g)", y = "right_length")
histogram_1
