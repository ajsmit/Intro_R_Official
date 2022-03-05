# Day_3.R
# Day 3 Laminaria Class Exercise
# Ammaarah Conrad
# Student number: 3947006
# 09 February 2022

library(tidyverse)

laminaria <- read.csv("R files/intro_r_data/data/laminaria")

laminaria %>% 
  group_by(site) %>% 
  summarise(avg_stp_len = mean(stipe_length), avg_total_len = mean(total_length))

laminaria %>% 
  filter(site == "Kommetjie") %>% 
  group_by(site) %>% 
  select(site, stipe_length, total_length)

ggplot(data = laminaria, aes(x = total_length, y = stipe_length, colour = site)) +
  geom_point() +
  labs(x = "Total length (cm)", y = "Stipe length (cm)", colour = "Site") +
  theme(legend.position = "bottom") +
  geom_line() 
  

