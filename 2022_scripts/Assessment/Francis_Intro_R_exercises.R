#Author: Taufeeqah Francis
#Date: 19 February 2022
#Exercise: Intro R exercise: Miscellaneous exercises for the mind (2)


# load packages -----------------------------------------------------------

library(tidyverse)
library(ggpubr)
library(boot)
library(plyr)
library(ggthemes)
library(colorspace)

# exercise A --------------------------------------------------------------
# part 1
shells <- read_csv("data/shells.csv")
shells_tidy <- shells %>% 
  gather(left_length, left_width, right_length, right_width, key = "measurement", value =  "value")

# part 2

ggplot(data = shells, aes(x = left_length, y = right_length, colour = species)) +
  geom_point() +
  geom_line() +
  scale_colour_canva(palette = "Neon night") +
  theme_clean() +
  labs(x = "Left length (mm)", y = "Right length (mm)")

# part 3

ggplot(shells_tidy, aes(x = measurement, color = species, fill = species)) +
  geom_histogram(stat = "count", position = "dodge", alpha = 0.5, bins = 30) +
  facet_wrap(~measurement, ncol = 2) +
  labs(x = "measurement (mm)", y = "count")

# exercise B --------------------------------------------------------------
data(frets = "frets")

frets_tidy <- frets %>% 
  gather(l1, b1, l2, b2, key = "brothers", value = "measurements")

ggplot(data = frets_tidy, aes(x = brothers, y = measurements, fill = brothers)) +
  geom_col() +
  labs(x = "Brothers", y = "Measurement (mm)") +
  theme_clean()

# exercise C --------------------------------------------------------------
PlantGrowth <- datasets::PlantGrowth

# part 1

ggplot(data = PlantGrowth, aes(x = group, y = weight)) +
  geom_point() +
  labs(x = "Group", y = "Weight (mg)")

# part 2

ggplot(data = PlantGrowth, aes(y = weight, x = group)) +
  geom_boxplot(aes(fill = group)) +
  labs(x = "Group", y = "Weight (mg)")

# part 3

ggplot(data = PlantGrowth, aes(x = group, y = weight, fill = group)) +
  stat_summary(geom = "bar", fun = mean, position = "dodge", alpha = 0.5) +
  stat_summary(geom = "errorbar", fun.data = mean_sd, position = "dodge", width = 0.4) +
  labs(x = "Group", y = "Weight(mg)")

# exercise D --------------------------------------------------------------
sleep <- datasets::sleep
  
ggplot(data = sleep, aes(x = ID, y = extra, colour = group)) +
  geom_point() +
  geom_line(aes(group = group)) +
  labs(x = "ID", y = "Extra sleep (hours)")

ggplot(data = sleep, aes(x = ID, y = extra, fill = group)) +
  geom_col(position = "dodge") +
  labs(x = "ID", y = "Extra sleep (hours)") +
  scale_fill_manual("group", values = c("1" = "pink", "2" = "yellow"))

# exercise E --------------------------------------------------------------
# Listing 1

In the first line, the dataset "the_data" is created by using the "some_data" dataset.
The mutate function creates a new column where the year and month are displayed differently.
The data is grouped by country first, then year.

Th following set of information shows the creation of a scatter plot. Geom_line adds a line of best fit to the plot. The graph is grouped by country and is coloured in blue. Facet wrap splits the graph by country, with 3 rows in each graph. The label for the x-axis is "year" and the label for the y-axis is "Chlorophyll-a (mg/m3)". The graph also has the title "Chlorophyll-a concentration".

# Listing 2

The package "ggforce" is loaded from the library. A scatter plot is then created. The dataset used is called "iris". The data is coloured by species, with petal length on the x-axis and petal width on the y-axis. The facet zoom function allows you to zoom in on the versicolor species on the x-axis. This means that the versicolor species will appear more zoomed in than the other species.

# Listing 3

set.seed allows you to get a random result that can be reproduced. The 13 specifies the initial value of the seed. A new set of data (my_data) is created as a data frame, which will include the gender and length categories. The mean is 55, and the stadnard deviation is 58. The first graph is a box and whisker plot, with the gender on the x-axis and the length on the y-axis. The graph is filled by gender.
The second graph is a violin graph, used to display continuous distribution. The gender is on the x-axis and the length is on the y-axis.
The third graph shows a dot plot. The stackdir shows that the dots must be stacked in the center. The binaxis shows that the axis to bin is along the y axis.

