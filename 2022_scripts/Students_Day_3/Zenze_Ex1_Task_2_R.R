# Exercise 1
# Task 2
# Author: ZM George
# 9 Feb 2022


# load packages -----------------------------------------------------------

library(tidyverse)
library(ggpubr)


# load data ---------------------------------------------------------------

load("data/SACTNmonthly_v4.0.RData")


# faceting plots ----------------------------------------------------------


ColdTemp <- SACTNmonthly_v4.0 %>% 
  filter(temp < 12)

line_1 <- ggplot(data = SACTNmonthly_v4.0, aes(x = temp, y = date, colour = depth)) +
  geom_point() +
  geom_line(aes(group = site)) +
  labs(x = "Temp. (C)", y = "Date")
line_1


lm_1 <- ggplot(data = SACTNmonthly_v4.0, aes(x = temp, y = date, colour = depth)) +
  geom_point() +
  geom_smooth(method = "gam") +
  labs(x = "Temp. (C)", y = "Date")
lm_1


histogram_2 <- ggplot(data = ColdTemp, aes(x = temp)) +
  geom_histogram(aes(group = site, fill = depth), position = "dodge", binwidth = 100) +
  labs(x = "Temp. (C)", y = "Date")
histogram_2


box_2 <- ggplot(data = ColdTemp, aes(x = depth, y = date)) +
  geom_boxplot(aes(group = type, fill = depth)) +
  labs(x = "Depth (m)", y = "Date")
box_2


ggarrange(line_1, lm_1, histogram_2, box_2,
          ncol = 2, nrow = 2,
          labels = c("A", "B", "C", "D"),
          common.legend = TRUE)
