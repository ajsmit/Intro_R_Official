# Lindokuhle_Sibisi_Exercise_2.R
# R Training Day 3
# Exersice 2
# 18 March 2021
# AJ Smit


library(tidyverse)
library(lubridate)
library(ggpubr)



1.
# Load the SACTNmonthly_v4.o
("~/INTRO_R/SACTNmonthly_v4.0.RData")

KZNSB_sub1 <- SACTNmonthly_v4.0 %>%
 mutate(year = year(date)) %>%
  filter(src == "KZNSB") %>%
  group_by(site, year) %>% 
  summarise (mean_temp = (mean(temp, na.rm = TRUE)))

ggplot(data = KZNSB_sub1, aes(x = year, y = mean_temp, colour = "red")) +
  geom_line() +
facet_wrap(~site, ncol = 5)


2.
# Load the SACTNmonthly_v4.o
("~/INTRO_R/SACTNmonthly_v4.0.RData")

KZNSB_sub1 <- SACTNmonthly_v4.0 %>%
  mutate(yr = year(date), mo = month(date)) %>%
  filter(src == "KZNSB") %>%
  group_by(site, mo) %>% 
  summarise (mean_temp = (mean(temp, na.rm = TRUE)))

ggplot(data = KZNSB_sub1, aes(x = mo, y = mean_temp, col = "red")) +
  geom_line() +
  facet_wrap(~site, nrow = 9)
  labs(x = "Year",y = "Temperature(degree celcius)" , 
       title = "KZNSB: series of monthly means") + 
  theme_bw()


3.
# Load the ToothGrowth data
datasets::ToothGrowth

# Basic line plot with points
ggplot(data = ToothGrowth, aes(x = dose, y = len, colour = supp)) +
  geom_smooth(method = "lm")



4.
# Load the ToothGrowth data
datasets::ToothGrowth

# Basic box-and-whisker graph

range(ToothGrowth)
unique(supp)
tail(ToothGrowth)
max(supp)

# box and whisker
ToothGrowth %>%

  ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = dose)) +
  facet_wrap(~supp, ncol = 2)



# plot of tooth length vs. dose levels compared by supplement type

ToothGrowth$dose <- as.factor(ToothGrowth$dose)                 # change 'dose' from numeric to factor
levels(ToothGrowth$supp) <- c("OrangeJuice", "Vitamin C")       # rename levels of supplement type
library(ggplot2)
ggplot(ToothGrowth, aes(x = dose, y = len)) + geom_boxplot(aes(fill = dose)) + xlab("Dose in milligrams/day") + 
  ylab("Tooth length") + facet_grid(. ~ supp) + theme(plot.title = element_text(size = 16, face = "bold")) +
  theme(axis.title.x = element_text(size = 12, face = "bold"), axis.text.x = element_text(size = 10)) + 
  theme(axis.title.y = element_text(size = 12, face = "bold"), axis.text.y = element_text(size = 10)) + 
  theme(strip.text = element_text(size = 12, color = "blue", face = "bold.italic")) + 
  ggtitle("Tooth length vs. Dose levels:\nComparison by supplement type")



5.




















  
  

  


