# Emma Langtry
# 19 Feb 2022
# Week 2 exercises


# Exercise A --------------------------------------------------------------


library(tidyverse)
library(colorspace)
library(ggthemr)

shells <- read.csv("shells.csv")

tidy_shells <- shells %>% 
  gather(left_length, left_width, right_length, right_width, key = "measurements", value = "mm")

ggthemr("earth", type = "outer", layout = "scientific")
ggplot(shells, aes(x = right_width, y = right_length, colour = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_colour_discrete_qualitative(palette = "Cold") +
  labs(x = "Right Valve Width (mm)", y = "Right Valve Length (mm)", colour = "Species")

ggthemr_reset()

labels <- c(left_length = "Left Valve Length", left_width = "Left Valve Width", right_length = "Right Valve Length", right_width = "Right Valve Width")

ggthemr(layout = "minimal")
ggplot(tidy_shells, aes(x = mm)) +
  geom_histogram(aes(fill = species), position = "dodge") +
  facet_wrap(~measurements, labeller = as_labeller(labels)) +
  scale_fill_discrete_qualitative(palette = "Dark 3") +
  labs(x = "Measurement (mm)", y = "Count", fill = "Species")

ggthemr_reset()


# Exercise B --------------------------------------------------------------


library(boot)
?frets
data(frets = "frets")

tidy_frets <- frets %>% 
  gather(l1, b1, l2, b2, key = "measurements", value = "mm")

ggplot(tidy_frets, aes(x = measurements, y = mm)) +
  geom_point(colour = "black") +
  theme_bw() +
  labs(x = "Measurements", y = "Size (mm)") +
  scale_x_discrete(labels = c("Eldest Son's Head Breadth", "Second Son's Head Breadth", "Eldest Son's Head Length", "Second Son's Head Length"))


# Exercise C --------------------------------------------------------------


?PlantGrowth
PG <- datasets::PlantGrowth

ggplot(PG, aes(x = group, y = weight)) +
  geom_point(colour = "red") +
  labs(x = "Group", y = "Mass (g)") +
  scale_x_discrete(labels = c("Control", "Treatment 1", "Treatment 2")) +
  theme_bw()

ggplot(PG, aes(x = group, y = weight)) +
  geom_boxplot(colour = "black", fill = "purple") +
  labs(x = "Group", y = "Mass (g)") +
  scale_x_discrete(labels = c("Control", "Treatment 1", "Treatment 2")) +
  theme_minimal()

PG2 <- PG %>% 
  group_by(group) %>% 
  mutate(sd = sd(weight)) %>% 
  ungroup() %>% 
  group_by(group, sd) %>% 
  summarise(weight = mean(weight))

ggplot(PG2, aes(x = group, y = weight)) +
  geom_bar(stat = "identity", width = .5, fill = "green", colour = "dark green") +
  geom_errorbar(aes(ymin = weight - sd, ymax = weight + sd), colour = "black", width = .3) +
  labs(x = "Group", y = "Mass (g)") +
  scale_x_discrete(labels = c("Control", "Treatment 1", "Treatment 2")) +
  theme_classic()


# Exercise D --------------------------------------------------------------

?sleep
sleep <- datasets::sleep

ggplot(sleep, aes(x = ID, y = extra, colour = group)) +
  scale_colour_discrete(name = "Drug") +
  scale_colour_discrete_qualitative(palette = "Pastel 1") +
  geom_point(aes(size = extra)) +
  geom_line(aes(group = group)) +
  labs(x = "Patient ID", y = "Change in Sleep Length (hrs)") +
  theme_dark()

ggthemr("dust")
ggplot(sleep, aes(x = group, y = extra, fill = group)) +
  geom_boxplot() +
  labs(x = "Drug Given", y = "Change in Sleep Length (hrs)", fill = "Drug")
  

# Exercise E --------------------------------------------------------------


# Listing 1:
the_data <- some_data %>% #A new data object called "the_data" is created using the dataset called "some_data" and piping it into the next command.
  mutate(yr = year(date), #Adding a new variable/column called "yr", which is created by using the lubridate function "year" on the variable "date" to extract only the year values from the selected variable.
         mo = month(date)) %>% #Also adding "mo" using a similar lubridate function that only returns the month values from the "date" variable. Then piping this into the next command.
  group_by(country, yr) %>% #Grouping the dataset by the "country" and "yr" variables and piping it into the next command.
  summarise(med_chl = mean(chl, na.rm = TRUE)) %>% #Creating a new variable using the "summarise" function. The new variable is called "med_chl" and it is a summary of the average values of the "chl" variable. The NA values were removed in the average calculation. The code chunk is piped into the next command.
  ungroup() #The code is ungrouped from its previous "group_by" variables.

ggplot(the_data, aes(x = yr, y = med_chl)) + #A ggplot (graph) is created using the new dataset "the_data". Aesthetic function is applied to specify the x and y-axes. The year values from the "yr" variable will be listed along the x-axis and the average values from the "med_chl" variable will be listed along the y-axis. The + symbol is adding another command in the next line.
  geom_line(aes(group = country), colour = "blue3") + #Adding a "blue3" coloured line geometry feature to connect the values. The aesthetics argument groups the line to the country variable, making a line for each listed country that connects their respective values. Then adding another command.
  facet_wrap(~country, nrow = 3) + #Using the facet_wrap function to create three rows of different graohs from the listed values in the variable "country", and adding another command to the code chunk.
  labs(x = "Year", y = "Chlorophyll-a (mg/m3)", #Changing the label titles of the x and y-axes. The x-axis title will be "Year" and the y-axis title will be "Chlorophyll-a (mg/m3)".
       title = "Chlorophyll-a concentration") #Changing the title of the graph into "Chlorophyll-a concentration". End of the graph's code.

# Listing 2
library(ggforce) #Loading the package "ggforce" using the library function.
ggplot(iris, aes(Petal.Length, Petal.Width, colour = Species)) + #Creating a ggplot graph using the "iris" dataset. Applying aesthetics: plotting Petal.Length along the x-axis and Petal.Width along the y-axis, plotting Species using colour (adding a legend to indicate which species by which colour). Adding another command.
  geom_point() + #Adding point geometry feature to create a scatterplot diagram. Adding another command.
  facet_zoom(x = Species == "versicolor") #Creating a facet graph of the original to include only the x-axis values of Species under the observation "versicolor". End of code.

# Listing 3
set.seed(13) #Setting the seed to the number 13.
my_data = data.frame( #Creating object called "my_data" using the data.frame function, which creates new dataframes.
  gender = factor(rep(c("F", "M"), each=200)), #Argument specifies that the variable gender will contain the categories "F" and "M". The categories will have 200 values each replicated using the rep function.
  length = c(rnorm(200, 55), rnorm(200, 58))) #Argument specifies that the variable length will contain 200 observations of a random generation for the normal distribution of 55 and 58 each.
head(my_data) #Display the first 6 rows of the my_data data set.

ggplot(my_data, aes(x = gender, y = length)) + #Create a ggplot graph using the my_data object. Aesthetics applies gender to be plotted along the x-axis and length to be plotted along the y-axis. Adding another line of code.
  geom_boxplot(aes(fill = gender)) #Adding a boxplot geometry feature and using aesthetic function to fill the boxplots with the colour corresponding to the values in the gender variable (creating a legend showing the colour allocated to each value).

ggplot(my_data, aes(x = gender, y = length)) + #Create a ggplot graph using my_data. Aesthetics add gender along x-axis and length along y-axis. Add another line of code.
  geom_violin() #Add violin geometry feature to the values. End of code.

ggplot(my_data, aes(x = gender, y = length)) + #Create a ggplot graph using my_data. Aesthetics add gender along x-axis and length along y-axis. Add another line of code.
  geom_dotplot(stackdir = "center", binaxis = "y", dotsize = 0.5) #Add a dotplot geometry feature with the 0.5 sized dots stacked in the center. The axis to bin along is set to the y-axis.
