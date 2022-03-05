# Exercise_A-E
# Cailin_Pillay
# 18/02/2022

# Load some packages ------------------------------------------------------

library(tidyverse)
library(lubridate)
library(colorspace)
library(ggthemes)
library(readr)

# Load data
shells <- read_csv("data/shells.csv", col_types = cols(ID = col_number(), 
                                                       left_length = col_number(), left_width = col_number(), 
                                                       right_length = col_number(), right_width = col_number())) # Changing it from integers to numeric 

# Exercise A --------------------------------------------------------------

# Tidy data
shells_tidy <- shells %>% # Tell R which data set to use and assining it a new name in the environment 
  gather(left_length, left_width, right_length, right_width, key = "Measurement", value = "Value(mm)") %>% # Gathering the data you want to use in the data frame you are working with. key is the name of the key column to create. Value is the name of the value column
  arrange(species, Measurement) # Arrange the data in order to use accordingly 

shells_tidy <- shells_tidy %>% # tidy the data to exclude ID
  select(-ID)

shells_left_len <- shells_tidy %>% # Join both data frames 
  filter(Measurement == "left_length") %>% # Tells R we only want to use the data with left_length
  select(species,`Value(mm)`) %>%  # Choosing only the specific columns
  rename(Length = "Value(mm)", Species = "species") # Renaming the column names 

shells_left_wid <- shells_tidy %>% 
  filter(Measurement == "left_width") %>%  # Tells R we only want to use the data with left_width
  select(species,`Value(mm)`) %>% # Choosing only the specific columns
  rename(Width = "Value(mm)", Species = "species")# Renaming the column names 
  
shells_joined <- left_join(shells_left_len, shells_left_wid)# Join both data frames 

# Create a basic figure
  ggplot(data = shells_joined, aes(x = Length, y = Width)) + # Tells R to plot points and lines for each selected columns at the same time using ggplot2 to create the figure
  geom_point() + # Makes points on the figure
  geom_line(aes(group = Species)) # Changes the line type and connects them in order of the variable on the x-axis and ground it by species
  
  myPalette <- c("#4999AE", "#E192C0") # Creating my own ggthemr
  
Shellsgraph <- ggplot(data = shells_joined, aes(x = Length, y = Width, colour = Species)) + # Creates a figure, tell R what data set to use and aes controls the look of the other functions dynamically based on the variables you provide it.
  geom_point() + # Makes points on the figure
  geom_line(aes(group = Species)) + # Changes the line type and connects them in order of the variable on the x-axis and ground it by species
  geom_smooth(method = "lm") + # Creatng a liner model 
  scale_colour_manual("Species", values = myPalette) + # Adding my own ggthemr which I created
  labs(x = "Length (mm)", y = "Width (mm)", title = "The relationship between Length(mm) vs Width(mm) for two different species of shells") + # Change labels and title 
  theme_grey() + # Change theme 
    theme(legend.position = "bottom") # Change legend position 
Shellsgraph

# library(devtools)
# devtools::install_github('cttobin/ggthemr') # Had to install this 

library(ggthemr)
ggthemr("dust") # Creating a dust theme instead of my own colours 
Shellsgraph

ggthemr("dust", type="outer", layout="scientific", spacing=2) # Creating a dust theme instead of my own colours 
Shellsgraph

# Create a histogram for each species for each measurement variable 

histogram_1 <- ggplot(data = shells, aes(x = left_length)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 10) + # Making sure the data is neat and not on top of each other ranging from 10
  labs(x = "Left Length", y = "Count") + # Change labels 
  scale_fill_manual("Species", values = myPalette) +  # Adding my own ggthemr which I created
  theme_grey() # Change theme 
histogram_1

ggthemr("flat") # Creating a theme instead of my own colours 
Shellsgraph
histogram_1

ggthemr("flat", type="outer", layout="scientific", spacing=2) # Creating a theme instead of my own colours 
histogram_1 

myPalette_2 <- c("#EBE664", "#2E150D") # Creating my own ggthemr

# Create a histogram for each species for each measurement variable  
histogram_2 <- ggplot (data = shells, aes(x= left_width)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 10) + # Making sure the data is neat and not on top of each other ranging from 10
  labs(x = "Left Width", y = "Count") + # Change labels 
  scale_fill_manual("Species", values = myPalette_2) + # Adding my own ggthemr which I created
  theme_get() # Change theme 
histogram_2

ggthemr("sea") # Creating a theme instead of my own colours 
histogram_2 

ggthemr("sea", type="outer", layout="scientific", spacing=2)# Creating a theme instead of my own colours 
histogram_2

myPalette_3 <- c("#A1B52D", "#5CB6D8") # Creating my own ggthemr

# Create a histogram for each species for each measurement variable 

histogram_3 <- ggplot (data = shells, aes (x = right_length)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 10) + # Making sure the data is neat and not on top of each other ranging from 10
  labs(x= "Right Length", y = "Count") + # Change labels 
  scale_fill_manual("Species", values = myPalette_3) +# Adding my own ggthemr which I created
  theme_light() # Change theme 
histogram_3

ggthemr("grape") # Creating a theme instead of my own colours 
histogram_3

ggthemr("grape", type="outer", layout="scientific", spacing=2) # Creating a theme instead of my own colours 
histogram_3
 
myPalette_4 <- c("#C9E36A", "#D890BE") # Creating my own ggthemr

# Create a histogram for each species for each measurement variable 

histogram_4 <- ggplot (data = shells, aes (x = right_width)) +
  geom_histogram(aes(fill = species), position = "dodge", binwidth = 10) + # Making sure the data is neat and not on top of each other ranging from 10
  labs(x = "Right Width", y = "Count") +# Change labels 
  scale_fill_manual("Species", values = myPalette_4) + # Adding my own ggthemr which I created
  theme_dark() # Change theme 
histogram_4

ggthemr("lilac") # Creating a theme instead of my own colours 
histogram_4

ggthemr("lilac", type="outer", layout="scientific", spacing=2) # Creating a theme instead of my own colours 
histogram_4

# Exercise B --------------------------------------------------------------

# Load some packages ------------------------------------------------------

library(tidyverse)
library(lubridate)
library(ggpubr)
library(ggplot2)
library(boot)

# Load data
??frets 

# Load data
frets <- boot::frets # Assigning a new named data frame 

head(frets) # Viewing the top part of the data 

tail(frets) # Viewing the last part of the data 

# Create tidy data
Eldestson <- frets %>% # Assigning a new named data frame 
  select(l1, b1) %>% # Selecting the columns and renaming them 
  rename(Length = l1, Breadth = b1) %>%
  gather(Length, Breadth, 
         key = "Head_Dimensions", value = "Brother_1")

Secondson <- frets %>% # Assigning a new named data frame 
  select(l2, b2) %>% # Selecting the columns and renaming them 
  rename(Length = l2, Breadth = b2) %>%
  gather(Length, Breadth, 
         key = "Head_Dimensions", value = "Brother_2")

Eldestson$Brother2 <- Secondson$Brother_2 # Combining the data sets created together 

frets_tidy <- Eldestson %>% # Assigning a new named data frame 
  gather(Brother_1, Brother2, # Creating a new tidier data set 
         key = "Brother (1&2)", value = "value")

# Create a basic figure 
ggplot(Eldestson, aes(x = Brother_1, y = Brother2, colour = Head_Dimensions)) +
  geom_point() + # Creates points 
  geom_smooth(method = 'lm') + # Creates a liner model 
  ggtitle('Head Dimensions in Brothers (mm)') + # Change title 
  xlab('Length and Breadth of Brother 1 (mm)') + # Change labels of x axis 
  ylab('Length and Breadth of Brother 2 (mm)') + # Change labels of y axis 
  theme_light() + # Change theme 
  theme(legend.position = "bottom") # Change legend position 
  
ggthemr_reset() # Resets all the themes made so it does not carry on 

# Exercise C  -------------------------------------------------------------

# Load some packages ------------------------------------------------------

library(tidyverse)
library(lubridate)
library(ggpubr)
library(ggplot2)

??PlantGrowth 

# Load data
PlantGrowth <- datasets::PlantGrowth  

# Creating a scatter plot 
scatterplot_1 <- qplot(x = group, y = weight, colour = group, data = PlantGrowth) # Plotting all the points on the x and y axis accordingly and tells R what data set to use
scatterplot_1

#Producing a box and whisker plot:
box_1 <- ggplot(data = PlantGrowth, aes(x = group, y = weight)) + # Creating a figure using ggplot, telling R which data set to use and what to plot on the x and y axis
  geom_boxplot(aes(fill = group)) + # Filling the box plot 
  labs(x = "Treatment Condition", y = "Dried weight of plants (g)", title = "Box Plot Shells") + # Change labe;s 
  theme_classic() + # Change theme 
  theme(legend.position = "bottom") # Change legend position 
box_1

#f1 help key data 
boxplot(weight ~ group, data = PlantGrowth, main = "PlantGrowth data",
        ylab = "Dried weight of plants", col = "lightgray",
        notch = TRUE, varwidth = TRUE)
anova(lm(weight ~ group, data = PlantGrowth))

# Creating a bar plot figure:
barplot_1 <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +      
  labs(x = "Treatment Condition", y = "Dried weight of plants (g)") + # Change labels          
  stat_summary(geom = "bar", fun = mean, position = "dodge") + # Generating the summary of means to plot accordingly 
  stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge", width = 0.2) + # Adding in standard errors and making them smaller 
  scale_fill_manual(values = c('orange','green','purple')) + # Change the colours 
  theme_dark() + # Change theme
  theme(legend.position = "bottom") # Change legend 
barplot_1


# Exercise D --------------------------------------------------------------

# Load some packages ------------------------------------------------------

library(tidyverse)
library(lubridate)
library(ggpubr)
library(ggplot2)

??sleep 

# Load data
sleep <- datasets::sleep  

#f1 help key data 

require(stats)
## Student's paired t-test
with(sleep,
     t.test(extra[group == 1],
            extra[group == 2], paired = TRUE))

## The sleep *prolongations*
sleep1 <- with(sleep, extra[group == 2] - extra[group == 1])
summary(sleep1)
stripchart(sleep1, method = "stack", xlab = "hours",
           main = "Sleep prolongation (n = 10)")
boxplot(sleep1, horizontal = TRUE, add = TRUE,
        at = .6, pars = list(boxwex = 0.5, staplewex = 0.25))

# Create a box plot figure 
box_1 <- ggplot(data = sleep, aes(x = group, y = extra, colour = group, fill = group)) + # Tells R what data to use and aes accordingly 
  geom_boxplot(alpha = 0.1) + # Alpha in order to still see the median line so change the transparency 
  labs(x = "Drug Given", y = "Increase Hours of Sleep") + # Change labels 
  theme_bw() + # Change theme 
  theme(legend.position = "bottom") # Chaneg legend position 
box_1

# Create a violin plot figure
vio1 <- ggplot(data = sleep, aes(x = group, y = extra, fill = group)) + # Tells R what data to use and aes accordingly 
  geom_violin(show.legend = FALSE, draw_quantiles = c(0.25, 0.5, 0.75)) + # Create the violin graph and draw lines on the quartiles 
  theme_pubclean() + theme(legend.position = "bottom") + # Change legend position 
  labs(title = "Sleep data",
       subtitle = "Violin plot with quartiles", x = "Drug Given", y = "Increase Hours of Sleep") + # Change the titles, subtitles and labels 
  theme(axis.text.x = element_text(face = "bold"))
vio1                     
                     

# Exercise E --------------------------------------------------------------


# Listing 1: --------------------------------------------------------------

the_data <- some_data %>% # Assigning a new named data frame  
  mutate(yr = year(date), # Mutate creates a new column with variables that are a function of more than one existing column. Tells R what the name of the column is and then tell R what to put in the new column.
         mo = month(date)) %>% 
  group_by(country, yr) %>% # Groups a data frame. Takes an existing table and converts it into a grouped table with specific variables
  summarise(med_chl = mean(chl, na.rm = TRUE)) %>% # Summarizing the mean of variables and removing all missing variables from the data if they are coded as NA
  ungroup() # This will drop any grouping 
ggplot(the_data, aes(x = yr, y = med_chl)) + # Creating a figure using ggplot, telling R which data set to use and what to plot on the x and y axis
  geom_line(aes(group = country), colour = "blue3") + # Changes the line type and connects them in order of the variable on the x-axis, groups by country, and makes the colour of the line blue
  facet_wrap(~country, nrow = 3) + # This line creates the facet with the number of columns and rows
  labs(x = "Year", y = "Chlorophyll-a (mg/m3)",# Changes the labels and title
       title = "Chlorophyll-a concentration")

# Listing 2: --------------------------------------------------------------
                     
library(ggforce) # Loads the library ggforce package which is an extension to ggplot2 
ggplot(iris, aes(Petal.Length, Petal.Width, colour = Species)) + # Creates a figure, tell R what data set to use and aes controls the look of the other functions dynamically based on the variables you provide it.Colour is added to each species to distinguish between the different types of species 
  geom_point() + # Plots points and connects them in order of the variable on the x-axis
  facet_zoom(x = Species == "versicolor") # This facetting provides the means to zoom in on a subset of the data, while keeping the view of the full data set as a separate panel and focuses only on the species with versicolor



# Listing 3: --------------------------------------------------------------

set.seed(13) # Setting a seed in R means to initialize a pseudo random number generator
my_data = data.frame( # Tells R what data fram to use 
  gender = factor(rep(c("F", "M"), each=200)), # variable used to categorize and store the data
  length = c(rnorm(200, 55), rnorm(200, 58))) # variable used to categorize and store the data
head(my_data) # View the first part of the data set 
ggplot(my_data, aes(x = gender, y = length)) + # Creates a figure, tell R what data set to use and aes controls the look of the other functions dynamically based on the variables you provide it.
  geom_boxplot(aes(fill = gender)) # Creates a box plot and fills the box plot with a colour and naming it gender
ggplot(my_data, aes(x = gender, y = length)) + # Creates a figure, tell R what data set to use and aes controls the look of the other functions dynamically based on the variables you provide it.
  geom_violin() # Creates a violin plot figure
ggplot(my_data, aes(x = gender, y = length)) + # Creates a figure, tell R what data set to use and aes controls the look of the other functions dynamically based on the variables you provide it.
  geom_dotplot(stackdir = "center", binaxis = "y", dotsize = 0.5) # Creates a dot plot where the width of a dot corresponds to the bin width and provides it with names 




