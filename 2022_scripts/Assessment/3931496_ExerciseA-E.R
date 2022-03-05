#Task Assignment: Exercise A - Exercise E
#Exercise A
#Lauryn Bull 
#19th February 2022

# Purpose: Test assignment 

#Loading packages:
library(tidyverse)
library(colorspace)
library(ggthemr)

#Load data:
shells <- read_csv("shells.csv")

#Tidy the data:
tidy_Shells <- shells %>%
  pivot_longer(c("left_width","right_width", "left_length", "right_length"), 
               names_to = "Dimensions", values_to = "values") #Tidying data , by deleting unnecessary coloumns and merging similar data

#Find the unique species only and use the data set:
unique(shells$species)

species_select <- c("Aulacomya")

variable_2 <- shells %>%
  dplyr::filter(species == species_select) #Filter data (making a simpler dataset)

variable_2 <- shells %>%
  select(left_length,right_length) #Creating a data set with only left length and right length 

#Producing a line graph: (Line graph 1)
line_1 <- ggplot(data = variable_2, aes(x = left_length, y = right_length)) +   #creates a relationship graph showing the direct proportionality
  #                                                                               of the two variables/measurements
  geom_point(aes(colour = species, size = 0.5)) + #creates accurate data points on the graph 
  geom_smooth(method = "lm") + # creates a line of regression to show the trend of the data (making it easy to analyse)
  labs(x = "Right length (mm)", y = "Left length (mm)") #Relabelling the axis titles
line_1

#Find the unique species only and use the data set:
unique(shells$species)

species_select <- c("Choromytilus") 

variable_4 <- shells %>%
  dplyr::filter(species == species_select) #Species select function used to only select data with regards to a specific object or variable

variable_4 <- shells %>%
  select(left_width,right_width)# Creating a data set with only left width and right width

#Producing a line graph: (Line graph 2)
line_2 <- ggplot(data = variable_4, aes(x = left_width, y = right_width)) + #creates a relationship graph showing the direct proportionality
  #                                                                               of the two variables/measurements
  geom_point() + #creates accurate data points on the graph 
  geom_smooth(method = "lm") + # creates a line of regression to show the trend of the data (making it easy to analyse)
  labs(x = "Left width (mm)", y = "Right width (mm)") #Re-labeling the axis titles
line_2

#Producing a histogram: 
#Producing histograms for both Choromytilus and Aulacomya

histogram_1 <- ggplot(data = shells, aes(x = left_length)) + 
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 30) +#Playing around with binwidth to find perfect graph
  labs(x = "Right length (mm)", y = "Count") + #plotting histograms with only one variable at a time 
  scale_colour_manual(aes("Purple", "Green"))
histogram_1

histogram_2 <- ggplot(data = shells, aes(x = right_length)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 10) +#plotting histograms with only one variable at a time 
  labs(x = "Right length (mm)", y = "Count")+
  scale_color_brewer(palette = "Dark2")
histogram_2

histogram_3 <- ggplot(data = shells, aes(x = left_width)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 50) +#plotting histograms with only one variable at a time 
  labs(x = "Left width (mm)", y = "Count")
histogram_3

histogram_4 <- ggplot(data = shells, aes(x = right_width)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 10) +#plotting histograms with only one variable at a time 
  labs(x = "Right width (mm)", y = "Count")
histogram_4




#Exercise B

#Load packages:
library(boot)

#Load data:
frets <- read_csv("frets.csv")
brothers <- boot::frets # Assign the data in the environment to specific 

#Producing tidy data from the given data set: 
broth_1 <- brothers %>% 
  select(l1, b1) %>% 
  rename(length = l1, breadth = b1) %>%
  gather(length, breadth, 
         key = "Measurements", value = "First_Born") #Creating new tables with variables specific to the first born

broth_2 <- brothers %>% 
  select(l2, b2) %>% 
  rename(length = l2, breadth = b2) %>%
  gather(length, breadth, 
         key = "Measurements", value = "Second_Born") #Creating new tables with variables specific to the second born

broth_1$Second_Born <- broth_2$Second_Born # Moving data from two coloumns (merge two coloumns into one)
# specific to the dimensions of head length and breadth
tidy_brothers <- broth_1 %>% 
  gather(First_Born, Second_Born, 
         key = "Brothers (1&2)", value = "value") #Finally tidying data with both first and second born

#Produce line graphs for both brothers on the same set of axes: 
Line_2 <- ggplot(broth_1, aes(x = First_Born, y = Second_Born, colour = Measurements)) +
  geom_point() +
  geom_smooth(method = 'lm') + #Produces a line of regression into the datavset(show trends)
  ggtitle('Measurements of the Brothers head (mm)') + #Adding a title 
  xlab('Length and Breadth of brother 1 (mm)') +
  ylab('Length and Breadth of brother 2 (mm)') +
  scale_colour_manual(values = c("Purple", "Orange"))+ #Manually changing the colours of graphs and the themes
  theme_classic() +
  theme(legend.position = "bottom") #Moving the legend to the bottom of the plot
Line_2




#Exercise C

#Load data:
PlantGrowth <- datasets::PlantGrowth

#Producing a Basic scatter plot:
scatterplot_1 <- qplot(x = group, y = weight, colour = group, data = PlantGrowth)
geom = c("point", "smooth")+
  labs(x = "Treatment condition", y = "Weight (g)") #Producing a scatterplot with both points and a trend line by geom_smooth
scatterplot_1

#Producing a box and whisker plot:
box_1 <- ggplot(data = PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot(aes(fill = group)) +
  labs(x = "Treatment condition", y = "Weight (g)")+
  scale_fill_manual(values = c('yellow','blue','green')) +
  theme_classic() +
  theme(legend.position = "bottom")
box_1

#Producing a barplot with smoothed lines:
barplot_1 <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +      # ggplot2 barplot with error bars
  labs(x = "Treatment condition", y = "Weight (g)") +               #Changing axis titles 
  stat_summary(geom = "bar", fun = mean, position = "dodge") + #Creating error bars is required by using the stat summary function
  stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge") +
  scale_fill_manual(values = c('pink','purple','blue')) +      #changing the colour of bars can be done manually by picking colours
  theme_classic()
barplot_1





#Exercise D

#Load data;
sleep <- datasets::sleep

#Produce a box and whisker plot:
box_2 <- ggplot(data = sleep, aes(x = group, y = extra)) +
  geom_boxplot(aes(fill = group)) + #Adding colours to the different groups 
  labs(x = "Soporific drugs", y = "Extra sleep (hrs)")+
  theme_classic()+
  theme_bw()+
  theme(legend.position = "bottom") 

#Produce a histogram graph:
barplot_2 <- ggplot(sleep, aes(x = group, y = extra, fill = group)) + #Producing a barplot with both the group and extra time slept
  labs(x = "Soporifiic drugs", y = "Extra sleep (hrs) ") +               #Changing axis titles 
  stat_summary(geom = "bar", fun = mean, position = "dodge") +
  scale_fill_manual(values = c('purple','orange')) +      #changing the colour of bars can be done manually by picking colours
  theme_bw()
barplot_2




#Exercise E

#Listing 1:

the_data <- some_data %>%
  mutate(yr = year(date),     #Mutate() function is used to create a new variable from a set of data
         mo = month(date)) %>%      #yr= year and the date and mo= month and the date
  group_by(country, yr) %>%           #The data is grouped by country and the year
  summarise(med_chl = mean(chl, na.rm = TRUE)) %>%  # The summarize function calculates the mean from the med_chl data set forming the new variable 
  #Using the na.rm function it feedS a logical value (TRUE or FALSE), It indicates whether you want to strip the NAs or not while running the function.
  #rm = remove therefore it removes the NAs
  ungroup() #ungroup function always prevents errors from occurring

ggplot(the_data, aes(x = yr, y = med_chl)) +  #Poducing a line graph from the coloumns: yr, med_chl 
  geom_line(aes(group = country), colour = "blue3") + # the geom_line function groups the different countries by aesthetic and changing the colour to blue from the standard black or navy blue
  facet_wrap(~country, nrow = 3) + # The facet wrap function is used to arrange the line graphs into 3 rows (below each other)
  # The countries names are then arranged in facets with their specific line graphs.
  labs(x = "Year", y = "Chlorophyll-a (mg/m3)",  #The axis labels are changed x = "Year", y = "Chlorophyll-a (mg/m3)", with an added title of 
       title = "Chlorophyll-a concentration")  #with an added title of "Chlorophyll-a concentration"

#Listing 2:

library(ggforce) #Loading the package ggforce
ggplot(iris, aes(Petal.Length, Petal.Width, colour = Species)) + # Loading the data iris with the different variable of petal.length, petal 
  geom_point() + #adds points to the line graph( indicated by the types of variables usd in the example)
  facet_zoom(x = Species == "versicolor") #the facet zoom function is used to zoom in on a subset of data in this case it is the "versicolour species on the x axis only 

#Listing 3:

#This particular plot can only be used using the ggpubr package.
set.seed(13) #The seed function is needed in the programme to produce reproducible results, but also produces randm data.
my_data = data.frame( #Used to debug the program
  gender = factor(rep(c("F", "M"), each=200)), #The code generates some data containing the lengths by gender factor indicated by (M for male; F for female)
  length = c(rnorm(200, 55), rnorm(200, 58))) #Using this data frame function is used to create some data format using gender and length  
head(my_data) # this function returns the first parts of the data set/ data table in the console(usually first 4 rows)

ggplot(my_data, aes(x = gender, y = length)) + #The plot uses the coloumns 
  geom_boxplot(aes(fill = gender)) #A ggplot is being produced in a boxplot format with the dataset above
#The boxplot colours are filled with colour depending on the gender.
ggplot(my_data, aes(x = gender, y = length)) +
  geom_violin() #Using the ggplot function to produce a violin plot (combination of boxplots and the densities of different values)
#The graph will show the median, and interquartile ranges in the centre of the diagrams as boxplots

ggplot(my_data, aes(x = gender, y = length)) + #producing a dotplot from the my_data dataset.
  geom_dotplot(stackdir = "center", binaxis = "y", dotsize = 0.5) #The dots in the plot are stacked in the center of the diagram (stackdir = "center") 
#The axis in which the bin is along the "y" axis.







