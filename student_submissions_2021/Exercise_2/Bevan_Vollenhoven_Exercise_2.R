#Exercise 2
#Bevan Vollenhoven (3840572)
# 17 March

library(tidyverse)
library(ggplot2)
library(lubridate)
library(ggpubr)

load("Data/SACTNmonthly_v4.0.RData")

view(SACTNmonthly_v4.0)
head(SACTNmonthly_v4.0)
tail(SACTNmonthly_v4.0)

#1. #Question 1:The SACTmonthly_v4.0RDATA(A) 
#The annual mean temperature of each location within KZN

sactn_stats <-  SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>% 
  mutate(year = year(date)) %>%  #mutated the data to show the years
  group_by(site, year) %>% #the isolate the site and year data as we only have monthly data
  summarise(mean_temp = mean(temp, na.rm = TRUE))  #there was missing data that needed to be omitted
#data is now filtered to sow annual temperature per year, per location rather than per month
glimpse(sactn_stats)
view(sactn_stats)

ggplot(data = sactn_stats, aes(x = year, y = mean_temp)) +
  geom_line(aes(group = site), col = "orange") +
  facet_wrap(~site, ncol = 5, nrow = 9) + #separates by site
  labs(x = "Year", y = "Temperature (°C)", title = "KZNSB: series of annual means") +
  scale_x_continuous(breaks = c(1980, 2000)) + 
  scale_y_continuous(breaks = c(20 ,22 , 24)) #show specific values on the axis

#2. Question 2: The SACTmonthly_v4.0RDATA(B)
#Monthly mean temperature plot of all locations
sactn_stats2 <-  SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>% 
  mutate(month = month(date)) %>%  #mutated the data to show the years
  group_by(site, month) %>% #the isolate the site and year data as we only have monthly data
  summarise(mean_temp = mean(temp, na.rm = TRUE))

head(sactn_stats2)
view(sactn_stats2)

ggplot(data = sactn_stats2, aes(x = month, y = mean_temp)) +
  geom_line(aes(group = site), col = "purple",) +
  facet_wrap(~site, ncol = 5, nrow = 9) + #separates by site
  labs(x = "Month", y = "Temperature (°C)", title = "KZNSB: series of monthly mean temperature") +
  scale_x_continuous(breaks = c(3, 6, 9)) + 
  scale_y_continuous(breaks = c(20 ,22 , 24))

#3. Question 3: The toothGrowth data (A)
#The graphical representation of the influence the dosage has on 
#tooth growth with respect to each supplement

toothgrowth <- datasets::ToothGrowth

view(toothgrowth)
head(toothgrowth)

ggplot(data = toothgrowth, aes(x = dose, y = len)) +
  geom_point(aes(colour = supp)) +
  geom_smooth(method = "lm", aes(group = supp, colour = supp)) + #linear method enabled to show the linear relationship between dosage and length
  labs(x = "Dose", y = "Length", title = "Tooth length as a function of dosage")

#4. Question 4: The ToothGrowth data (B)
#A box plot that shows the relation of dosage and tooth length 

ggplot(data = toothgrowth, aes(x = dose, y = len, group = dose, "black" = supp)) + #grouping together different dosages
  geom_boxplot(fill = "green", alpha = 0.2, outlier.colour = "Black", outlier.shape = 10, outlier.size = 1) +
  facet_wrap(~supp, ncol = 2) +
  labs(x = "Dose (mg/d)", y = "Length (mm)", title = "Boxplot displaying toothlength as a function of dosage" )

#5. Question  5: The ToothGrowth data (C)
#A histogram comparing the relationship of length with dosage in the context
#of two types of supplements
toothgrowth2 <- ToothGrowth %>% 
  group_by(dose, supp) %>% 
  summarise(mean_len = mean(len),
            sd_len = sd(len))

head(toothgrowth2)  
tail(toothgrowth2)

ggplot(data = toothgrowth2, aes(x = dose, y = mean_len, fill = supp)) +
  #fill = supp, assigns the bar colours to their respective sups
  geom_col(position = "dodge", colour = "black") +
  #geom_dodge preserves vertical position of the column while adjusting 
  #horizontal position. 
  geom_errorbar(aes(ymin = mean_len - sd_len,
                    ymax = mean_len + sd_len,
                    x = dose), position = position_dodge(0.5), width = 0.2) + 
  #position_dodge(..) specifies how far away from the original vertical center point
  labs(x = "Dose (mg/d)", y = "Length (mm)", title = "Histogram of Length as a dunction of dosage")














  
      



  



  
