#Intro R course Day 3 Exercise 2
#Jesse Phillips
#17/03/2021

#load packages
library(tidyverse)
library(lubridate)
library(dplyr)


#TASK 1: SACTNmonthly_v4.0.RData (A)

load("data/SACTNmonthly_v4.0.RData")
SACTN <- SACTNmonthly_v4.0

SACTN_yr <- SACTN %>%  
  filter(src == "KZNSB") %>% 
  mutate (yr = year(date)) %>%  
  group_by(site, yr) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>%   
  ungroup()

ggplot(SACTN_yr, aes(yr, mean_temp)) +
  geom_line(size = 0.9, col = "Salmon") + 
  facet_wrap(~site, ncol = 5, nrow = 9) + 
  labs(x = "Year", y = "Temperature (°C)", title = "KZNSB: series of annual means") +
  scale_x_continuous(breaks = c(1980, 2000)) +
  scale_y_continuous(breaks = c(20, 22, 24))
  


#TASK 2: SACTNmonthly_v4.0.RData (B)

SACTN_mo <- SACTN %>%  
  filter(src == "KZNSB") %>% 
  mutate (mo = month(date)) %>%  
  group_by(site, mo) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>%   
  ungroup()

ggplot(SACTN_mo, aes(mo, mean_temp)) +
  geom_line(size = 0.9, col = "Salmon") + 
  facet_wrap(~site, ncol = 5, nrow = 9) + 
  labs(x = "Month", y = "Temperature (°C)", title = "KZNSB: monthly climatology") +
  scale_x_continuous(breaks = c(3, 8), labels = c("March", "August")) +
  scale_y_continuous(breaks = c(20, 22, 24))


#TASK 3: ToothGrowth data (A)

tooth <- datasets::ToothGrowth

ggplot(tooth, aes(dose, len, colour = supp)) + 
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Dose (mg/d)", y = "Tooth Length (mm)", 
       title = "Tooth length under varying levels of orange juice (OJ)\n or ascorbic acid (VC)",
       colour = "Supplement") +
  theme_bw() +
  theme(legend.position = c(1,0), legend.justification = c(1,0),
        axis.title.x = element_text(size = 12, face = "bold"),
        axis.title.y = element_text(size = 12, face = "bold"))


#TASK 4: ToothGrowth data (B)

ggplot(tooth, aes(dose, len, group = dose, fill = supp)) +
  geom_boxplot(show.legend = FALSE) +
  facet_wrap(~supp, ncol = 2) +
  labs(x = "Dose (mg/d)", y = "Tooth Length (mm)", 
       title = "Tooth length under varying levels of orange juice (OJ)\n or ascorbic acid (VC)") +
  theme_bw() +
  theme(axis.title.x = element_text(size = 11, face = "bold"),
        axis.title.y = element_text(size = 11, face = "bold"))


#TASK 5: ToothGrowth data (C)

tooth_means <- tooth %>% 
  group_by(dose, supp) %>% 
  summarise(mean_length = mean(len),
            sd_length = sd(len)) %>% 
  ungroup()

ggplot(tooth_means, aes(dose, mean_length, fill = supp)) +
  geom_col(position = "dodge", col = "black", width = 0.2) +
  geom_errorbar(aes(ymin = mean_length - sd_length,
                    ymax = mean_length + sd_length,
                    x = dose), position = position_dodge(0.2), width = 0.1) +
  labs(x = "Dose (mg/d)", y = "Tooth length (mm)", fill = "Supplement") +
  theme_bw() +
  theme(axis.title.x = element_text(size = 11, face = "bold"),
        axis.title.y = element_text(size = 11, face = "bold"))
