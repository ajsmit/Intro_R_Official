# Emma Langtry
# 10 Feb 2022
# Day 3: Exercise C


# Task 1 ------------------------------------------------------------------

library(tidyverse)
library(ggpubr)
library(lubridate)

load("data/SACTNmonthly_v4.0.RData")

KZNSB <-  SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB")
  
yr_avg <- KZNSB %>%
  mutate(year = floor_date(date, "year")) %>%
  group_by(year, site) %>% 
  summarise(avg = mean(temp))

ggplot(yr_avg, aes(x = year, y = avg)) +
  geom_line(colour = "red") +
  facet_wrap(~site, ncol = 5)

# Task 2 ------------------------------------------------------------------

mo_avg <- KZNSB %>%
  mutate(month = floor_date(date, "month")) %>%
  group_by(month, site) %>% 
  summarise(avg = mean(temp))

ggplot(mo_avg, aes(x = month, y = avg)) +
  geom_line(colour = "red") +
  facet_wrap(~site, ncol = 5)

# Task 3 ------------------------------------------------------------------

tooth <- datasets::ToothGrowth

ggplot(tooth, aes(x = dose, y = len, colour = supp)) +
  geom_smooth() +
  labs(x = "Dosage (mg/day)", y = "Length (mm)") +
  theme_bw()

# Task 4 ------------------------------------------------------------------

ggplot(tooth, aes(group = dose, y = len)) +
  geom_boxplot() +
  facet_wrap(~supp) +
  theme_bw() +
  labs(x = "Dosage (mg/day)", y = "Length (mm)")

# Task 5 ------------------------------------------------------------------

toothsum <- tooth %>%
  group_by(len, supp, dose) %>%
  summarise(sd = sd(len))

ggplot(toothsum, aes(fill = supp, y = len, x = dose)) + 
  geom_bar(position = "dodge", stat = "identity") +
  labs(x = "Dosage (mg/day)", y = "Length (mm)")
