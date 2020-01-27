# Day_1.R
# Here we are going to practice some things taught to us on Day 1 of the R workshop
# AJ Smit
# 20 Feb 2018


# setup -------------------------------------------------------------------

library(tidyverse)

# Making a basic graph ----------------------------------------------------



library(ggplot2) # load ggplot2
x <- seq(0, 2, by = 0.01) # make x
y <- 2 * sin(2 * pi * (x - 1/4)) # generate y
ggplot() + # make the plot
  geom_point(aes(x = x, y = y), shape = 21, col = "salmon", fill = "white")




# Read in data ------------------------------------------------------------

# read in data that were exported as .csv from Excel

library(readr)
laminaria <- read_csv("data/laminaria.csv")



# Exploring the data ------------------------------------------------------

# option 1 for looking at data:
laminaria

# option 2: use the environment pane
# click the interface

# option 3
head(laminaria)
head(laminaria, n = 2)
tail(laminaria)

# option 4
names(laminaria)
colnames(laminaria)
things <- names(laminaria)
row.names(laminaria)

# option 5: descriptive statistical summaries
summary(laminaria)
mean(laminaria$blade_weight)
sd(laminaria$blade_weight)
median(laminaria$blade_weight)
min(laminaria$blade_weight)
max(laminaria$blade_weight)
range(laminaria$blade_weight)



# The tidyverse functions -------------------------------------------------

sub <- laminaria %>% 
  select(site, total_length) %>% 
  filter(site == "Kommetjie")

sub1 <- laminaria %>% 
  filter(site == "Kommetjie") %>% 
  nrow()
sub1

laminaria %>%
  filter(total_length == max(total_length))



# Getting to the graphs ---------------------------------------------------

ChickWeight <- datasets::ChickWeight

ggplot(ChickWeight, aes(x = Time, y = weight)) +
  geom_point() +
  geom_line(aes(group = Chick))


ggplot(ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
  geom_point() +
  # geom_line(aes(group = Chick)) +
  geom_smooth(method = "lm")

ChickWeight %>% 
  group_by(Diet, Time) %>% 
  summarise(mn.wt = mean(weight)) %>% 
  ggplot(aes(x = Time, y = mn.wt, colour = Diet)) +
  geom_point() +
  geom_line(aes(group = Diet))
