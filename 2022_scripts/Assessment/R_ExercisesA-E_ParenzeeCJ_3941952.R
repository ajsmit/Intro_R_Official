#R Assignment
#CJ Parenzee
#3941952
#Intro R Exercises A-E


# Exercise A --------------------------------------------------------------

library(tidyverse)
library(colorspace)
library(ggthemr)

shells <- read.csv("data/shells.csv")
unique(shells$species)

# Straight Line graph

tidyshells <- shells %>% 
 gather(left_length, left_width, right_length, right_width, key = "measurement", value = "value")

line_1 <- ggplot(data = shells, aes(x = left_width, y = left_length, colour = species))+
  geom_point() +
  geom_line(aes(group = species))+
  labs(title = "Length VS Width of Aulacomya and Choromytilus", x = "Left Width (mm)", y = "Left Length (mm)" )
  
darken(col = "red", amount = 2, space = "combined")

line_1

# Histogram

library(colorspace)
library(ggthemr)

measure_sel <- c("left_width", "left_length", "right_width", "right_length") #c is concatinate which is to group multiple things to one variable/object

shells_species <- tidyshells %>% 
  filter(measurement %in% measure_sel) 

histogram_1 <- ggplot(shells_species, aes(x = ID, color = species))+
  geom_histogram(fill = "red", position = "dodge", alpha = 0.5, bins = 30) +
  facet_wrap(~measurement, ncol = 2)

histogram_1


# Exercise B --------------------------------------------------------------

library(boot)

view(frets)

frets_tidy <- frets %>% 
  gather(l1, b1, l2, b2, key = head, value = measurement)

brothers <- ggplot(frets_tidy, aes(x = head, y = measurement, colour = head)) +
  geom_point() +
  geom_line(aes(group = head)) +
  labs(title = "Brothers head measurements", x = "Breadth and Length of Head", y = "Measurement(cm)" ) +
  theme_classic()
  
brothers

# Exercise C --------------------------------------------------------------

datasets::PlantGrowth
view(PlantGrowth)

#scatterplot

scatterplot_1 <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_point(colour = "blue") +
  geom_smooth(method = "lm")

scatterplot_1

#box and whisker plot

boxplot_1 <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot(aes(fill = group))+
  labs(title = "Plant Weight per group", x = "Group Type", y = "Weight (mg)")

boxplot_1 


# Barplot

library(ggplot2)
library(ggpubr)

view(PlantGrowth)

barplot_1 <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
  stat_summary(geom = "bar", fun = mean, position = "dodge", alpha= 0.5) +
  stat_summary(geom = "errorbar", fun.data = mean_sd, position = "dodge", width = 0.2) +
  labs(title = "Plant weight(mg) of two groups and the control", x = "group", y = "Weight(mg)") +
  theme_classic()

barplot_1

# Exercise D --------------------------------------------------------------

view(sleep)

line_2 <- ggplot(data = sleep, aes(x = ID, y = extra, colour = group)) +
  geom_point() +
  geom_line(aes(group = group)) +
  labs(x = "Drug Group", y = "Hours of Sleep")

line_2

boxplot_2 <- ggplot(sleep, aes(x = group, y = extra)) +
  geom_boxplot(aes(fill = group)) +
  labs(title = "Extra hours of sleep per group", x = "ID", y = "Hours of sleep")

boxplot_2 



# Exercise E --------------------------------------------------------------

#The data produced from the following lines of code is assigned to the object "the_data" and introduced into the environment upon execution of those lines of code. The dataset being used, "some_data", is piped to link the consequential lines of code. It is mutated to create additional columns containing the separated year column into year, and month. It then groups the data by country and year, with this data being piped into a stats summary. here the meean is calculated, leaving out missing values. Finally all of this data is ungrouped again. 
# A graph is plotted using dataset "the_data", with the year being plotted on the x axis and the "med_chl" plotted onto the y axis. Further, the graph is plotted as a line graph using geom_line, with the lines grouping by each country, and the colour of the lines being the colour "blue3"
# the line graph is also faceted by each country,  creating 3 rows of faceted graphs
# labels are assigned to the graph with the x axis labeled "Year", the y axis "Chlorphyll-a (mg/m3) and a title assigned as "Chlorophyll-a concentration". 
