#Exercise 2 :Task1-Task5
#Author: Lauryn Bull (3931496)
#Date: 13th February 2022

#Purpose: Manipulate and visualise data to produce figure and graphs
--------------------------------------------------------------------

#Task 1
# Load packages:
library(dplyr)
library(lubridate)
library(tidyverse)
library(ggpubr)
library(rmarkdown)

#Load data:
load("data/SACTNmonthly_v4.0.Rdata")

#Make the data a shorter name

SACTN <- SACTNmonthly_v4.0

#Filter out data for the src KZNSB in the SACTNmonthly datasheet:
KZNSB <- SACTN %>%                   #Filter out data from  site select function into sites
  dplyr::filter(src == "KZNSB")

KZNSB_1 <- KZNSB %>%
  mutate(year = floor_date(date, "year")) %>% #mutate function is used 
  group_by(year, site) %>%
  na.omit() %>%
  dplyr::summarise(avg_temp = mean(temp))

Line_1 <- ggplot(data = KZNSB_1, aes(x = year, y = avg_temp, colour = site)) +
  geom_line(aes(group = site), show.legend = FALSE) +
  facet_wrap(vars(site), ncol = 5) + 
  labs(x = "Years", y = "Temperature (°C)", colour = "Site") +
  theme(legend.position = "none")
Line_1

--------------------------------------------------------------------
#Task 2:

#Load data:
load("data/SACTNmonthly_v4.0.Rdata")

#Make the data a shorter name

SACTN <- SACTNmonthly_v4.0

#Filter out data for the src KZNSB in the SACTNnmonthly datasheet:
KZNSB <- SACTN %>%                   #Filter out data from  site select function into sites
  dplyr::filter(src == "KZNSB")

KZNSB_1 <- KZNSB %>%
  mutate(date = as.Date(date, format = "%m/%d/%y")) %>%     #mutate function is used 
  group_by(date, site) %>%
  na.omit() #
KZNSB_1

Line_1 <- ggplot(data = KZNSB_1, aes(x = date, y = temp, colour = site)) +
  geom_line(aes(group = site), show.legend = FALSE) +
  facet_wrap(vars(site), ncol = 5) + 
  labs(x = " Months", y = "Temperature (°C)", colour = "Site") +
  theme(legend.position = "none")
Line_1

---------------------------------------------------------------------  
#Task 3:

#Load data:--------------------------------------------------------

ToothGrowth <- datasets::ToothGrowth

#Produce line graphs

lm_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len, colour = supp)) +
  geom_line() +
  labs(x = "Dose (mg)", y = "Tooth length (mm)") +
scale_colour_brewer(palette = "Set2")
lm_1

------------------------------------------------------------------------
#Task 4:

#Produce Box and whisker graphs:----------------------------------

box_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp)) +
  facet_wrap(~supp, ncol = 2) +   #The graphs become placed in different facets
  labs(x = "Dose (mg)", y = "Tooth length (mm)")      #Change axes labels 
box_1

-------------------------------------------------------------------------
#Task 5:
  
#Load packages:----------------------------------------------------------

library(lattice)

#Producing a histogram graph: --------------------------------------------

barplot_1 <- ggplot(ToothGrowth, aes(x = dose, y = len, fill = supp)) +      # ggplot2 barplot with error bars
  stat_summary(geom = "bar", fun = mean, position = "dodge") +
  stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge") +
  labs(x ="Dose (mg/d)", y = "Tooth Length (mm)") +               #Changing axis titles 
  scale_fill_manual(values = c('purple','orange')) +      #changing the colour of bars can be done manually by picking colours
  theme_classic()
barplot_1
----------------------------------------------------------------------------------

  
  
  