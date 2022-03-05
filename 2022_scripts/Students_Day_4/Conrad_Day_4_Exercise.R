# Day_4.R
# Day 4 Exercise C
# Ammaarah Conrad
# Student number: 3947006
# 10 February 2022


# Task 1 ------------------------------------------------------------------

library(tidyverse)
library(ggpubr)
library(lubridate)

# load data
load("R files/intro_r_data/data/SACTNmonthly_v4.0")

# filter data so that only temperatures from the source KZNSB are present
KZNSB <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB")

# finding mean temperature for each year for each site
task_1 <- KZNSB %>% 
  mutate(year = floor_date(date, "year")) %>% 
  group_by(year, site) %>% 
  na.omit() %>% 
  summarise(avg = mean(temp))

# plotting faceted line graphs
graph_1 <- ggplot(task_1, aes(x = year, y = avg, colour = site)) +
  labs(x = "Year", y = "Temperature (°C)") +
  facet_wrap(~site,ncol = 5) +
  geom_line(aes(group = site), colour = "red") +
  theme_grey() 
graph_1


# Task 2 ------------------------------------------------------------------

# load data
load("R files/intro_r_data/data/SACTNmonthly_v4.0")

# filter data so that only temperatures from the source KZNSB are present
KZNSB <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB")

# finding mean temperature for each month for each site
task_2 <- KZNSB %>% 
  select(date, site, temp) %>% 
  mutate(date = as.Date(date, format = "%%y-%m-%d")) %>% 
  group_by(site, date) %>% 
  na.omit() %>% 
  summarise(avg = mean(temp))

# separating date column into three columns for day, month, and year.
KZNSB_2 <- task_2 %>% 
  mutate(day = lubridate::day(date), 
         month = lubridate::month(date),
         year = lubridate::year(date),
         month_abr = lubridate::month(date, label = TRUE, abbr = TRUE))
KZNSB_2

# plotting the monthly climatology onto faceted line graph
graph_2 <- ggplot(KZNSB_2, aes(x = month_abr, y = avg, colour = site)) +
  labs(x = "Month", y = "Temperature (°C)") +
  facet_wrap(~site,ncol = 5) +
  geom_line(aes(group = site), colour = "red") +
  theme_grey() 
graph_2


# Task 3 ------------------------------------------------------------------

# load data
ToothGrowth <- datasets::ToothGrowth

# plotting line graph
line_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len, colour = supp)) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_line(aes(group = supp)) +
  labs(x = "Dose (mg/day)", y = "Tooth length") +
  scale_colour_brewer(palette = "Spectral") +
  theme_dark()
line_1

# Task 4 ------------------------------------------------------------------

# load data
ToothGrowth <- datasets::ToothGrowth

box_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp)) +
  facet_wrap(~supp,ncol = 2) +
  labs(x = "Dose (mg/day)", y = "Tooth length")
box_1


# Task 5 ------------------------------------------------------------------ 

library(lattice)

# load data
ToothGrowth <- datasets::ToothGrowth

# plotting faceted double bar graph with errorbars
bg_1 <- ggplot(ToothGrowth, aes(x = dose, y = len, fill = supp)) +
  stat_summary(geom = "bar", fun = mean, position = "dodge") +
  stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge") + # includes errorbars
  labs(x = "Dose (mg/d)", y = "Tooth length (mm)") +
  scale_fill_manual(values = c("seagreen", "blue")) +
  theme_gray()
bg_1




