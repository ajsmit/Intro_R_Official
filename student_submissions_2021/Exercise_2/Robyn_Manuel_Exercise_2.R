# Script name: Exercise_Two
# Purpose: Howework
# Date: 17 March 2021
# Author: Robyn Manuel


install.packages("broom")
install.packages("ggpubr")
install.packages("ggpubr", type="binary")
install.packages("broom", type="binary")
install.packages("ggplot2")
library(broom)
library(ggpubr)
library(tidyverse)
library(lubridate)
library(dplyr)
library(ggplot2)
library(ggpubr)


load("data/SACTNmonthly_v4.0.RData")

# 1. The SACTNmonthly_v4.0.RData (A)

SACTN_2 <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>%
  mutate(year = year(date)) %>% 
  group_by(site, year) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE))

Yearly_Mean_Temp <- ggplot(data = SACTN_2, aes(x = year, y = mean_temp)) +
  geom_line(aes(group = site), colour = "salmon") + ggtitle("KZNSB:series of annual mean") +
  facet_wrap(~site, ncol = 5, nrow = 9) +
  theme_bw()+
  xlab("Year") + ylab("Temperature (dg)") +
  scale_x_continuous (breaks = c(1980, 2000)) + scale_y_continuous(breaks = c(20, 22, 24))

#2. The SACTNmonthly_v4.0.RData (B)

SACTN_3 <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>%
  mutate(year = year(date) +
         month = month(date)) %>% 
  group_by(site, month) %>% 
  summarize(mean_temp = mean(temp, na.rm = TRUE))


Monthly_Climatology <- ggplot(data = SACTN_3, aes(x = month, y = mean_temp)) +
  geom_line(aes(group = site), colour = "salmon") + ggtitle("KZNSB:series of monthly climatology") +
  facet_wrap(~site, ncol = 5, nrow = 9) +
  theme_bw() +
  xlab("Month") + ylab("Temperature (dg)") +
  scale_x_continuous (breaks = c(1, 12)) + scale_y_continuous(breaks = c(20, 22, 24))

#3. The ToothGrowth data (A)
 Tooth_growth <- datasets:: ToothGrowth

 Line_Graph <- ggplot(data = Tooth_growth, aes(x = dose, y = len)) +
   geom_smooth(aes(group = supp, col = supp), method = "lm") +
   ggtitle("A line graph showing the change of tooth length according to the change of vitamin C dose change") +
   xlab("Dose (milligrams/day)") + ylab("Tooth length")
   
   
# 4. The ToothGrowth data (B)
   Box_and_Whisker <- ggplot(ToothGrowth, aes(x = dose, y = len)) + 
     geom_boxplot(aes(group = supp), outlier.colour = "blue", outlier.shape = 8, 
                  fill = "grey", col = "black") +  ggtitle("Box and whiskers plot shoowing:the relationship of tooth length as a function of dose") +
     facet_wrap(~supp) +
     theme(axis.text.x = element_text(angle = 90, hjust = 1)) +   
     xlab("Dose (milligrams/day)") + ylab("Tooth Length") 
   

# 5. The ToothGrowth data (C)
   Tooth_growth_1 <- ToothGrowth %>% 
     group_by(supp, dose) %>% 
     summarise(mean_len = mean(len), 
              mean_len = c(6.8, 15, 33, 4.2, 10, 29.5))
   
   ggplot(data = Tooth_growth_1, aes(x = dose, y = mean_len)) +
     geom_bar(stat="identity", fill="steelblue", position=position_dodge())+
     theme_minimal() +
     ggtitle("Bar graph showing the relationship between tooth length and dose") +
     theme() +
     xlab("Dose (mg/day") + ylab("Mean tooth length")
   
   

?ToothGrowth
