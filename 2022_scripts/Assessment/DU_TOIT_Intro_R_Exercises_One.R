# Intro_R_Exercises_One
# Author: Dahraan du Toit
# Date: 21 Feb 2022
# The following script concerns the manipulation and presentation of statistical
# data


# load packages -----------------------------------------------------------
# The below package unpacks a variety of functions related to statistical
# science
library(tidyverse)
# the below package contains commands and data related to graphical 
# presentation of statistical data
library(ggpubr)
# the below package contains commands and data related to presentation of
# graphical data
library(colorspace)
# the below package contains commands relating to boostrap replicates of
# statistical data
library(boot)


# load data ---------------------------------------------------------------
# the below command reads the indicated data file and declares a new data object
# in the environment
shells <- read_csv("data/shells.csv")


# manipulate data ---------------------------------------------------------
# the below command generates two new variables in total length and total width
# and summarises the resulting data inside a new data object
shells2 <- shells %>% 
  group_by(species) %>% 
  mutate(length_t = left_length + right_length,
         width_t = left_width + right_width) %>% 
  summarise(species, ID, length_t, width_t)

# the below command generates a linear regression based on the shells2
# data object with total length as the independent variable, 
# total width as the dependent variable and segregation of species based on
# assignment of colours
ggplot(data = shells2, aes(x = length_t, y = width_t, colour = species)) +
  geom_point() +
  labs(x = "Total Length (mm)", y = "Total Width (mm)", colour = "Genus", title
       = "Line Graph showing relationship between length and width") +
  geom_smooth(method = "lm") + # this line generates a regression based on trends
                               # within the dataset
  theme_dark() +
  scale_color_discrete_qualitative(palette = "Pastel 1")

# the below command generates a histogram based on the shells2 data object with
# total width as the independent variable, frequency as the dependent variable,
# and segregation of species based on assignment of colours
histogram_width <- ggplot(data = shells2, aes(x = width_t, fill = species)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 10, colour = "black") +
  labs(x = "Total Width (mm)", y = "Frequency", fill = "Genus") +
  theme_light() +
  scale_fill_manual(values = c("blue", "green"))
histogram_width

# the below command generates a histogram based on the shells2 data object with
# total length as the independent variable, frequency as the dependent variable,
# and segregation of species based on assignment of colours
histogram_length <- ggplot(data = shells2, aes(x = length_t, fill = species)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 10, colour = "black") +
  labs(x = "Total Length (mm)", y = "Frequency", fill = "Genus") +
  theme_light() +
  scale_fill_manual(values = c("blue", "green"))
histogram_length

# the below command generates a grid consisting of two graphs generated above:
# histogram_length and histogram_width
grid_1 <- ggarrange(histogram_length, histogram_width, 
                    ncol = 2, nrow = 1, # Set number of rows and columns
                    labels = c("A", "B"), # Label each figure
                    common.legend = TRUE) # Create common legend

# the below command adds a title to the aggregated graph grid
annotate_figure(grid_1, top = text_grob("Measurement Frequencies in Aulacomya and Choromytilus", 
                                      color = "black", face = "bold", size = 14))

# the below command calls the help screen for the declared data set 
?frets

# the below command preserves only the length and breadth data for the elder
# brother and renames the numbered length and breadth columns to a non-numbered
# version of the same variable
fretsbro1 <- frets %>%
  rename(b = b1,
         l = l1) %>% 
  mutate(brother = "elder") %>% 
  summarise(brother, b, l)

# the below command preserves only the length and breadth data for the second
# brother and renames the numbered length and breadth columns to a non-numbered
# version of the same variable
fretsbro2 <- frets %>%
  rename(b = b2,
         l = l2) %>% 
  mutate(brother = "second") %>% 
  summarise(brother, b, l)

# the below command combines the data concerning only the elder and only the 
# second brother, allowing for segregation of data by brother
fretsbros <- full_join(fretsbro1, fretsbro2, by = c("brother", "b", "l"))
  
# the below command generates a line graph based on the combined fretsbros data, 
# with length as the independent variable, breadth as the dependent variable, 
# segregation of brothers by age according to arrangement of colours, and with
# a linear regression based on trends from each data set.
ggplot(data = fretsbros, aes(x = l, y = b, colour = brother)) +
  geom_point() +
  labs(x = "Length (mm)", y = "Breadth (mm)", colour = "Brother", title
       = "Line Graph showing relationship between head length and breadth in pairs of brothers") +
  geom_smooth(method = "gam") + # this line generates a regression based on trends
  # within the dataset
  theme_classic2() +
  scale_color_manual(values = c("blue", "red"),
                     labels = c("Eldest Son", "Second Son"))

PlantGrowth

# The below command calculates a mean, standard deviation, n value, and
# standard error for the data set
PlantGrowth_2 <- PlantGrowth %>%
  group_by(group) %>% 
  mutate(sd = sd(weight),
         mean = mean(weight),
         n = n(),
         se = sd(weight) / sqrt(n))

# the below command generates a scatter plot representing plant weight as a
# function of treatment type.
ggplot(data = PlantGrowth, aes( x = group , y = weight)) +
  geom_point() +
  labs(x = "Group", y = "Weight", title
       = "Scatter Plot showing plant weight as a function of experimental group") +
  theme_classic2() +
  scale_x_discrete(labels = c("ctrl" = "Control", "trt1" = "Treatment 1", "trt2" = "Treatment 2"))

# the below command generates a series of box plots showing the relationship
# between treatment type and plant weight.
ggplot(data = PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot() +
  labs(x = "Group", y = "Weight",
       title = "Box Plot showing plant weight per treatment") +
  theme_classic2() +
  scale_x_discrete(labels = c("ctrl" = "Control", "trt1" = "Treatment 1", "trt2" = "Treatment 2"))

# The below command generates a bar graph showing the relationship between
# treatment type and plant weight. The standard deviation of the data set is 
# represented by sets of error bars placed above the measured variables
ggplot(data = PlantGrowth_2, aes(x = group, y = mean, ymin = mean - sd, 
                                 ymax = mean + sd)) + 
  geom_bar(colour = "black", stat = "identity", position = "dodge", width = 0.4) +      	
  geom_errorbar(colour = "black", stat = "identity", 
                position = position_dodge(0.4), width = 0.2) + 
  labs(x = "Group", y = "Weight",
       title = "Bar Graph showing average weight per treatment") +
  theme_classic2() +
  scale_x_discrete(labels = c("ctrl" = "Control", "trt1" = "Treatment 1", "trt2" = "Treatment 2"))

?sleep

# The below command calculates a mean, standard deviation, n value, and
# standard error for the data set
sleep_2 <- sleep %>%
  group_by(group) %>% 
  mutate(sd = sd(extra),
         mean = mean(extra),
         n = n(),
         se = sd(extra) / sqrt(n))

# the below command generates a bar graph showing the change in sleep duration
# experienced by each patient, with segregation per drug type according to
# arrangement of colours
ggplot(data = sleep, aes(x = ID, y = extra, fill = group)) + 
  geom_bar(colour = "black", stat = "identity", position = "dodge", width = 0.4) +
  labs(x = "Patient ID", y = "Change in Sleep Duration (hours)", fill = "Drug Given",
       title = "Bar Graph showing change in sleep duration based on drugs given per patient") + 
  theme_classic2() +
  scale_fill_manual(values = c("blue", "yellow"),
                     labels = c("Drug 1", "Drug 2"))

# the below command generates a series of box plots showing the relationship
# between change in sleep duration and drug type
ggplot(data = sleep, aes(x = group, y = extra)) +
  geom_boxplot() +
  labs(x = "Drug Given", y = "Change in Sleep Duration (hours)",
       title = "Box Plot showing change in sleep duration based on drugs given") +
  theme_classic2() +
  scale_x_discrete(labels = c("1" = "Drug 1", "2" = "Drug 2"))

# Listing 1:
# The first block of code alters the given data set, separating dates into months
# and years to allow for calculations using those values. The data is then
# grouped by country and then by year. This newly arranged data has a mean
# chlorophyll value calculated for the dataset.
# The second block of code generates a set of line graphs for each country based
# on monthly chlorophyll concentrations
# Listing 2:
# The code loads the ggforce library, which contains commands relevant to 
# graphing data. Using the iris data set native to R, the command generates a 
# line graph with petal length as the independent variable, petal width as the
# dependent variable and segregation of species via arrangement of colours. The
# facet zoom function used in the last line of the code highlights and enlarges
# the declared grouping variable, extracting the section of the graph that 
# contains all data points grouped within that variable
# Listing 3:
# The first line of code sets a seed for an array of random numbers that are then
# called for by the rnorm command. The seed being set retains this reproducible
# set of random numbers rather than calling a new set of random numbers each time
# the command is used. The distribution of male/female units within the array
# is declared in the next line, with each having 200 observations. The following 
# line after that declares the variance for length for either sex, with 
# female units having a lower variance than male units. The "head" command then
# reports the first six lines of the new data set. The following command
# generates a box plot with sex-based segregation based on colour arrangement 
# and with length as the dependent variable. The command that follows that
# generates a violin plot that reports the frequency of different lengths in each
# sex-based grouping. The final command generates a dot plot that illustrates
# frequency of different lengths in each grouping, thereby highlighting outliers
# in the array.

