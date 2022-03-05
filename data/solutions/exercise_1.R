# Intro R workshop
# Day 3, Exercise 1
# 17 March 2021
# AJ Smit

library(tidyverse)
library(lubridate)
library(ggpubr)

# The chicken data
chicks <- datasets::ChickWeight
head(chicks)

chick_plt <- ggplot(data = chicks, aes(x = as.factor(Time), y = weight)) +
  geom_boxplot(aes(colour = Diet)) +
  geom_smooth(aes(group = Diet), method = "lm", colour = "grey40") +
  facet_wrap(~Diet) + 
  labs(x = "Time (days)", y = "Chick mass (g)", title = "Chick mass dataset") +
  theme_bw()
  
# The SACTN data
load("_GitBook/data/SACTNmonthly_v4.0.RData")

two_sites <- SACTNmonthly_v4.0 %>%
  filter(site %in% c("Kommetjie", "Karridene") &
           date >= "2000-01-01" & date <= "2000-12-31")

temps <- ggplot(two_sites, aes(x = date, y = temp)) +
  geom_line(aes(group = site, colour = site)) +
  labs(x = "Year", y = "Temperature (°C)",
       title = "Monthly mean temperature")

# Ecklonia data
ecklonia <- read_csv("_GitBook/data/ecklonia.csv")

eck1 <- ggplot(data = ecklonia, aes(x = site, y = stipe_mass + frond_mass)) +
  geom_boxplot() +
  geom_point(aes(y = stipe_mass + frond_mass), colour = "blue") +
  geom_jitter(aes(y = stipe_mass + frond_mass), width = 0.1, colour = "salmon") +
  labs(x = "Site", y = "Total mass (g)", title = "Ecklonia dataset")

eck2 <- ggplot(data = ecklonia, aes(x = stipe_mass, y = stipe_length)) +
  geom_point(aes(colour = site)) +
  geom_smooth(method = "lm", aes(group = site, colour = site)) +
  labs(x = "Stipe mass (g)", y = "Frond mass (g)", title = "Ecklonia dataset")

# First we must assign the code to an object name
grid_1 <- ggarrange(chick_plt, temps, eck1, eck2, 
                    ncol = 2, nrow = 2, 
                    labels = c("A", "B", "C", "D"),
                    common.legend = TRUE)

grid_1

# Then we save the object we created
ggsave(plot = grid_1, filename = "figures/grid_1.pdf")