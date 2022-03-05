# ZM George
# 18 Feb 2022
# Intro to R Exercises



# Load packages ----------------------------------------------------------

library(tidyverse)
library(colorspace)
#ggthemr is not available for my version of r

# EXERCISE A --------------------------------------------------------------

# Load data ------

shells <- read.csv2("intro_r_2022/shells.csv")


# Make data tidy -----

shells_tbl <- shells %>% 
  separate(col = species.ID.left_length.left_width.right_length.right_width,
           into = c("species", "ID", "left_length", "left_width", 
           "right_length", "right_width"), sep = ",") #separate the single column into 6

shells_tidy <- shells_tbl %>% 
  gather(left_length, left_width, right_length, right_width,
         key = "Measurements", value = "mm") #gather all the measurements and put them into 1 column
#place the values uner "mm"

# Create line graph -----

ggplot(data = shells_tbl, aes(x = left_length, y = right_length)) +
  geom_line(aes(colour = species, group = species)) +
  labs(x = "Left length (mm)", y = "Right length (mm)") +
  theme_bw() +
  qualitative_hcl(2, palette = "Dark 3") #add colour palette using colorspace


# Create histograms -----


ggplot(data = shells_tidy, aes(x = Measurements, 
               colour = species)) +
  geom_histogram(aes(fill = "species"), position = "dodge",
                 binwidth = 30) +
facet_wrap(~measurements, ncol = 2) #create 4 facets on the same axis




# EXERCISE B --------------------------------------------------------------

# Load package

library(boot)

# Load data

data(frets = "frets")

# Make data tidy

frets_tidy <- frets %>%
  gather(l1, b1,l2, b2, key = "brothers", value = "measurements")

# Make graph
ggplot(frets_tidy, aes(x = brothers, y = measurements)) 
  ggplot(data = frets_tidy, 
         aes(x = brothers, y = measurements, fill = brothers)) +
  stat_summary(geom = "bar", fun = mean, 
               position = "dodge", alpha = 0.5 ) +
  labs(x = "Brothers", y = "Measurements (mm)", 
       title = "The length and breadth of the heads of pairs of adult brothers in 25 randomly sampled families") +
  scale_fill_manual(values = c("red", "blue")) + 
  theme_bw()
  #stat sum - enter what you want the physical graph to look like
  #scale fill - colour of the bars

# EXERCISE C --------------------------------------------------------------

library(ggpubr)

# Load data
PlantGrowth <- datasets::PlantGrowth

ggplot(data = PlantGrowth, aes(x = group, y = weight, colour = group)) +
  geom_point(aes(group = weight)) +
  labs(x = "Groups", y = "Weight (g)") +
  theme_bw() 

ggplot(data = PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot(aes(fill = group)) +
  labs(x = "Groups", y = "Weight (g)") +
  theme_bw()

ggplot(data = PlantGrowth, 
       aes(x = group, y = weight, fill = group)) +
  stat_summary(geom = "bar", fun = mean, 
               position = "dodge", alpha = 0.5 ) +
  stat_summary(geom = "errorbar", fun.data = mean_sd, 
               position = "dodge", width = .4) +
  labs(x = "Dose (mg/d)", y = "Tooth Length (mm)") +
  theme_bw()


# EXERCISE D --------------------------------------------------------------

# Load dataset
sleep <- datasets::sleep

# Create 2 different graphs
ggplot(data = sleep, 
       aes(x = ID, y = extra, fill = group)) +
  stat_summary(geom = "bar", fun = mean, 
               position = "dodge", alpha = 0.5 ) +
  labs(x = "Patient ID", y = "Increase in hours of sleep (hrs)", 
       title = "The Effect of Two Soporific Drugs on 10 Patients") +
  scale_fill_manual(values = c("red", "blue")) + 
  theme_bw()

ggplot(data = sleep, aes(x = ID, y = extra, colour = group)) +
  geom_point() +
  geom_line(aes(group = group)) +
  labs(x = "Patient ID", y = "Increase in hours of sleep (hrs)",
  title = "The Effect of Two Soporific Drugs on 10 Patients") +
  theme_bw()


# EXERCISE E --------------------------------------------------------------

# Listing 1 ---

#create a new data set by taking 'some_data'  and adding year and month columns 
#group the data by country and year
#calculate the mean 'chl' and remove all the NA values
#ungroup the data (will show all the columns) 

#create a graph with 'the data' where the yr column will be on the x axis and med_chl column will be on the y.
#make it a line graph where the line will be represented by the country and the colour will be blue3
#make a line graph for each country and it will be displayed in 3 rows
#add labels for the x and y axis and the title of the graph 

# Listing 2 ---

#load the package ggforce 
#create a graph with the data called iris. petal.length is the x axis and petal.width is the y axis and the points on the graph will represent the species column
#make it a scattershot
#make it zoom in on the versicolor species on the x axis 

# Listing 3 ---

#set 3 as a starting number to generate a sequence of random numbers
#create a data frame from 'my data'
#the data frame will have 2 columns "gender" and "length"
#the gender column will contain categories F and M which will repeat 200 times each.
#the length column will have random variates with a mean if 55 and std of 58 

#head calls up the first few lines of the dataframe 
#create a graph with "my data" where the x axis = gender and y = length. make the graph a box and whisker and make the fill = gender (the bars represent gender)
#create a violin graph 
#create a dotplot graph and make the direction of the dots "center", the axis to the bin along the y-axis and the size of the dots 0.5


  