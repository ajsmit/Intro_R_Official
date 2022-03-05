# Intro R Day 4
# Exercise C
# Purpose:  Creating some graphs and applying some manipulations using different packages
# Date: 10 February 2022
# Author Danielle Roach
# 

# loading the packages ----------------------------------------------------

library(tidyverse) 
library(lubridate)
library(dplyr)
library(ggpubr)



# Task 1 ------------------------------------------------------------------



# loading the data --------------------------------------------------------

load("Data/SACTNmonthly_v4.0.RData") # Filtering the data to include only the KZNSB sites
kzn_data <- SACTNmonthly_v4.0 %>%
  filter(src == "KZNSB")



# Grouping by the year and by the site ----------------------------------------------------

year_temps <- kzn_data %>% # First created an object for the temp per year to which we can refer to later
  mutate(yr = year(date) , # Creates new columns with the year information that we needed
         mo = month(date)) %>% # Removed the date to have the year separated from it
  group_by(site, yr) %>% # We grouped the data by the site and the year
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # We summarized the data and calculated the mean temperature and ignored all the data which had no values in them 
  ungroup() # We ungrouped the data to make it look more neat


# Creating the plot -------------------------------------------------------

ggplot(data = year_temps, aes(x = yr , y = mean_temp)) + # Creating the graph using the new object with x= year and y= temp
  geom_line(colour = "brown")+ # using  a line graph
  facet_wrap(~site, ncol = 5) + # Creating a facet wrap by each site and have 5 columns showing
  labs(x = "Year", y = "Temp(°C)", title = "KZNSB series of annual means") # added labels for the x and y axes as well as the units and a title


# Task 2 ------------------------------------------------------------------
month_temps <- kzn_data %>% # First created an object for the temp per month
  mutate(mo = month(date, label = TRUE, abbr = TRUE)) %>% # Changed the values for each month to the abbreviation of the name 
  group_by(site, mo) %>% # grouped by site and month
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # summarized the data and calculated the mean temperature and ignored all of the cells which had no data for the calculation of the mean
  ungroup() 


# Doing the plot ----------------------------------------------------------

ggplot(data = month_temps, aes(x = mo , y = mean_temp)) + # used the month temperature data to do the plot and specified what the x and the y should be
  geom_line(aes(group = site, colour = "red")) + # made a line graph and specified that the lines needed to be in the colour red
  facet_wrap(~site, ncol = 5) + # made a faceted plot to include every sites' monthly climatology
  theme(axis.text.x = element_text(angle = 90)) + # This rotated the axis title
  labs(x = "Month", y = "Temp(°C)", title = "KZNSB series of monthly means") # changed the labels for the graph and specified the units


# Task 3 ------------------------------------------------------------------


# loading the data --------------------------------------------------------

ToothGrowth <- datasets::ToothGrowth


mean_toothgrowth <- ToothGrowth %>%  # created an object for mean tooth growth to manipulate further
  group_by(supp,dose) %>% # grouped the data by supplement and dosage
  summarize(lenmean=mean(len), lensd=sd(len), count = n()) # used the summarize function to calculate the mean of length and dose
print(mean_toothgrowth)


# Doing the plot ----------------------------------------------------------



ggplot(data = mean_toothgrowth, aes(x = dose, y = lenmean, colour = supp)) + # using the mean tooth growth data to do the plot and specifying what x and y should be and instructing R that the supplements need to be distinguished by colour
  geom_point() + # used points to display the data
  geom_line() + # used lines to display the data
  labs(x = "Dose(mg/day)", y = "Tooth length(mm)") # specified what the labels should be on the x and the y axis, as well as the units


# Task 4 ------------------------------------------------------------------


# Doing the plot ----------------------------------------------------------



ggplot(data = ToothGrowth, aes(x = dose, y = len)) + # used the toot growth data to create the plot, with x= dose and y=length
  geom_boxplot(aes(fill = supp)) + # specified that the aesthetic fill of the plot needed to represent the supplements
  facet_wrap(~supp, ncol = 2) + # used a facet wrap to create two panels with 2 columns
  labs(x = "Dose(mg/day)", y = "Tooth length (mm)") # changed the labels and the units on the x and y axis


# Task 5 ------------------------------------------------------------------

# Doing the plot ----------------------------------------------------------


ggplot(data = mean_toothgrowth, aes(x = dose, y = lenmean, fill = supp)) + # used the mean tooth growth data to create a bar graph and specified what the x and y should be, the supplement needed to be distinguishable by the fill
  geom_bar(stat = "identity", position = "dodge") + # created a bar graph and setting the position to dodge so that the bars do not sit on top of each other
  geom_errorbar(data = mean_toothgrowth, aes(ymin = lenmean - lensd, ymax = lenmean + lensd), # created an error bar which represented the standard deviation
                width = 0.1, position = position_dodge(0.4)) +
  labs(x = "Dose(mg/day)", y = "Tooth length(mm)") # changed the labels of the plot and specified the units






