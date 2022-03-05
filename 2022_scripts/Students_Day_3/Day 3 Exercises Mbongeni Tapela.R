# IntroR Day 3
# Author: M H Tapela
# 09/02/21
# ggplot2: making graphs


# New Project -------------------------------------------------------------

# Create a new project in a known working directory 


# Load packages -----------------------------------------------------------

library("tidyverse")


# Load laminaria ----------------------------------------------------------
read.csv("laminaria.csv")
laminaria<-read.csv("laminaria.csv")

# Group laminaria dataframe by site
laminaria %>% 
  group_by(site) # Group the dataframe by site

# Create a new object for the laminaria dataframe which is grouped by site 
lam1 <- laminaria %>% 
  group_by(site) # Group the dataframe by site
lam1

# Create a basic scatterplot using a linear model (y~x) linear blade length ~ blade weight with a with lines of best fit for every site (with 95% confidence intervals)  
figure_1 <- ggplot(data = lam1, aes(x = blade_weight, y = blade_length, colour = site)) +
  geom_point(aes(size = blade_length)) +
  geom_smooth(method = "lm", size = 0.95, se = TRUE, aes(fill = site), alpha = 0.15) +
  labs(x = "Blade weight (g)", y = "Blade length (cm)", colour = "Site") + # Change the labels
  theme(legend.position = "bottom") # Change the legend position
figure_1 + guides(fill = FALSE, alpha = FALSE) # remove unwanted legend for geom_smooth aesthetic

# The figure depicts a positive relationship between blade length ~ blade weight for all sites for laminaria. This relationship between sites are not significantly different from each as confidence intervals overlap

# export plot as an image or pdf

