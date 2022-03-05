# Intro_R_Day_4
# Jamie Ceasar
# Exercise C
# 10 Feb 2022

# Purpose: Reinforce graph making skills

# Task 1: The SACTNmonthly_v4.0.RData (A) ------------------------------------------------------------------

# load packages 
library(tidyverse)
library(ggpubr)
library(lubridate)

# load data 
load('data/SACTNmonthly_v4.0.RData')

# Copy the data as a data frame with a shorter name
SACTN <- SACTNmonthly_v4.0

# Remove the original
rm(SACTNmonthly_v4.0)

temps_KZNSB <- SACTN %>% # Assign new data frame 
  filter(src == "KZNSB") # Filter the data by source to include only the KZNSB data

temps <- temps_KZNSB %>% 
  mutate (yr = year((date)), 
          mo = month(date)) %>% # Mutate the date format to separate the year and the month
  group_by(site, yr) %>% # Group by site and year to calculate the mean temperature
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # Summarize annual mean temperature for each site 
  ungroup() 

# Create the faceted figure
ggplot(temps, aes(x = yr, y = mean_temp)) + # Use the newly created "temps" data frame to plot the annual mean temps 
  geom_line(colour = "red", size = 0.7) + 
  scale_x_continuous(breaks = seq(1980, 2013, by = 20)) + # Change the x and y axis tick mark intervals
  scale_y_continuous(breaks = seq(20, 24, by = 2)) +
  facet_wrap (~site, ncol = 5) + # Create the facets
  labs(x = "Year", y = "Temperature (°C)", title = "KZNSB: series of annual means") # Change the labels


# Task 2: The SACTNmonthly_v4.0.RData (B) ------------------------------------------------------------------

# Remove unnecessary data frame
rm(SACTN)
rm(temps)

# Use temps_KZNSB data frame (created above) to create a new data frame 
temps_mo <- temps_KZNSB %>% 
  mutate (mo = month(date)) %>% # Mutate the date format to include only the month 
  group_by(site, mo) %>% # Group by site and year to calculate the mean temperature
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # Summarize the monthly mean temperature
  ungroup()

Temp_mo <- temps_mo %>% # 
  mutate(mon = month.abb[mo]) %>% # Change from month number to abbreviations
  select("site", "mean_temp", "mon") 

Mon <- factor(Temp_mo$mon, 
              levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", # Change months to a factor
                         "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")) 

# Create the figure
ggplot(Temp_mo, aes(x = Mon, y = mean_temp)) + # Note: the use of "x = Mon" 
  geom_line(aes(group = "site"), colour = "LightSeaGreen", size = 0.8) + 
  theme(axis.text.x = element_text(angle = 90)) + # Rotate the text on the x-axis 
  scale_y_continuous(breaks = seq(20, 24, by = 2)) + # Change the y axis tick mark intervals
  facet_wrap (~site, ncol = 5) + # Create the facets
  labs(x = "Months of the Year", y = "Temperature (°C)", title = "KZNSB: series of monthly means") # Change the labels


# Task 3: The ToothGrowth data (A) -----------------------------------------------------------------

# load data
ToothGrowth <- datasets::ToothGrowth 

tooth_growth <- ToothGrowth %>% 
  group_by(supp,dose) %>% # "supp" and "dose" are the variables for which we need to calculate the mean length
  summarize(lenmean=mean(len)) %>% # Summarize the mean length
  ungroup()

# Plot the length (y) by the dosage (x)
ggplot(tooth_growth, aes(x= dose, y= lenmean, colour = supp)) + 
  geom_point(aes(color = supp), size = 2.2) + # Create points on the figure
  geom_line(size = 1.2) + 
  theme_light() + 
  facet_wrap(~supp, ncol = 2) + # Create the facets
  theme (legend.position = "bottom", aspect.ratio = 1.1) + # Change the legend position and aspect ratio
  labs(x = "Dose (mg/d)", y = "Tooth length (mm)", colour = "Supplement type") # Change labels


# Task 4 The ToothGrowth data (B)  ------------------------------------------------------------------

# Create a basic box plot with ggplot
ggplot(ToothGrowth, aes(x = factor(dose), y = len, fill = factor(dose))) + 
  geom_boxplot(size = 0.5) + # Create box plot and alter size of the lines
  theme_bw() +
  facet_grid(~supp, labeller = as_labeller(c("OJ" = "Orange Juice", "VC" = "Vitamin C"))) + # Create the facets
  theme (legend.position = "bottom", aspect.ratio = 1.1) + # Change legend position and aspect ratio
  labs(x = "Dose (mg/d)", y = "Tooth length (mm)", fill = "Dose (mg/d)") # Change the labels


# Task 5: The ToothGrowth data (C) ------------------------------------------------------------------

tooth_growth_2 <- ToothGrowth %>% 
    group_by(dose, supp) %>% # Grouping the data by dose and supp
    summarize(lenmean = mean(len), lensd = sd(len)) # Summarize the mean and standard deviation 

ggplot(tooth_growth_2, aes(x = dose, y = lenmean, ymin = lenmean - lensd, 
                        ymax = lenmean + lensd, fill = supp)) + # Set error bars
  geom_bar(size = 1, colour = "black", 
           stat = "identity", # Tell R to use the y-value "lenmean" in the data, 
                              # to specify the height of the bars
           position = "dodge", # Spread the data on the x-axis
           width = 0.4) + # Specify the width of the bars
  geom_errorbar(size = 1, 
                colour = "black", # Specify the colour of the error bars
                position = position_dodge(0.4), # Spread the error bars across the x-axis
                width = 0.2) + # Specify the width of the error bars
  theme (aspect.ratio = 1.1) +
  labs(x = "Dose (mg/d)", y = "Tooth length (mm)") # Change the labels

  