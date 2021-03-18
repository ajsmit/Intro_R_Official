# Day_3
# Exercise 2
# CJ Larey
# 17 March 2021

# 1. The_SACTN_monthly_v4.0.R.Data_(A)

load(file= "data/SACTNmonthly_v4.0.RData")
summary(SACTNmonthly_v4.0)
head(SACTNmonthly_v4.0)
library(tidyverse)
library(lubridate)
library(dplyr)
library(knitr)
library(ggpubr)
library(ggplot2)

# filter data 

 SACTN_1 <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>% 
  mutate(yr = year(date)) %>% 
  group_by(site, yr) %>%
  summarise(mean_temp =mean(temp, na.rm = TRUE))
  
# line graph for sites in KZNSB 
 
 ggplot(SACTN_1, aes(x = yr, y = mean_temp)) +
   geom_line(aes(group = site), colour = "red") + 
   facet_wrap(~site, ncol = 5) + 
   labs(x = "Year", y = "Temperature (°C)", 
        title = "KZNSB: series of annual means") +
   scale_y_discrete(limit = c(20, 22, 24)) +
   scale_x_discrete(limit = c(1980, 2000))
 
 # 2.The_SACTN_monthly_v4.0.R.Data (B)
 
 library(tidyverse)
 library(lubridate)
 library(dplyr)
 
 SACTN <- load("SACTNmonthly_v4.0.RData")
 
 SACTN_2 <- SACTNmonthly_v4.0 %>% 
   filter(src == "KZNSB") %>% 
   mutate(mo = month(date)) %>% 
   group_by(site, mo) %>%
   summarise(mean_temp =mean(temp, na.rm = TRUE)) %>%
   ungroup()
 
 # line graph for the monthly climate in sites of KZNSB
 
 ggplot(SACTN_2, aes(x = mo, y = mean_temp)) + 
   geom_line(aes(group = site), colour = "red") + 
   facet_wrap(~site, ncol = 5) + 
   labs(x = "Months", y = "Temperature (°C)", 
        title = "Monthly Climatology of KZNSB") +
   scale_x_discrete(limit = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)) +
   scale_y_discrete(limit = c(20, 22, 24)) 
   
   
 # 3. The Tooth_Growth data (A)
   
   toothg <- datasets::ToothGrowth
   
 # line graph that shows both supplements on one graph   
   ggplot(toothg, aes(x = dose, y = len)) +
     geom_line(aes(group = supp, colour = supp)) +
     labs(x = "Dose(mg/d)",y = "Tooth length (mm)")
   
 # 4. The Tooth_Growth data (B)
   
   toothg <- datasets::ToothGrowth
   
 # line graph that shows the supplements on different graphs   
   ggplot(toothg, aes(x = dose, y = len, colour = supp)) +
      geom_boxplot() +
      facet_wrap(~supp, ncol = 2) +
      labs(x = "Dose(mg/d)",y = "Tooth length (mm)")    
   
 # 5. The Tooth_Growth data (C)
   
   toothg <- datasets::ToothGrowth
   
# bar graph without the error bars
   ggplot(toothg, aes(x = dose, y = len)) +
      geom_col(aes(fill = supp), position = "dodge") +
      labs(x = "Dose(mg/d)",y = "Tooth length (mm)")
   
# bar graph with the error bars
   
   test1 <- toothg %>% 
     group_by(dose) %>% 
      summarise(mn.ln = mean(len),
                sd.ln = sd(len))
   test1
   test2 <- ggplot(test1, aes(x = dose, y = mn.ln, fill = supp)) +
      geom_col(aes(fill = supp), position = "dodge") +
      labs(x = "Dose(mg/d)",y = "Tooth length") +
      geom_errorbar(aes(ymin = mn.ln-sd.ln,
                        ymax = mn.ln + sd.ln),
                    position = "dodge", width = 2, colour = "black")
   
   test3 <- ggplot(toothg, aes(x = dose, y = mn.ln, fill = supp)) +
      geom_col(aes(fill = supp), position = "dodge") +
      labs(x = "Dose(mg/d)",y = "Tooth length") +
      geom_errorbar(aes(ymin = Mean-SE,
                        ymax = Mean+SE),
                    position = "dodge", width = 2, colour = "black")
   
   
   