#Intro_Workshop_Exercise_2
#17_March_2021
#Tyla_Noelle_Goldman(3837300) 

#running of needed packages:
library(tidyverse)
library(lubridate)
library(ggplot2)
library(ggpubr)
library(dplyr)

#Question_1:

load("data/SACTNmonthly_v4.0.RData") # data was loaded because the file contains R_data compared to a csv file or a file imbeded into R_studio.   

View(SACTNmonthly_v4.0) # observing data 
head(SACTNmonthly_v4.0)
tail(SACTNmonthly_v4.0)
summary(SACTNmonthly_v4.0)

SACTNMonthly1 <- SACTNmonthly_v4.0 %>%
  select(site, src, date, temp) %>%
  filter(src == "KZNSB") %>%
  mutate(year = year(date)) %>%
  group_by(site, year) %>%
  summarise(mean_temp = mean(temp, na.rm = TRUE))

View(SACTNMonthly1) # observing data
head(SACTNMonthly1)
tail(SACTNMonthly1)
summary(SACTNMonthly1)

ggplot(data = SACTNMonthly1, aes(x = year, y = mean_temp)) + 
  geom_line(aes(group = site, col = "red")) +
  facet_wrap(~site) +
  labs(x = "Year", y = "Temperature (°C)",
       title = "KZNSB: series of annual means") +
  theme(legend.position = "remove")  

#Question_2:

SACTNMonthly2 <- SACTNmonthly_v4.0 %>%
  select(site, src, date, temp) %>%
  filter(src == "KZNSB") %>%
  mutate(year = year(date), 
         month = month(date)) %>%
  group_by(site, month) %>%
  summarise(mean_temp = mean(temp, na.rm = TRUE))

view(SACTNMonthly2) # observing data
head(SACTNMonthly2)
tail(SACTNMonthly2)
summary(SACTNMonthly2)

ggplot(data = SACTNMonthly2, aes(x = month, y = mean_temp)) + 
  geom_line(aes(group = site, col = "red")) +
  facet_wrap(~site) +
  labs(x = "Month", y = "Temperature (°C)",
       title = "KZNSB: series of annual means") +
  theme(legend.position = "remove")  

#Question_3:

ToothGrowth <- datasets::ToothGrowth

view(ToothGrowth) # observing data  
head(ToothGrowth)
tail(ToothGrowth)
summary(ToothGrowth)

ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_point(aes(colour = supp)) +
  geom_smooth(method = "lm", aes(group = supp, colour = supp)) +
  labs(x = "Dose", y = "Length (cm)",
       title = "Graph showing toothgrowth by tooth length at particular dose of supplement")

#Question_4:

ggplot(data = ToothGrowth, aes(x = dose, y = len, group = dose, col = supp)) + #grouping of doses otherwise they appear as an overall boxplot 
  geom_boxplot(outlier.colour = "Green", outlier.shape = 4, outlier.size = 2) +
  facet_wrap(~supp, ncol = 2) +
  labs(x = "Dose", y = "Length (mm)",
       title = "Graph showing toothgrowth by tooth length at each particular dose of supplement")

#Question_5 

ToothGrowth_B <- ToothGrowth %>%
  group_by(dose, supp) %>%
  summarise(mean_len = mean(len),
            sd_len = sd(len))

view(ToothGrowth_B)
head(ToothGrowth_B)
tail(ToothGrowth_B)
summary(ToothGrowth_B)

ggplot(data = ToothGrowth_B, aes(x = dose, y = mean_len, fill = supp)) +
  geom_col(position = "dodge", col = "black") +
  geom_errorbar(aes(ymin = mean_len - sd_len,
                    ymax = mean_len + sd_len,
                    x = dose), position = position_dodge(0.45), width = 0.2) +
  labs(x = "Dose (mg/d)", y = "Total length (mm)", 
       title = "Comparative colomn graph comparing dosage of various supplements VS toothlength")

--------------------------------------------------------------------------------  
  