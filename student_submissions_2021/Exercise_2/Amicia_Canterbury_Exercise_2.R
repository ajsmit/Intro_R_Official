# Exercise 2
# Date: 17.03.2021
# Purpose: Creating ggplots and understanding the data 
# Author: Amicia Canterbury

library(tidyverse)
library(ggpubr)
library(ggplot2)
library(lubridate)

#TASK 1

load("R/R/Intro_R/SACTNmonthly_v4.0.RData")

SACTN_sub1 <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>% 
  mutate(yr = year(date)) %>% 
  group_by(site, yr) %>%
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>%
  ungroup()


ggplot(SACTN_sub1, aes(x= yr, y= mean_temp)) +
  geom_line(aes(group = site), col = "salmon", size = 1)+
  facet_wrap(~site, ncol = 5, nrow = 9) +
  labs(x = "Year", y = "Temperature (°C)", 
    title = "KZNSB: Series of annual means") +
  scale_x_continuous(breaks = c(1980, 2000)) +
  scale_y_continuous(breaks = c(20,22,24))
  

# TASK 2: 

SACTN_sub2 <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>% 
  mutate(yr = year(date),
         mo = month (date)) %>% 
  group_by(site, mo) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% 
  ungroup()

ggplot(SACTN_sub2, aes(x = mo, y = mean_temp)) +
  geom_line(aes(group = site), colour = "salmon", size = 1)+
  facet_wrap(~site, ncol = 5, nrow = 9)+
  labs(x = "Monthly", y = "Temperature(°C)", 
       title= "KZNSB: Series of annual means")+
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,12)) +
  scale_y_continuous(breaks = c(20,22,24))


# TASK 3: 

ToothGrowth <- datasets::ToothGrowth

ggplot(data = ToothGrowth, aes(x =dose , y = len, col = supp)) +
  geom_point() +
  geom_smooth( method = "lm") +
labs(x = "Dose (mg/d)", y = "Length (mm)", 
     title= "ToothGrowth: Line graph showing the relationship of
     tooth length as a function of dose.")

# TASK 4: 

ggplot(ToothGrowth, aes(x = dose, y = len, group = dose, 
                        col = supp))+
  geom_boxplot (outlier.colour = "lime green", outlier.shape = 8,
                outlier.size = 1)+
  facet_wrap(~supp, ncol = 2)+
  labs(x ="Dose (mg/d)", y = "Tooth length (mm)",
       title = "Boxplot representing the function of tooth length
       and dosage")

# TASK 5:

ToothGrowth_sub1 <- ToothGrowth %>% 
  group_by(dose, supp) %>% 
  summarise(mean_length = mean(len),
            sd_length = sd(len))

ggplot(ToothGrowth_sub1, aes(x = dose, y = mean_length, fill = supp))+
  geom_col(position = "dodge", col = "black")+ 
  geom_errorbar(aes(ymin = mean_length - sd_length,
                    ymax = mean_length + sd_length,
                    x = dose), position = position_dodge(0.45), width = 0.2)+
  labs(x = "Dose (mg/d)", y = "Total length (mm)", 
  title = "Histogram representing the function of tooth length
       and dosage.")
  

