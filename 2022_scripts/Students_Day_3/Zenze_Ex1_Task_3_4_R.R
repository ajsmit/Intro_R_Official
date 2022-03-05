# Exercise 1
# Task 3 and 4
# Author: ZM George
# 9 Feb 2022


# load packages -----------------------------------------------------------

library(tidyverse)
library(ggpubr)



# Task 3 ---------------------------------------------------------------

ecklonia <- read.csv("data/ecklonia.csv")
ecklonia

box_1 <- ggplot(data = ecklonia, aes(x = ID, y = stipe_mass)) +
  geom_boxplot(aes(fill = site)) +
  labs(x = "Individuals", y = "Stipe mass (kg)")
box_1


histogram_1 <- ggplot(data = ecklonia, aes(x = stipe_length)) +
  geom_histogram(aes(fill = site), position = "dodge", binwidth = 100) +
  labs(x = "Stipe length (cm)", y = "Stipe diameter (cm)")
histogram_1

ggarrange(box_1, histogram_1,
          ncol = 2, nrow = 2,
          labels = c("A", "B"),
          common.legend = TRUE)


# Task 4 ------------------------------------------------------------------

ggarrange(lm_1, line_1, box_1, histogram_1,
          ncol = 2, nrow = 2,
          labels = c("A", "B", "C", "D"),
          common.legend = TRUE)

