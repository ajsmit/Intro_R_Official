# Imanathi Kekaya
# BDC 744
# 18/02/2022
# Intro R exercises 
# Miscellaneous exercises for the mind (2)



# Load some packages -----------------------------------------------------


library(tidyverse)
library(tidyr)
library(ggplot2)
library(colorspace)

# Exercise A --------------------------------------------------------------


# Read and tidy data ------------------------------------------------------


shells <- read_csv("data/shells.csv") # assign the csv data to an object named "shells"


Shells_tidy <- shells %>%             # pipe tp make everything sequential
  pivot_longer(c("left_width","right_width",     # reduces the number of columns
                 "left_length", "right_length"), 
               names_to = "measurements", values_to = "Value")

species_A <- shells %>%         # creating an object named "species_A" from the shells data
  filter(species == "Aulacomya") # filter out the species required to be used in the graph

species_C <- shells %>%   # creating an object named "species_C" 
  filter(species == "Choromytilus") # filter out the species that will be used in graph

# Creating graph for species 1 (Aulacomya)
  
line_1 <- ggplot(data = species_A, aes(x = right_width,  y = left_width)) + #set up graph
  geom_point(aes(colour = species), size = 3) + # add data points to graph
  geom_smooth(method = "lm") + # add line of regression to show trend
  ggtitle("Relating the left and right length of Aulacomya" )+ # provide title for the graph
  labs(x= "Left_length", y = "Right_length", colour = "Species") # add labels to the axis
line_1

# creating a graph for species 2 (Choromylitus)

line_2 <- ggplot(data = species_C, aes(x = right_width,  y = left_width)) + # set up graph
  geom_point(aes(colour = species), size = 3) + # add datap oints to graph
  geom_smooth(method = "lm") +                  # add line of regression to show trend
  ggtitle("Relating the left and right length of Choromytilus" )+ # provides title to graph
  labs(x= "Left_length", y = "Right_length", colour = "Species") # add labels to the axis
line_2


# Creating individual histograms for each of the measurement 
# variables for Aulacomya species-----------


species_A <- shells %>% # creating an object
  filter(species == "Aulacomya") # filter required data for graph


histo_1 <- ggplot(species_A, aes(x= left_length)) + # set up graph
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 25) + # create a histogram
  labs(y = "Left_length", colour = "Species") # add labels to the axis
histo_1
  
histo_2 <- ggplot(species_A, aes(x= left_width)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 25) +
  labs(y = "Left_length", colour = "Species")
histo_2

histo_3 <- ggplot(species_A, aes(x= right_length)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 25) +
  labs(y = "Left_length", colour = "Species")
histo_3

histo_4 <- ggplot(species_A, aes(x= right_width)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 25) +
  labs(y = "Left_length", colour = "Species")


# Creating individual histograms for each of the measurement 
# variables for Choromytilus species-----------

species_B <- shells %>% 
  filter(species == "Choromylitus")


histo_5 <- ggplot(species_B, aes(x= left_length)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 25) +
  labs(y = "Left_length", colour = "Species")
histo_5

histo_6 <- ggplot(species_B, aes(x= left_width)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 25) +
  labs(y = "Left_length", colour = "Species")
histo_6

histo_7 <- ggplot(species_B, aes(x= right_length)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 25) +
  labs(y = "Left_length", colour = "Species")
histo_7

histo_8 <- ggplot(species_B, aes(x=right_width)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 25) +
  labs(y = "Left_length", colour = "Species")
histo_8


# Exercise B ------------------------------------------------------------


# Load some packages ------------------------------------------------------

library(boot)

boot::frets # retrieve frets data from boot

# tidying the data 

brothers_data <- boot::frets # assign an object to frets data

brother_1 <- brothers_data %>%          # utilises the brothers data
  select(l1, b1) %>%                    #retain only these listed columns
  rename(length = l1, breadth = b1) %>% #rename the columns
  gather(length, breadth, key = "Head", value= "Brother_1") # gathering the data into one column

brother_2 <- brothers_data %>%        # utilises the brothers data
  select(l2, b2) %>%                  # retain only these listed columns
  rename(length = l2, breadth = b2) %>% # rename the columns 
  gather(length, breadth, key = "Head", value = "Brother_2") # gathering the data into one column 


brother_1$Brother_2 <- brother_2$Brother_2
brother_2$Brother_2 <- brother_1$Brother_1

# tidy the brothers data

brother_tidy <- brother_1 %>% 
  gather(Brother_1, Brother_2,  key = "Brothers", # gather brother 1 and 2 in one column "brother"s
         value = "Values")              # gather the values into the value column
                                                                

# Creating the graph

ggplot(brother_1, aes(x= Brother_1, y = Brother_2, colour = Head)) +
  geom_point() + # add point to graph
  geom_smooth(method = "lm") + # adds line of regression to show relationship/trend
  ggtitle("Head measurements of the Brothers (mm)") + # provides tittle for the graph
  xlab("Length and breadth of brother_1(mm)") + # provide label fro x axis
  ylab("Length and breadth of brother_2 (mm)") # provide labels for y axis



# Exercise C --------------------------------------------------------------

# Load data

PlantGrowth <- datasets::PlantGrowth # assign an object to the dataset

# creating a scatterplot with individual weight datapoints as a function of group

ggplot(data = PlantGrowth, aes(x = group, y = weight)) + # set up graph
  geom_point(shape = 21, colour = "yellow", fill = "red", size = 3) + # adds points to graph
  geom_smooth(method = "lm", se = F) + # adds regression line to show trends
  labs(x = "Group", y = "Weight") # add labels to axis

# creating a scatterplot with individual weight datapoints as a function of group

ggplot(data = PlantGrowth, aes(x = group, y = weight)) + #set up graph
  geom_boxplot(aes(fill = group)) + #create a boxplot
  labs(x = "Group", y = "Weight") # add labels to graph

# a bar plot with associated SD for each group (on one set of axes)

Plantgrowth_mean <- PlantGrowth %>%   # use plant growth data
  group_by(group) %>%                 # group the data by "group"
  summarize(mean_wght = mean(weight), # calculates the mean weight
            sd_wght = sd(weight),     # calculates the standard deviation and 
            count = n())              # calculates the number of observations

ggplot(data = Plantgrowth_mean, aes(x = group, y = mean_wght, fill = group)) + # set up graph
  geom_bar(stat = "identity", position = "dodge") + # create bar graph
  geom_errorbar(data = Plantgrowth_mean, # create errorbars
                aes(ymin = mean_wght - sd_wght, ymax = mean_wght + sd_wght),
                width = 0.1, position = position_dodge(0.4)) +
  labs(x = "Group", y = "Mean weight") + #adding labels to the axis
  ggtitle("Mean weight of plant growth of the groups") # provide title for the graph


# Exercise D --------------------------------------------------------------

# Load data 

Sleep_data <- datasets::sleep  # load dataset "sleep" from datasets within R
  
sleep_data_1 <- Sleep_data %>% # utilises the Sleep_data and assigning it to an object
  filter(group == 1)
 
# graphically displaying these data in two different ways 
  
ggplot(Sleep_data, aes(x= ID, y= extra, fill = group)) + # set up graph
  geom_bar(stat = "identity", position = "dodge") + # create a bar graph
  labs(x = "ID", y = "Extra hours in sleep") ##adding labels to graph

ggplot(Sleep_data, aes(x= ID, y= extra, colour = group)) + #set up graph
  geom_point() + #add data oints to graph
  geom_line(aes(group = group)) + # add connecting lines
  labs(x = "ID", y = "Extra hours in sleep") # adding labels to graph


# Exercise E --------------------------------------------------------------

# providing English Narrative for Some Code


# Listing one -------------------------------------------------------------


the_data <- some_data %>% #utilises the "some_data" and assigning an obj. to "the_data"
  mutate(yr = year(date),  # creates new variable "yr and mo" from old variable "date" 
         mo = month(date)) %>% 
  group_by(country, yr) %>%  #groups data by country and year
  summarise(med_chl = mean(chl, na.rm = TRUE)) %>% 
  ungroup()                               # data no longer grouped by country and year
ggplot(the_data, aes(x = yr, y = med_chl)) + # set up graph
  geom_line(aes(group = country), colour = "blue3") + # add connecting lines
  facet_wrap(~country, nrow = 3) + # view individual categories in their own graph
  labs(x = "Year", y = "Chlorophyll-a (mg/m3)", # add labels to the axis
       title = "Chlorophyll-a concentration") # adds title to the graph


# Listing two -------------------------------------------------------------

library(ggforce) # load library
ggplot(iris, aes(Petal.Length, Petal.Width, colour = Species)) + # set up graph
  geom_point() + # use data points to represent the data
  facet_zoom(x = Species == "versicolor") # view subset of data while keeping
                                         # full dataset in a separate panel


# Listing three -----------------------------------------------------------

set.seed(13)
my_data = data.frame(                          # creating own dataframe for females and males
  gender = factor(rep(c("F", "M"), each=200)), # rep stands for replicate
  length = c(rnorm(200, 55), rnorm(200, 58)))
?head(my_data)  # return first parts of dataframe         

ggplot(my_data, aes(x = gender, y = length)) + # set up graph
  geom_boxplot(aes(fill = gender)) # create boxplot
ggplot(my_data, aes(x = gender, y = length)) + #set up graph
  geom_violin() # shows distribution of observations
ggplot(my_data, aes(x = gender, y = length)) + #set up graph
  geom_dotplot(stackdir = "center", binaxis = "y", dotsize = 0.5)# creates dots, each dot representing 
                                                                  # one observation
       
       
       
       
       