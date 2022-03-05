# CJ Parenzee
# BCB744
# EXERCISE 2
# 10 FEBRUARY 2022


# TASK 1: -----------------------------------------------------------------

library(tidyverse)
library(lubridate)

load("data/SACTNmonthly_v4.0.RData")

unique(SACTNmonthly_v4.0$site)
unique(SACTNmonthly_v4.0$src)

temps_KZNSB <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB")

unique(temps_KZNSB$site)
unique(temps_KZNSB$temp)

AveTempsYear_KZNSB <- temps_KZNSB %>% 
  mutate(year = floor_date(date, "year")) %>% 
  group_by(site, year) %>% 
  na.omit() %>% 
  summarise(
    avg = mean(temp))


task_1<- ggplot(AveTempsYear_KZNSB, aes(x = year, y = avg, colour = site)) +
  labs(x = "Year", y = "Temperature (°C)") +
  geom_line(colour = "red") +
  facet_wrap(~site, ncol = 5)

task_1

# Task 2: -----------------------------------------------------------------

       
AveTempsMonth_KZNSB <- temps_KZNSB %>% 
  group_by(site, date) %>% 
  mutate(date = as.Date(date, format = "%%y-%m-%d")) %>% 
  na.omit() %>% 
  summarise(avg = mean(temp))


task_2 <- AveTempsMonth_KZNSB %>% 
  mutate(day = lubridate::day(date),
         month = lubridate::month(date),
         month_abr = lubridate::month(date, label = TRUE, abbr = TRUE),
         year = lubridate::year(date))


task_2_graph <- ggplot(task_2, aes(x = month_abr, y = avg, colour = site)) +
  labs(x = "Month", y = "Temperature (°C)") +
  geom_line(aes(group = site), colour = "red") +
  facet_wrap(~site, ncol = 5)

task_2_graph

# Task 3: ---------------------------------------------------------------

ToothGrowth <- datasets::ToothGrowth

line_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len, colour = supp)) + 
  geom_point() +
  geom_line() +
  geom_smooth(method = "lm") +
  labs(x = "Dose (mg/day)", y = "Tooth Length(mm)") +
  scale_colour_brewer(palette = "Dark2") + 
  theme(legend.position = "bottom")

line_1


# Task 4: -----------------------------------------------------------------



datasets::ToothGrowth

box_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp)) +
  labs( x = "Dose(mg/day", y = "Tooth Length(mm)")

box_1


# Task 5: -----------------------------------------------------------------

ToothGrowth %>% 
  summarise(
    sd = sd(len))
    
doublebar_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len, fill = supp)) +
  stat_summary(geom = "bar", fun = mean, positio = "dodge") +
  labs(x = "Dose (mg/d)", y = "Tooth Length (mm)") +
  stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge")

doublebar_1
