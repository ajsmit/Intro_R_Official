# Introduction to R Day # Assessment
#Author: Viwe Mabongo
# Day: 18 March 2021
#Exercise 2

# Load libraries
library(tidyverse)
library(ggpubr)
library(lubridate)
#1
KZNSB_sub1 <- SACTNmonthly_v4.0 %>% 
  mutate(year = year(date)) %>%
  filter(src == "KZNSB") %>% 
  group_by(site, year) %>% 
  summarise(mean_temp = (mean(temp, na.rm = TRUE)))

ggplot(data = KZNSB_sub1, aes(x = year, y = mean_temp, col = "red")) +
  geom_line() +
  facet_wrap(~site, ncol = 5) +
  labs(x ="Year", y ="Temperature (degree celcius)",     
       title = "KZNSB:series of annual means") +
  theme_bw() # Creating graphs showing KZNSB:series of annual means 
#2
KZNSB_sub1 <- SACTNmonthly_v4.0 %>% 
mutate(yr = year(date),
         mo= month(date)) %>% 
filter(src == "KZNSB") %>%
group_by(site, mo) %>%
summarise(mean_temp = mean(temp, na.rm = TRUE))


ggplot(data = KZNSB_sub1, aes(x = mo, y = mean_temp, col = "red")) +
  geom_line() +
  facet_wrap(~site, nrow = 9) +
  labs(x ="Year", y ="Temperature (degree celcius)",     
       title = "KZNSB:series of monthly means") +
  theme_bw() #Creating a graphs showing KZNSB:series of monthly means.

#3
datasets::ToothGrowth

ToothGrowth$dose <- as.factor(ToothGrowth$dose)

levels(ToothGrowth$supp) <- c("OrangeJuice", "Vitamin C")
library(ggplot2)
#Plot showing the line graph
ggplot(ToothGrowth, aes(x = dose, y = len)) + geom_line(aes(fill = dose)) + xlab("Dose in milligrams/day") + 
  ylab("Tooth length") + facet_grid(. ~ supp) + theme(plot.title = element_text(size = 16, face = "bold")) +
  theme(axis.title.x = element_text(size = 12, face = "bold"), axis.text.x = element_text(size = 10)) + 
  theme(axis.title.y = element_text(size = 12, face = "bold"), axis.text.y = element_text(size = 10)) + 
  theme(strip.text = element_text(size = 12, color = "blue", face = "bold.italic")) + 
  ggtitle("Tooth length vs. Dose levels:\nComparison by supplement type")

#4
datasets::ToothGrowth

ToothGrowth$dose <- as.factor(ToothGrowth$dose)

levels(ToothGrowth$supp) <- c("OrangeJuice", "Vitamin C")
library(ggplot2)
#Ploting the box and whisker graph 
ggplot(ToothGrowth, aes(x = dose, y = len)) + geom_boxplot(aes(fill = dose)) + xlab("Dose in milligrams/day") + 
  ylab("Tooth length") + facet_grid(. ~ supp) + theme(plot.title = element_text(size = 16, face = "bold")) +
  theme(axis.title.x = element_text(size = 12, face = "bold"), axis.text.x = element_text(size = 10)) + 
  theme(axis.title.y = element_text(size = 12, face = "bold"), axis.text.y = element_text(size = 10)) + 
  theme(strip.text = element_text(size = 12, color = "blue", face = "bold.italic")) + 
  ggtitle("Tooth length vs. Dose levels:\nComparison by supplement type")
          


