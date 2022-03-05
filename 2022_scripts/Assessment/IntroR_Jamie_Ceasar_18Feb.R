# Jamie Ceasar
# Intro R exercises
# 18 Feb 2022

# Purpose: Miscellaneous exercises for the mind (and marks)

# Load packages -----------------------------------------------------------

# Load some packages
library(tidyverse)

library(ggpubr)

library(colorspace)
hcl_palettes(plot = TRUE) # View colour chart

# install.packages("devtools") Its commented out as it only needs to be loaded once.
# devtools::install_github('Mikata-Project/ggthemr') # Found on GitHub website https://github.com/Mikata-Project/ggthemr
library(ggthemr)

# "ggthemr could not be loaded on my version of R. 
# Therefore, I had to install the package "devtools" in order to use the 
# following command, which in turn, allowed me to load the package "ggthemr".


# Exercise A: Load and tidy the data --------------------------------------

# Load data frame
shell <- read.csv('data/shells.csv')

# Create tidy data frame
Shell_tidy <- shell %>%
  gather(left_length, left_width,   
         right_length, right_width,      # Gather all variables into one column named "Measurement Type"
         key = "Measurement_type", 
         value = "value") %>%            # Place the value of the measurement in a separate column named "value"
  arrange(species, Measurement_type, ID) # Places like rows of observations together


# Exercise A: Line Graph -----------------------------------------------

# creating data set #1 from the tidy data
Shell_l.l <- Shell_tidy %>% 
  filter(Measurement_type == "left_length") %>% # Only want the 'left_length' data
  select(species, ID, value) %>%                # Select the variables
  rename(length = "value")                      # rename the 'value' in the 'shell_tidy' data- 
                                                # frame to be length in the new data
# creating data set #2 from the tidy data
Shell_l.w <- Shell_tidy %>% 
  filter(Measurement_type == "left_width") %>%  # Only want the 'left_width' data
  select(species, ID, value) %>%                # Select the variables
  rename(width = "value")                       # rename 'value' to 'Left_width' in the new

# Joining data sets #1 and #2 
Shell_merge <- left_join(Shell_l.l, Shell_l.w)  

ggthemr("light", type = "inner", layout = "scientific", spacing = 2) # Set the theme using 'ggthmr'

ggplot(data = Shell_merge,                              # Use the merged dataset
       aes(x = length, y = width, colour = species)) +  # Plot width as a function of length for each species
  geom_point() +
  geom_smooth(method = "lm", size = 1.2) +
  scale_colour_discrete_qualitative(palette = "Warm") + # "Species" is discrete, qualitative data
  theme(legend.box = "horizontal", legend.position = "bottom") + # Change the position and orientation of the legend
  facet_wrap(~species, ncol = 2) +                      # Facet wrap to have the species on two separate graphs
  labs(x = "Left length (mm)", y = "Left width (mm)")   # Set the labels 


# Exercise A: Histograms --------------------------------------------------

ggthemr("grape", layout = "scientific", spacing = 2) # Set the theme using 'ggthmr'

# Histogram for the left length variable of both species
left_length <- ggplot(data = shell, aes(x = left_length)) +      
  geom_histogram(aes(fill = species), colour = "black", 
                 position = "dodge", binwidth = 10) +            # Set geom_bar()’s position with "dodge"
  scale_fill_discrete_qualitative(palette = "Cold") +            # "Species" is discrete, qualitative data
  theme(legend.box = "horizontal", legend.position = "bottom") + # Change the position and orientation of the legend
  facet_wrap(~species, ncol = 2) +                               # Facet wrap to have the species on two separate graphs
  labs(x = "Left Length", y = "Count")                           # Set the labels
left_length

# Histogram for the left width variable of both species
left_width <- ggplot (data = shell, aes(x= left_width)) +
  geom_histogram(aes(fill = species), colour = "black", 
                 position = "dodge", binwidth = 10) + # Set the binwidth 
  scale_fill_discrete_qualitative(palette = "Warm") + 
  theme(legend.box = "horizontal", legend.position = "bottom") +
  facet_wrap(~species, ncol = 2) +                               
  labs(x = "Left Width", y = "Count")
left_width

# Histogram for the right length variable of both species
right_length <- ggplot (data = shell, aes (x = right_length)) +
  geom_histogram(aes(fill = species), colour = "black",
                 position = "dodge", binwidth = 10) + 
  scale_fill_discrete_qualitative(palette = "Dynamic") +
  theme(legend.box = "horizontal", legend.position = "bottom") +
  facet_wrap(~species, ncol = 2) +  
  labs(x= "Right Length", y = "Count") 
right_length

# Histogram for the right width variable of both species
right_width <- ggplot (data = shell, aes (x = right_width)) +
  geom_histogram(aes(fill = species), colour = "black",
                 position = "dodge", binwidth = 5) + 
  scale_fill_discrete_qualitative(palette = "Harmonic") +
  theme(legend.box = "horizontal", legend.position = "bottom") +
  facet_wrap(~species, ncol = 2) +  
  labs(x= "Right Width", y = "Count")
right_width


# Exercise B --------------------------------------------------------------

# Load the "boots" package
install.packages("boot")

??fret

# Load data
brothers <- boot::frets # Assign data to an object in the environment

# Creating dataset #1 for the tidy data
brother1 <- brothers %>% 
  select(l1, l2) %>%               # Select the length columns
  rename(bro1 = l1, bro2 = l2) %>% # Rename the length columns to identify to which brother the data belongs
  gather(bro1, bro2,               # Gather the two new columns, "bro1" and "bro2' to create the variable "Brother"
         key = "Brother", value = "length") # Assign headings to the new variables

# Creating dataset #2 for the tidy data
brother2 <- brothers %>% 
  select(b1, b2) %>%               # Select the breadth columns
  rename(bro1 = b1, bro2 = b2) %>% # Rename the breadth columns to identify to which brother the data belongs
  gather(bro1, bro2,               # Gather the two new columns, "bro1" and "bro2' to create the variable "Brother"
         key = "Brother", value = "breadth")  # Assign headings to the new variables

# Combine dataset 1 and 2
brother1$breadth <- brother2$breadth 

# brother1 = the table in which I'm pasting my new column.
# breadth = the name of the new column in the 'brother1' dataset  
# brother2 = the table from which we are taking the 'breadth' column

# Tidy Data 
brother_tidy <- brother1 %>%                  
  gather(length, breadth, # Gather the columns with the same type of information so that there is one observation per row
         key = "dimension", value = "value") # Assign headings to the new variables


# Exercise B: Create the graph --------------------------------------------

ggthemr("grape", layout = "scientific", spacing = 2) # Set the theme using 'ggthmr')

ggplot(brother1, aes(x = length, y = breadth, colour = Brother)) + 
  geom_point(size = 1) +
  geom_smooth(method = lm, alpha = 0.1) + # relationship between length and weight is now represented by a smooth linear model
  scale_colour_ggthemr_d() +              # Apply the currently selected ggthemr palette to the ggplot
  theme(legend.position = "bottom") +     # Change the position of the legend
  ggtitle('Head Dimensions in Brothers (mm)') + # Define the graph's title
  xlab('Length (mm)') + # Define the x-axis label
  ylab('Breadth (mm)')  # Define the y-axis label


# Exercise C --------------------------------------------------------------

# Load Data
PlantGrowth <- PlantGrowth 

plantgrowth_1 <- PlantGrowth %>% 
  group_by(group) %>%            # Group the data by the "groups" of treatment conditions
  mutate(Individual = 1:n())     # Use the mutate() function to assign a number from 1 - 10, 
                                 # to each entry in the "group", and create a new column called "Individual"


# Exercise C: Scatter Plot ------------------------------------------------

ggthemr("flat", type = "inner", layout = "scientific", spacing = 2) # Set the theme using 'ggthmr')

myPalette <- c("#ED8B68", "#C29046", "#8D9242", "#5B8E56", "#34846F",  
               "#34747E", "#52617B", "#694D66", "#6E3C48", "#63342B") # Create a custom colour palette

ggplot(plantgrowth_1, aes(x = group,                         # 'Weight' is plotted as a function of 'group'
                          y = weight,                        # Therefore, x = group and y = weight
                          colour = as.factor(Individual))) + # Change "Individual" to a factor in order to get discrete colours
  geom_point(size = 2.5) +
  scale_fill_manual("Individual", values = myPalette) + # Manually select the colours, specified by the custom palette in the environment 
  labs(x = "Group", y = "Plant Growth (cm)", colour = "ID")  # Add the axis labels


# Exercise C: Box and whisker ---------------------------------------------

ggthemr("flat", type = "inner", layout = "scientific", spacing = 2) # Set the theme using 'ggthmr')

ggplot(plantgrowth_1, aes(x = group,                          # 'Weight' is plotted as a function of 'group'
                          y = weight,                         # Therefore, x = group and y = weight
                          fill = group)) + 
  geom_boxplot(size = 0.5) +                                  # Create box plot and alter size of the lines
  theme (legend.position = "bottom", aspect.ratio = 1.1) +    # Change legend position and aspect ratio
  labs(x = "Group", y = "Plant Growth (cm)", fill = "Group")  # Change the labels


# Exercise C: Bar graph with SD -------------------------------------------

ggthemr("dust", type = "inner", layout = "scientific", spacing = 2) # Set the theme using 'ggthmr')

plantgrowth_2 <- plantgrowth_1 %>% 
  group_by(group) %>%                               # Grouping the data by 
  summarize(wmean = mean(weight), wsd = sd(weight)) # Summarize the mean and standard deviation 

ggplot(plantgrowth_2, aes(x = group, y = wmean, 
                          ymin = wmean - wsd, 
                          ymax = wmean + wsd, fill = group)) + # Set error bars
  geom_bar(size = 1, colour = "black", 
           stat = "identity",  # Tell R to use the y-values provided in the dataset
           position = "dodge", # Spread the data on the x-axis
           width = 0.4) +      # Specify the width of the bars
  geom_errorbar(size = 1, 
                colour = "black", # Specify the colour of the error bars
                position = position_dodge(0.4), # Spread the error bars across the x-axis
                width = 0.2) +    # Specify the width of the error bars
  labs(x = "Group", y = "Plant Growth (cm)", fill = "Group") # Change the labels


# Exercise D --------------------------------------------------------------

# Load data
sleep <- sleep %>% 
  rename(drug = "group") # Renamed "group" to avoid confusion 

ggthemr("dust", type = "inner", layout = "scientific", spacing = 2) # Set the theme using 'ggthmr')

# First graph: Bar graph comparing the effect of two soporific drugs (and a control) on 10 patients
ggplot(sleep, aes(x = ID, y = extra, fill = drug)) + 
  geom_bar(size = 1, colour = "black", 
           stat = "identity",  # Tell R to use the y-values provided in the dataset
           position = "dodge", # Spread the data on the x-axis
           width = 0.9) +      # Specify the width of the bars
  labs(x = "Individual", y = "Amount of extra sleep (h)", fill = "Drug") # Change the labels

# Second graph: Bar graph comparing the effect of two soporific drugs (and a control) on 10 patients
ggplot(sleep, aes(x = ID, y = extra, colour = drug)) + 
  geom_point(size = 3, shape = 16) +   # Change size and shape of the point
  geom_line(aes(group = drug)) +       # Tell R to group the points by the type of 'drug' 
  theme (legend.position = "bottom") + # Change legend position and aspect ratio
  labs(x = "Individual", y = "Amount of extra sleep (h)", colour = "Drug") # Change the labels


# Exercise E --------------------------------------------------------------
# Listing 1 ---------------------------------------------------------------

the_data <- some_data %>% 
  mutate(yr = year(date), 
         mo = month(date)) %>% # Use the mutate function to separate the date into 'year' and the 'month'
                               # In order to make these changes, you would need to first load the 'lubridate' package
  group_by(country, yr) %>%    # This sets up the grouping variables, which is 'country' and 'year' 
  summarise(med_chl = mean(chl, na.rm = TRUE)) %>%  # Calculates the mean "chl' for each year and country 
                                                    # 'na.rm = true' tells R to remove all the 'NA' values
  ungroup() # Always ungroup the data after summarizing



ggplot(the_data, aes(x = yr, y = med_chl)) + 

# The first argument for ggplot() is the dataset, which is called 'the_data' 
# Next, the aesthetics needs to be added using the aes() function.
# X and Y aesthetics have been defined as 'year' and 'mean chlorophyll-a concentration', respectively. 

  geom_line(aes(group = country), colour = "blue3") + # First tel R to connect the data grouped by the variable "country"
                                                      # Then changing the color of connecting lines to blue
  facet_wrap(~country, nrow = 3) + # Separate each country into a facet/panel of their own
                                   # The nrow = 3 tell r to separate the figures into three rows
  labs(x = "Year", y = "Chlorophyll-a (mg/m3)",       # Define the axis labels and the graphs title
       title = "Chlorophyll-a concentration")



# Listing 2 ---------------------------------------------------------------

library(ggforce)
# The 'ggforce' package is ultimately an extention of 'ggplot'. 
# as it provides additional tools that aid in the visualization of data.
# An example of an added tool, would be the facet_zoom function that allows
# you to zoom in on a subset of the data in one panel, 
# while retaining a second panel for the complete dataframe.


ggplot(iris, aes(Petal.Length, Petal.Width, colour = Species)) +
  
                # The first argument for ggplot() is the dataset. 
                # In the example above, we are using the built-in 'iris' dataset. 
                # Next, the aesthetics needs to be added using the aes() function, 
                # which requires a x and a y input. 
                # X and Y aesthetics have been defined as 'Petal.Length' and 'Petal.Width', respectively. 
                # Defining Species by colour, allows you to change the graph so that each 
                # species is differentiated by colour.  
  
    geom_point() + # Plots the data points on the graph.
    facet_zoom(x = Species == "versicolor") # This tells R to zoom in on the versicolor species on only the x-axis.
 
 
# Listing 3 ---------------------------------------------------------------

set.seed(13)

# The set.seed function is used to generate a sequence random objects that can be reproducible.
# The number in the brackets specifies the starting point of the sequence of random data. 
# It ensures that you get the same result if you start with that same seed 
# each time you run the same process.

my_data = data.frame( 
  
# Here, we create a new dataframe, named my_data, using the function 'data.frame'. 
# The next step is to define the variables in the dataframe, which is 'gender' and 'length'. 

        gender = factor(rep(c("F", "M"), each = 200)), 
        
        # This tell R to read the 'gender' variable as a factor with two levels: F for female, and M for male.
        # The second part of the code specifies that each level should appear in the dataset 200 times each. 
        
        length = c(rnorm(200, 55), rnorm(200, 58))) 

        # This line defines the normal distribution of the data for both males and females. 
        # We tell R to generate 200 random 'lengths' each, for females and males, 
        # with an average of 55 for females and an average of 58 for males.

head(my_data) # Allows you to view the first few rows of the specified table or data frame.

ggplot(my_data, aes(x = gender, y = length)) + 
  
# The first argument for ggplot() is the dataset, which in this case, is 'my_data'
# The aesthetics needs to be added next using the aes() function,
# X and Y aesthetics have been defined as gender and length, respectively. 
  
  geom_boxplot(aes(fill = gender)) # This line specifies that the type of ggplot being plotted is a boxplot.
                                   # Filling the boxes by gender allows you to differentiate between the M and F 

ggplot(my_data, aes(x = gender, y = length)) +
  geom_violin() # This line specifies that the type of ggplot being plotted is a violin plot, 
                # which is a a condensed representation of a continuous distribution

ggplot(my_data, aes(x = gender, y = length)) +
  geom_dotplot(stackdir = "center", binaxis = "y", dotsize = 0.5) 

# In a dotplot the dots are stacked and each indicates one observation.
# 'Stackedir' tells R in which direction to stack the dots. In this case the dots are stached in the center.
# 'binaxis' specifies on which axis to place the bins. Here, the bins are placed on the y-axis
# The 'dotsize' defines the diameter of the dots relative to binwidth.



