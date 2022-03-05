# Intro R Exercises
# Ammaarah Conrad
# Student number: 3947006
# 18 February 2022


# Exercise A --------------------------------------------------------------

# Load programs
library(tidyverse)
library(ggplot2)
library(colorspace)
library(ggthemr)

# Load data
shells <- read.csv("R Files/intro_r_data/data/shells.csv")

# Tidy original dataset
shells_tidy <- shells %>%
  gather(left_length, left_width, right_length, right_width, key = "position", value = "measurement") # Puts left_length, left_width, right_length, right_width into one column (titled "position"), and places all values in one column (titled "measurement").

# Line graph
lg_shells <- ggplot(data = shells, aes(x = left_width, y = right_width, colour = species)) + # produces the line graph
  geom_point() + # creates a scatter plot
  geom_line(aes(group = species)) + # connects the plots with lines to make a line graph
  geom_smooth(method = "lm") + # linear model
  labs(x = "Left Width (mm)", y = "Width (mm)") + # adds labels for the x and y axes
  theme_minimal() # adds theme
lg_shells

# Histogram
hist_shells <- ggplot(shells_tidy, aes(x = measurement, color = species, fill = species)) + # produces a histogram
  geom_histogram(fill = "white", position = "dodge", alpha = 0.5) + 
  facet_wrap(~position, ncol = 2) + # splits the data into 4 facets on the same set of axes; data separated into left_length, right_length, left_width, and right_width
  labs(x = "Measurement (mm)", y = "Count") # adds labels for the x and y axes
hist_shells


# Exercise B --------------------------------------------------------------

# Load program
library(boot)

# Load dataset
data(frets = "frets")

# Tidy original dataset
frets_tidy <- frets %>%
  gather(l1, b1, l2, b2, key = "head_measurement", value = "value")

# Histogram
hist_frets <- ggplot(frets_tidy, aes(x = value, color = head_measurement, fill = head_measurement)) + # produces a histogram
  geom_histogram(fill = "white", position = "dodge", alpha = 0.5) + 
  labs(x = "Value (cm)", y = "Count") + # adds labels for the x and y axes
  theme_grey()
hist_frets


# Exercise C --------------------------------------------------------------

# Load dataset
PlantGrowth <- datasets::PlantGrowth

# Scatterplot
scatter_1 <- ggplot(data = PlantGrowth, aes(x = group, y = weight, colour = group)) + # produces scatterplot
  geom_point(size = 3, shape = 20) + # creates points for each value
  geom_smooth(method = "lm") + 
  labs(x = "Group Type", y = "Weight") + # creates labels for x and y axes
  theme_grey() # generates theme
scatter_1

# Box and Whisker
box_1 <- ggplot(data = PlantGrowth, aes(x = group, y = weight)) + # produces box and whisker graph
  geom_boxplot(aes(fill = group)) + # fills boxes colour depending on the group type
  labs(x = "Group", y = "Weight (mg)") # creates labels for x and y axes
box_1

# Bar plot 
bg_1 <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) + # produces bar plot
  stat_summary(geom = "bar", fun = mean, position = "dodge") +
  stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge") + # produces SD and error bars
  labs(x = "Group Type", y = "Weight (g)") + # creates labels for x and y axes
  scale_fill_manual(values = c("seagreen", "blue", "purple")) # customizes colours of each box
bg_1


# Exercise D --------------------------------------------------------------

# Load dataset
sleep <- datasets::sleep

# display 1 - Faceted Scatterplot
sp_sleep <- ggplot(data = sleep, aes(x = ID, y = extra, colour = group)) + # produces scatter plot
  geom_point(size = 3, shape = 20) + # creates points for each value
  geom_smooth(method = "lm") +
  labs(x = "ID", y = "Extra Hours (hrs)") + # creates labels for x and y axes
  facet_wrap(~group,ncol = 2) + # splits data onto 2 facets, separated by group type
  theme_grey() # adds theme
sp_sleep

# display 2 - Line graph
line_sleep <- ggplot(data = sleep, aes(x = ID, y = extra, colour = group)) + # produces line graph
  geom_point() +  # creates points for each value
  geom_smooth(method = "lm") +
  geom_line(aes(group = group)) +  # connects the plots with lines to make a line graph
  labs(x = "ID", y = "Extra Hours (hrs)") + # creates labels for x and y axes
  scale_colour_brewer(palette = "Pastel2") + # chooses colour palette
  theme_dark() # adds a theme
line_sleep

# Exercise E --------------------------------------------------------------

# LISTING 1
# In the first half of the code (in the first line), the dataset "the_data" is being modified and renamed to be called "some_data". The mutate function is then used to separate the full date (d/m/yr) into two separate columns of "year" and "month". The "group_by" function is used to ensure that only data under the columns "country" and "yr" are present in the new dataset. "Summarise" calculates the mean value of "chl". "ungroup" removes the groupings made in the dataset.
# In the second portion of the code, the first line begins the plotting of the graph using data from the dataset "the_data", with values from the "yr" column on the x-axis and from the "med_chl" on the y-axis. "geom_line" tells us that it will be a line graph and that the values will be connected by this line. That same line of coding tells us that the lines will be grouped by country and will be the colour "blue3". "facet_wrap" splits the graph into three different facets (nrow = 3), and each facet will focus on data from a different country. "labs" creates the labels from the graph, with "Year" as the x-axis label and "Chlorophyll-a (mg/m3)" as the y-axis label. The last line of the code creates the graphs title, which will be "Chlorophyll-a concentration".

# LISTING 2
# "library(ggforce)" loads the ggforce package. "ggplot" begins creating the graph with data from the "iris" dataset (dataset giving the measurements in cm of the variables sepal length and width and petal length and width for 50 flowers from 3 different iris species). Petal.Length and Petal.Width will be shown on the graph's axes, and the colour will show the 3 different species types. "geom_point" tells us that the graph will be a scatter plot. 'facet_zoom" zooms into a specific variable. In the case of this graph, the code zooms into the data belonging to the 'versicolor' species of Iris.

# LISTING 3
# "set.seed" is used to specify the seeds that need to be focused on. The "data.frame" function groups together variables that have the same properties. In this example, the data is grouped by gender and length. "Head"...
# The next three pieces of code are three different graphs made from the dataset used. The first one is a box plot. Values from the "my_data" dataset is used to make the graph, with values for "gender" on the x-axis and "length" on the y-axis. The boxes on the graph are coloured depending on the gender. The second graph is a violin plot shows the continuous distribution of the data. Values from the "my_data" dataset is used to make the graph, with values for "gender" on the x-axis and "length" on the y-axis. The final graph is a dot plot. With this graph, "stackdir" dictates which direction the dots will be stacked in ("center" means that the dots will be stacked in the center), "binaxis" shows the axis to bin along the y-axis in this example, and the "dotsize" decides the diameter of the dots in relation to the binwidth (diameter is 0.5).