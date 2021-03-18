#Intro R workshop
#Exercise 2
#17 March 2021
#Emma Buckley (3832644)

#Task 1 The SACTNmonthly_v4.0.RData (A)

library(tidyverse)
library(lubridate)
library(dplyr)
library(ggplot2)

load("~/Intro_R/Intro_R/data/SACTNmonthly_v4.0.RData")
SACTN_sub1 <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>% 
  mutate(yr = year(date)) %>% 
  group_by(site, yr) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% 
  ungroup()

ggplot(SACTN_sub1, aes(x = yr, y = mean_temp)) +
  geom_line(aes(group = site), colour = "salmon", size = 1)+
  facet_wrap(~site, ncol = 5, nrow = 9) +
  labs(x = "Year", y = "Temperature (°C)",
       title = "KZNSB: Series of annual means")+
  scale_x_continuous(breaks = c(1980, 2000))+
  scale_y_continuous(breaks = c(20, 22, 24))
 

#Task 2:The SACTNmonthly_v4.0.RData (B)

SACTN_sub2 <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>%
  mutate(yr = year(date),
         mo = month (date)) %>% 
  group_by(site, mo) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% 
  ungroup()

ggplot(SACTN_sub2, aes(x = mo, y = mean_temp)) +
  geom_line(aes(group = site), colour = "salmon", size = 1)+
  facet_wrap(~site, ncol = 5, nrow = 9) +
  labs(x = "Monthly climatology", y = "Temperature (°C)",
       title = "KZNSB: Series of annual means")+
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10, 11, 12))+
  scale_y_continuous(breaks = c(20, 22, 24))

#Task 3: The ToothGrowth data (A)

ToothGrowth <- datasets::ToothGrowth

ggplot(data = ToothGrowth, aes(x = dose, y = len, col = supp)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Dose (mg/d)", y = "Tooth Length (mm)", 
       title = "A line graph showing the tooth length as a function of dose")
  

#Task 4: The ToothGrowth data (B)

ggplot(ToothGrowth, aes(x = dose, y = len, group = dose, col = supp)) +
  geom_boxplot (outlier.colour = "red", outlier.shape = 8, 
               outlier.size = 1) +
  facet_wrap(~supp, ncol = 2) +
  labs(x = "Dose(mg/d)", y = "Tooth Length (mm))" ,  
       title = "A box plot of the relationship of tooth length as a function of dose")

#Task 5: The ToothGrowth data (C)

ToothGrowth_sub1 <- ToothGrowth %>% 
  group_by(dose, supp) %>% 
  summarise(mean_length = mean(len),
            sd_length = sd(len))

ggplot(ToothGrowth_sub1, aes(x = dose,y = mean_length, fill = supp)) +
  geom_col(position = "dodge", col = "black") +
  geom_errorbar(aes(ymin = mean_length - sd_length, 
                    ymax = mean_length + sd_length, 
                    x = dose), position = position_dodge(0.45), width = 0.2) +
  labs(x = "Dose (mg/d)", y = "Total length (mm)") 

      
