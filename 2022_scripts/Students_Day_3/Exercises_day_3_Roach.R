# Intro R Day 3
# Exercises
# Aim: Making graphs using ggplot2 and doing manipulations such as facetting
# Danielle Roach
# 9 February 2022
# 
# 

# Exercise 0- Making a plot using the laminaria data ----------------------


# Loading the tidyverse package -------------------------------------------
library(tidyverse)


# Reading the laminaria data ----------------------------------------------

laminaria <- read_csv("Data/laminaria.csv")


# Making stipe mass an object and selecting only the site column ---------------------------------------------

stipe_mass <- laminaria %>%
  select(site) # selecting site

 # Making stipe mas an object and selecting only the stipe mass column -------------------------------------------------------------------

site <- laminaria %>% 
  filter(stipe_mass)
  
# Making a graph ----------------------------------------------------------

ggplot(data = laminaria, aes(x = site, y = stipe_mass, colour = stipe_mass)) +
  geom_point() + # This specified that site=x and stipe mass=y and stipe mass was assigned a colour. The data was represented here as points
  geom_smooth(method = "lm") + # Fitting a regression model using a linear model
  labs(x = "site", y = "Stipe_mass (g)") + # Adding labels and units
  theme_bw() + # Making the theme black and white
  theme(axis.text.x = element_text(angle = 90)) # Rotating the axis labels by 90 degrees


# Exercise 1 --------------------------------------------------------------


# Task 1 ------------------------------------------------------------------

# loading the chicken data
Chickweight <- datasets::ChickWeight

# Doing the plot ----------------------------------------------------------

ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) + # Telling ggplot to use the chickenweight data and make time=x and y=weight and assign a colour to each different diet  
  
  scale_colour_brewer(palette = "Set1") + # Adding a custom colour palette
  geom_point(aes(size = weight)) +  # Making the size of the data points go up with weight
  geom_smooth(method = "lm") + # fitting a regression model by using a linear model
  labs(x = "Time(Days)", y = "Mass(g)") # adding appropriate labels to the axes


# Task 2 ------------------------------------------------------------------

# loading the data --------------------------------------------------------

load("Data/SACTNmonthly_v4.0.RData")

# loading the package -----------------------------------------------------
library(ggpubr)

# Doing a faceted plot ----------------------------------------------------

SACTN_facet <- SACTNmonthly_v4.0 %>% # A new object was created in order to create a subset of the data
  select(site, temp,depth) %>% # Only site, temp and depth was selected out of the different columns
  slice(1:1478) # This only retained rows 1 to 1478 to ensure that there were only 4 sites in the data


ggplot(data = SACTN_facet, aes(x = depth, y = temp, colour = site)) + # The plot was created using the sliced data with x=depth and y=temp and different sites being denoted by different colours
  scale_colour_brewer(palette = "Set1") + # The colour palette was changed
  geom_point() + # The data is shown in points
  geom_smooth(method = "lm") + # fitted a regression model using a linear model
  facet_wrap(~site, ncol = 2) + # Created a facet wrap for the 4 different sites with the facets being presented in 2 columns
  labs(x = "Depth(m)", y = "Temp(°C)")


# Task 3 ------------------------------------------------------------------

# loading the data

ecklonia <- read_csv("Data/ecklonia.csv")


# Doing the plots ---------------------------------------------------------

ggplot(data = ecklonia, aes(x = species, y = stipe_mass)) + # Using the ecklonia data to create a boxplot with x=species and y=stipe_mass
  geom_boxplot(aes(fill = site)) + # added the site to the fill
  labs(x = "site", y = "Stipe diameter (mm)") # changed the labels

# I know this is incomplete but it is currently 23:54 I have to throw in the towel





