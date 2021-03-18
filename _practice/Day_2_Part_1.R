# Date: 16 March 2021
# Author: AJ Smit
# Purpose: continuing Intro R course, Day2
# # Objective: An R  workflow

library(tidyverse)
library(ggplot2)
laminaria <- read_csv("data/laminaria.csv") # works for real CSV files
# laminaria <- read_delim("data/laminaria.csv", delim = ";") # if faile has semi-colons
head(laminaria, n = 9)

tail(laminaria, n = 2)
glimpse(laminaria)

laminaria_sub1 <- laminaria %>%
  select(site, stipe_diameter)
glimpse(laminaria_sub1)

laminaria_sub2 <- laminaria %>%
  select(-Ind)
glimpse(laminaria_sub2)

laminaria_sub3 <- laminaria %>% 
  filter(site == "Kommetjie")
glimpse(laminaria_sub3)

laminaria_sub4 <- laminaria %>%
  select(site, stipe_diameter) %>% 
  filter(site == "Kommetjie")

laminaria %>%
  select(site, stipe_diameter) %>% 
  filter(site == "Kommetjie") %>% 
  nrow()

laminaria %>%
  filter(total_length == max(total_length))

# calculate the mean 'total_length' of ALL kelps across
# ALL sites
laminaria %>% 
  summarise(mean_total_length = mean(total_length),
            mean_blade_thickness = mean(blade_thickness))

# calculate the mean 'total_length' of ALL kelps across
# PER each of the inidvidual site
laminaria_stats1 <- laminaria %>%
  group_by(site) %>% 
  summarise(mean_total_length = round(mean(total_length), 2),
            SD_total_length = sd(total_length),
            mean_blade_thickness = round(mean(blade_thickness), 2),
            SD_blade_thickness = sd(blade_thickness))

# barplots
laminaria_stats2 <- laminaria %>%
  group_by(site) %>% 
  summarise(mean_total_length = round(mean(total_length), 2),
            SD_total_length = sd(total_length))

ggplot(data = laminaria_stats2) +
  geom_col(aes(x = site, y = mean_total_length), fill = "red", col = "black") +
  geom_errorbar(aes(ymin = mean_total_length - SD_total_length,
                    ymax = mean_total_length + SD_total_length,
                    x = site),
                col = "black",
                width = 0.2) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  xlab("Site") + ylab("Total length (cm)")

# the boxplot
ggplot(data = laminaria, aes(x = site, y = total_length)) +
  geom_boxplot() +
  xlab("Site") + ylab("Total length (cm)") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# more complex calculations
laminaria %>%
  group_by(site) %>%
  summarise(var_bl = var(blade_length),
            n_bl = n()) %>%
  mutate(se_bl = sqrt(var_bl / n_bl))

# example of how to save data
write_csv(laminaria_stats2, path = "data/laminaria_stats2.csv")
