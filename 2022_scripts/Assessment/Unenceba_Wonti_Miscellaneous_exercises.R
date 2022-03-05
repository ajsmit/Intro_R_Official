# Unenceba Wonti
# Miscellaneous exercises 
# Due date: 22 February 2022


# Exercise A --------------------------------------------------------------

# Load packages

library(tidyverse)
library(ggpubr)
library(colorspace)
library(lubridate)
library(ggthemr) #Cannot load?
library(boot)

# Load shell data

load("data/shells.csv")

# Produce a *tidy* dataset from the data contained in `shells.csv`.
# Create an object for tidy data and gather the measurements into one column
shells_tidy <- shells %>%
  gather(left_length,left_width, right_length, right_width, key = "src", value = "value")

# For each species, relate two measurement variables within the dataset to one-another and represent the relationship with a straight line.

Aulacomya_data <- shells %>%
  filter(species == "Aulacomya") #Filter the data so that we work with Aulacomya species only

# Plot graph showing widths of Aulacomya species
ggplot(data = Aulacomya_data, aes(x= right_width, y= left_width))+
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x= "Right width (cm)", y= "Left width (cm)", title = "Graph showing Aulacomya widths")

Choromytilus_data <- shells %>%
  filter(species == "Choromytilus") #Filter the data so that we work with Choromytilus species only

#Plot graph showing widths of Choromytilus species

ggplot(data = Choromytilus_data, aes(x= right_width, y= left_width))+
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x= "Right width (cm)", y= "Left width (cm)", title = "Graph showing Choromytilus widths")

# For each species, concisely produce histograms for each of the measurement variables.

# Aulacomya species histograms

# Histogram 1 -------------------------------------------------------------

histogram <- ggplot(data = Aulacomya_data, aes(x = right_width)) +
  geom_histogram(aes(fill = species), colour = "black", position = "dodge", binwidth = 2) +
  labs(x = "Right width (cm)", y = "Count")
histogram


# Histogram 2 -------------------------------------------------------------

histogram <- ggplot(data = Aulacomya_data, aes(x = left_width)) +
  geom_histogram(aes(fill = species),colour = "black", position = "dodge", binwidth = 2) +
  labs(x = "Left width (cm)", y = "Count")
histogram

# Histogram 3 -------------------------------------------------------------

histogram <- ggplot(data = Aulacomya_data, aes(x = right_length)) +
  geom_histogram(aes(fill = species), colour = "black", position = "dodge", binwidth = 2) +
  labs(x = "Right length (cm)", y = "Count")
histogram

# Histogram 4 -------------------------------------------------------------

histogram <- ggplot(data = Aulacomya_data, aes(x = left_length)) +
  geom_histogram(aes(fill = species),colour = "black", position = "dodge", binwidth = 2) +
  labs(x = "Left length (cm)", y = "Count")
histogram

# Choromytilus species histograms


# Histogram 1 -------------------------------------------------------------

histogram <- ggplot(data = Choromytilus_data, aes(x = right_width)) +
  geom_histogram(aes(fill = species), colour = "black", position = "dodge", binwidth = 2) +
  scale_fill_discrete_qualitative(palette = "dark 3") #Used colorspace package to assign dark 3 colour pallete
  labs(x = "Right width (cm)", y = "Count")
histogram


# Histogram 2 -------------------------------------------------------------

histogram <- ggplot(data = Choromytilus_data, aes(x = left_width)) +
  geom_histogram(aes(fill = species), colour = "black", position = "dodge", binwidth = 2) +
  scale_fill_discrete_qualitative(palette = "dynamic") #Used colorspace package to assign the dynamic colour pallete
  labs(x = "Left width (cm)", y = "Count")
histogram

# Histogram 3 -------------------------------------------------------------

histogram <- ggplot(data = Choromytilus_data, aes(x = right_length)) +
  geom_histogram(aes(fill = species), colour = "black", position = "dodge", binwidth = 2) +
  scale_fill_discrete_qualitative(palette = "harmonic") #Used colorspace package to assign the harmonic colour pallete
  labs(x = "Right length (cm)", y = "Count")
histogram

# Histogram 4 -------------------------------------------------------------

histogram <- ggplot(data = Choromytilus_data, aes(x = left_length)) +
  geom_histogram(aes(fill = species), colour = "black", position = "dodge", binwidth = 2) +
  scale_fill_discrete_qualitative(palette = "warm") #Used the colorspace package to assign the warm colour pallate
  labs(x = "Left length (cm)", y = "Count")
histogram

# For each species, concisely produce histograms for each of the measurement variables.

hcl_palettes(plot = TRUE) # To view the colour pallets that I am able to use and play around with

#Use the **ggthemr** package and assign interesting themes to your graphs (all graphs above).
ggthemr("chalk", layout = "scientific")

# Exercise B --------------------------------------------------------------

# Create an object for the data 
brothers <- boot::frets 

# Creating a tidy dataset
brothers1 <- brothers %>%
  select(l1, b1) %>%
  rename(length = l1, breadth = b1) %>% #Change names of l1 and b2 to more sensible measurments.
  gather(length, breadth, key = "Head_dimension", value = "Brother_1") # Gather the two renamed columns so that they are in one column.

brothers2 <- brothers %>%
  select(l2, b2) %>%
  rename(length = l2, breadth = b2) %>%
  gather(length, breadth, key = "Head_dimension", value = "Brother_2")

brothers1$Brother2 <- brothers2$Brother_2

brother_tidy <- brothers1 %>%
  gather(Brother_1, Brother2, key = "Brother (1/2)", value = "value")

# Demonstrate the most concise way for displaying both brother's data on one set of axes.


# Exercise c --------------------------------------------------------------

# Plotting a scatterplot

PlantGrowth <- datasets::PlantGrowth

ggplot(data = PlantGrowth, aes(x= group, y= weight)) +
  geom_point(shape = 21, colour = "black", fill = "purple", size = 3) +
  geom_smooth (method = "lm", se = F) +
  labs(x = "Group", y= "Weight")

# Plotting a box and whisker plot

ggplot(data = PlantGrowth, aes(x = group, y= weight)) +
  geom_boxplot(aes(fill = group)) +
  labs(x = "Group", y= "Weight", title = "Box and whisker plot showing weight of plant yields relative to groups")

# Plotting a bar plot
barplot_1 <- ggplot(PlantGrowth, aes(x = group, y =weight, fill = group)) +
  labs(x= "Treatment condition", y= "Weight (g)") +
  stat_summaryy(geom = "bar", fun = mean, position = "dodge") +
  stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge") +
  scale_fill_manual(values = c('purple', 'green', "blue")) +
  theme_
  
  ggplot(data = PlantGrowth, mapping = aes(x = group, y= weight)) +
  geom_bar(aes(fill = group)) +
  labs(x = "Group", y= "Weight")



# Exercise D --------------------------------------------------------------

sleep<- datasets::sleep
ggplot(data = sleep, aes(x= ID, y= extra, colour = group)) +
         geom_point() +
         geom_line(aes(group = group)) + 
  labs(x = "Patient ID", y = "Increase in hours of sleep", title = "The effect of two sporofic drugs")

ggplot(data = sleep, aes(x= ID, y= extra, colour = group)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Patient ID", y= "Increase in hours of sleep", title = "The effect of sporofic drugs" )

# Exercise E --------------------------------------------------------------

## Listing 1:



the_data <- some_data %>% #Creates an object for the data in the environment section 
  mutate(yr = year(date), #Changes the date such that it is represented in years
         mo = month(date)) %>% #Changes the date such that it is represented in months
  group_by(country, yr) %>% #A command used to group the dataframe by whatever desired manner, in this case counrty and years
  summarise(med_chl = mean(chl, na.rm = TRUE)) %>% #Used to summarise a dataframe to, for example, just one value.
  ungroup()  
  
  





