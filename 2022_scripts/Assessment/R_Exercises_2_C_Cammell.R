# C Cammell
# 20 February 2022
# Intro R Exercise (2)
# Exercises for the mind



# Exercise A: The shells.csv data -----------------------------------------

# load packages

library(tidyverse)
library(dplyr)
library(ggpubr)
library(ggplot2)
library(boot)

# load dataset

shells <- read.csv("Data/shells.csv")


# Produce a tidy dataset from the data contained in shells.csv.

shells_tidy <- shells %>%
  gather(left_length, left_width, right_length, right_width, key = "src", value = "value")


# For each species, relate two measurement variables within the dataset to one-another and represent the relationship with a straight line.


# Aulacomya species

Aulacomya_data <- shells %>%
  filter(species == "Aulacomya") # filter the desired species

Aulacomya_graph <- ggplot(Aulacomya_data, aes(x = right_length, y = left_length)) +
  geom_smooth(method = 'lm') + # use the line of best fit to create a straight line
  labs(x = "Right Length (cm)", y = "Left Length (cm)", title = "Aulacomya Lengths")
Aulacomya_graph


# Choromytilus species

Choromytilus_data <- shells %>%
  filter(species == "Choromytilus") # filter the desired species

Choromytilus_graph <- ggplot(Choromytilus_data, aes(x = right_length, y = left_length)) +
  geom_smooth(method = 'lm') + # use the line of best fit to create a straight line
  labs(x = "Right Length (cm)", y = "Left Length (cm)", title = "Choromytilus Lengths")
Choromytilus_graph


# Aulacomya species (4 variables)

# left length

Aulacomya_histo_left_length <- ggplot(Aulacomya_data, aes(x = left_length)) +
  geom_histogram(position = "dodge", color= "#e9ecef", alpha=0.9, binwidth = 2) + # specifics for histogram setup
  labs(x = "Left Length (cm)", y = "Count", title = "Aulacomya Left Length")
Aulacomya_histo_left_length


# left width

Aulacomya_histo_left_width <- ggplot(Aulacomya_data, aes(x = left_width)) +
  geom_histogram(position = "dodge", fill= "#69b3a2", color= "#e9ecef", alpha=0.9, binwidth = 2) +
  labs(x = "Left Width (cm)", y = "Count", title = "Aulacomya Left Width")
Aulacomya_histo_left_width


# right length

Aulacomya_histo_right_length <- ggplot(Aulacomya_data, aes(x = right_length)) +
  geom_histogram(position = "dodge", fill= "#69b3a2", color= "#e9ecef", alpha=0.9, binwidth = 2) +
  labs(x = "Right Length (cm)", y = "Count", title = "Aulacomya Right Length")
Aulacomya_histo_right_length


# right width

Aulacomya_histo_right_width <- ggplot(Aulacomya_data, aes(x = right_width)) +
  geom_histogram(position = "dodge", fill= "#69b3a2", color= "#e9ecef", alpha=0.9, binwidth = 2) +
  labs(x = "Right Width (cm)", y = "Count", title = "Aulacomya Right Width")
Aulacomya_histo_right_width



# Choromytilus species (4 variables)


# left length 

Choromytilus_histo_left_length <- ggplot(Choromytilus_data, aes(x = left_length)) +
  geom_histogram(position = "dodge", fill= "#69b3a2", color= "#e9ecef", alpha=0.9, binwidth = 2) +
  labs(x = "Left Length (cm)", y = "Count", title = "Choromytilus Left Length")
Chromytilus_histo_left_length


# left width

Choromytilus_histo_left_width <- ggplot(Choromytilus_data, aes(x = left_width)) +
  geom_histogram(position = "dodge", fill= "#69b3a2", color= "#e9ecef", alpha=0.9, binwidth = 2) +
  labs(x = "Left Width (cm)", y = "Count", title = "Choromytilus Left Width")
Choromytilus_histo_left_width


# right length

Choromytilus_histo_right_length <- ggplot(Choromytilus_data, aes(x = right_length)) +
  geom_histogram(position = "dodge", fill= "#69b3a2", color= "#e9ecef", alpha=0.9, binwidth = 2) +
  labs(x = "Right Length (cm)", y = "Count", title = "Choromytilus Right Length")
Choromytilus_histo_right_length


# right width

Choromytilus_histo_right_width <- ggplot(Choromytilus_data, aes(x = right_width)) +
  geom_histogram(position = "dodge", alpha=0.9, binwidth = 2) +
  scale_fill_discrete_qualitative() + # use the colorspace package to change the look
  labs(x = "Right Width (cm)", y = "Count", title = "Choromytilus Right Width")
Choromytilus_histo_right_width



# Use the colorspace package and assign interesting colours to your graphs (all graphs above).

library(colorspace)


# Use the ggthemr package and assign interesting themes to your graphs (all graphs above).


library(devtools) # load new package to be used above
devtools::install_github('cttobin/ggthemr') # install

library(ggthemr) # load new package to be used above
ggthemr("earth") # select desired theme for all graphs above




# Exercise B: Head Dimensions in Brothers ---------------------------------

# load things

library(boot)
library(dplyr)

brother_data <- boot::frets

# Create a tidy dataset from the frets data

brother_tidy <- brother_data %>% 
  gather(l1, b1, l2, b2, key = "brother", value = "size") # give new colums names


# Demonstrate the most concise way for displaying both brother's data on one set of axes

brother1 <- brother_data %>% 
  select(l1, b1) %>% # isolate data from brother 1 only
  gather(l1, b1, key = "head_dimension", value = "Brother_1") # gather the above data into new dataset

brother2 <- brother_data %>% 
  select(l2, b2) %>% # isolate data from brother 2 only
  gather(l2, b2, key = "head_dimension", value = "Brother_2") # gather the above data into new dataset

brother1$Brother2 <- brother2$Brother_2 # creates new object called 'brother1' which displays the dimensions for brother 1 and brother 2 alongside each other

# plot the graph

brothers_plot <- ggplot(brother1, aes(x = Brother_1, y = Brother2, colour = head_dimension)) +
  geom_point() + # display exact data points
  geom_smooth(method = 'lm') + # smooth line to show data more clearly
  scale_colour_ggthemr_d() + # apply unique theme to graph
  labs(x = "Length and Breadth of Brother 1", y = "Length and Breadth of Brother 2", colour = "Head Dimension", title = "Head Dimensions of Brothers")
brothers_plot

# Apply your own unique theme modification to the graph in order to produce a publication-worthy figure

# see above in 'brothers_plot




# Exercise C: Results from an Experiment on Plant Growth ------------------

# load dataset

PlantGrowth <- datasets::PlantGrowth
summary(PlantGrowth)


# Concisely present the results of the plant growth experiment as graphs:

  # a scatterplot with individual weight datapoints as a function of group

scatterplot <- ggplot(PlantGrowth, aes(x = 1:nrow(PlantGrowth), y = weight, colour = group)) +
  geom_point() + # scatterplots to be displayed at points
  labs(x = "Value", y = "Dried Plant Weight (mg)", title = "Plant Growth Scatterplot", colour = "Group") # create labels
scatterplot


  # a box and whisker plot showing each group (on one set of axes)

box_and_whisker <- ggplot(PlantGrowth, aes(x = 1:nrow(PlantGrowth), y = weight, colour = group)) +
  geom_boxplot(aes(fill = group)) + # fill with groups to distinguish between them
  labs(x = "Value", y = "Dried Plant Weight (mg)", title = "Plant Growth Boxplot")
box_and_whisker

  # a bar plot with associated SD for each group (on one set of axes)

    # load dataset

PlantGrowth <- datasets::PlantGrowth
summary(PlantGrowth)

Plant_Growth <- PlantGrowth %>% 
  group_by(group) %>% # group data before summarizing
  summarize(weightmean = mean(weight), weightsd = sd(weight)) # summarize to get mean and sd

# plot histogram

bar_2 <- ggplot(Plant_Growth, aes(x = group, y = weightmean, fill = group)) +
  geom_bar(stat = "identity", position = position_dodge()) + # specify bar aesthetics
  geom_errorbar(Plant_Growth, mapping = aes(ymin = weightmean - weightsd, ymax = weightmean + weightsd), width = 0.1, position = position_dodge(0.4), colour = "black") + # plot errorbar to utilize sd data with specific aesthetics
  labs(x = "Group", y = "Plant Weight (mg)", colour = "Group")
bar_2




# Exercise D: Student's Sleep Data ----------------------------------------

# load the data

sleep <- datasets::sleep
summary(sleep)

# Graphically display these data in two different ways

  # graph 1: extra hours slept per group 

extra_hours <- ggplot(sleep, aes(x = ID, y = extra, colour = group)) +
  geom_point() + # plot points
  geom_line(aes(group = group)) + # include lines to connect the data of each group
  labs(x = "ID", y = "Extra hours slept", colour = "Group", title = "Extra hours slept per group")
extra_hours


  # graph 2: mean extra sleep obtained by the two groups

sleep_grouped <- sleep %>% 
  group_by(group) %>% # group by the different groups supplied
  summarize(extramean = mean(extra), extrasd = sd(extra)) # obtain data for plotting

mean_sleep <- ggplot(sleep_grouped, aes(x = group, y = extramean, fill = group)) +
  geom_bar(stat = "identity", position = position_dodge()) + # plot bar graph (best display option for the data wanting to be displayed)
  labs(x = "Group", y = "Plant Weight (mg)", colour = "Group", title = "Mean extra sleep obtained by the two groups")
mean_sleep




# Exercise E: English Narrative for Some Code -----------------------------

# Provide an English description for what the following lines of code does:

# Listing 1:

  the_data <- some_data %>% #load the data, then pipe to next row
  mutate(yr = year(date), # extract the year from the column 'date' in dataset
         mo = month(date)) %>%  # continued, same with month. Pipe to next row
  group_by(country, yr) %>%  #group the data by 'country' then 'year' columns
  summarise(med_chl = mean(chl, na.rm = TRUE)) %>% # summarise the column 'chl' to obtain the mean while ignoring any NA values
  ungroup() # ungroup the data again to make data tidier before creating graph

ggplot(the_data, aes(x = yr, y = med_chl)) + # plot graph from 'the_data' data with 'yr' on x axis and 'med_chl' (as calculated above) on y axis
  geom_line(aes(group = country), colour = "blue3") + # plot graph in form of a line while grouping the lines by column 'country' and changing the colours of the lines to 'blue3'
  facet_wrap(~country, nrow = 3) + # display the graphs alongside each other by country with 3 graphs per row
  labs(x = "Year", y = "Chlorophyll-a (mg/m3)",
       title = "Chlorophyll-a concentration") # label your x and y axis and give a title to complete graph


# Listing 2:

library(ggforce) # load new library

ggplot(iris, aes(Petal.Length, Petal.Width, colour = Species)) + # plot graph from 'iris' dataset with 'Petal.Length' and 'Petal.Width' on x and y axes respectively and group by species
  geom_point() + # plot the graph with points
  facet_zoom(x = Species == "versicolor") # zoom in on subset of data (species versicolor) while keeping the rest of the dataset as a separate panel, specifically zoomed only on x axis here


# Listing 3:

set.seed(13) # set.seed generates specific seeds (13 is the specific integer here) 

my_data = data.frame( # data incomplete, but data.frame creates new data frames
gender = factor(rep(c("F", "M"), each=200)), # 'factor' encodes a vector as a factor, 'rep' replicates the x values from the data, 'c' generates x values only 'F' and 'M', 'each' selects 200 values of each. All of this is taken from gender
length = c(rnorm(200, 55), rnorm(200, 58))) # taken from length data, 'rnorm' extracts a vector of normally distributed random numbers, where the two values inside the brackets that follow indicate the number of observations (the sample size) and the mean of the data respectively.

head(my_data) # head function returns the first value in the data

ggplot(my_data, aes(x = gender, y = length)) + # plot graph from data 'my_data' with 'gender' column values on the x axis and 'length' column values on the y axis
  geom_boxplot(aes(fill = gender)) # make the graph a boxplot (box-and-whisker diagram) with the colours of the different boxes to be filled with different colours according to the two genders used

ggplot(my_data, aes(x = gender, y = length)) + # same as above graph
  geom_violin() # geom_violin is a mirrored density plot which looks the same as a boxplot. It uses the same values but has a shape which is more similar to a violin than a box

ggplot(my_data, aes(x = gender, y = length)) + # same as above graph
  geom_dotplot(stackdir = "center", binaxis = "y", dotsize = 0.5) # make the graph a dot plot, where the dots are stacked and each dot represents one observation, 'stackdir' where 'center' indicates which direction to stack the dots (centrally in this case), 'binaxis' where 'y' indicates which axis to bin along and 'dotsize' indicates the diameter of the dots relative to the binwidth



