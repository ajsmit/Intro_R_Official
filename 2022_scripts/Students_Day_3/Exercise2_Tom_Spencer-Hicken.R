
# Task 1 ------------------------------------------------------------------

library(tidyverse)
library(lubridate)
library(ggpubr)

load("data/SACTNmonthly_v4.0.RData")

SACTN <- SACTNmonthly_v4.0
rm(SACTNmonthly_v4.0)

mean_KZNSB <- SACTN %>% 
  filter(src == "KZNSB") %>% 
  select(-depth, -type) %>% 
  mutate(year = year(date)) %>% 
  group_by(site, year) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE))

mean_KZNSB

ggplot(mean_KZNSB, aes(x = year, y = mean_temp)) +
  geom_line(colour = "red") +
  facet_wrap(~site, ncol = 5, nrow = 10) +
  labs(title = "KZNSB: series of annual means", x = "Year", y = "Temperature (°C)")

# Task 2 ------------------------------------------------------------------

library(dplyr)

month_new <- SACTN %>% 
  filter(src =="KZNSB") %>% 
  select(-depth, -type) %>% 
  mutate(month = month(date, label = TRUE)) %>% 
  group_by(site, month) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% 
  ungroup()

ggplot(month_new, aes(x = month, y = mean_temp)) +
  geom_point(size = .5) +
  geom_line(colour = "red") +
  facet_wrap(~site, ncol= 5, nrow = 10) +
  labs(x = "Month", y = ("Temperature (C^O)"))

  
  

# Task 3 ------------------------------------------------------------------

ToothGrowth <- datasets::ToothGrowth

TG2 <- ToothGrowth %>% 
  group_by(supp, dose) %>% 
  summarise(mean_len = mean(len))

ggplot(data = TG2, aes(x = dose, y = mean_len, colour = supp)) +
  geom_point() +
  geom_line() + 
  theme_bw() + 
  labs(x = "Dose (mg/day)", y = "Tooth Length", colour = "Supplement Type")


ggplot(data = TG2, aes(x = dose, y = mean_len, colour = supp)) +
  geom_point() +
  geom_line() +
  facet_wrap(~supp) + 
  theme_bw() + 
  labs(x = "Dose (mg/day)", y = "Tooth Length", colour = "Supplement Type")

# Task 4 ------------------------------------------------------------------

ggplot(ToothGrowth, aes(x = dose, y = len, fill = supp)) + 
  geom_boxplot(aes(group = dose)) +
  facet_wrap(~supp, ncol = 2) +
   theme_bw() +
  labs(x = "Dose (mg/d)", y = "Tooth Length", fill = "Supplement Type")


# Task 5 ------------------------------------------------------------------

ToothGrowth <- datasets::ToothGrowth

ToothGrowth2 <- ToothGrowth %>%
  group_by(supp, dose) %>% 
  mutate(mean_len = mean(len), 
            se = sd(len) / sqrt(n()),
            max = mean_len + se,
            min = mean_len - se) 
  

ggplot(ToothGrowth2, aes(x = dose, y = mean_len, fill = supp)) + 
  geom_bar(stat = "identity", color = "black", 
           position = position_dodge()) +
  geom_errorbar(aes(ymin = min, ymax = max), width = .3,
                position = position_dodge(.5)) +
  theme_bw() +
  labs(x = "Dose (mg/d)", y = "Mean Length", fill = "Supplement Type")

