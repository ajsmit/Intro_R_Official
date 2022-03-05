# Intro R Day Four: Exercise 2
# Author: Dahraan du Toit
# Date: 10 Feb 2022
# The following script concerns the analyses of temperature data and, separately
# tooth growth data


# load packages -----------------------------------------------------------

# the below package contains a number of functions related to statistical 
# science and the graphical representations thereof
library(tidyverse)
# the below package contains a number of functions related to interpreting
# date-based data
library(lubridate)
#  the below package contains functions relating to data manipulation
library(dplyr)
# the below package concerns scales and presentation of data
library(scales)



# load data ---------------------------------------------------------------

# the below command loads the necessary data and declares it as a new
# environment object
load("data/SACTNmonthly_v4.0.RData")


# analysing data ----------------------------------------------------------


##TASKS 1 AND 2
# the below command filters the data to only include observations from the
# indicated source
sactn_new <- SACTNmonthly_v4.0 %>%
  filter(src == "KZNSB")

# the below command calculates the average temperature year on year and declares
# a new data set
sactn_means <- sactn_new %>%
  mutate(year = year(date)) %>% 
  group_by(year, site) %>% 
  dplyr::summarise(mean_temp = mean(temp, na.rm = TRUE)) %>%
  select(site, year, mean_temp)

# the below command calculates the average temperature on a monthly basis 
# and declares a new data set
sactn_month_means <- sactn_new %>%
  mutate(month = month(date)) %>% 
  group_by(month, site) %>% 
  dplyr::summarise(mean_temp = mean(temp, na.rm = TRUE)) %>%
  select(site, month, mean_temp)

# the below command generates a series of line graphs segregated by site. The
# independent variable is year, the dependent variable is temperature
ggplot(sactn_means, aes(x = year, y = mean_temp)) +
  geom_line(colour = "salmon") +
  labs(x = "Year", y = "Temperature (°C)", title = "KZNSB: series of annual means") +
  facet_wrap(~site, ncol = 5)

# the below command generates a series of line graphs segregated by site. The
# independent variable is month, the dependent variable is temperature. The
# numerical x-axis labels are replaced with an ordered series of months, with
# these labels altered in order to facilitate ease of perception.
ggplot(sactn_month_means, aes(x = month, y = mean_temp)) +
  geom_line(colour = "blue") +
  labs(x = "Month", y = "Temperature (°C)", title = "KZNSB: series of monthly climatologies") +
  facet_wrap(~site, ncol = 5) +
  scale_x_discrete(limits = month.abb) +
  theme(axis.text.x=element_text(angle=60, hjust=1))


# Task 3, 4 and 5 ------------------------------------------------------------

# load data ---------------------------------------------------------------

# The below command loads and declares a new data set for the purposes of the 
# analysis
ToothGrowth <- datasets::ToothGrowth


# manipulate data ---------------------------------------------------------

# The below command calculates a mean, standard deviation, n value, and
# standard error for the data set
ToothGrowth_2 <- ToothGrowth %>%
  group_by(supp, dose) %>% 
  mutate(sd = sd(len),
         mean = mean(len),
         n = n(),
         se = sd(len) / sqrt(n))

# The below command changes the "dose" variable from a numerical value to a 
# factor variable
ToothGrowth_2$dose <- factor(ToothGrowth_2$dose)


# The below commands generates a line graph showing the relationship between 
# supplement dosage and tooth length. The independent variable is dosage in 
# milligrams per day, the dependent variable is length in millimetres, and a
# linear regression is generated to show the relationship between these two 
# values
ggplot(data = ToothGrowth, aes(x = dose, y = len, colour = supp)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Dose (mg/day)", y = "Mean Tooth Length (mm)", colour = "Supplement\nType", title = 
         "Line Graph showing relationship between supplement dosage and tooth length")

# The below commands generates a line graph showing the relationship between 
# supplement dosage and mean tooth length. The independent variable is dosage in 
# milligrams per day, the dependent variable is mean length in millimetres.
ggplot(data = ToothGrowth_2, aes(x = dose, y = mean, colour = supp)) +
  geom_point() +
  geom_line(aes(group = supp)) +
  labs(x = "Dose (mg/day)", y = "Mean Tooth Length (mm)", colour = "Supplement\nType", title = 
         "Line Graph showing relationship between supplement dosage and mean tooth length\nper supplement type")

# The below command generates a pair of faceted box-and-whisker plots that show
# the relationship between supplement dosage and tooth length. The independent 
# variable is dosage in milligrams per day, the dependent variable is length in 
# millimetres and data is segregated based on supplement type
ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp, group = dose)) +
  facet_wrap(~supp, ncol = 2) +
  labs(x = "Dose (mg/day)", y = "Tooth Length (mm)", fill = "Supplement\nType",
       title = "Box Plot showing relationship between supplement dosage and tooth length")

# The below command generates a bar graph showing the relationship between
# supplement dosage and tooth length. The independent variable is dosage in
# milligrams per day, the dependent variable is tooth length in millimetres, the
# data is segregated based on supplement type, and the standard deviation of the
# data set is represented by sets of error bars placed above the measured 
# variables
ggplot(data = ToothGrowth_2, aes(x = dose, y = mean, ymin = mean - sd, 
                                 ymax = mean + sd, fill = supp)) + 
  geom_bar(colour = "black", stat = "identity", position = "dodge", width = 0.4) +      	
  geom_errorbar(colour = "black", stat = "identity", 
                position = position_dodge(0.4), width = 0.2) + 
  labs(x = "Dose (mg/d)", y = "Tooth length (mm)", fill = "Supplement\nType",
       title = "Bar Graph showing relationship between supplement dosage and tooth length")
