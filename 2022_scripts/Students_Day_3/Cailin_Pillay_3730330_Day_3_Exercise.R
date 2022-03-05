# Day_3_Exercise.R
# Laminaria_ggplot
# CHAPTER 5 
# Cailin_Pillay
# 09/02/2022

# Load some packages ------------------------------------------------------

library(tidyverse)
library(lubridate)

# CREATING AN INTERESTING GGPLOT WITH THE LAMINARIA DATA ----------------------

# Run this if 'laminaria.csv` has columns separated by ','
laminaria <- read_csv("data/laminaria.csv") # Tell R where to find the data in the working directory and read the csv file

laminaria %>% # Tell R which dataset to use
  select(site, blade_weight, blade_length) # Retaining specific columns from the laminaria data to include all sites,regions, blade_Weight and blade_length in order to compare the weights and lengths to different sites and regions

# Create a basic figure
ggplot(data = laminaria, aes(x = blade_weight, y = blade_length)) + # Tells R to plot points and lines for each selected columns at the same time using ggplot2 to create the figure
  geom_point() + # Makes points on the figure
  geom_line(aes(group = site)) # Makes lines on the figure and groups by site

# Create a basic figure
ggplot(data = laminaria, aes(x = blade_weight, y = blade_length, colour = site)) + # Adding colour to represent each site
  geom_point() + # Makes points on the figure
  geom_line(aes(group = site))# Makes lines on the figure and groups by site

# Create a basic figure
ggplot(data = laminaria, aes(x = blade_weight, y = blade_length, colour = site)) +
  geom_point() + # Makes points on the figure
  geom_smooth(method = "lm") # Creating a linear model to visualize any patterns better

# Create a basic figure
ggplot(data = laminaria, aes(x = blade_weight, y = blade_length, colour = site)) +
  geom_point(aes(size = blade_length)) + # Controlling the looks of the functions based on the variable provided
  geom_smooth(method = "lm", size = 1.2) # Adding the size of the dots to equal the weight and length of the linear model to one static value

# Create a basic figure
Site_comparison<-ggplot(data = laminaria, aes(x = blade_weight, y = blade_length, colour = site)) + # Assigning a new named data frame containing the ggplot created
  geom_point(aes(size = blade_length)) + # Controlling the looks of the functions based on the variable provided
  geom_smooth(method = "lm") + # Creating a linear model to visualize any patterns better
  labs(x = "Blade Weight (g)", y = "Blade Length (cm)", colour = "site") +  # Change the labels
  theme_light()+ # Change the theme
  theme(legend.position = "bottom") # Change the legend position

Site_comparison # Viewing the GGplot created with the new named data frame

# Create a basic figure
Region_comparison<-ggplot(data = laminaria, aes(x = blade_weight, y = blade_length, colour = region)) + # Assigning a new named data frame containing the ggplot created and adding colour to represent each region
  geom_point(aes(size = blade_length)) + # Controlling the looks of the functions based on the variable provided
  geom_smooth(method = "lm") + # Creating a linear model to visualize any patterns better
  labs(x = "Blade Weight (g)", y = "Blade Length (cm)", colour = "Region") + # Change the labels
  theme_light()+ # Change the theme
  theme(legend.position = "bottom") # Change the legend position

Region_comparison #Viewing the GGplot created with the new named data frame


# Interpreting Data Graphs Created ----------------------------------------

# In Site_comparison we can see that there is a positive correlation between Blade Length (cm)and Blade Weight(g). As Blade Length(cm) increases so does Blade Weight(g) for all sites. 

# In Region_comparison we can see that there is a very strong positive correlation between Blade Length (cm) and Blade Weight (g). It is evident that there is a much greater Blade Length (cm) and Blade Weight (g) in region WC compared to in region FB. 

