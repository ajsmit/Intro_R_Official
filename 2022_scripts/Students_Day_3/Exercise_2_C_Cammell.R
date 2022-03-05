# C Cammell
# 10 February 2022
# Intro R Workshop: Exercise 2
# Furthering our graph skills


# Task 1: The SACTNmonthly_v4.0.RData (A) ----------------------------

# load packages ------------------------------------------------------

library(tidyverse)
library(dplyr)
library(lubridate)
library(ggpubr)
library(ggplot2)

# load data ----------------------------------------------------------

load("Data/SACTNmonthly_v4.0.RData") # load data

temps_KZNSB <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") # filter the src to be KZN

a_date <- as.Date("1981-01-01")
year(a_date) # example of filtering a date


# extract the year from dates and calculate average-----------------


temps_yr <- temps_KZNSB %>% # create new object
  mutate(yr = year(date), # separate year from date, mutate creates                               new columns
         mo = month(date)) %>%  # separate month from date
  group_by(site, yr) %>% # group the sites by year
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # calculate the                                     average temperature for each year
  ungroup() # ungroup to clarify data


# plot the data on a graph ------------------------------------------


site_plot <- ggplot(temps_yr, aes(x = yr, y = mean_temp)) +
  geom_line(colour = "purple") + # line graph, select colour
  facet_wrap(~site, ncol = 5) + # create facets with 5 in each column
  labs(x = "Year", y = "Temperature (°C)", title = "KZNSB: series of  annual means") # create labels
site_plot #run object ... Success!



# Task 2: the SACTNmonthly_v4.0.RData data continued -----------------


# load data ----------------------------------------------------------

load("Data/SACTNmonthly_v4.0.RData") # load data

temps_KZNSB <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") # filter the src to be KZN


# extract the year from dates and calculate average-----------------


temps_mo <- temps_KZNSB %>% # create new object
  mutate(yr = year(date), # separate year from date, mutate creates                               new columns
         mo = month(date)) %>%  # separate month from date
  group_by(site, mo) %>% # group the sites by year
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # calculate the                                     average temperature for each year
  mutate(mo = month.abb[as.numeric(mo)]) %>% # change labels of months                                             from numbers to words
  ungroup() # ungroup to clarify data
temps_mo


# plot the data on a graph ------------------------------------------


site_plot <- ggplot(temps_mo_arr, aes(x = mo, y = mean_temp)) +
  geom_line(aes(group = site, colour = "purple")) + # line graph, select colour
  theme(axis.text.x = element_text(angle = 90)) + #rotate axes
  scale_x_discrete(limits = c("Jan","Feb","Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")) +
  facet_wrap(~site, ncol = 5) + # create facets with 5 in each column
  labs(x = "Month", y = "Temperature (°C)", title = "KZNSB: series of monthly means") # create labels
site_plot #run object



# Task 3: the datasets::ToothGrowth data -----------------------------

# load library

library(dplyr)

# load dataset

ToothGrowth <- datasets::ToothGrowth
summary(ToothGrowth)


# begin plotting

tooth_growth <- ToothGrowth %>% 
  group_by(supp,dose) %>%
  summarize(lenmean=mean(len), lensd=sd(len), count = n())

print(toothgrowth)

# create facets

final_plot <- ggplot(tooth_growth, aes(x = dose, y = lenmean, colour = supp)) +
  geom_line() + # line graph, select colour
  labs(x = "Dose (mg)", y = "Mean Tooth Length (mm)", title = "Mean Tooth Growth", colour = "Supplement") # create labels
final_plot #run object



# Task 4: the datasets::ToothGrowth data, continued -----------------------

# load dataset

ToothGrowth <- datasets::ToothGrowth
summary(ToothGrowth)

# plot boxplots

box_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp)) + # fill with supps colour to distinguish
  facet_wrap(~supp, ncol = 2) + # use facet wrap to display supp plots next to each other
  labs(x = "Dose (mg)", y = "Tooth Length (mm)")
box_1



# Task 5: the datasets::ToothGrowth data, continued again -----------------

# load dataset

ToothGrowth <- datasets::ToothGrowth
summary(ToothGrowth)

tooth_growth <- ToothGrowth %>% 
  group_by(supp,dose) %>%
  summarize(lenmean = mean(len), lensd = sd(len))

# plot histogram

bar_2 <- ggplot(tooth_growth, aes(x = dose, y = lenmean, fill = supp)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(tooth_growth, mapping = aes(ymin = lenmean - lensd, ymax = lenmean + lensd),
                width = 0.1, position = position_dodge(0.4)) +
  labs(x = "Dose (mg)", y = "Tooth Length (mm)")
bar_2



