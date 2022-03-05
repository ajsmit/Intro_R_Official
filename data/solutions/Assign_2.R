# Assign_2.R
# Analyse the CO2 data
# AJ Smit
# 22 Feb 2018


# set-up ------------------------------------------------------------------

library(tidyverse)
library(ggpubr)


CO2 <- as_tibble(datasets::CO2)

ggplot(CO2, aes(x = conc, y = uptake)) +
  geom_point() +
  geom_line(aes(group = Plant)) +
  geom_smooth(method = "gam", aes(linetype = Treatment)) +
  facet_wrap(Treatment~Type, nrow = 2) + theme_bw()
  
