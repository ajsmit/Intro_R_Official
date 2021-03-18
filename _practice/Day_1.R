# Script name: Day_1.R
# Purpose: R training on Day 1
# Date: 15 March 2021
# Author: AJ Smit

library(tidyverse)

# calculate the body mass index:
mass <- 48 
mass <- mass * 2.0 # mass? 
age <- 42
age <- age - 17 # age? m
mass_index <- mass / age # mass_index?

# another example:
apples <- c(5.3, 3.8, 4.5) # mass of apples
pears <- c(1.2, 3.3, 13, NA)
mean(pears)
mean(pears, na.rm = TRUE)
sum(apples)
mean(apples)
sd(apples)
max(apples)
range(apples)
?mean


x <- c(0:10, 50)
mean(x)

# some example plots
x <- seq(0, 2, by = 0.01)
y <- 2 * sin(2 * pi * (x - 1/4))
ggplot() +
  geom_point(aes(x = x, y = y),
             shape = "a",
             col = "salmon",
             fill = "white")

# example importing of cvs file
# belongs to the tidyverse package...
laminaria <- read_csv("data/laminaria.csv") 

head(laminaria)
summary(laminaria)
colnames(laminaria)
length(laminaria)
