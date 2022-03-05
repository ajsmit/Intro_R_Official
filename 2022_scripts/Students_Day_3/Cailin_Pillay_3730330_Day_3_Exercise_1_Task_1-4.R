# Day_3_Exercise_1.R
# Task_1-4
# Cailin_Pillay
# 09/02/2022


# TASK_1 ------------------------------------------------------------------

# Load some packages ------------------------------------------------------

library(tidyverse)
library(lubridate)
library(ggpubr)

# Load data
ChickWeight <- datasets::ChickWeight 

# Create faceted figure 
Graph_1<-ggplot(data = ChickWeight, aes(x = Time, y = weight)) + 
  geom_point(aes(colour = as.factor(Diet))) + # Assigning points and colour to different diets
  scale_colour_manual(values = c("pink", "maroon", "yellow", "red")) + # Creating my own colours
  geom_smooth(method = "lm") + # Creating a linear model
  facet_wrap(~Diet, ncol = 2) + # This creates the faceted figure
  labs(x = "Time (Days)", y = "Mass (g)") + # Change the labels
  theme_bw() + # Change the theme
  theme(legend.position = "bottom") # Change the legend position
Graph_1

#All four of our Diets graphed together with an colour for each diet as a legend


# TASK_2 ------------------------------------------------------------------

# Load some packages ------------------------------------------------------

library(tidyverse)
library(lubridate)
library(ggpubr)

# Load data 
load("data/SACTNmonthly_v4.0.RData") 

SACTN <- SACTNmonthly_v4.0 # Assigning a new named data frame containing the ggplot created and Telling R what dataframe to use as this is a shorter name

rm(SACTNmonthly_v4.0) # Deleting the old long name

SACTN_AVG<-SACTN %>% # Assigning a new named data frame containing the ggplot created and Telling R what data frame to use
  group_by(site, src) %>% # Grouping by site and src
  na.omit() %>% # Getting rid of NA values 
  summarise(avg_temp = mean(temp)) # Calculating the Average Temperature Means

# Create faceted figure
Graph_2<-ggplot(data = SACTN_AVG, aes(x = site, y = avg_temp, colour = src)) + # Assigning a new named data frame containing the ggplot created
  geom_point() + # Creating points on the figure
  scale_colour_manual(values = c("pink", "maroon", "yellow", "red","green", "brown", "purple")) + # Creating my own colours
  geom_smooth(method = "lm") + # Creating a linear model
  facet_wrap(~src, ncol = 2) + # This is the line that creates the facets
  labs(x = "Site", y = "Average Temperature (Degrees Celsius°C)") # Change the labels
Graph_2 

# TASK_3 ------------------------------------------------------------------

# Load some packages ------------------------------------------------------

library(tidyverse)
library(lubridate)
library(ggpubr)

# Load data 
ecklonia <- read_csv("data/ecklonia.csv") 


# CREATING AN INTERESTING GGPLOT WITH THE EXKLONIA DATA ----------------------


ecklonia %>% # Tell R which dataset to use
  select(site, primary_blade_width, primary_blade_length) # Retaining specific columns  in order to compare the width and lengths 

# Create a basic figure
ggplot(data = ecklonia, aes(x = primary_blade_width, y = primary_blade_length)) + # Tells R to plot points and lines for each selected columns at the same time using ggplot2 to create the figure
  geom_point() + # Makes points on the figure
  geom_line(aes(group = site)) # Makes lines on the figure and groups by site

# Create a basic figure
ggplot(data = ecklonia, aes(x = primary_blade_Width, y = primary_blade_length, colour = site)) + # Adding colour to represent each site
  geom_point() + # Makes points on the figure
  geom_line(aes(group = site))# Makes lines on the figure and groups by site

# Create a basic figure
ggplot(data = ecklonia, aes(x = primary_blade_width, y = primary_blade_length, colour = site)) +
  geom_point() + # Makes points on the figure
  geom_smooth(method = "lm") # Creating a linear model to visualize any patterns better

# Create a basic figure
ggplot(data = ecklonia, aes(x = primary_blade_width, y = primary_blade_length, colour = site)) +
  geom_point(aes(size = primary_blade_length)) + # Controlling the looks of the functions based on the variable provided
  geom_smooth(method = "lm", size = 1.2) # Adding the size of the dots to equal the weight and length of the linear model to one static value

# Create a basic figure
Graph_4a<-ggplot(data = ecklonia, aes(x = primary_blade_width, y = primary_blade_length, colour = site)) + # Assigning a new named data frame containing the ggplot created
  geom_point(aes(size = primary_blade_length)) + # Controlling the looks of the functions based on the variable provided
  geom_smooth(method = "lm") + # Creating a linear model to visualize any patterns better
  labs(x = "Primary Blade Width (cm)", y = "Primary Blade Length (cm)", colour = "site") +  # Change the labels
  theme_light()+ # Change the theme
  theme(legend.position = "bottom") # Change the legend position

Graph_4a


# SECOND SINGLE-PANEL GRAPH SHOWING ASPECTS NOT SHOWN IN TASK 1 AND 2.-----------


ecklonia %>% # Tell R which dataset to use
  select(site, stipe_diameter, stipe_length) # Retaining specific columns in order to compare the weights and lengths to different sites and regions

# Create a basic figure
ggplot(data = ecklonia, aes(x = stipe_diameter, y = stipe_length)) + # Tells R to plot points and lines for each selected columns at the same time using ggplot2 to create the figure
  geom_point() + # Makes points on the figure
  geom_line(aes(group = site)) # Makes lines on the figure and groups by site

# Create a basic figure
ggplot(data = ecklonia, aes(x = stipe_diameter, y = stipe_length, colour = site)) + # Adding colour to represent each site
  geom_point() + # Makes points on the figure
  geom_line(aes(group = site))# Makes lines on the figure and groups by site

# Create a basic figure
ggplot(data = ecklonia, aes(x = stipe_diameter, y = stipe_length, colour = site)) +
  geom_point() + # Makes points on the figure
  geom_smooth(method = "lm") # Creating a linear model to visualize any patterns better

# Create a basic figure
ggplot(data = ecklonia, aes(x = stipe_diameter, y = stipe_length, colour = site)) +
  geom_point(aes(size = stipe_length)) + # Controlling the looks of the functions based on the variable provided
  geom_smooth(method = "lm", size = 1.2) # Adding the size of the dots to equal the weight and length of the linear model to one static value

# Create a basic figure
Graph_4b<-ggplot(data = ecklonia, aes(x = stipe_diameter, y = stipe_length, colour = site)) + # Assigning a new named data frame containing the ggplot created
  geom_point(aes(size = stipe_length)) + # Controlling the looks of the functions based on the variable provided
  geom_smooth(method = "lm") + # Creating a linear model to visualize any patterns better
  labs(x = "Stipe Diameter (cm)", y = "Stipe Length (cm)", colour = "site") +  # Change the labels
  theme_light()+ # Change the theme
  theme(legend.position = "bottom") # Change the legend position

Graph_4b


# TASK_4 ------------------------------------------------------------------

grid_1<-ggarrange(Graph_1, Graph_2, Graph_4a, Graph_4b, 
                  ncol = 2, nrow = 2, # Set number of rows and columns
                  labels = c("A", "B", "C", "D"), # Label each figure. c() is to combine A,B,C,D
                  common.legend = TRUE) # Create common legend
grid_1
